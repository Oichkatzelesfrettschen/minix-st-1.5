; src/llvm/ipc_primitives.ll
; Implementation of asynchronous Inter-Process Communication (IPC) primitives.

@requeue_overflow_policy_g = internal global i32 0, align 4 ; 0=drop, future: 1=retry, 2=panic

; Forward declaration of types
%message = type { i32, i32, [6 x i64], ptr } ; m_source is field 0
%msg_queue = type { ptr, i64, i64, i32 }

; External function declarations
declare ptr @get_process_queue(i32 %pid) nounwind ; Defined in queue_registry.ll
declare ptr @get_current_process_message_queue() nounwind ; Hypothetical
declare i32 @minix_atomic_enqueue(ptr %q_ptr, ptr %msg_to_enqueue_ptr) nounwind ; Defined in atomic.ll
declare ptr @minix_atomic_dequeue(ptr %q_ptr) nounwind ; Defined in atomic.ll
declare i64 @llvm.readcyclecounter() nounwind readnone
declare i64 @ns_to_cycles(i64) nounwind ; From timing.ll

; Declaration for llvm.trap
declare void @llvm.trap() nounwind noreturn

; Placeholder for handling requeue buffer overflow
define internal void @handle_requeue_overflow(ptr %queue, ptr %msg) nounwind {
entry:
  %current_policy = load i32, ptr @requeue_overflow_policy_g, align 4

  ; Switch on policy, but for now, only explicitly handle 'drop' (0).
  ; Other values will fall to default and can trap, indicating unimplemented policy.
  %is_drop_policy = icmp eq i32 %current_policy, 0
  br i1 %is_drop_policy, label %policy_drop, label %policy_unsupported_or_panic

policy_drop:
  ; Policy is to drop the message %msg.
  ; This means we effectively do nothing with %msg and it's lost.
  ret void

policy_unsupported_or_panic:
  ; For any policy other than 0 (drop), or for future explicit panic policy.
  ; TODO: Implement other policies like retry N times.
  ; For now, non-drop policies are treated as critical/unhandled.
  call void @llvm.trap()
  unreachable

}

define internal void @requeue_saved_messages(ptr %queue, ptr %buffer_base_ptr, ptr %requeue_count_addr) nounwind {
entry:
  %current_requeue_count = load i32, ptr %requeue_count_addr, align 4
  %no_messages_to_requeue = icmp eq i32 %current_requeue_count, 0
  br i1 %no_messages_to_requeue, label %requeue_done, label %requeue_loop_header

requeue_loop_header:
  %loop_idx = phi i32 [ 0, %entry ], [ %next_loop_idx, %requeue_loop_body_continue ]
  %message_to_requeue_ptr_addr = getelementptr ptr, ptr %buffer_base_ptr, i32 %loop_idx
  %message_to_requeue = load ptr, ptr %message_to_requeue_ptr_addr, align 8

  %is_msg_valid = icmp ne ptr %message_to_requeue, null ; Defensive check
  br i1 %is_msg_valid, label %do_actual_requeue, label %requeue_loop_body_continue

do_actual_requeue:
  %enqueue_ret = call i32 @minix_atomic_enqueue(ptr %queue, ptr %message_to_requeue)
  %enqueue_success = icmp eq i32 %enqueue_ret, 0
  br i1 %enqueue_success, label %requeue_loop_body_continue, label %handle_overflow

handle_overflow:
  call void @handle_requeue_overflow(ptr %queue, ptr %message_to_requeue)
  ; Depending on handle_requeue_overflow's behavior (e.g., if it could return),
  ; we might continue or stop. Since it traps/unreachable, this path effectively stops.
  br label %requeue_loop_body_continue ; Or directly to requeue_done if overflow is fatal for the loop

requeue_loop_body_continue:
  %next_loop_idx = add i32 %loop_idx, 1
  %processed_all = icmp eq i32 %next_loop_idx, %current_requeue_count
  br i1 %processed_all, label %requeue_done, label %requeue_loop_header

requeue_done:
  store i32 0, ptr %requeue_count_addr, align 4 ; Reset count
  ret void
}

define i32 @minix_send_async(ptr %msg_ptr, i32 %dest_pid) nounwind {
entry_send:
  %is_msg_ptr_null_send = icmp eq ptr %msg_ptr, null
  br i1 %is_msg_ptr_null_send, label %fail_invalid_msg_ptr_send, label %lookup_queue_send

fail_invalid_msg_ptr_send:
  ret i32 3

lookup_queue_send:
  %dest_queue_ptr_send = call ptr @get_process_queue(i32 %dest_pid)
  %is_queue_ptr_null_send = icmp eq ptr %dest_queue_ptr_send, null
  br i1 %is_queue_ptr_null_send, label %fail_no_queue_send, label %enqueue_message_send

fail_no_queue_send:
  ret i32 1

enqueue_message_send:
  %enqueue_status_send = call i32 @minix_atomic_enqueue(ptr %dest_queue_ptr_send, ptr %msg_ptr)
  %enqueue_succeeded_send = icmp eq i32 %enqueue_status_send, 0
  br i1 %enqueue_succeeded_send, label %send_success, label %fail_queue_full_send

fail_queue_full_send:
  ret i32 2

send_success:
  ret i32 0
}

define i32 @minix_receive_async(ptr %msg_out_param, i32 %filter_pid_param, i64 %timeout_val_param) nounwind {
entry:
  %is_msg_out_null = icmp eq ptr %msg_out_param, null
  br i1 %is_msg_out_null, label %invalid_output_param_exit, label %initial_setup

invalid_output_param_exit:
  ret i32 -1 ; E_INVALID_PARAM

initial_setup:
  %requeue_buffer = alloca ptr, i32 32, align 8
  %requeue_count_addr = alloca i32, align 4
  store i32 0, ptr %requeue_count_addr, align 4

  %my_queue_ptr = call ptr @get_current_process_message_queue()
  %is_my_queue_null = icmp eq ptr %my_queue_ptr, null
  br i1 %is_my_queue_null, label %fail_no_queue_exit, label %determine_timeout_behavior

fail_no_queue_exit:
  store ptr null, ptr %msg_out_param, align 8
  ret i32 2 ; E_WOULD_BLOCK (no queue)

determine_timeout_behavior:
  %is_non_blocking = icmp eq i64 %timeout_val_param, 0
  %is_infinite_wait = icmp slt i64 %timeout_val_param, 0
  %is_timed_wait = icmp sgt i64 %timeout_val_param, 0

  %timeout_cycles_internal_addr = alloca i64, align 8

  br i1 %is_timed_wait, label %convert_ns_to_cycles, label %handle_special_timeout_cycles

convert_ns_to_cycles:
  %converted_cycles = call i64 @ns_to_cycles(i64 %timeout_val_param)
  store i64 %converted_cycles, ptr %timeout_cycles_internal_addr, align 8
  br label %setup_receive_loop

handle_special_timeout_cycles:
  %val_for_special_timeout = select i1 %is_non_blocking, i64 0, i64 -1 ; 0 for non-blocking, -1 for infinite (marker)
  store i64 %val_for_special_timeout, ptr %timeout_cycles_internal_addr, align 8
  br label %setup_receive_loop

setup_receive_loop:
  %start_cycles = call i64 @llvm.readcyclecounter()
  %timeout_occurred_flag_addr = alloca i1, align 1
  store i1 false, ptr %timeout_occurred_flag_addr, align 1
  br label %receive_loop

receive_loop:
  ; Check for timeout only if it's a timed wait. Non-blocking handled by empty queue. Infinite never times out here.
  br i1 %is_timed_wait, label %evaluate_timed_wait_in_loop, label %proceed_dequeue

evaluate_timed_wait_in_loop:
  %current_cycles_loop = call i64 @llvm.readcyclecounter()
  %elapsed_cycles_loop = sub i64 %current_cycles_loop, %start_cycles
  %loaded_timeout_cycles = load i64, ptr %timeout_cycles_internal_addr, align 8
  %timeout_exceeded_loop = icmp uge i64 %elapsed_cycles_loop, %loaded_timeout_cycles
  br i1 %timeout_exceeded_loop, label %handle_timeout_event_occurred, label %proceed_dequeue

handle_timeout_event_occurred:
  store i1 true, ptr %timeout_occurred_flag_addr, align 1
  br label %final_requeue_and_exit ; Timeout detected, proceed to exit sequence

proceed_dequeue:
  %dequeued_msg = call ptr @minix_atomic_dequeue(ptr %my_queue_ptr)
  %is_msg_dequeued_null = icmp eq ptr %dequeued_msg, null
  br i1 %is_msg_dequeued_null, label %handle_empty_main_queue, label %check_filter

check_filter:
  %msg_source_addr = getelementptr inbounds %message, ptr %dequeued_msg, i32 0, i32 0
  %msg_source_pid = load i32, ptr %msg_source_addr, align 4
  %filter_is_any = icmp eq i32 %filter_pid_param, -1 ; ANY_SOURCE is PID -1
  %pid_matches_filter = icmp eq i32 %msg_source_pid, %filter_pid_param
  %accept_this_message = or i1 %filter_is_any, %pid_matches_filter
  br i1 %accept_this_message, label %accept_message_path, label %save_for_requeue_path

save_for_requeue_path:
  %current_requeue_count = load i32, ptr %requeue_count_addr, align 4
  %is_requeue_buffer_full = icmp sge i32 %current_requeue_count, 32
  br i1 %is_requeue_buffer_full, label %handle_requeue_buffer_full, label %add_to_requeue_buffer

add_to_requeue_buffer:
  %requeue_slot_addr = getelementptr ptr, ptr %requeue_buffer, i32 %current_requeue_count
  store ptr %dequeued_msg, ptr %requeue_slot_addr, align 8
  %new_requeue_count = add i32 %current_requeue_count, 1
  store i32 %new_requeue_count, ptr %requeue_count_addr, align 4
  br label %receive_loop

handle_requeue_buffer_full:
  call void @requeue_saved_messages(ptr %my_queue_ptr, ptr %requeue_buffer, ptr %requeue_count_addr)
  %requeue_slot_for_current = getelementptr ptr, ptr %requeue_buffer, i32 0
  store ptr %dequeued_msg, ptr %requeue_slot_for_current, align 8
  store i32 1, ptr %requeue_count_addr, align 4
  br label %receive_loop

accept_message_path:
  call void @requeue_saved_messages(ptr %my_queue_ptr, ptr %requeue_buffer, ptr %requeue_count_addr)
  store ptr %dequeued_msg, ptr %msg_out_param, align 8
  ret i32 0 ; Success

handle_empty_main_queue:
  %timeout_flag_is_set = load i1, ptr %timeout_occurred_flag_addr, align 1
  %exit_due_to_timeout = and i1 %timeout_flag_is_set, true
  %exit_due_to_non_blocking = and i1 %is_non_blocking_call, true
  %should_exit_now = or i1 %exit_due_to_timeout, %exit_due_to_non_blocking
  br i1 %should_exit_now, label %final_requeue_and_exit, label %receive_loop

final_requeue_and_exit:
  call void @requeue_saved_messages(ptr %my_queue_ptr, ptr %requeue_buffer, ptr %requeue_count_addr)
  store ptr null, ptr %msg_out_param, align 8
  %final_timeout_status = load i1, ptr %timeout_occurred_flag_addr, align 1
  %status_code = select i1 %final_timeout_status, i32 1, i32 2 ; 1 for timeout, 2 for E_WOULD_BLOCK/no_msg
  ret i32 %status_code
}
