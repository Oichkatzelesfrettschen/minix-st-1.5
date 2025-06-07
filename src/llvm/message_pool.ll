; src/llvm/message_pool.ll
; Message Buffer Pool Management

source_filename = "src/llvm/message_pool.ll"

; --- Type Definitions ---
; Ensure %message is consistent with its definition in other files
; { i32, i32, [6 x i64], ptr }
%message = type { i32, i32, [6 x i64], ptr }

; Free list node structure. The 'next' pointer will be stored
; at the beginning of the message buffer itself when it's free.
%free_list_node = type { ptr } ; ptr to next %free_list_node

%message_pool = type {
  ptr,    ; base_address (ptr to the start of the contiguous block of messages)
  i32,            ; total_messages (capacity)
  i32,            ; message_size (size of one %message structure in bytes)
  i128            ; tagged_free_list_head {ptr, counter}

}

; --- Global Variables ---
@global_message_pool = global ptr null, align 8 ; Ptr to the %message_pool instance
@message_pool_initialized_flag = global i32 0, align 4 ; Guard for one-time init

@pool_alloc_success_count = global i64 0, align 8
@pool_alloc_failure_count = global i64 0, align 8
@pool_free_count = global i64 0, align 8

; --- External Function Declarations ---
declare ptr @malloc(i64) nounwind
declare void @llvm.trap() nounwind noreturn

; --- Internal Helper Functions ---

; Packs a pointer and a counter into an i128
; Pointer in lower 64 bits, counter in upper 64 bits
define internal i128 @pack_tagged_pointer(ptr %node_ptr, i64 %counter) nounwind {
entry:
  %ptr_as_int = ptrtoint ptr %node_ptr to i64
  %ptr_zext_i128 = zext i64 %ptr_as_int to i128
  %counter_zext_i128 = zext i64 %counter to i128
  %counter_shl_i128 = shl i128 %counter_zext_i128, 64
  %packed = or i128 %ptr_zext_i128, %counter_shl_i128
  ret i128 %packed
}

; Unpacks an i128 into a pointer and a counter
; Pointer from lower 64 bits, counter from upper 64 bits
define internal { ptr, i64 } @unpack_tagged_pointer(i128 %tagged_ptr) nounwind {
entry:
  %ptr_bits_i64 = trunc i128 %tagged_ptr to i64
  %unpacked_node_ptr = inttoptr i64 %ptr_bits_i64 to ptr ; ptr %free_list_node
  %counter_bits_shifted_i128 = lshr i128 %tagged_ptr, 64
  %unpacked_counter_i64 = trunc i128 %counter_bits_shifted_i128 to i64

  %result_struct = insertvalue { ptr, i64 } undef, ptr %unpacked_node_ptr, 0
  %result_struct_final = insertvalue { ptr, i64 } %result_struct, i64 %unpacked_counter_i64, 1
  ret { ptr, i64 } %result_struct_final
}

; Builds the initial free list from the contiguous message buffer
define internal void @build_free_list(ptr %pool_instance) nounwind {
entry:
  %base_addr_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 0
  %base_addr = load ptr, ptr %base_addr_ptr_loc, align 8

  %total_messages_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 1
  %total_messages = load i32, ptr %total_messages_ptr_loc, align 4

  %message_size_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 2
  %message_size = load i32, ptr %message_size_ptr_loc, align 4
  %message_size_64 = zext i32 %message_size to i64

  %free_list_head_i128_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3 ; Now ptr to i128

  ; Use a local plain pointer for building the list non-atomically
  %local_plain_head_ptr_alloca = alloca ptr, align 8
  store ptr null, ptr %local_plain_head_ptr_alloca, align 8

  %i_alloc = alloca i32, align 4
  store i32 0, ptr %i_alloc, align 4
  br label %loop_header

loop_header:
  %idx = load i32, ptr %i_alloc, align 4
  %loop_cond = icmp slt i32 %idx, %total_messages
  br i1 %loop_cond, label %loop_body, label %loop_exit_build

loop_body:
  %current_offset_bytes = mul i64 %message_size_64, (zext i32 %idx to i64)
  %current_msg_raw_ptr = getelementptr i8, ptr %base_addr, i64 %current_offset_bytes
  %current_node_as_plain_freelist_ptr = bitcast ptr %current_msg_raw_ptr to ptr ; ptr %free_list_node

  %current_plain_head = load ptr, ptr %local_plain_head_ptr_alloca, align 8
  %next_ptr_in_node_loc = getelementptr inbounds %free_list_node, ptr %current_node_as_plain_freelist_ptr, i32 0, i32 0
  store ptr %current_plain_head, ptr %next_ptr_in_node_loc, align 8

  store ptr %current_node_as_plain_freelist_ptr, ptr %local_plain_head_ptr_alloca, align 8

  %next_idx = add i32 %idx, 1
  store i32 %next_idx, ptr %i_alloc, align 4
  br label %loop_header

loop_exit_build:
  ; List built with plain pointers. Now pack the final head with an initial counter.
  %final_plain_head_ptr = load ptr, ptr %local_plain_head_ptr_alloca, align 8
  %initial_packed_head = call i128 @pack_tagged_pointer(ptr %final_plain_head_ptr, i64 1) ; Start counter at 1 for live list
  store i128 %initial_packed_head, ptr %free_list_head_i128_ptr_loc, align 16 ; Store final i128

  ret void
}

; --- Public API Functions ---

; Initializes the global message pool
define void @init_message_pool(i32 %num_messages) nounwind {
entry:
  ; One-time initialization guard (remains the same)

  %already_init_val = load atomic i32, ptr @message_pool_initialized_flag acquire, align 4
  %is_already_init = icmp ne i32 %already_init_val, 0
  br i1 %is_already_init, label %init_done, label %proceed_init

proceed_init:
  %cas_result = cmpxchg ptr @message_pool_initialized_flag, i32 0, i32 1 acq_rel acquire
  %init_succeeded_this_thread = extractvalue { i32, i1 } %cas_result, 1
  br i1 %init_succeeded_this_thread, label %perform_actual_init, label %init_done

perform_actual_init:
  %is_num_msg_invalid = icmp sle i32 %num_messages, 0
  br i1 %is_num_msg_invalid, label %invalid_params_trap, label %allocate_pool_struct

invalid_params_trap:
  call void @llvm.trap()
  unreachable

allocate_pool_struct:
  %size_of_pool_struct_64 = ptrtoint ptr getelementptr (%message_pool, ptr null, i32 1) to i64
  %pool_struct_raw_mem = call ptr @malloc(i64 %size_of_pool_struct_64)
  %is_pool_struct_alloc_failed = icmp eq ptr %pool_struct_raw_mem, null
  br i1 %is_pool_struct_alloc_failed, label %alloc_failure_trap, label %pool_struct_allocated

pool_struct_allocated:
  %pool_instance = bitcast ptr %pool_struct_raw_mem to ptr %message_pool

  %size_of_message_64 = ptrtoint ptr getelementptr (%message, ptr null, i32 1) to i64
  %num_messages_64 = zext i32 %num_messages to i64
  %total_buffer_size_64 = mul i64 %size_of_message_64, %num_messages_64

  %messages_raw_mem = call ptr @malloc(i64 %total_buffer_size_64)
  %is_msg_buffer_alloc_failed = icmp eq ptr %messages_raw_mem, null
  br i1 %is_msg_buffer_alloc_failed, label %alloc_failure_trap, label %msg_buffer_allocated

msg_buffer_allocated:
  %base_addr_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 0
  store ptr %messages_raw_mem, ptr %base_addr_ptr_loc, align 8

  %total_messages_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 1
  store i32 %num_messages, ptr %total_messages_ptr_loc, align 4

  %message_size_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 2
  %size_of_message_32 = trunc i64 %size_of_message_64 to i32
  store i32 %size_of_message_32, ptr %message_size_ptr_loc, align 4

  ; Initialize tagged_free_list_head to (null, 0) before building.
  ; build_free_list will then set it to (actual_head, 1).
  %free_list_head_i128_ptr_loc_init = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3
  %initial_empty_packed_head = call i128 @pack_tagged_pointer(ptr null, i64 0)
  store i128 %initial_empty_packed_head, ptr %free_list_head_i128_ptr_loc_init, align 16

  call void @build_free_list(ptr %pool_instance)

  store ptr %pool_instance, ptr @global_message_pool, align 8 ; Publish the pool instance

  br label %init_done

alloc_failure_trap:
  call void @llvm.trap()
  unreachable

init_done:
  ret void
}

; Allocate a message from the pool (lock-free atomic with ABA protection)

define ptr @alloc_message() nounwind {
entry:
  %pool_instance = load ptr, ptr @global_message_pool, align 8
  %is_pool_not_init = icmp eq ptr %pool_instance, null
  br i1 %is_pool_not_init, label %pool_uninitialized_failure_alloc, label %get_head_ptr_loc_alloc

get_head_ptr_loc_alloc:
  %tagged_free_list_head_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3 ; ptr to i128
  br label %try_alloc_loop

try_alloc_loop:
  %loaded_tagged_head = load atomic i128, ptr %tagged_free_list_head_ptr_loc acquire, align 16
  %unpacked_head_struct = call { ptr, i64 } @unpack_tagged_pointer(i128 %loaded_tagged_head)
  %old_head_plain_ptr = extractvalue { ptr, i64 } %unpacked_head_struct, 0
  %old_counter = extractvalue { ptr, i64 } %unpacked_head_struct, 1

  %is_list_empty = icmp eq ptr %old_head_plain_ptr, null
  br i1 %is_list_empty, label %pool_empty_failure_alloc, label %prepare_cas_alloc

prepare_cas_alloc:
  %next_ptr_field_in_old_head_loc = getelementptr inbounds %free_list_node, ptr %old_head_plain_ptr, i32 0, i32 0
  %next_node_plain_ptr_for_new_head = load ptr, ptr %next_ptr_field_in_old_head_loc, align 8 ; Non-atomic load

  %new_counter = add i64 %old_counter, 1
  %new_tagged_head = call i128 @pack_tagged_pointer(ptr %next_node_plain_ptr_for_new_head, i64 %new_counter)

  %cas_result = cmpxchg ptr %tagged_free_list_head_ptr_loc, i128 %loaded_tagged_head, i128 %new_tagged_head acq_rel acquire, align 16
  %cas_succeeded = extractvalue { i128, i1 } %cas_result, 1
  br i1 %cas_succeeded, label %allocation_succeeded_alloc, label %try_alloc_loop

allocation_succeeded_alloc:
  ; Clear the 'next' pointer in the allocated node (%old_head_plain_ptr)
  store ptr null, ptr %next_ptr_field_in_old_head_loc, align 8
  %message_to_return = bitcast ptr %old_head_plain_ptr to ptr %message

  ; Increment success counter
  %current_success_val = load atomic i64, ptr @pool_alloc_success_count monotonic, align 8
  %next_success_val = add i64 %current_success_val, 1
  store atomic i64 %next_success_val, ptr @pool_alloc_success_count monotonic, align 8

  ret ptr %message_to_return

pool_uninitialized_failure_alloc:
  ; Increment failure counter
  %current_fail_val_uninit = load atomic i64, ptr @pool_alloc_failure_count monotonic, align 8
  %next_fail_val_uninit = add i64 %current_fail_val_uninit, 1
  store atomic i64 %next_fail_val_uninit, ptr @pool_alloc_failure_count monotonic, align 8
  ret ptr null

pool_empty_failure_alloc:
  ; Increment failure counter
  %current_fail_val_empty = load atomic i64, ptr @pool_alloc_failure_count monotonic, align 8
  %next_fail_val_empty = add i64 %current_fail_val_empty, 1
  store atomic i64 %next_fail_val_empty, ptr @pool_alloc_failure_count monotonic, align 8
  ret ptr null
}

; Return a message to the pool (lock-free atomic with ABA protection)
define void @free_message(ptr %msg_to_free) nounwind {
entry:
  %is_msg_null = icmp eq ptr %msg_to_free, null
  br i1 %is_msg_null, label %free_done_exit, label %proceed_free_op

proceed_free_op:
  %pool_instance_free = load ptr, ptr @global_message_pool, align 8
  %is_pool_not_init_free = icmp eq ptr %pool_instance_free, null
  br i1 %is_pool_not_init_free, label %pool_uninit_free_failure_trap, label %prepare_new_head_node

prepare_new_head_node:
  %new_head_plain_ptr = bitcast ptr %msg_to_free to ptr ; ptr %free_list_node
  %tagged_free_list_head_ptr_loc_free = getelementptr inbounds %message_pool, ptr %pool_instance_free, i32 0, i32 3 ; ptr to i128
  br label %try_free_loop

try_free_loop:
  %loaded_tagged_head_free = load atomic i128, ptr %tagged_free_list_head_ptr_loc_free acquire, align 16
  %unpacked_current_head_struct = call { ptr, i64 } @unpack_tagged_pointer(i128 %loaded_tagged_head_free)
  %current_head_plain_ptr = extractvalue { ptr, i64 } %unpacked_current_head_struct, 0
  %current_counter_val = extractvalue { ptr, i64 } %unpacked_current_head_struct, 1

  ; Set the 'next' pointer of the message being freed to point to the current actual head
  %next_ptr_field_in_new_head_loc = getelementptr inbounds %free_list_node, ptr %new_head_plain_ptr, i32 0, i32 0
  store ptr %current_head_plain_ptr, ptr %next_ptr_field_in_new_head_loc, align 8

  %new_counter_val = add i64 %current_counter_val, 1
  %new_tagged_head_for_freelist = call i128 @pack_tagged_pointer(ptr %new_head_plain_ptr, i64 %new_counter_val)

  %cas_result_free = cmpxchg ptr %tagged_free_list_head_ptr_loc_free, i128 %loaded_tagged_head_free, i128 %new_tagged_head_for_freelist acq_rel acquire, align 16
  %cas_succeeded_free = extractvalue { i128, i1 } %cas_result_free, 1
  br i1 %cas_succeeded_free, label %freeing_succeeded_exit, label %try_free_loop ; CAS failed, retry

freeing_succeeded_exit:
  ; Increment free counter
  %current_free_val = load atomic i64, ptr @pool_free_count monotonic, align 8
  %next_free_val = add i64 %current_free_val, 1
  store atomic i64 %next_free_val, ptr @pool_free_count monotonic, align 8
  br label %free_done_exit

pool_uninit_free_failure_trap:
  call void @llvm.trap() ; Freeing to a non-existent pool is a critical error
  unreachable

free_done_exit:
  ret void
}
