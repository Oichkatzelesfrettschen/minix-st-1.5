; src/llvm/memory_model.ll

%click_t = type i64
%phys_addr_t = type i64
%vir_clicks = type i32

@CLICK_SHIFT_16 = internal constant i32 4
@CLICK_SHIFT_32 = internal constant i32 8
@CLICK_SHIFT_64 = internal constant i32 12

@click_shift = external global i32 ; Defined in arch_config.ll

define i64 @click2byte(i64 %clicks, i32 %arch_bits) nounwind readnone speculatable willreturn {
entry:
  fence acquire
  switch i32 %arch_bits, label %click2byte_default_path [
    i32 16, label %click2byte_arch16_path
    i32 32, label %click2byte_arch32_path
    i32 64, label %click2byte_arch64_path
  ]

click2byte_arch16_path:
  %shift_val_16 = load i32, ptr @CLICK_SHIFT_16, align 4
  %shift_val_16_64 = zext i32 %shift_val_16 to i64
  %result16 = shl i64 %clicks, %shift_val_16_64
  ret i64 %result16

click2byte_arch32_path:
  %shift_val_32 = load i32, ptr @CLICK_SHIFT_32, align 4
  %shift_val_32_64 = zext i32 %shift_val_32 to i64
  %result32 = shl i64 %clicks, %shift_val_32_64
  ret i64 %result32

click2byte_arch64_path:
  %shift_val_64 = load i32, ptr @CLICK_SHIFT_64, align 4
  %shift_val_64_64 = zext i32 %shift_val_64 to i64
  %result64 = shl i64 %clicks, %shift_val_64_64
  ret i64 %result64

click2byte_default_path:
  %current_click_shift = load i32, ptr @click_shift, align 4
  %shift64 = zext i32 %current_click_shift to i64
  %result_default = shl i64 %clicks, %shift64
  ret i64 %result_default
}

define i64 @safe_click2byte(i64 %clicks, i32 %arch_bits) {
entry:
  %max_shift_val = load i32, ptr @CLICK_SHIFT_64, align 4
  %max_shift_val_64 = zext i32 %max_shift_val to i64
  %max_allowable_clicks = lshr i64 -1, %max_shift_val_64
  %overflow = icmp ugt i64 %clicks, %max_allowable_clicks
  br i1 %overflow, label %safe_click2byte_error_path, label %safe_click2byte_convert_path

safe_click2byte_convert_path:
  %result = call i64 @click2byte(i64 %clicks, i32 %arch_bits)
  ret i64 %result

safe_click2byte_error_path:
  call void @llvm.trap()
  unreachable
}

define i64 @byte2click(i64 %bytes, i32 %arch_bits) nounwind readnone speculatable willreturn {
entry:
  fence acquire
  switch i32 %arch_bits, label %byte2click_default_path [
    i32 16, label %byte2click_arch16_path
    i32 32, label %byte2click_arch32_path
    i32 64, label %byte2click_arch64_path
  ]

byte2click_arch16_path:
  %shift_val_16 = load i32, ptr @CLICK_SHIFT_16, align 4
  %shift_val_16_64 = zext i32 %shift_val_16 to i64
  %result16 = lshr i64 %bytes, %shift_val_16_64
  ret i64 %result16

byte2click_arch32_path:
  %shift_val_32 = load i32, ptr @CLICK_SHIFT_32, align 4
  %shift_val_32_64 = zext i32 %shift_val_32 to i64
  %result32 = lshr i64 %bytes, %shift_val_32_64
  ret i64 %result32

byte2click_arch64_path:
  %shift_val_64 = load i32, ptr @CLICK_SHIFT_64, align 4
  %shift_val_64_64 = zext i32 %shift_val_64 to i64
  %result64 = lshr i64 %bytes, %shift_val_64_64
  ret i64 %result64

byte2click_default_path:
  %current_click_shift = load i32, ptr @click_shift, align 4
  %shift64 = zext i32 %current_click_shift to i64
  %result_default = lshr i64 %bytes, %shift64
  ret i64 %result_default
}

define i64 @safe_byte2click(i64 %bytes, i32 %arch_bits) {
entry:
  %result = call i64 @byte2click(i64 %bytes, i32 %arch_bits)
  ret i64 %result
}

; Renamed intrinsic declarations
declare i64 @minix_click2byte(i64, i32) nounwind readnone speculatable willreturn
declare i64 @minix_byte2click(i64, i32) nounwind readnone speculatable willreturn

declare void @llvm.trap() nounwind noreturn
