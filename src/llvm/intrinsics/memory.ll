; src/llvm/intrinsics/memory.ll
; Vectorized memory operations

; Constants for vector widths
@vector_width_sse = internal constant i32 16    ; 128-bit
@vector_width_avx = internal constant i32 32    ; 256-bit
@vector_width_avx512 = internal constant i32 64 ; 512-bit

; External CPU feature flags (defined in arch_config.ll)
@has_avx2 = external global i1
@has_sse2 = external global i1

!nontemporal_memset_hint = !{i32 1}

define void @minix_memset_v128(ptr %ptr, i8 %val, i64 %size) nounwind {
entry_v128:
  %ptr_int_v128 = ptrtoint ptr %ptr to i64
  %alignment_offset_v128 = and i64 %ptr_int_v128, 15
  %is_directly_aligned_v128 = icmp eq i64 %alignment_offset_v128, 0
  br i1 %is_directly_aligned_v128, label %vector_setup_v128, label %scalar_prefix_check_v128

scalar_prefix_check_v128:
  %bytes_to_align_v128 = sub i64 16, %alignment_offset_v128
  %prefix_size_v128 = select i1 (icmp ugt i64 %bytes_to_align_v128, %size), i64 %size, i64 %bytes_to_align_v128
  %no_prefix_v128 = icmp eq i64 %prefix_size_v128, 0
  br i1 %no_prefix_v128, label %vector_setup_v128, label %scalar_prefix_loop_header_v128

scalar_prefix_loop_header_v128:
  %prefix_end_ptr_v128 = getelementptr i8, ptr %ptr, i64 %prefix_size_v128
  br label %scalar_prefix_loop_v128

scalar_prefix_loop_v128:
  %current_prefix_ptr_v128 = phi ptr [ %ptr, %scalar_prefix_loop_header_v128 ], [ %next_prefix_ptr_v128, %scalar_prefix_loop_v128 ]
  store i8 %val, ptr %current_prefix_ptr_v128, align 1
  %next_prefix_ptr_v128 = getelementptr i8, ptr %current_prefix_ptr_v128, i64 1
  %prefix_loop_done_v128 = icmp eq ptr %next_prefix_ptr_v128, %prefix_end_ptr_v128
  br i1 %prefix_loop_done_v128, label %vector_setup_v128, label %scalar_prefix_loop_v128

vector_setup_v128:
  %vec_start_ptr_v128 = phi ptr [ %ptr, %entry_v128 ], [ %prefix_end_ptr_v128, %scalar_prefix_loop_v128 ]
  %size_after_prefix_v128 = phi i64 [ %size, %entry_v128 ], [ sub i64 %size, %prefix_size_v128, %scalar_prefix_loop_v128 ]
  %val_vec_elem_v128 = insertelement <16 x i8> undef, i8 %val, i32 0
  %splat_vector_v128 = shufflevector <16 x i8> %val_vec_elem_v128, <16 x i8> undef, <16 x i32> zeroinitializer
  %num_vector_bytes_v128 = and i64 %size_after_prefix_v128, -16
  %vector_loop_end_ptr_v128 = getelementptr i8, ptr %vec_start_ptr_v128, i64 %num_vector_bytes_v128
  %no_vector_ops_v128 = icmp eq i64 %num_vector_bytes_v128, 0
  br i1 %no_vector_ops_v128, label %scalar_suffix_setup_v128, label %vector_loop_header_v128

vector_loop_header_v128:
  br label %vector_loop_v128

vector_loop_v128:
  %current_vector_ptr_v128 = phi ptr [ %vec_start_ptr_v128, %vector_loop_header_v128 ], [ %next_vector_ptr_v128, %vector_loop_v128 ]
  %typed_vec_ptr_v128 = bitcast ptr %current_vector_ptr_v128 to ptr
  store <16 x i8> %splat_vector_v128, ptr %typed_vec_ptr_v128, align 16, !nontemporal !nontemporal_memset_hint
  %next_vector_ptr_v128 = getelementptr i8, ptr %current_vector_ptr_v128, i64 16
  %vector_loop_done_v128 = icmp eq ptr %next_vector_ptr_v128, %vector_loop_end_ptr_v128
  br i1 %vector_loop_done_v128, label %scalar_suffix_setup_v128, label %vector_loop_v128

scalar_suffix_setup_v128:
  %suffix_start_ptr_v128 = phi ptr [ %vec_start_ptr_v128, %vector_loop_header_v128 ], [ %vector_loop_end_ptr_v128, %vector_loop_v128 ]
  %size_for_suffix_v128 = phi i64 [ %size_after_prefix_v128, %vector_loop_header_v128 ], [ sub i64 %size_after_prefix_v128, %num_vector_bytes_v128, %vector_loop_v128 ]
  %suffix_end_ptr_v128 = getelementptr i8, ptr %suffix_start_ptr_v128, i64 %size_for_suffix_v128
  %no_suffix_v128 = icmp eq i64 %size_for_suffix_v128, 0
  br i1 %no_suffix_v128, label %memset_done_v128, label %scalar_suffix_loop_header_v128

scalar_suffix_loop_header_v128:
  br label %scalar_suffix_loop_v128

scalar_suffix_loop_v128:
  %current_suffix_ptr_v128 = phi ptr [ %suffix_start_ptr_v128, %scalar_suffix_loop_header_v128 ], [ %next_suffix_ptr_v128, %scalar_suffix_loop_v128 ]
  store i8 %val, ptr %current_suffix_ptr_v128, align 1
  %next_suffix_ptr_v128 = getelementptr i8, ptr %current_suffix_ptr_v128, i64 1
  %suffix_loop_done_v128 = icmp eq ptr %next_suffix_ptr_v128, %suffix_end_ptr_v128
  br i1 %suffix_loop_done_v128, label %memset_done_v128, label %scalar_suffix_loop_v128

memset_done_v128:
  ret void
}

define void @minix_memset_v256(ptr %ptr, i8 %val, i64 %size) available_externally target("avx2") nounwind {
entry_v256:
  %ptr_int_v256 = ptrtoint ptr %ptr to i64
  %alignment_offset_v256 = and i64 %ptr_int_v256, 31
  %is_directly_aligned_v256 = icmp eq i64 %alignment_offset_v256, 0
  br i1 %is_directly_aligned_v256, label %vector_setup_v256, label %scalar_prefix_check_v256

scalar_prefix_check_v256:
  %bytes_to_align_v256 = sub i64 32, %alignment_offset_v256
  %prefix_size_v256 = select i1 (icmp ugt i64 %bytes_to_align_v256, %size), i64 %size, i64 %bytes_to_align_v256
  %no_prefix_v256 = icmp eq i64 %prefix_size_v256, 0
  br i1 %no_prefix_v256, label %vector_setup_v256, label %scalar_prefix_loop_header_v256

scalar_prefix_loop_header_v256:
  %prefix_end_ptr_v256 = getelementptr i8, ptr %ptr, i64 %prefix_size_v256
  br label %scalar_prefix_loop_v256

scalar_prefix_loop_v256:
  %current_prefix_ptr_v256 = phi ptr [ %ptr, %scalar_prefix_loop_header_v256 ], [ %next_prefix_ptr_v256, %scalar_prefix_loop_v256 ]
  store i8 %val, ptr %current_prefix_ptr_v256, align 1
  %next_prefix_ptr_v256 = getelementptr i8, ptr %current_prefix_ptr_v256, i64 1
  %prefix_loop_done_v256 = icmp eq ptr %next_prefix_ptr_v256, %prefix_end_ptr_v256
  br i1 %prefix_loop_done_v256, label %vector_setup_v256, label %scalar_prefix_loop_v256

vector_setup_v256:
  %vec_start_ptr_v256 = phi ptr [ %ptr, %entry_v256 ], [ %prefix_end_ptr_v256, %scalar_prefix_loop_v256 ]
  %size_after_prefix_v256 = phi i64 [ %size, %entry_v256 ], [ sub i64 %size, %prefix_size_v256, %scalar_prefix_loop_v256 ]
  %val_vec_elem_v256 = insertelement <32 x i8> undef, i8 %val, i32 0
  %splat_vector_v256 = shufflevector <32 x i8> %val_vec_elem_v256, <32 x i8> undef, <32 x i32> zeroinitializer
  %num_vector_bytes_v256 = and i64 %size_after_prefix_v256, -32
  %vector_loop_end_ptr_v256 = getelementptr i8, ptr %vec_start_ptr_v256, i64 %num_vector_bytes_v256
  %no_vector_ops_v256 = icmp eq i64 %num_vector_bytes_v256, 0
  br i1 %no_vector_ops_v256, label %scalar_suffix_setup_v256, label %vector_loop_header_v256

vector_loop_header_v256:
  br label %vector_loop_v256

vector_loop_v256:
  %current_vector_ptr_v256 = phi ptr [ %vec_start_ptr_v256, %vector_loop_header_v256 ], [ %next_vector_ptr_v256, %vector_loop_v256 ]
  %typed_vec_ptr_v256 = bitcast ptr %current_vector_ptr_v256 to ptr
  store <32 x i8> %splat_vector_v256, ptr %typed_vec_ptr_v256, align 32
  %next_vector_ptr_v256 = getelementptr i8, ptr %current_vector_ptr_v256, i64 32
  %vector_loop_done_v256 = icmp eq ptr %next_vector_ptr_v256, %vector_loop_end_ptr_v256
  br i1 %vector_loop_done_v256, label %scalar_suffix_setup_v256, label %vector_loop_v256

scalar_suffix_setup_v256:
  %suffix_start_ptr_v256 = phi ptr [ %vec_start_ptr_v256, %vector_loop_header_v256 ], [ %vector_loop_end_ptr_v256, %vector_loop_v256 ]
  %size_for_suffix_v256 = phi i64 [ %size_after_prefix_v256, %vector_loop_header_v256 ], [ sub i64 %size_after_prefix_v256, %num_vector_bytes_v256, %vector_loop_v256 ]
  %suffix_end_ptr_v256 = getelementptr i8, ptr %suffix_start_ptr_v256, i64 %size_for_suffix_v256
  %no_suffix_v256 = icmp eq i64 %size_for_suffix_v256, 0
  br i1 %no_suffix_v256, label %memset_done_v256, label %scalar_suffix_loop_header_v256

scalar_suffix_loop_header_v256:
  br label %scalar_suffix_loop_v256

scalar_suffix_loop_v256:
  %current_suffix_ptr_v256 = phi ptr [ %suffix_start_ptr_v256, %scalar_suffix_loop_header_v256 ], [ %next_suffix_ptr_v256, %scalar_suffix_loop_v256 ]
  store i8 %val, ptr %current_suffix_ptr_v256, align 1
  %next_suffix_ptr_v256 = getelementptr i8, ptr %current_suffix_ptr_v256, i64 1
  %suffix_loop_done_v256 = icmp eq ptr %next_suffix_ptr_v256, %suffix_end_ptr_v256
  br i1 %suffix_loop_done_v256, label %memset_done_v256, label %scalar_suffix_loop_v256

memset_done_v256:
  ret void
}

define void @minix_memset_dispatch(ptr %ptr, i8 %val, i64 %size) nounwind {
entry_dispatch:
  %avx2_is_available = load i1, ptr @has_avx2, align 1
  br i1 %avx2_is_available, label %dispatch_use_avx2, label %dispatch_check_sse2

dispatch_use_avx2:
  call void @minix_memset_v256(ptr %ptr, i8 %val, i64 %size)
  ret void

dispatch_check_sse2:
  %sse2_is_available = load i1, ptr @has_sse2, align 1
  br i1 %sse2_is_available, label %dispatch_use_sse2, label %dispatch_use_scalar

dispatch_use_sse2:
  call void @minix_memset_v128(ptr %ptr, i8 %val, i64 %size)
  ret void

dispatch_use_scalar:
  call void @minix_memset_scalar(ptr %ptr, i8 %val, i64 %size)
  ret void
}

define void @minix_memset_scalar(ptr %ptr, i8 %val, i64 %size) nounwind {
entry_scalar:
  %end_ptr_scalar = getelementptr i8, ptr %ptr, i64 %size
  %loop_start_condition_scalar = icmp eq ptr %ptr, %end_ptr_scalar
  br i1 %loop_start_condition_scalar, label %scalar_memset_done, label %scalar_memset_loop_header

scalar_memset_loop_header:
  br label %scalar_memset_loop

scalar_memset_loop:
  %current_ptr_scalar = phi ptr [ %ptr, %scalar_memset_loop_header ], [ %next_ptr_scalar, %scalar_memset_loop ]
  store i8 %val, ptr %current_ptr_scalar, align 1
  %next_ptr_scalar = getelementptr i8, ptr %current_ptr_scalar, i64 1
  %loop_done_scalar = icmp eq ptr %next_ptr_scalar, %end_ptr_scalar
  br i1 %loop_done_scalar, label %scalar_memset_done, label %scalar_memset_loop

scalar_memset_done:
  ret void
}

define void @minix_memcpy_vectorized(ptr %dst, ptr %src, i64 %size) nounwind {
entry_memcpy:
  %is_zero_size = icmp eq i64 %size, 0
  br i1 %is_zero_size, label %memcpy_done, label %initial_alignment_check_memcpy

initial_alignment_check_memcpy:
  %dst_as_int = ptrtoint ptr %dst to i64
  %src_as_int = ptrtoint ptr %src to i64
  %dst_align_val = and i64 %dst_as_int, 15
  %src_align_val = and i64 %src_as_int, 15

  %dst_is_16_aligned = icmp eq i64 %dst_align_val, 0
  %src_is_16_aligned = icmp eq i64 %src_align_val, 0
  %both_dst_src_16_aligned = and i1 %dst_is_16_aligned, %src_is_16_aligned

  br i1 %both_dst_src_16_aligned, label %vector_setup_aligned_src_dst_memcpy, label %align_dst_path_memcpy

align_dst_path_memcpy:
  %dst_alignment_offset_for_prefix = and i64 %dst_as_int, 15
  %dst_is_already_aligned_for_prefix = icmp eq i64 %dst_alignment_offset_for_prefix, 0
  br i1 %dst_is_already_aligned_for_prefix, label %vector_setup_unaligned_src_memcpy, label %scalar_prefix_memcpy_header

scalar_prefix_memcpy_header:
  %bytes_to_align_dst = sub i64 16, %dst_alignment_offset_for_prefix
  %prefix_actual_size = select i1 (icmp ugt i64 %bytes_to_align_dst, %size), i64 %size, i64 %bytes_to_align_dst
  %prefix_dst_end_ptr = getelementptr i8, ptr %dst, i64 %prefix_actual_size
  %no_prefix_work = icmp eq i64 %prefix_actual_size, 0
  br i1 %no_prefix_work, label %vector_setup_unaligned_src_memcpy, label %scalar_prefix_memcpy_loop

scalar_prefix_memcpy_loop:
  %current_dst_prefix_mc = phi ptr [ %dst, %scalar_prefix_memcpy_header ], [ %next_dst_prefix_mc, %scalar_prefix_memcpy_loop ]
  %current_src_prefix_mc = phi ptr [ %src, %scalar_prefix_memcpy_header ], [ %next_src_prefix_mc, %scalar_prefix_memcpy_loop ]
  %byte_loaded_mc = load i8, ptr %current_src_prefix_mc, align 1
  store i8 %byte_loaded_mc, ptr %current_dst_prefix_mc, align 1
  %next_dst_prefix_mc = getelementptr i8, ptr %current_dst_prefix_mc, i64 1
  %next_src_prefix_mc = getelementptr i8, ptr %current_src_prefix_mc, i64 1
  %prefix_done_mc = icmp eq ptr %next_dst_prefix_mc, %prefix_dst_end_ptr
  br i1 %prefix_done_mc, label %vector_setup_unaligned_src_memcpy, label %scalar_prefix_memcpy_loop

vector_setup_aligned_src_dst_memcpy:
  %vec_dst_start_aasd = phi ptr [ %dst, %initial_alignment_check_memcpy ]
  %vec_src_start_aasd = phi ptr [ %src, %initial_alignment_check_memcpy ]
  %size_aasd = phi i64 [ %size, %initial_alignment_check_memcpy ]
  %num_vector_bytes_aasd = and i64 %size_aasd, -16
  %vector_dst_end_aasd = getelementptr i8, ptr %vec_dst_start_aasd, i64 %num_vector_bytes_aasd
  %no_vector_work_aasd = icmp eq i64 %num_vector_bytes_aasd, 0
  br i1 %no_vector_work_aasd,
    label %scalar_suffix_memcpy_setup_from_aligned,
    label %vector_memcpy_loop_header_aasd

vector_memcpy_loop_header_aasd:
  br label %vector_memcpy_loop_aasd

vector_memcpy_loop_aasd:
  %current_dst_vec_aasd = phi ptr [ %vec_dst_start_aasd, %vector_memcpy_loop_header_aasd ], [ %next_dst_vec_aasd, %vector_memcpy_loop_aasd ]
  %current_src_vec_aasd = phi ptr [ %vec_src_start_aasd, %vector_memcpy_loop_header_aasd ], [ %next_src_vec_aasd, %vector_memcpy_loop_aasd ]
  %typed_src_vec_ptr_aasd = bitcast ptr %current_src_vec_aasd to ptr
  %loaded_vector_aasd = load <16 x i8>, ptr %typed_src_vec_ptr_aasd, align 16
  %typed_dst_vec_ptr_aasd = bitcast ptr %current_dst_vec_aasd to ptr
  store <16 x i8> %loaded_vector_aasd, ptr %typed_dst_vec_ptr_aasd, align 16
  %next_dst_vec_aasd = getelementptr i8, ptr %current_dst_vec_aasd, i64 16
  %next_src_vec_aasd = getelementptr i8, ptr %current_src_vec_aasd, i64 16
  %vector_part_done_aasd = icmp eq ptr %next_dst_vec_aasd, %vector_dst_end_aasd
  br i1 %vector_part_done_aasd,
    label %scalar_suffix_memcpy_setup_from_aligned,
    label %vector_memcpy_loop_aasd

vector_setup_unaligned_src_memcpy:
  %vec_dst_start_uas = phi ptr [ %dst, %align_dst_path_memcpy ], [ %prefix_dst_end_ptr, %scalar_prefix_memcpy_loop ]
  %vec_src_start_uas = phi ptr [ %src, %align_dst_path_memcpy ], [ %next_src_prefix_mc, %scalar_prefix_memcpy_loop ]
  %size_after_prefix_uas = phi i64 [ %size, %align_dst_path_memcpy ], [ sub i64 %size, %prefix_actual_size, %scalar_prefix_memcpy_loop ]
  %num_vector_bytes_uas = and i64 %size_after_prefix_uas, -16
  %vector_dst_end_uas = getelementptr i8, ptr %vec_dst_start_uas, i64 %num_vector_bytes_uas
  %no_vector_work_uas = icmp eq i64 %num_vector_bytes_uas, 0
  br i1 %no_vector_work_uas,
    label %scalar_suffix_memcpy_setup_from_unaligned,
    label %vector_memcpy_loop_header_uas

vector_memcpy_loop_header_uas:
  br label %vector_memcpy_loop_uas

vector_memcpy_loop_uas:
  %current_dst_vec_uas = phi ptr [ %vec_dst_start_uas, %vector_memcpy_loop_header_uas ], [ %next_dst_vec_uas, %vector_memcpy_loop_uas ]
  %current_src_vec_uas = phi ptr [ %vec_src_start_uas, %vector_memcpy_loop_header_uas ], [ %next_src_vec_uas, %vector_memcpy_loop_uas ]
  %typed_src_vec_ptr_uas = bitcast ptr %current_src_vec_uas to ptr
  %loaded_vector_uas = load <16 x i8>, ptr %typed_src_vec_ptr_uas, align 1
  %typed_dst_vec_ptr_uas = bitcast ptr %current_dst_vec_uas to ptr
  store <16 x i8> %loaded_vector_uas, ptr %typed_dst_vec_ptr_uas, align 16
  %next_dst_vec_uas = getelementptr i8, ptr %current_dst_vec_uas, i64 16
  %next_src_vec_uas = getelementptr i8, ptr %current_src_vec_uas, i64 16
  %vector_part_done_uas = icmp eq ptr %next_dst_vec_uas, %vector_dst_end_uas
  br i1 %vector_part_done_uas,
    label %scalar_suffix_memcpy_setup_from_unaligned,
    label %vector_memcpy_loop_uas

scalar_suffix_memcpy_setup_from_aligned:
  %suffix_dst_start_from_aligned = phi ptr [ %vec_dst_start_aasd, %vector_memcpy_loop_header_aasd ], [ %vector_dst_end_aasd, %vector_memcpy_loop_aasd ]
  %suffix_src_start_from_aligned = phi ptr [ %vec_src_start_aasd, %vector_memcpy_loop_header_aasd ], [ %next_src_vec_aasd, %vector_memcpy_loop_aasd ]
  %suffix_remaining_size_from_aligned = phi i64 [ %size_aasd, %vector_memcpy_loop_header_aasd ], [ sub i64 %size_aasd, %num_vector_bytes_aasd, %vector_memcpy_loop_aasd ]
  br label %scalar_suffix_memcpy_common_setup

scalar_suffix_memcpy_setup_from_unaligned:
  %suffix_dst_start_from_unaligned = phi ptr [ %vec_dst_start_uas, %vector_memcpy_loop_header_uas ], [ %vector_dst_end_uas, %vector_memcpy_loop_uas ]
  %suffix_src_start_from_unaligned = phi ptr [ %vec_src_start_uas, %vector_memcpy_loop_header_uas ], [ %next_src_vec_uas, %vector_memcpy_loop_uas ]
  %suffix_remaining_size_from_unaligned = phi i64 [ %size_after_prefix_uas, %vector_memcpy_loop_header_uas ], [ sub i64 %size_after_prefix_uas, %num_vector_bytes_uas, %vector_memcpy_loop_uas ]
  br label %scalar_suffix_memcpy_common_setup

scalar_suffix_memcpy_common_setup:
  %suffix_dst_start = phi ptr [ %suffix_dst_start_from_aligned, %scalar_suffix_memcpy_setup_from_aligned ], [ %suffix_dst_start_from_unaligned, %scalar_suffix_memcpy_setup_from_unaligned ]
  %suffix_src_start = phi ptr [ %suffix_src_start_from_aligned, %scalar_suffix_memcpy_setup_from_aligned ], [ %suffix_src_start_from_unaligned, %scalar_suffix_memcpy_setup_from_unaligned ]
  %suffix_remaining_size = phi i64 [ %suffix_remaining_size_from_aligned, %scalar_suffix_memcpy_setup_from_aligned ], [ %suffix_remaining_size_from_unaligned, %scalar_suffix_memcpy_setup_from_unaligned ]

  %suffix_dst_end = getelementptr i8, ptr %suffix_dst_start, i64 %suffix_remaining_size
  %no_suffix = icmp eq i64 %suffix_remaining_size, 0
  br i1 %no_suffix, label %memcpy_done, label %scalar_suffix_memcpy_loop_header

scalar_suffix_memcpy_loop_header:
  br label %scalar_suffix_memcpy_loop

scalar_suffix_memcpy_loop:
  %current_dst_suffix = phi ptr [ %suffix_dst_start, %scalar_suffix_memcpy_loop_header ], [ %next_dst_suffix, %scalar_suffix_memcpy_loop ]
  %current_src_suffix = phi ptr [ %suffix_src_start, %scalar_suffix_memcpy_loop_header ], [ %next_src_suffix, %scalar_suffix_memcpy_loop ]
  %byte_loaded_suffix = load i8, ptr %current_src_suffix, align 1
  store i8 %byte_loaded_suffix, ptr %current_dst_suffix, align 1
  %next_dst_suffix = getelementptr i8, ptr %current_dst_suffix, i64 1
  %next_src_suffix = getelementptr i8, ptr %current_src_suffix, i64 1
  %suffix_done = icmp eq ptr %next_dst_suffix, %suffix_dst_end
  br i1 %suffix_done, label %memcpy_done, label %scalar_suffix_memcpy_loop

memcpy_done:
  ret void
}

define void @minix_memmove_vectorized(ptr %dst, ptr %src, i64 %size) nounwind {
entry_memmove:
  %src_as_int = ptrtoint ptr %src to i64
  %dst_as_int = ptrtoint ptr %dst to i64
  %is_zero_size_mv = icmp eq i64 %size, 0
  br i1 %is_zero_size_mv, label %memmove_done, label %overlap_check

overlap_check:
  %src_plus_size = add i64 %src_as_int, %size
  %cond1_src_lt_dst = icmp ult i64 %src_as_int, %dst_as_int
  %cond2_src_overlaps_dst_end = icmp ugt i64 %src_plus_size, %dst_as_int
  %needs_backward_copy = and i1 %cond1_src_lt_dst, %cond2_src_overlaps_dst_end
  br i1 %needs_backward_copy, label %backward_copy_path, label %forward_copy_path

forward_copy_path:
  call void @minix_memcpy_vectorized(ptr %dst, ptr %src, i64 %size)
  ret void

backward_copy_path:
  %is_zero_size_bw = icmp eq i64 %size, 0
  br i1 %is_zero_size_bw, label %memmove_done, label %scalar_backward_loop_header
scalar_backward_loop_header:
  br label %scalar_backward_loop
scalar_backward_loop:
  %loop_idx_bw = phi i64 [ 0, %scalar_backward_loop_header ], [ %next_loop_idx_bw, %scalar_backward_loop ]
  %offset_from_end_bw = sub i64 %size, %loop_idx_bw
  %current_offset_bw = sub i64 %offset_from_end_bw, 1
  %src_ptr_bw = getelementptr i8, ptr %src, i64 %current_offset_bw
  %dst_ptr_bw = getelementptr i8, ptr %dst, i64 %current_offset_bw
  %byte_to_copy_bw = load i8, ptr %src_ptr_bw, align 1
  store i8 %byte_to_copy_bw, ptr %dst_ptr_bw, align 1
  %next_loop_idx_bw = add i64 %loop_idx_bw, 1
  %loop_finished_bw = icmp eq i64 %next_loop_idx_bw, %size
  br i1 %loop_finished_bw, label %memmove_done, label %scalar_backward_loop

memmove_done:
  ret void
}

!nontemporal_memset_hint = !{i32 1}

```