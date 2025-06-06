; src/llvm/intrinsics/memory.ll
; Vectorized memory operations

; Constants for vector widths
@vector_width_sse = internal constant i32 16    ; 128-bit
@vector_width_avx = internal constant i32 32    ; 256-bit
@vector_width_avx512 = internal constant i32 64 ; 512-bit

; External CPU feature flags (defined in arch_config.ll)
@has_avx2 = external global i1
@has_sse2 = external global i1

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
  store <16 x i8> %splat_vector_v128, ptr %typed_vec_ptr_v128, align 16
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
entry_memcpy_v128:
  ; Assuming size is a multiple of 16 and dst/src are 16-byte aligned for this basic version
  %vector_size_memcpy = i64 16
  %end_src_ptr = getelementptr i8, ptr %src, i64 %size

  %loop_cond_memcpy = icmp eq i64 %size, 0
  br i1 %loop_cond_memcpy, label %memcpy_done, label %memcpy_loop_header

memcpy_loop_header:
  br label %memcpy_loop

memcpy_loop:
  %current_src_ptr = phi ptr [ %src, %memcpy_loop_header ], [ %next_src_ptr, %memcpy_loop ]
  %current_dst_ptr = phi ptr [ %dst, %memcpy_loop_header ], [ %next_dst_ptr, %memcpy_loop ]

  %typed_src_ptr = bitcast ptr %current_src_ptr to ptr
  %loaded_vector = load <16 x i8>, ptr %typed_src_ptr, align 16

  %typed_dst_ptr = bitcast ptr %current_dst_ptr to ptr
  store <16 x i8> %loaded_vector, ptr %typed_dst_ptr, align 16

  %next_src_ptr = getelementptr i8, ptr %current_src_ptr, i64 %vector_size_memcpy
  %next_dst_ptr = getelementptr i8, ptr %current_dst_ptr, i64 %vector_size_memcpy

  %done_memcpy = icmp eq ptr %next_src_ptr, %end_src_ptr
  br i1 %done_memcpy, label %memcpy_done, label %memcpy_loop

memcpy_done:
  ret void
}

define void @minix_memmove_vectorized(ptr %dst, ptr %src, i64 %size) nounwind {
entry_memmove:
  ; TODO: Implement overlap detection:
  ; Check if src < dst and src + size > dst (overlap, copy backwards)
  ; OR if dst < src and dst + size > src (overlap, copy forwards - already handled by naive)
  ; If no overlap, can use memcpy logic.

  ; For now, implement a simple forward copy like memcpy.
  ; This is only correct if dst <= src or if there's no overlap.
  ; A full memmove needs to handle src < dst and overlap by copying from end to start.

  ; Assuming size is a multiple of 16 and dst/src are 16-byte aligned for this basic version
  %vector_size_memmove = i64 16
  %current_src_ptr_memmove = phi ptr [ %src, %entry_memmove ], [ %next_src_ptr_memmove, %memmove_loop_body ]
  %current_dst_ptr_memmove = phi ptr [ %dst, %entry_memmove ], [ %next_dst_ptr_memmove, %memmove_loop_body ]
  %remaining_size_memmove = phi i64 [ %size, %entry_memmove ], [ %next_remaining_size_memmove, %memmove_loop_body ]

  %is_done_memmove = icmp eq i64 %remaining_size_memmove, 0
  br i1 %is_done_memmove, label %memmove_done, label %memmove_loop_body

memmove_loop_body:
  %typed_src_ptr_memmove = bitcast ptr %current_src_ptr_memmove to ptr
  %loaded_vector_memmove = load <16 x i8>, ptr %typed_src_ptr_memmove, align 16

  %typed_dst_ptr_memmove = bitcast ptr %current_dst_ptr_memmove to ptr
  store <16 x i8> %loaded_vector_memmove, ptr %typed_dst_ptr_memmove, align 16

  %next_src_ptr_memmove = getelementptr i8, ptr %current_src_ptr_memmove, i64 %vector_size_memmove
  %next_dst_ptr_memmove = getelementptr i8, ptr %current_dst_ptr_memmove, i64 %vector_size_memmove
  %next_remaining_size_memmove = sub i64 %remaining_size_memmove, %vector_size_memmove

  %loop_again_memmove = icmp ne i64 %next_remaining_size_memmove, 0
  br i1 %loop_again_memmove, label %memmove_loop_body, label %memmove_done

memmove_done:
  ret void
}
