; src/llvm/benchmark/ipc_benchmarks.ll
; IPC Performance Benchmarking Suite

source_filename = "src/llvm/benchmark/ipc_benchmarks.ll"

; --- Type Definitions ---
%perf_metrics = type {
  i64,    ; total_operations
  i64,    ; total_cycles
  i64,    ; min_latency
  i64,    ; max_latency
  i64,    ; avg_latency
  i64,    ; p50_latency (placeholder for now)
  i64,    ; p95_latency (placeholder for now)
  i64,    ; p99_latency (placeholder for now)
  i64     ; throughput_msg_per_sec (placeholder for now)
}

%bench_config = type {
  i32,    ; num_producers
  i32,    ; num_consumers
  i32,    ; messages_per_producer
  i32,    ; message_size
  i32,    ; filter_ratio  ; percentage of messages that match filter
  i64     ; timeout_ns
}

; Forward declare msg_queue if needed by setup_benchmark_queues
%msg_queue = type { ptr, i64, i64, i32 }

; --- Global Variables ---
@default_config = global %bench_config {
  i32 4,      ; num_producers
  i32 2,      ; num_consumers
  i32 10000,  ; messages_per_producer
  i32 64,     ; message_size (unused by current IPC, but for future)
  i32 50,     ; filter_ratio
  i64 1000000 ; 1ms timeout_ns
}, align 8

; --- External Function Declarations ---
declare void @init_timing_subsystem() nounwind
declare void @init_message_pool(i32) nounwind
declare void @initialize_global_queue_registry(i32) nounwind
declare i64 @llvm.readcyclecounter() nounwind readnone

declare ptr @alloc_message() nounwind
declare void @free_message(ptr) nounwind
declare i32 @minix_send_async(ptr, i32) nounwind
declare i32 @minix_receive_async(ptr, i32, i64) nounwind
declare ptr @get_process_queue(i32) nounwind ; For minix_send_async
declare i32 @register_process_queue(i32, ptr) nounwind ; For setup_benchmark_queues

; LLVM intrinsics for min/max
declare i64 @llvm.umin.i64(i64, i64) nounwind readnone
declare i64 @llvm.umax.i64(i64, i64) nounwind readnone

; --- Global Test Queue & Mock for Benchmarking PID 0 ---
@benchmark_pid0_queue_storage = internal global %msg_queue zeroinitializer, align 8
@benchmark_pid0_queue_buffer = internal global [10 x ptr] zeroinitializer, align 8 ; Buffer for 10 msgs

; Mock for get_current_process_message_queue, specific to this benchmark's context
; This overrides the weak definition in test_ipc.ll if linked together,
; or provides the definition if ipc_primitives.ll only declares it.
define ptr @get_current_process_message_queue() nounwind {
entry:
  ret ptr @benchmark_pid0_queue_storage
}

; --- Placeholder Benchmark Phase Functions & Setup ---
define internal void @setup_benchmark_queues(ptr %producer_queues, ptr %consumer_queues, ptr %config) nounwind {
entry:
  ; Initialize and register a queue for PID 0 for loopback tests
  %q_ptr = ptr @benchmark_pid0_queue_storage
  %q_buf_ptr_loc = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 0
  %q_head_loc = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 1
  %q_tail_loc = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 2
  %q_cap_loc = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 3

  %actual_buffer = getelementptr inbounds [10 x ptr], ptr @benchmark_pid0_queue_buffer, i32 0, i32 0
  store ptr %actual_buffer, ptr %q_buf_ptr_loc, align 8
  store i64 0, ptr %q_head_loc, align 8 ; head = {idx=0, tag=0}
  store i64 0, ptr %q_tail_loc, align 8 ; tail = {idx=0, tag=0}
  store i32 10, ptr %q_cap_loc, align 4  ; Capacity 10

  %pid_for_queue = i32 0
  %register_result = call i32 @register_process_queue(i32 %pid_for_queue, ptr %q_ptr)
  ; TODO: Add error check for register_result if necessary for benchmark setup robustness
  ; For now, assume registration succeeds. If it fails, subsequent tests might behave unexpectedly.
  ret void
}

define internal void @calculate_latency_stats(ptr %latencies_array, i32 %count, ptr %results_output_struct) nounwind {
entry:
  %count_is_zero = icmp eq i32 %count, 0
  br i1 %count_is_zero, label %no_samples_exit, label %process_samples

process_samples:
  %min_lat_alloca = alloca i64, align 8
  %max_lat_alloca = alloca i64, align 8
  %sum_lat_alloca = alloca i64, align 8

  store i64 -1, ptr %min_lat_alloca, align 8 ; Max i64 for min init (unsigned -1 is max)
  store i64 0, ptr %max_lat_alloca, align 8
  store i64 0, ptr %sum_lat_alloca, align 8

  %i_alloca = alloca i32, align 4
  store i32 0, ptr %i_alloca, align 4
  br label %stats_loop_header

stats_loop_header:
  %idx = load i32, ptr %i_alloca, align 4
  %loop_cond = icmp slt i32 %idx, %count
  br i1 %loop_cond, label %stats_loop_body, label %stats_loop_exit

stats_loop_body:
  %lat_addr = getelementptr i64, ptr %latencies_array, i32 %idx
  %current_lat = load i64, ptr %lat_addr, align 8

  %current_min_val = load i64, ptr %min_lat_alloca, align 8
  %new_min_val = call i64 @llvm.umin.i64(i64 %current_min_val, i64 %current_lat)
  store i64 %new_min_val, ptr %min_lat_alloca, align 8

  %current_max_val = load i64, ptr %max_lat_alloca, align 8
  %new_max_val = call i64 @llvm.umax.i64(i64 %current_max_val, i64 %current_lat)
  store i64 %new_max_val, ptr %max_lat_alloca, align 8

  %current_sum_val = load i64, ptr %sum_lat_alloca, align 8
  %new_sum_val = add i64 %current_sum_val, %current_lat
  store i64 %new_sum_val, ptr %sum_lat_alloca, align 8

  %next_idx_val = add i32 %idx, 1
  store i32 %next_idx_val, ptr %i_alloca, align 4
  br label %stats_loop_header

stats_loop_exit:
  %final_min = load i64, ptr %min_lat_alloca, align 8
  %final_max = load i64, ptr %max_lat_alloca, align 8
  %final_sum = load i64, ptr %sum_lat_alloca, align 8
  %count_64 = zext i32 %count to i64

  %avg_lat = i64 0 ; Default if count_64 is 0 (though caught by initial check)
  %can_calc_avg = icmp ne i64 %count_64, 0
  br i1 %can_calc_avg, label %calc_avg, label %post_avg_calc

calc_avg:
  %avg_lat_calc = udiv i64 %final_sum, %count_64
  br label %post_avg_calc

post_avg_calc:
  %avg_lat_final = phi i64 [ %avg_lat_calc, %calc_avg ], [ 0, %stats_loop_exit ]

  %min_lat_ptr_loc_res = getelementptr inbounds %perf_metrics, ptr %results_output_struct, i32 0, i32 2
  store i64 %final_min, ptr %min_lat_ptr_loc_res, align 8
  %max_lat_ptr_loc_res = getelementptr inbounds %perf_metrics, ptr %results_output_struct, i32 0, i32 3
  store i64 %final_max, ptr %max_lat_ptr_loc_res, align 8
  %avg_lat_ptr_loc_res = getelementptr inbounds %perf_metrics, ptr %results_output_struct, i32 0, i32 4
  store i64 %avg_lat_final, ptr %avg_lat_ptr_loc_res, align 8

  ; Percentiles (P50, P95, P99) fields remain 0 as set by run_ipc_benchmark
  br label %no_samples_exit

no_samples_exit: ; Also used as common exit path
  ret void
}

define internal void @benchmark_phase_1_latency(ptr %config_param, ptr %results_param) nounwind {
entry:
  %num_samples_const = i32 1000 ; Number of latency samples to collect
  %latencies_array_alloca = alloca i64, i32 %num_samples_const, align 8

  ; Attempt to allocate a message for the test
  %msg_for_latency_test = call ptr @alloc_message()
  %is_alloc_failed = icmp eq ptr %msg_for_latency_test, null
  br i1 %is_alloc_failed, label %alloc_failed_exit_latency, label %proceed_latency_loop_setup

proceed_latency_loop_setup:
  ; Initialize message source (PID 0 - self)
  %msg_source_field_ptr_latency = getelementptr inbounds %message, ptr %msg_for_latency_test, i32 0, i32 0
  store i32 0, ptr %msg_source_field_ptr_latency, align 4
  ; Other message fields can be left as zero/default from pool for this test

  %output_msg_ptr_alloca_latency = alloca ptr, align 8 ; For minix_receive_async's out param

  %loop_idx_alloca = alloca i32, align 4
  store i32 0, ptr %loop_idx_alloca, align 4
  br label %measure_latency_loop_header

measure_latency_loop_header:
  %current_idx_latency = load i32, ptr %loop_idx_alloca, align 4
  %latency_loop_cond = icmp slt i32 %current_idx_latency, %num_samples_const
  br i1 %latency_loop_cond, label %measure_latency_loop_body, label %measure_latency_loop_exit

measure_latency_loop_body:
  %t1_cycles = call i64 @llvm.readcyclecounter()

  ; Send to PID 0 (self)
  %send_status_latency = call i32 @minix_send_async(ptr %msg_for_latency_test, i32 0)
  ; TODO: Check %send_status_latency if robustness is critical for the benchmark itself

  ; Receive from ANY_SOURCE (-1), non-blocking (timeout 0ns)
  %receive_status_latency = call i32 @minix_receive_async(ptr %output_msg_ptr_alloca_latency, i32 -1, i64 0)
  ; TODO: Check %receive_status_latency and the content of %output_msg_ptr_alloca_latency if needed
  ; For pure latency, we assume it's the message we sent.

  %t2_cycles = call i64 @llvm.readcyclecounter()
  %latency_value_cycles = sub i64 %t2_cycles, %t1_cycles

  %latency_sample_addr = getelementptr i64, ptr %latencies_array_alloca, i32 %current_idx_latency
  store i64 %latency_value_cycles, ptr %latency_sample_addr, align 8

  %next_idx_latency = add i32 %current_idx_latency, 1
  store i32 %next_idx_latency, ptr %loop_idx_alloca, align 4
  br label %measure_latency_loop_header

measure_latency_loop_exit:
  ; Process the collected latency samples
  call void @calculate_latency_stats(ptr %latencies_array_alloca, i32 %num_samples_const, ptr %results_param)

  ; Free the message used for the test
  call void @free_message(ptr %msg_for_latency_test)
  br label %alloc_failed_exit_latency ; Common exit path

alloc_failed_exit_latency: ; Also serves as the common exit for this function
  ret void
}

define internal void @benchmark_phase_2_throughput(ptr %config, ptr %results) nounwind {
entry:
  ; TODO: Implement throughput measurement.
  ret void
}

define internal void @benchmark_phase_3_contention(ptr %config, ptr %results) nounwind {
entry:
  ; TODO: Implement contention measurement.
  ret void
}

; --- Main Benchmark Entry Point ---
define void @run_ipc_benchmark(ptr %config_param, ptr %results_param) nounwind {
entry:
  ; Initialize subsystems
  call void @init_timing_subsystem()
  call void @init_message_pool(i32 65536)  ; Pool for 64k messages
  call void @initialize_global_queue_registry(i32 256) ; Registry for 256 PIDs

  ; For this step, setup_benchmark_queues is a no-op, passing null pointers.
  call void @setup_benchmark_queues(ptr null, ptr null, ptr %config_param)

  %start_cycles = call i64 @llvm.readcyclecounter()

  ; Run benchmark phases (currently placeholders)
  call void @benchmark_phase_1_latency(ptr %config_param, ptr %results_param)
  call void @benchmark_phase_2_throughput(ptr %config_param, ptr %results_param)
  call void @benchmark_phase_3_contention(ptr %config_param, ptr %results_param)

  %end_cycles = call i64 @llvm.readcyclecounter()
  %total_cycles_val = sub i64 %end_cycles, %start_cycles

  ; Store total_cycles in the results structure
  ; %perf_metrics field indices: total_operations=0, total_cycles=1, ...
  %total_cycles_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 1
  store i64 %total_cycles_val, ptr %total_cycles_ptr_loc, align 8

  ; Initialize other fields of results_param to 0 for now
  %total_ops_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 0
  store i64 0, ptr %total_ops_ptr_loc, align 8
  %min_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 2
  store i64 0, ptr %min_lat_ptr_loc, align 8
  %max_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 3
  store i64 0, ptr %max_lat_ptr_loc, align 8
  %avg_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 4
  store i64 0, ptr %avg_lat_ptr_loc, align 8
  %p50_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 5
  store i64 0, ptr %p50_lat_ptr_loc, align 8
  %p95_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 6
  store i64 0, ptr %p95_lat_ptr_loc, align 8
  %p99_lat_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 7
  store i64 0, ptr %p99_lat_ptr_loc, align 8
  %throughput_ptr_loc = getelementptr inbounds %perf_metrics, ptr %results_param, i32 0, i32 8
  store i64 0, ptr %throughput_ptr_loc, align 8

  ret void
}
