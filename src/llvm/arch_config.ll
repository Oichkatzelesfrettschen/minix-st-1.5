; src/llvm/arch_config.ll

@arch_bits = internal global i32 0, align 4
@click_shift = internal global i32 0, align 4
@page_size = internal global i64 4096, align 8
@cache_line_size = internal global i32 64, align 4

@has_sse2 = internal global i1 false, align 1
@has_avx2 = internal global i1 false, align 1
@has_popcnt = internal global i1 false, align 1

; Function to check if CPUID instruction is supported
define internal i1 @has_cpuid_support() nounwind readnone {
entry:
  %result = call i32 asm sideeffect
    "pushfl\0A\09"
    "popl %eax\0A\09"
    "movl %eax, %ecx\0A\09"
    "xorl $$0x00200000, %eax\0A\09"
    "pushl %eax\0A\09"
    "popfl\0A\09"
    "pushfl\0A\09"
    "popl %eax\0A\09"
    "xorl %ecx, %eax\0A\09"
    "shrl $$21, %eax\0A\09"
    "andl $$1, %eax\0A\09",
    "={eax}"()
  %has_cpuid = icmp ne i32 %result, 0
  ret i1 %has_cpuid
}

; Wrapper for CPUID instruction
define internal { i32, i32, i32, i32 } @cpuid_execute(i32 %leaf, i32 %subleaf) nounwind readnone {
entry:
  %cpuid_result = call { i32, i32, i32, i32 } asm sideeffect
    "cpuid",
    "=a,=b,=c,=d,a,c"
    (i32 %leaf, i32 %subleaf)
  ret { i32, i32, i32, i32 } %cpuid_result
}

; Architecture detection function
define void @detect_architecture() nounwind {
entry:
  ; Corrected pointer size detection
  %ptr_max_val = inttoptr i64 -1 to ptr
  %size_of_pointer_type = ptrtoint ptr %ptr_max_val to i64
  %leading_zeros = call i64 @llvm.ctlz.i64(i64 %size_of_pointer_type, i1 false)
  %temp_bits = sub nsw i64 64, %leading_zeros
  %detected_arch_bits = trunc i64 %temp_bits to i32
  store i32 %detected_arch_bits, ptr @arch_bits, align 4

  switch i32 %detected_arch_bits, label %config_16_path [
    i32 64, label %config_64_path
    i32 32, label %config_32_path
  ]

config_64_path:
  store i32 12, ptr @click_shift, align 4
  store i64 4096, ptr @page_size, align 8
  br label %detect_cpu_features_entry

config_32_path:
  store i32 8, ptr @click_shift, align 4
  store i64 4096, ptr @page_size, align 8
  br label %detect_cpu_features_entry

config_16_path:
  store i32 4, ptr @click_shift, align 4
  store i64 256, ptr @page_size, align 8
  br label %detect_cpu_features_entry

detect_cpu_features_entry:
  %cpuid_supported = call i1 @has_cpuid_support()
  br i1 %cpuid_supported, label %do_detect_cpu_features, label %done_cpu_features

do_detect_cpu_features:
  %cpuid1_result = call { i32, i32, i32, i32 } @cpuid_execute(i32 1, i32 0)
  %ecx1 = extractvalue { i32, i32, i32, i32 } %cpuid1_result, 2
  %edx1 = extractvalue { i32, i32, i32, i32 } %cpuid1_result, 3

  %sse2_mask = and i32 %edx1, 67108864
  %sse2_present = icmp ne i32 %sse2_mask, 0
  store i1 %sse2_present, ptr @has_sse2, align 1

  %cpuid7_result = call { i32, i32, i32, i32 } @cpuid_execute(i32 7, i32 0)
  %ebx7 = extractvalue { i32, i32, i32, i32 } %cpuid7_result, 1

  %avx2_mask = and i32 %ebx7, 32
  %avx2_present = icmp ne i32 %avx2_mask, 0
  store i1 %avx2_present, ptr @has_avx2, align 1

  %popcnt_mask = and i32 %ecx1, 8388608
  %popcnt_present = icmp ne i32 %popcnt_mask, 0
  store i1 %popcnt_present, ptr @has_popcnt, align 1

  br label %done_cpu_features

done_cpu_features:
  ret void
}

declare i64 @llvm.ctlz.i64(i64, i1) nounwind readnone speculatable willreturn
