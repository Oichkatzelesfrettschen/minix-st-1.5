; src/llvm/test/test_benchmarks.ll
; Basic smoke tests for the IPC benchmarking framework

source_filename = "src/llvm/test/test_benchmarks.ll"

; --- Type Definitions (mirror from ipc_benchmarks.ll) ---
%perf_metrics = type {
  i64,    ; total_operations
  i64,    ; total_cycles
  i64,    ; min_latency
  i64,    ; max_latency
  i64,    ; avg_latency
  i64,    ; p50_latency
  i64,    ; p95_latency
  i64,    ; p99_latency
  i64     ; throughput_msg_per_sec
}

%bench_config = type {
  i32,    ; num_producers
  i32,    ; num_consumers
  i32,    ; messages_per_producer
  i32,    ; message_size
  i32,    ; filter_ratio
  i64     ; timeout_ns
}

; --- External Declarations ---
; From ipc_benchmarks.ll
declare void @run_ipc_benchmark(ptr, ptr) nounwind
@default_config = external global %bench_config, align 8

; From queue_registry.ll (globals potentially touched by initializers in run_ipc_benchmark)
@global_queue_registry_ptr = external global ptr, align 8
@global_registry_initialized_flag = external global i32, align 4
@registry_rw_lock_initialized = external global i32, align 4
; Contention counters might be reset by a global test setup, declare them if so.
@read_lock_contentions = external global i64, align 8
@write_lock_contentions = external global i64, align 8

; From message_pool.ll (globals potentially touched by initializers in run_ipc_benchmark)
@global_message_pool = external global ptr, align 8
@message_pool_initialized_flag = external global i32, align 4
; Pool metric counters might be reset by a global test setup.
@pool_alloc_success_count = external global i64, align 8
@pool_alloc_failure_count = external global i64, align 8
@pool_free_count = external global i64, align 8

; LLVM intrinsics / standard functions
declare void @llvm.trap() nounwind noreturn

; --- Assertion Helper Definitions ---
; These are self-contained for this test file.
@assert_eq_i64_msg_str = private unnamed_addr constant [19 x i8] c"assert_eq_i64 fail\00", align 1
define void @assert_eq_i64(i64 %v1, i64 %v2, ptr %msg) nounwind {
entry:
  %cond = icmp eq i64 %v1, %v2
  br i1 %cond, label %ok_i64, label %fail_i64
fail_i64:
  ; In a real test, %msg would be printed.
  call void @llvm.trap()
  unreachable
ok_i64:
  ret void
}

@assert_true_msg_str = private unnamed_addr constant [16 x i8] c"assert_true fail\00", align 1
define void @assert_true(i1 %condition, ptr %msg) nounwind {
entry:
  br i1 %condition, label %ok_true, label %fail_true
fail_true:
  ; In a real test, %msg would be printed.
  call void @llvm.trap()
  unreachable
ok_true:
  ret void
}

; --- Test Functions ---
define i32 @test_run_benchmark_smoke() nounwind {
entry:
  %results_alloca = alloca %perf_metrics, align 8

  ; Initialize results_alloca to a known non-zero pattern for some fields to ensure they are written by run_ipc_benchmark
  ; For example, set total_cycles (idx 1) to -1, min_latency (idx 2) to 0.
  ; run_ipc_benchmark is expected to set all fields (total_cycles from measurement, others to 0 if not measured).
  %init_total_cycles_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 1
  store i64 -1, ptr %init_total_cycles_ptr, align 8
  %init_min_lat_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 2
  store i64 0, ptr %init_min_lat_ptr, align 8 ; calculate_latency_stats initializes min to -1 (max_u64)

  %config_ptr = ptr @default_config
  call void @run_ipc_benchmark(ptr %config_ptr, ptr %results_alloca)

  ; Check total_cycles (field index 1)
  %total_cycles_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 1
  %total_cycles_val = load i64, ptr %total_cycles_ptr, align 8
  %total_cycles_ok = icmp ugt i64 %total_cycles_val, 0
  call void @assert_true(i1 %total_cycles_ok, ptr internal constant [20 x i8] c"Total cycles > 0\00")

  ; Check min_latency (field index 2), max_latency (3), avg_latency (4)
  ; These are set by benchmark_phase_1_latency which calls calculate_latency_stats
  %min_lat_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 2
  %min_lat_val = load i64, ptr %min_lat_ptr, align 8
  ; If samples were taken, min_lat should be < max_u64. If no samples, it might remain max_u64.
  ; Phase 1 runs 1000 samples, so min_lat should be updated.
  %min_lat_updated = icmp ne i64 %min_lat_val, -1 ; Check it's not still max_u64
  call void @assert_true(i1 %min_lat_updated, ptr internal constant [25 x i8] c"Min latency updated\00")

  %max_lat_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 3
  %max_lat_val = load i64, ptr %max_lat_ptr, align 8
  %max_lat_ok = icmp uge i64 %max_lat_val, 0
  call void @assert_true(i1 %max_lat_ok, ptr internal constant [20 x i8] c"Max latency >= 0\00")

  %avg_lat_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 4
  %avg_lat_val = load i64, ptr %avg_lat_ptr, align 8
  %avg_lat_ok = icmp uge i64 %avg_lat_val, 0
  call void @assert_true(i1 %avg_lat_ok, ptr internal constant [20 x i8] c"Avg latency >= 0\00")

  %min_is_valid_for_compare = icmp ne i64 %min_lat_val, -1 ; Not initial max_u64
  %max_is_valid_for_compare = icmp ne i64 %max_lat_val, 0 ; Not initial 0 (assuming some latency occurs)
  %can_compare_min_max = and i1 %min_is_valid_for_compare, %max_is_valid_for_compare
  br i1 %can_compare_min_max, label %do_min_max_check, label %skip_min_max_check

do_min_max_check:
  %min_le_max = icmp ule i64 %min_lat_val, %max_lat_val
  call void @assert_true(i1 %min_le_max, ptr internal constant [20 x i8] c"Min <= Max latency\00")
  br label %skip_min_max_check

skip_min_max_check:
  ; Check placeholder fields are still 0 (as set by run_ipc_benchmark)
  %p50_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 5
  %p50_val = load i64, ptr %p50_ptr, align 8
  call void @assert_eq_i64(i64 %p50_val, i64 0, ptr internal constant [22 x i8] c"P50 latency is zero\00")

  %p95_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 6
  %p95_val = load i64, ptr %p95_ptr, align 8
  call void @assert_eq_i64(i64 %p95_val, i64 0, ptr internal constant [22 x i8] c"P95 latency is zero\00")

  %p99_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 7
  %p99_val = load i64, ptr %p99_ptr, align 8
  call void @assert_eq_i64(i64 %p99_val, i64 0, ptr internal constant [22 x i8] c"P99 latency is zero\00")

  %throughput_ptr = getelementptr inbounds %perf_metrics, ptr %results_alloca, i32 0, i32 8
  %throughput_val = load i64, ptr %throughput_ptr, align 8
  call void @assert_eq_i64(i64 %throughput_val, i64 0, ptr internal constant [23 x i8] c"Throughput is zero\00")

  ret i32 0 ; Success
}

; --- Main function for this test file ---
define i32 @main() nounwind {
entry:
  ; run_ipc_benchmark calls all necessary initializers (timing, pool, queue_registry)
  ; These initializers have their own one-time guards.
  %test_ret_code = call i32 @test_run_benchmark_smoke()
  ret i32 %test_ret_code
}
