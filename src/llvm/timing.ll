; src/llvm/timing.ll
; CPU Frequency Calibration and Timing Utilities

source_filename = "src/llvm/timing.ll"

; --- Global Variables ---
@cpu_freq_hz = global i64 0, align 8
@tsc_freq_hz = global i64 0, align 8 ; Defined as per feedback, though not immediately used
@ns_per_cycle = global double 0.0, align 8

; --- Internal Helper Functions ---

define internal i32 @get_platform_id() nounwind {
entry:
  ; Placeholder: Assume 0 for x86, 1 for ARM, etc.
  ; A real implementation would determine this.
  ret i32 0 ; Default to x86 for now
}

define internal i64 @read_x86_tsc_frequency() nounwind {
entry:
  ; Input for CPUID leaf 0x15 (decimal 21)
  %leaf_0x15_const = i32 21

  ; Check if leaf 0x15 is supported by checking max basic leaf.
  ; CPUID with EAX=0 gives max basic leaf in EAX.
  %max_basic_leaf_val = call i32 asm sideeffect "cpuid", "={eax},{eax},~{ebx},~{ecx},~{edx}"(i32 0)
  %leaf_15_supported_cond = icmp uge i32 %max_basic_leaf_val, %leaf_0x15_const
  br i1 %leaf_15_supported_cond, label %exec_cpuid_15, label %fallback_to_default_freq

exec_cpuid_15:
  ; For CPUID leaf 0x15, EAX (input) = 0x15, ECX (input) = 0 (subleaf for core crystal clock info)
  ; Output: EAX=Denominator, EBX=Numerator, ECX=CrystalHz
  ; Using separate asm calls to retrieve each register value.
  ; Note: The input to the asm template is empty "()" because registers are set within the asm string.

  ; Get EAX output (Denominator) from CPUID leaf 0x15, subleaf 0
  %eax_val_15 = call i32 asm sideeffect "movl $21, %eax; movl $0, %ecx; cpuid", "={eax},~{ebx},~{ecx},~{edx}"()
  ; Get EBX output (Numerator) from CPUID leaf 0x15, subleaf 0
  %ebx_val_15 = call i32 asm sideeffect "movl $21, %eax; movl $0, %ecx; cpuid", "={ebx},~{eax},~{ecx},~{edx}"()
  ; Get ECX output (Crystal Clock Frequency in Hz) from CPUID leaf 0x15, subleaf 0
  %ecx_val_15 = call i32 asm sideeffect "movl $21, %eax; movl $0, %ecx; cpuid", "={ecx},~{eax},~{ebx},~{edx}"()

  %denominator_eax64 = zext i32 %eax_val_15 to i64
  %numerator_ebx64 = zext i32 %ebx_val_15 to i64
  %crystal_hz_ecx64 = zext i32 %ecx_val_15 to i64

  %is_eax_zero = icmp eq i64 %denominator_eax64, 0
  br i1 %is_eax_zero, label %check_ecx_direct_freq, label %calculate_ratio_freq

check_ecx_direct_freq:
  %is_ebx_also_zero = icmp eq i64 %numerator_ebx64, 0
  %is_ecx_non_zero = icmp ne i64 %crystal_hz_ecx64, 0
  %can_use_ecx_directly = and i1 %is_ebx_also_zero, %is_ecx_non_zero
  br i1 %can_use_ecx_directly, label %return_ecx_freq, label %fallback_to_default_freq

calculate_ratio_freq:
  %is_crystal_hz_also_zero = icmp eq i64 %crystal_hz_ecx64, 0
  br i1 %is_crystal_hz_also_zero, label %fallback_to_default_freq, label %perform_calculation_freq

perform_calculation_freq:
  ; TSC Frequency = Crystal Clock * (Numerator / Denominator)
  %mul_num_crystal = mul i64 %crystal_hz_ecx64, %numerator_ebx64
  %tsc_freq_calculated = udiv i64 %mul_num_crystal, %denominator_eax64

  %is_calc_freq_valid = icmp ugt i64 %tsc_freq_calculated, 0
  br i1 %is_calc_freq_valid, label %return_calculated_freq, label %fallback_to_default_freq

return_ecx_freq:
  ret i64 %crystal_hz_ecx64

return_calculated_freq:
  ret i64 %tsc_freq_calculated

fallback_to_default_freq:
  ; Fallback if CPUID method fails or is not supported adequately.
  ; Could also call @calibrate_frequency_empirically() here.
  ret i64 2400000000 ; Default 2.4 GHz
}

define internal i64 @read_arm_cntfrq() nounwind {
entry:
  ; Placeholder: Would read ARM system register CNTVCT_EL0 or similar
  ret i64 2000000000 ; Default 2.0 GHz (example)
}

define internal i64 @calibrate_frequency_empirically() nounwind {
entry:
  ; Placeholder: Would involve calibration against a known time source
  ret i64 2400000000 ; Default 2.4 GHz as a fallback
}

; Platform-specific frequency detection
define internal i64 @detect_cpu_frequency() nounwind {
entry:
  %platform_id = call i32 @get_platform_id()

  switch i32 %platform_id, label %default_platform [
    i32 0, label %x86_platform   ; Assuming 0 is x86
    i32 1, label %arm_platform    ; Assuming 1 is ARM
  ]

x86_platform:
  %freq_x86 = call i64 @read_x86_tsc_frequency()
  ret i64 %freq_x86

arm_platform:
  %freq_arm = call i64 @read_arm_cntfrq()
  ret i64 %freq_arm

default_platform:
  ; Fallback for unknown platforms or if specific detection fails
  %freq_calibrated = call i64 @calibrate_frequency_empirically()
  ret i64 %freq_calibrated
}

; --- Public API Functions ---

; Initializes the timing subsystem
define void @init_timing_subsystem() nounwind {
entry:
  %detected_freq = call i64 @detect_cpu_frequency()
  store i64 %detected_freq, ptr @cpu_freq_hz, align 8

  ; Calculate nanoseconds per cycle for informational purposes (double)
  %freq_double = uitofp i64 %detected_freq to double
  %billion_double = fconstant double 1.0e9 ; 1,000,000,000.0

  ; Check for division by zero if detected_freq could be zero (detect_cpu_frequency should prevent this)
  %is_freq_zero_check = icmp eq double %freq_double, 0.0
  br i1 %is_freq_zero_check, label %handle_zero_freq_init, label %do_division_init

handle_zero_freq_init:
  ; Avoid division by zero, store 0.0 for ns_per_cycle.
  store double 0.0, ptr @ns_per_cycle, align 8
  br label %timing_init_done

do_division_init:
  %calculated_ns_per_cycle = fdiv double %billion_double, %freq_double
  store double %calculated_ns_per_cycle, ptr @ns_per_cycle, align 8
  br label %timing_init_done

timing_init_done:
  ret void
}

; Convert nanoseconds to CPU cycles
define i64 @ns_to_cycles(i64 %ns) nounwind {
entry:
  %current_cpu_freq_hz_val = load i64, ptr @cpu_freq_hz, align 8
  %ns_per_second_const_val = i64 1000000000

  ; Check if cpu_freq_hz is 0 to prevent division by zero
  %is_freq_zero_conv = icmp eq i64 %current_cpu_freq_hz_val, 0
  br i1 %is_freq_zero_conv, label %handle_zero_freq_conversion, label %do_conversion

handle_zero_freq_conversion:
  ; If frequency is unknown, behavior depends on desired error handling.
  ; Returning max i64 for non-zero ns indicates an effectively infinite wait/error.
  %is_ns_input_zero = icmp eq i64 %ns, 0
  %ret_val_on_zero_freq = select i1 %is_ns_input_zero, i64 0, i64 -1 ; Using -1 (all ones bitpattern for i64)
  ret i64 %ret_val_on_zero_freq

do_conversion:
  ; Using simplified integer math: cycles = ns * (cpu_freq_hz / ns_per_second)
  ; This can lose precision if cpu_freq_hz < ns_per_second_const (i.e., < 1GHz).
  ; Assumes cpu_freq_hz will typically be >= 1GHz.
  ; For more precision with integer math, (ns * cpu_freq_hz) / ns_per_second_const is better,
  ; but requires overflow checks for the intermediate multiplication (ns * cpu_freq_hz).
  ; The user snippet implied the simpler (freq/ns_per_sec)*ns.

  %cycles_per_ns_quotient_conv = udiv i64 %current_cpu_freq_hz_val, %ns_per_second_const_val
  %calculated_cycles_conv = mul i64 %ns, %cycles_per_ns_quotient_conv

  ; To improve precision slightly for the (freq/ns_per_sec)*ns method:
  ; Add remainder term: (ns * (cpu_freq_hz % ns_per_second_const)) / ns_per_second_const
  %remainder_freq_part = urem i64 %current_cpu_freq_hz_val, %ns_per_second_const_val
  %adj_numerator = mul i64 %ns, %remainder_freq_part
  ; Check for overflow in adj_numerator if ns or remainder_freq_part are large, though
  ; remainder_freq_part < ns_per_second_const_val.
  %adj_cycles = udiv i64 %adj_numerator, %ns_per_second_const_val
  %final_calculated_cycles = add i64 %calculated_cycles_conv, %adj_cycles

  ret i64 %final_calculated_cycles
}
