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
; Head and Tail now store {i32 index, i32 tag} packed into an i64.
; Lower 32 bits: index, Upper 32 bits: tag.
%msg_queue = type {
  ptr,    ; Ring buffer of ptr to %message (effectively ptr*)
  i64,          ; Head: packed {index, tag} (atomic)
  i64,          ; Tail: packed {index, tag} (atomic)
  i32           ; Capacity of the ring buffer
}

; Attempts to enqueue a message pointer into the queue.
; Returns 0 on success, 1 if queue is full.
define i32 @minix_atomic_enqueue(ptr %q_ptr, ptr %msg_to_enqueue_ptr) nounwind {
entry:

%ring_buffer_elements_ptr_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 0

  %head_packed_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 1
  %tail_packed_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 2
  %capacity_val_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 3

  %ring_buffer_elements_base_ptr = load ptr, ptr %ring_buffer_elements_ptr_ptr, align 8
  %capacity_val = load i32, ptr %capacity_val_ptr, align 4

cas_loop_enqueue:
  %current_tail_packed = load atomic i64, ptr %tail_packed_ptr acquire, align 8
  %current_head_packed = load atomic i64, ptr %head_packed_ptr acquire, align 8

  %current_tail_idx_tmp = trunc i64 %current_tail_packed to i32
  %current_tail_tag_tmp = lshr i64 %current_tail_packed, 32
  %current_tail_tag = trunc i64 %current_tail_tag_tmp to i32
  %current_head_idx = trunc i64 %current_head_packed to i32

  %next_tail_idx_candidate = add i32 %current_tail_idx_tmp, 1
  %next_tail_idx_wrapped = urem i32 %next_tail_idx_candidate, %capacity_val

  %is_queue_full = icmp eq i32 %next_tail_idx_wrapped, %current_head_idx
  br i1 %is_queue_full, label %fail_queue_full_enqueue, label %attempt_cas_enqueue

attempt_cas_enqueue:
  %incremented_tail_tag = add i32 %current_tail_tag, 1
  %tag_wrapped_to_zero = icmp eq i32 %incremented_tail_tag, 0
  %final_new_tail_tag = select i1 %tag_wrapped_to_zero, i32 1, i32 %incremented_tail_tag ; Skip 0 on wrap

  %next_tail_idx_wrapped_64 = zext i32 %next_tail_idx_wrapped to i64
  %final_new_tail_tag_64 = zext i32 %final_new_tail_tag to i64
  %final_new_tail_tag_shifted_64 = shl i64 %final_new_tail_tag_64, 32
  %new_packed_tail_val = or i64 %next_tail_idx_wrapped_64, %final_new_tail_tag_shifted_64

  %cas_result_enqueue = cmpxchg ptr %tail_packed_ptr, i64 %current_tail_packed, i64 %new_packed_tail_val acq_rel acq_rel align 8
  %cas_succeeded_enqueue = extractvalue { i64, i1 } %cas_result_enqueue, 1

  br i1 %cas_succeeded_enqueue, label %cas_success_store_msg_enqueue, label %cas_loop_enqueue

cas_success_store_msg_enqueue:
  %slot_to_write_ptr = getelementptr ptr, ptr %ring_buffer_elements_base_ptr, i32 %current_tail_idx_tmp
  store ptr %msg_to_enqueue_ptr, ptr %slot_to_write_ptr, align 8
  ret i32 0

fail_queue_full_enqueue:
  ret i32 1
}

; Attempts to dequeue a message pointer from the queue.
; Returns ptr to %message on success, ptr null if queue is empty.
define ptr @minix_atomic_dequeue(ptr %q_ptr) nounwind {
entry_dequeue:
  %ring_buffer_elements_ptr_ptr_dq = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 0
  %head_packed_ptr_dq = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 1
  %tail_packed_ptr_dq = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 2
  %capacity_val_ptr_dq = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 3

  %ring_buffer_elements_base_ptr_dq = load ptr, ptr %ring_buffer_elements_ptr_ptr_dq, align 8
  %capacity_val_dq = load i32, ptr %capacity_val_ptr_dq, align 4

cas_loop_dequeue:
  %current_head_packed_dq = load atomic i64, ptr %head_packed_ptr_dq acquire, align 8
  %current_tail_packed_dq = load atomic i64, ptr %tail_packed_ptr_dq acquire, align 8

  %current_head_idx_dq_tmp = trunc i64 %current_head_packed_dq to i32
  %current_head_tag_dq_tmp = lshr i64 %current_head_packed_dq, 32
  %current_head_tag_dq = trunc i64 %current_head_tag_dq_tmp to i32
  %current_tail_idx_dq = trunc i64 %current_tail_packed_dq to i32

  %is_queue_empty = icmp eq i32 %current_head_idx_dq_tmp, %current_tail_idx_dq
  br i1 %is_queue_empty, label %fail_queue_empty_dequeue, label %attempt_cas_dequeue

attempt_cas_dequeue:
  %next_head_idx_candidate_dq = add i32 %current_head_idx_dq_tmp, 1
  %next_head_idx_wrapped_dq = urem i32 %next_head_idx_candidate_dq, %capacity_val_dq

  %incremented_head_tag_dq = add i32 %current_head_tag_dq, 1
  %head_tag_wrapped_to_zero_dq = icmp eq i32 %incremented_head_tag_dq, 0
  %final_new_head_tag_dq = select i1 %head_tag_wrapped_to_zero_dq, i32 1, i32 %incremented_head_tag_dq ; Skip 0 on wrap

  %next_head_idx_wrapped_64_dq = zext i32 %next_head_idx_wrapped_dq to i64
  %final_new_head_tag_64_dq = zext i32 %final_new_head_tag_dq to i64
  %final_new_head_tag_shifted_64_dq = shl i64 %final_new_head_tag_64_dq, 32
  %new_packed_head_val_dq = or i64 %next_head_idx_wrapped_64_dq, %final_new_head_tag_shifted_64_dq

  %cas_result_dequeue = cmpxchg ptr %head_packed_ptr_dq, i64 %current_head_packed_dq, i64 %new_packed_head_val_dq acq_rel acq_rel align 8
  %cas_succeeded_dequeue = extractvalue { i64, i1 } %cas_result_dequeue, 1

  br i1 %cas_succeeded_dequeue, label %cas_success_load_msg_dequeue, label %cas_loop_dequeue

cas_success_load_msg_dequeue:
  %slot_to_read_ptr_dq = getelementptr ptr, ptr %ring_buffer_elements_base_ptr_dq, i32 %current_head_idx_dq_tmp
  %dequeued_msg_ptr = load atomic ptr, ptr %slot_to_read_ptr_dq acquire, align 8
  ret ptr %dequeued_msg_ptr

fail_queue_empty_dequeue:

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
