; src/llvm/types/base_types.ll

%pid_t = type i32
%uid_t = type i16
%gid_t = type i16
%mode_t = type i16
%nlink_t = type i16
%off_t = type i64
%time_t = type i64

%mem_seg = type {
  i32,   ; Virtual address (clicks)
  i64,   ; Physical address (clicks)
  i32    ; Length (clicks)
} align 8 ; Ensure 64-bit alignment

%mem_seg_v2 = type {
  i64,           ; Base address (bytes)
  i64,           ; Length (bytes)
  i32,           ; Permissions (RWX)
  i32            ; Address space ID
}

; TBAA Metadata Definitions
; These nodes can be used to annotate memory access instructions later.
!minix_types = !{!"MINIX Type System"}

!pid_t_metadata = !{!"pid_t", !minix_types}
!uid_t_metadata = !{!"uid_t", !minix_types}
!gid_t_metadata = !{!"gid_t", !minix_types}
!mode_t_metadata = !{!"mode_t", !minix_types}
!nlink_t_metadata = !{!"nlink_t", !minix_types}
!off_t_metadata = !{!"off_t", !minix_types}
!time_t_metadata = !{!"time_t", !minix_types}
!mem_seg_metadata = !{!"mem_seg", !minix_types}
!mem_seg_v2_metadata = !{!"mem_seg_v2", !minix_types}
