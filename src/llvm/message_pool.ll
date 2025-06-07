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
  ptr             ; free_list_head (ptr to %free_list_node, effectively the first free message)
}

; --- Global Variables ---
@global_message_pool = global ptr null, align 8 ; Ptr to the %message_pool instance
@message_pool_initialized_flag = global i32 0, align 4 ; Guard for one-time init

; --- External Function Declarations ---
declare ptr @malloc(i64) nounwind
declare void @llvm.trap() nounwind noreturn

; --- Internal Helper Functions ---

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

  %free_list_head_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3

  ; Initialize head to null before building
  store ptr null, ptr %free_list_head_ptr_loc, align 8

  %i_alloc = alloca i32, align 4
  store i32 0, ptr %i_alloc, align 4
  br label %loop_header

loop_header:
  %idx = load i32, ptr %i_alloc, align 4
  %loop_cond = icmp slt i32 %idx, %total_messages
  br i1 %loop_cond, label %loop_body, label %loop_exit

loop_body:
  %current_offset_bytes = mul i64 %message_size_64, (zext i32 %idx to i64)
  %current_msg_raw_ptr = getelementptr i8, ptr %base_addr, i64 %current_offset_bytes

  %current_node_as_freelist_ptr = bitcast ptr %current_msg_raw_ptr to ptr ; ptr to %free_list_node

  %current_head = load ptr, ptr %free_list_head_ptr_loc, align 8
  %next_ptr_in_node_loc = getelementptr inbounds %free_list_node, ptr %current_node_as_freelist_ptr, i32 0, i32 0
  store ptr %current_head, ptr %next_ptr_in_node_loc, align 8

  store ptr %current_node_as_freelist_ptr, ptr %free_list_head_ptr_loc, align 8

  %next_idx = add i32 %idx, 1
  store i32 %next_idx, ptr %i_alloc, align 4
  br label %loop_header

loop_exit:
  ret void
}

; --- Public API Functions ---

; Initializes the global message pool
define void @init_message_pool(i32 %num_messages) nounwind {
entry:
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

  %free_list_head_ptr_loc_init = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3
  store ptr null, ptr %free_list_head_ptr_loc_init, align 8

  call void @build_free_list(ptr %pool_instance)

  store ptr %pool_instance, ptr @global_message_pool, align 8
  br label %init_done

alloc_failure_trap:
  call void @llvm.trap()
  unreachable

init_done:
  ret void
}

; Allocate a message from the pool
define ptr @alloc_message() nounwind {
entry:
  %pool_instance = load ptr, ptr @global_message_pool, align 8
  %is_pool_not_init = icmp eq ptr %pool_instance, null
  br i1 %is_pool_not_init, label %alloc_pool_fail, label %alloc_pool_ok

alloc_pool_ok:
  %free_list_head_ptr_loc = getelementptr inbounds %message_pool, ptr %pool_instance, i32 0, i32 3
  %current_head_node_ptr = load ptr, ptr %free_list_head_ptr_loc, align 8 ; ptr to %free_list_node

  %is_pool_empty = icmp eq ptr %current_head_node_ptr, null
  br i1 %is_pool_empty, label %alloc_pool_fail, label %pop_from_list

pop_from_list:
  %message_to_return_raw = bitcast ptr %current_head_node_ptr to ptr ; ptr to %message

  %next_node_ptr_loc = getelementptr inbounds %free_list_node, ptr %current_head_node_ptr, i32 0, i32 0
  %next_head_node_ptr = load ptr, ptr %next_node_ptr_loc, align 8

  store ptr %next_head_node_ptr, ptr %free_list_head_ptr_loc, align 8

  ret ptr %message_to_return_raw

alloc_pool_fail:
  call void @llvm.trap()
  unreachable
}

; Return a message to the pool
define void @free_message(ptr %msg_to_free) nounwind {
entry:
  %is_msg_null_to_free = icmp eq ptr %msg_to_free, null
  br i1 %is_msg_null_to_free, label %free_done_actual, label %proceed_free_actual

proceed_free_actual:
  %pool_instance_free = load ptr, ptr @global_message_pool, align 8
  %is_pool_not_init_free = icmp eq ptr %pool_instance_free, null
  br i1 %is_pool_not_init_free, label %free_fail_panic_actual, label %pool_ok_free_actual

pool_ok_free_actual:
  %free_list_head_ptr_loc_free = getelementptr inbounds %message_pool, ptr %pool_instance_free, i32 0, i32 3
  %current_head_node_free = load ptr, ptr %free_list_head_ptr_loc_free, align 8

  %new_head_node_free = bitcast ptr %msg_to_free to ptr ; ptr to %free_list_node

  %next_ptr_in_new_head_loc_free = getelementptr inbounds %free_list_node, ptr %new_head_node_free, i32 0, i32 0
  store ptr %current_head_node_free, ptr %next_ptr_in_new_head_loc_free, align 8

  store ptr %new_head_node_free, ptr %free_list_head_ptr_loc_free, align 8
  br label %free_done_actual

free_fail_panic_actual:
  call void @llvm.trap()
  unreachable

free_done_actual:
  ret void
}
