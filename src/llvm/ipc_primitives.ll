; src/llvm/ipc_primitives.ll
; Implementation of asynchronous Inter-Process Communication (IPC) primitives.

; Forward declaration of types
%message = type { i32, i32, [6 x i64], ptr } ; m_source is field 0
%msg_queue = type { ptr, i64, i64, i32 }

; External function declarations
declare ptr @get_process_queue(i32 %pid) nounwind ; Defined in queue_registry.ll
declare ptr @get_current_process_message_queue() nounwind ; Hypothetical
declare i32 @minix_atomic_enqueue(ptr %q_ptr, ptr %msg_to_enqueue_ptr) nounwind ; Defined in atomic.ll
declare ptr @minix_atomic_dequeue(ptr %q_ptr) nounwind ; Defined in atomic.ll
declare i64 @llvm.readcyclecounter() nounwind readnone


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

define ptr @minix_receive_async(i32 %source_pid_filter, i64 %timeout_us) nounwind {
entry_receive:
  %current_queue_ptr = call ptr @get_current_process_message_queue()
  %is_current_queue_null = icmp eq ptr %current_queue_ptr, null
  br i1 %is_current_queue_null, label %fail_receive_no_queue, label %initial_dequeue_or_setup_loop

fail_receive_no_queue:
  ret ptr null

initial_dequeue_or_setup_loop:
  ; Handle non-blocking case first: timeout_us == 0
  %is_non_blocking = icmp eq i64 %timeout_us, 0
  br i1 %is_non_blocking, label %try_dequeue_once, label %setup_loop_receive

try_dequeue_once: ; Non-blocking path
  %dequeued_msg_nb = call ptr @minix_atomic_dequeue(ptr %current_queue_ptr)
  %is_msg_null_nb = icmp eq ptr %dequeued_msg_nb, null
  br i1 %is_msg_null_nb, label %return_null_receive, label %check_filter_nb
check_filter_nb:
  %filter_is_any_nb = icmp eq i32 %source_pid_filter, 0
  br i1 %filter_is_any_nb, label %return_message_nb, label %eval_pid_filter_nb
eval_pid_filter_nb:
  %m_source_ptr_nb = getelementptr inbounds %message, ptr %dequeued_msg_nb, i32 0, i32 0
  %actual_source_pid_nb = load i32, ptr %m_source_ptr_nb, align 4
  %pid_match_nb = icmp eq i32 %actual_source_pid_nb, %source_pid_filter
  br i1 %pid_match_nb, label %return_message_nb, label %return_null_receive ; Mismatch on non-blocking, return null
return_message_nb:
  ret ptr %dequeued_msg_nb

setup_loop_receive: ; Timed or infinite blocking path
  %is_infinite_wait = icmp slt i64 %timeout_us, 0 ; Negative timeout means infinite
  %start_cycles = call i64 @llvm.readcyclecounter()
  ; TODO: Convert %timeout_us (microseconds) to %timeout_cycles. For now, treat %timeout_us as cycles if > 0.
  %timeout_as_cycles = select i1 %is_infinite_wait, i64 -1, i64 %timeout_us ; Use -1 to mark infinite for loop logic

  br label %poll_loop_receive

poll_loop_receive:
  ; Dequeue attempt
  %dequeued_msg_loop = call ptr @minix_atomic_dequeue(ptr %current_queue_ptr)
  %is_msg_null_loop = icmp eq ptr %dequeued_msg_loop, null
  br i1 %is_msg_null_loop, label %check_timeout_receive, label %check_filter_loop

check_filter_loop:
  %filter_is_any_loop = icmp eq i32 %source_pid_filter, 0
  br i1 %filter_is_any_loop, label %return_message_loop, label %eval_pid_filter_loop
eval_pid_filter_loop:
  %m_source_ptr_loop = getelementptr inbounds %message, ptr %dequeued_msg_loop, i32 0, i32 0
  %actual_source_pid_loop = load i32, ptr %m_source_ptr_loop, align 4
  %pid_match_loop = icmp eq i32 %actual_source_pid_loop, %source_pid_filter
  br i1 %pid_match_loop, label %return_message_loop, label %check_timeout_receive ; Mismatch, continue polling (effectively skipping for this call)
return_message_loop:
  ret ptr %dequeued_msg_loop

check_timeout_receive:
  %is_still_infinite = icmp eq i64 %timeout_as_cycles, -1
  br i1 %is_still_infinite, label %poll_loop_receive, label %process_finite_timeout ; If infinite, just loop back

process_finite_timeout:
  %current_cycles = call i64 @llvm.readcyclecounter()
  %elapsed_cycles = sub i64 %current_cycles, %start_cycles
  %timeout_exceeded = icmp uge i64 %elapsed_cycles, %timeout_as_cycles
  br i1 %timeout_exceeded, label %return_null_receive, label %poll_loop_receive

return_null_receive:
  ret ptr null
}
