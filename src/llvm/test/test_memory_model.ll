; src/llvm/test/test_memory_model.ll

; External declarations for functions being tested from memory_model.ll
declare i64 @click2byte(i64, i32) nounwind readnone speculatable willreturn
declare i64 @safe_click2byte(i64, i32)
declare void @llvm.trap() nounwind noreturn

; External declaration for cycle counter
declare i64 @llvm.readcyclecounter() nounwind readnone

define i32 @test_click_conversions() {
entry:
  %clicks_val = i64 100
  %bytes16 = call i64 @click2byte(i64 %clicks_val, i32 16)
  %expected16 = i64 1600
  %correct16 = icmp eq i64 %bytes16, %expected16

  %bytes32 = call i64 @click2byte(i64 %clicks_val, i32 32)
  %expected32 = i64 25600
  %correct32 = icmp eq i64 %bytes32, %expected32

  %bytes64 = call i64 @click2byte(i64 %clicks_val, i32 64)
  %expected64 = i64 409600
  %correct64 = icmp eq i64 %bytes64, %expected64

  %and_16_32 = and i1 %correct16, %correct32
  %all_correct = and i1 %and_16_32, %correct64
  %result = zext i1 %all_correct to i32
  ret i32 %result
}

define i32 @test_click_boundary_conditions() {
entry:
  ; Test zero clicks
  %zero_clicks_result = call i64 @click2byte(i64 0, i32 32)
  %is_zero_correct = icmp eq i64 %zero_clicks_result, 0

  ; Test safe_click2byte with a large, but valid, number of clicks for 64-bit arch
  ; Max safe clicks for shift 12 (arch 64) is (2^64-1) >> 12 approx 2^52 - 1
  ; Let's use 2^50 as a large safe value. (1125899906842624)
  %large_safe_clicks = i64 1125899906842624
  %large_safe_bytes = call i64 @safe_click2byte(i64 %large_safe_clicks, i32 64)
  %expected_large_safe_bytes = shl i64 %large_safe_clicks, 12
  %is_large_safe_correct = icmp eq i64 %large_safe_bytes, %expected_large_safe_bytes

  %all_boundaries_correct = and i1 %is_zero_correct, %is_large_safe_correct
  %result = zext i1 %all_boundaries_correct to i32
  ret i32 %result
}

define i64 @bench_click_conversion() {
entry:
  %start_cycles = call i64 @llvm.readcyclecounter()
  %i = phi i64 [ 0, %entry ], [ %next_i, %loop_body ]

loop_body:
  %dummy_result = call i64 @click2byte(i64 %i, i32 32)
  %next_i = add nsw i64 %i, 1
  %loop_condition = icmp slt i64 %next_i, 1000000 ; Loop 1 million times
  br i1 %loop_condition, label %loop_body, label %loop_exit

loop_exit:
  %end_cycles = call i64 @llvm.readcyclecounter()
  %total_cycles = sub i64 %end_cycles, %start_cycles
  ret i64 %total_cycles
}

; TODO: Add define i32 @test_byte2click_functionality()

define i32 @main() {
entry:
  %res_conv = call i32 @test_click_conversions()
  %conv_pass = icmp eq i32 %res_conv, 1

  %res_bound = call i32 @test_click_boundary_conditions()
  %bound_pass = icmp eq i32 %res_bound, 1

  %all_tests_pass_agg = and i1 %conv_pass, %bound_pass

  ; Optionally print benchmark result (requires external print function)
  ; %bench_result = call i64 @bench_click_conversion()
  ; call void @print_long(i64 %bench_result)

  br i1 %all_tests_pass_agg, label %success, label %failure

success:
  ret i32 0 ; Return 0 on success

failure:
  ret i32 1 ; Return 1 on failure
}
