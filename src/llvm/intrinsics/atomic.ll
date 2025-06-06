; src/llvm/intrinsics/atomic.ll
; Atomic operations for IPC

; Simplified Message structure
%message = type {
  i32,          ; m_source
  i32,          ; m_type
  [6 x i64],    ; Unified payload
  ptr           ; Extension pointer for large messages
}

; Simplified Message Queue structure (ring buffer of message pointers)
%msg_queue = type {
  ptr,    ; Ring buffer of ptr to %message (effectively ptr*)
  i32,          ; Head index (atomic)
  i32,          ; Tail index (atomic)
  i32           ; Capacity of the ring buffer
}

; Attempts to enqueue a message pointer into the queue.
; Returns 0 on success, 1 if queue is full.
define i32 @minix_atomic_enqueue(ptr %q_ptr, ptr %msg_to_enqueue_ptr) nounwind {
entry:
  ; Get pointers to queue fields
  %ring_buffer_elements_ptr_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 0
  %head_idx_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 1
  %tail_idx_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 2
  %capacity_val_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 3

  %ring_buffer_elements_base_ptr = load ptr, ptr %ring_buffer_elements_ptr_ptr, align 8 ; this is ptr* (array of ptr to %message)
  %capacity_val = load i32, ptr %capacity_val_ptr, align 4

  ; CAS loop for tail update
cas_loop:
  %current_tail_val = load atomic i32, ptr %tail_idx_ptr seq_cst, align 4
  %current_head_val = load atomic i32, ptr %head_idx_ptr seq_cst, align 4 ; For full check

  ; Check if queue is full: (tail + 1) % capacity == head
  %next_tail_candidate_val = add i32 %current_tail_val, 1
  %next_tail_wrapped_val = urem i32 %next_tail_candidate_val, %capacity_val

  %is_queue_full = icmp eq i32 %next_tail_wrapped_val, %current_head_val
  br i1 %is_queue_full, label %fail_queue_full, label %attempt_cas

attempt_cas:
  ; Try to atomically update the tail index
  %cas_result = cmpxchg ptr %tail_idx_ptr, i32 %current_tail_val, i32 %next_tail_wrapped_val seq_cst seq_cst align 4
  %previous_tail_val = extractvalue { i32, i1 } %cas_result, 0
  %cas_succeeded = extractvalue { i32, i1 } %cas_result, 1

  br i1 %cas_succeeded, label %cas_success_store_msg, label %cas_loop ; CAS failed, retry loop

cas_success_store_msg:
  ; CAS succeeded, %current_tail_val is the slot to write to.
  ; This slot is now exclusively ours.
  %slot_to_write_ptr = getelementptr ptr, ptr %ring_buffer_elements_base_ptr, i32 %current_tail_val
  store ptr %msg_to_enqueue_ptr, ptr %slot_to_write_ptr, align 8
  ret i32 0 ; Success

fail_queue_full:
  ret i32 1 ; Queue is full
}

; Placeholder for atomic dequeue
define ptr @minix_atomic_dequeue(ptr %q_ptr) nounwind {
  ret ptr null
}
