; src/llvm/test/test_intrinsics.ll
; Tests for memory and atomic intrinsics

; External declarations for functions/globals being tested
declare void @minix_memset_dispatch(ptr, i8, i64) nounwind
declare void @minix_memcpy_vectorized(ptr, ptr, i64) nounwind
declare void @minix_memmove_vectorized(ptr, ptr, i64) nounwind

; Atomics
%message_test = type { i32, i32, [6 x i64], ptr }
%msg_queue_test = type { ptr, i64, i64, i32 }
declare i32 @minix_atomic_enqueue(ptr, ptr) nounwind
declare ptr @minix_atomic_dequeue(ptr) nounwind


; Helper to check a region of memory for a specific byte value
; Returns 1 if all bytes match, 0 otherwise.
define internal i32 @check_memory_region(ptr %start_ptr, i8 %expected_val, i64 %length) {
entry_check_mem:
  %is_zero_length = icmp eq i64 %length, 0
  br i1 %is_zero_length, label %return_success_check_mem, label %loop_header_check_mem
loop_header_check_mem:
  %end_ptr = getelementptr i8, ptr %start_ptr, i64 %length
  br label %loop_body_check_mem
loop_body_check_mem:
  %current_ptr = phi ptr [ %start_ptr, %loop_header_check_mem ], [ %next_ptr, %continue_loop_check_mem ]
  %loaded_val = load i8, ptr %current_ptr, align 1
  %is_correct = icmp eq i8 %loaded_val, %expected_val
  br i1 %is_correct, label %continue_loop_check_mem, label %return_failure_check_mem
continue_loop_check_mem:
  %next_ptr = getelementptr i8, ptr %current_ptr, i64 1
  %is_done = icmp eq ptr %next_ptr, %end_ptr
  br i1 %is_done, label %return_success_check_mem, label %loop_body_check_mem
return_success_check_mem: ret i32 1
return_failure_check_mem: ret i32 0
}

; Helper to check if two memory regions are equal
define internal i32 @compare_memory_regions(ptr %ptr1, ptr %ptr2, i64 %length) {
entry_compare_mem:
  %is_zero_length = icmp eq i64 %length, 0
  br i1 %is_zero_length, label %return_success_compare_mem, label %loop_header_compare_mem
loop_header_compare_mem:
  %end_ptr1 = getelementptr i8, ptr %ptr1, i64 %length
  br label %loop_body_compare_mem
loop_body_compare_mem:
  %current_ptr1 = phi ptr [ %ptr1, %loop_header_compare_mem ], [ %next_ptr1, %continue_loop_compare_mem ]
  %current_ptr2 = phi ptr [ %ptr2, %loop_header_compare_mem ], [ %next_ptr2, %continue_loop_compare_mem ]
  %val1 = load i8, ptr %current_ptr1, align 1
  %val2 = load i8, ptr %current_ptr2, align 1
  %is_equal = icmp eq i8 %val1, %val2
  br i1 %is_equal, label %continue_loop_compare_mem, label %return_failure_compare_mem
continue_loop_compare_mem:
  %next_ptr1 = getelementptr i8, ptr %current_ptr1, i64 1
  %next_ptr2 = getelementptr i8, ptr %current_ptr2, i64 1
  %is_done = icmp eq ptr %next_ptr1, %end_ptr1
  br i1 %is_done, label %return_success_compare_mem, label %loop_body_compare_mem
return_success_compare_mem: ret i32 1
return_failure_compare_mem: ret i32 0
}


define i32 @test_memset_alignment() {
entry_test_memset:
  %buffer_size = i64 33
  %buffer = alloca [33 x i8], align 16
  %ptr_buffer_start = getelementptr inbounds [33 x i8], ptr %buffer, i64 0, i64 0

  call void @minix_memset_dispatch(ptr %ptr_buffer_start, i8 0, i64 %buffer_size) ; Clear buffer

  %ptr1_unaligned = getelementptr i8, ptr %ptr_buffer_start, i64 1
  %val1_to_set = i8 42
  %len1_to_set = i64 31
  call void @minix_memset_dispatch(ptr %ptr1_unaligned, i8 %val1_to_set, i64 %len1_to_set)
  %check1_res = call i32 @check_memory_region(ptr %ptr1_unaligned, i8 %val1_to_set, i64 %len1_to_set)
  %test1_ok = icmp eq i32 %check1_res, 1

  call void @minix_memset_dispatch(ptr %ptr_buffer_start, i8 0, i64 %buffer_size) ; Clear buffer

  %ptr2_aligned = getelementptr i8, ptr %ptr_buffer_start, i64 0
  %val2_to_set = i8 85
  %len2_to_set = i64 17
  call void @minix_memset_dispatch(ptr %ptr2_aligned, i8 %val2_to_set, i64 %len2_to_set)
  %check2_res = call i32 @check_memory_region(ptr %ptr2_aligned, i8 %val2_to_set, i64 %len2_to_set)
  %test2_ok = icmp eq i32 %check2_res, 1

  %all_memset_tests_ok = and i1 %test1_ok, %test2_ok
  %result = zext i1 %all_memset_tests_ok to i32
  ret i32 %result
}

define i32 @test_memcpy_alignments() {
entry_memcpy_align:
  %buf_size = i64 64
  %src_buffer = alloca [64 x i8], align 16
  %dst_buffer = alloca [64 x i8], align 16
  %ptr_src_start = getelementptr inbounds [64 x i8], ptr %src_buffer, i64 0, i64 0
  %ptr_dst_start = getelementptr inbounds [64 x i8], ptr %dst_buffer, i64 0, i64 0

  ; Initialize src_buffer
  call void @minix_memset_dispatch(ptr %ptr_src_start, i8 77, i64 %buf_size)

  ; Case 1: src aligned, dst aligned
  call void @minix_memset_dispatch(ptr %ptr_dst_start, i8 0, i64 %buf_size) ; Clear dst
  call void @minix_memcpy_vectorized(ptr %ptr_dst_start, ptr %ptr_src_start, i64 32)
  %check_aa = call i32 @compare_memory_regions(ptr %ptr_dst_start, ptr %ptr_src_start, i64 32)
  %ok_aa = icmp eq i32 %check_aa, 1

  ; Case 2: src unaligned, dst aligned
  %ptr_src_ua = getelementptr i8, ptr %ptr_src_start, i64 1
  call void @minix_memset_dispatch(ptr %ptr_dst_start, i8 0, i64 %buf_size) ; Clear dst
  call void @minix_memcpy_vectorized(ptr %ptr_dst_start, ptr %ptr_src_ua, i64 31)
  %check_ua_a = call i32 @compare_memory_regions(ptr %ptr_dst_start, ptr %ptr_src_ua, i64 31)
  %ok_ua_a = icmp eq i32 %check_ua_a, 1

  ; Case 3: src aligned, dst unaligned
  %ptr_dst_ua = getelementptr i8, ptr %ptr_dst_start, i64 1
  call void @minix_memset_dispatch(ptr %ptr_dst_ua, i8 0, i64 31) ; Clear relevant part of dst
  call void @minix_memcpy_vectorized(ptr %ptr_dst_ua, ptr %ptr_src_start, i64 31)
  %check_a_ua = call i32 @compare_memory_regions(ptr %ptr_dst_ua, ptr %ptr_src_start, i64 31)
  %ok_a_ua = icmp eq i32 %check_a_ua, 1

  %res1 = and i1 %ok_aa, %ok_ua_a
  %res2 = and i1 %res1, %ok_a_ua
  %final_res = zext i1 %res2 to i32
  ret i32 %final_res
}

define i32 @test_memmove_overlap() {
entry_memmove_overlap:
  %buf_size = i64 64
  %buffer = alloca [64 x i8], align 16
  %ptr_buffer_start = getelementptr inbounds [64 x i8], ptr %buffer, i64 0, i64 0

  ; Initialize buffer with distinct values (0 to 63)
  %i_init_mv = phi i64 [0, %entry_memmove_overlap], [%next_i_init_mv, %init_loop_mv]
init_loop_mv:
  %current_val_byte_mv = trunc i64 %i_init_mv to i8
  %current_ptr_init_mv = getelementptr i8, ptr %ptr_buffer_start, i64 %i_init_mv
  store i8 %current_val_byte_mv, ptr %current_ptr_init_mv, align 1
  %next_i_init_mv = add i64 %i_init_mv, 1
  %init_done_mv = icmp eq i64 %next_i_init_mv, %buf_size
  br i1 %init_done_mv, label %init_done_label_mv, label %init_loop_mv
init_done_label_mv:

  ; Case 1: No overlap (like memcpy) src=buffer[0], dst=buffer[32], len=16
  %src1_mv = getelementptr i8, ptr %ptr_buffer_start, i64 0
  %dst1_mv = getelementptr i8, ptr %ptr_buffer_start, i64 32
  call void @minix_memmove_vectorized(ptr %dst1_mv, ptr %src1_mv, i64 16)
  %check1_mv = call i32 @compare_memory_regions(ptr %dst1_mv, ptr %src1_mv, i64 16)
  %ok1_mv = icmp eq i32 %check1_mv, 1

  ; Re-Initialize buffer before next test
  %j_reinit_mv = phi i64 [0, %init_done_label_mv], [%next_j_reinit_mv, %reinit_loop_mv]
reinit_loop_mv:
  %current_val_byte_j_mv = trunc i64 %j_reinit_mv to i8
  %current_ptr_reinit_mv = getelementptr i8, ptr %ptr_buffer_start, i64 %j_reinit_mv
  store i8 %current_val_byte_j_mv, ptr %current_ptr_reinit_mv, align 1
  %next_j_reinit_mv = add i64 %j_reinit_mv, 1
  %reinit_done_mv = icmp eq i64 %next_j_reinit_mv, %buf_size
  br i1 %reinit_done_mv, label %reinit_done_label_mv, label %reinit_loop_mv
reinit_done_label_mv:

  ; Case 2: Overlap, src < dst (requires backward copy)
  ; Copy buffer[0..9] to buffer[5..14] ; src=buffer[0], dst=buffer[5], len=10
  %src2_mv = getelementptr i8, ptr %ptr_buffer_start, i64 0
  %dst2_mv = getelementptr i8, ptr %ptr_buffer_start, i64 5

  %expected_buf2_mv_size = i64 10
  %expected_buf2_mv = alloca [10 x i8], align 1
  %k_fill_mv = phi i64 [0, %reinit_done_label_mv], [%next_k_fill_mv, %fill_expected_loop_mv]
fill_expected_loop_mv:
  %val_k_byte_mv = trunc i64 %k_fill_mv to i8 ; Expected values are 0, 1, ..., 9
  %ptr_k_mv = getelementptr i8, ptr %expected_buf2_mv, i64 %k_fill_mv
  store i8 %val_k_byte_mv, ptr %ptr_k_mv, align 1
  %next_k_fill_mv = add i64 %k_fill_mv, 1
  %fill_done_mv = icmp eq i64 %next_k_fill_mv, %expected_buf2_mv_size
  br i1 %fill_done_mv, label %fill_done_label_mv, label %fill_expected_loop_mv
fill_done_label_mv:

  call void @minix_memmove_vectorized(ptr %dst2_mv, ptr %src2_mv, i64 10)
  %check2_mv = call i32 @compare_memory_regions(ptr %dst2_mv, ptr %expected_buf2_mv, i64 10)
  %ok2_mv = icmp eq i32 %check2_mv, 1

  %res_final_mv = and i1 %ok1_mv, %ok2_mv
  %final_val_mv = zext i1 %res_final_mv to i32
  ret i32 %final_val_mv
}

define i32 @test_atomic_stress() {
entry_atomic_stress:
  %queue_capacity_as = i32 10
  %queue_mem_as = alloca %msg_queue_test, align 8
  %buffer_mem_as = alloca [10 x ptr], align 8

  %q_buf_ptr_as = getelementptr inbounds %msg_queue_test, ptr %queue_mem_as, i32 0, i32 0
  %q_head_ptr_as = getelementptr inbounds %msg_queue_test, ptr %queue_mem_as, i32 0, i32 1
  %q_tail_ptr_as = getelementptr inbounds %msg_queue_test, ptr %queue_mem_as, i32 0, i32 2
  %q_cap_ptr_as = getelementptr inbounds %msg_queue_test, ptr %queue_mem_as, i32 0, i32 3

  %ptr_to_buffer_mem_start_as = getelementptr inbounds [10 x ptr], ptr %buffer_mem_as, i64 0, i64 0
  store ptr %ptr_to_buffer_mem_start_as, ptr %q_buf_ptr_as, align 8
  store i64 0, ptr %q_head_ptr_as, align 8
  store i64 0, ptr %q_tail_ptr_as, align 8
  store i32 %queue_capacity_as, ptr %q_cap_ptr_as, align 4

  %msg_data_area_as = alloca [10 x %message_test], align 8 ; Store actual messages
  %overall_success_as = icmp eq i1 true, true

  ; Enqueue 5 items
  %idx_enq_as = phi i32 [0, %entry_atomic_stress], [%next_idx_enq_as, %enq_loop_as]
enq_loop_as:
  %current_msg_struct_ptr_as = getelementptr inbounds [10 x %message_test], ptr %msg_data_area_as, i32 0, i32 %idx_enq_as
  %m_source_ptr_as = getelementptr inbounds %message_test, ptr %current_msg_struct_ptr_as, i32 0, i32 0
  store i32 %idx_enq_as, ptr %m_source_ptr_as, align 4 ; Store index as m_source for later check

  %enq_res_as = call i32 @minix_atomic_enqueue(ptr %queue_mem_as, ptr %current_msg_struct_ptr_as)
  %enq_ok_as = icmp eq i32 %enq_res_as, 0
  %overall_success_as = and i1 %overall_success_as, %enq_ok_as
  %next_idx_enq_as = add i32 %idx_enq_as, 1
  %enq_done_as = icmp eq i32 %next_idx_enq_as, 5
  br i1 %enq_done_as, label %deq_loop_header_as, label %enq_loop_as

deq_loop_header_as:
  %idx_deq_as = phi i32 [0, %enq_done_as], [%next_idx_deq_as, %deq_loop_as]
deq_loop_as:
  %deq_msg_ptr_as = call ptr @minix_atomic_dequeue(ptr %queue_mem_as)
  %is_null_as = icmp eq ptr %deq_msg_ptr_as, null
  %overall_success_as = and i1 %overall_success_as, (icmp ne i1 %is_null_as, true))
  br i1 %is_null_as, label %deq_loop_continue_check_as, label %deq_val_check_as ; Skip val check if null

deq_val_check_as:
  %m_source_ptr_deq_as = getelementptr inbounds %message_test, ptr %deq_msg_ptr_as, i32 0, i32 0
  %val_dequeued_as = load i32, ptr %m_source_ptr_deq_as, align 4
  %deq_val_ok_as = icmp eq i32 %val_dequeued_as, %idx_deq_as
  %overall_success_as = and i1 %overall_success_as, %deq_val_ok_as
  br label %deq_loop_continue_check_as

deq_loop_continue_check_as:
  %next_idx_deq_as = add i32 %idx_deq_as, 1
  %deq_done_as = icmp eq i32 %next_idx_deq_as, 5
  br i1 %deq_done_as, label %atomic_test_final_as, label %deq_loop_as

atomic_test_final_as:
  %final_result_atomic_as = zext i1 %overall_success_as to i32
  ret i32 %final_result_atomic_as
}


define i32 @main() {
entry_main:
  %res_memset_align = call i32 @test_memset_alignment()
  %memset_pass = icmp eq i32 %res_memset_align, 1

  %res_memcpy_align = call i32 @test_memcpy_alignments()
  %memcpy_pass = icmp eq i32 %res_memcpy_align, 1

  %res_memmove_overlap = call i32 @test_memmove_overlap()
  %memmove_pass = icmp eq i32 %res_memmove_overlap, 1

  %res_atomic_stress = call i32 @test_atomic_stress()
  %atomic_pass = icmp eq i32 %res_atomic_stress, 1

  %all_tests_pass_stage1 = and i1 %memset_pass, %memcpy_pass
  %all_tests_pass_stage2 = and i1 %all_tests_pass_stage1, %memmove_pass
  %all_tests_pass_final = and i1 %all_tests_pass_stage2, %atomic_pass

  br i1 %all_tests_pass_final, label %success_main, label %failure_main

success_main:
  ret i32 0
failure_main:
  ret i32 1
}

```
