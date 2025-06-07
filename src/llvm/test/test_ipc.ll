; src/llvm/test/test_ipc.ll
; Tests for asynchronous IPC primitives

; --- Type Declarations ---
%message = type { i32, i32, [6 x i64], ptr }
%msg_queue = type { ptr, i64, i64, i32 }

; --- External Function Declarations ---
declare i32 @minix_send_async(ptr, i32) nounwind
declare ptr @minix_receive_async(i32, i64) nounwind
declare i64 @llvm.readcyclecounter() nounwind readnone ; For potential future timeout tests

; --- Global Test Queue Setup ---
@TEST_QUEUE_CAPACITY = internal constant i32 10

@test_queue_buffer_pid1 = internal global [10 x ptr] zeroinitializer, align 8
@test_queue_instance_pid1 = internal global %msg_queue {
  ptr getelementptr inbounds ([10 x ptr], ptr @test_queue_buffer_pid1, i64 0, i64 0),
  i64 0, i64 0, i32 @TEST_QUEUE_CAPACITY
}, align 8

@test_queue_buffer_pid2 = internal global [10 x ptr] zeroinitializer, align 8
@test_queue_instance_pid2 = internal global %msg_queue {
  ptr getelementptr inbounds ([10 x ptr], ptr @test_queue_buffer_pid2, i64 0, i64 0),
  i64 0, i64 0, i32 @TEST_QUEUE_CAPACITY
}, align 8

@PID1 = internal constant i32 1
@PID2 = internal constant i32 2
@ANY_SOURCE_PID = internal constant i32 0 ; Convention for filter

; Global to simulate current process context for get_current_process_message_queue
@g_current_simulated_pid = internal global i32 @PID1, align 4


; --- Stub Implementations for Queue Lookup ---
define ptr @get_current_process_message_queue() nounwind {
entry_get_current_q:
  %current_pid = load i32, ptr @g_current_simulated_pid, align 4
  %is_pid1 = icmp eq i32 %current_pid, @PID1
  br i1 %is_pid1, label %return_q1, label %check_pid2

check_pid2:
  %is_pid2 = icmp eq i32 %current_pid, @PID2
  br i1 %is_pid2, label %return_q2, label %return_null_q

return_q1:
  ret ptr @test_queue_instance_pid1
return_q2:
  ret ptr @test_queue_instance_pid2
return_null_q:
  ret ptr null
}

define ptr @get_process_queue(i32 %pid) nounwind {
entry_get_q_for_pid:
  %is_pid1 = icmp eq i32 %pid, @PID1
  br i1 %is_pid1, label %return_q1_for_pid, label %check_pid2_for_pid

check_pid2_for_pid:
  %is_pid2 = icmp eq i32 %pid, @PID2
  br i1 %is_pid2, label %return_q2_for_pid, label %return_null_q_for_pid

return_q1_for_pid:
  ret ptr @test_queue_instance_pid1
return_q2_for_pid:
  ret ptr @test_queue_instance_pid2
return_null_q_for_pid:
  ret ptr null
}

; Helper to reset a queue instance (head, tail to 0)
define internal void @reset_queue_instance(ptr %q_ptr) nounwind {
  %q_head_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 1
  %q_tail_ptr = getelementptr inbounds %msg_queue, ptr %q_ptr, i32 0, i32 2
  store i64 0, ptr %q_head_ptr, align 8
  store i64 0, ptr %q_tail_ptr, align 8
  ret void
}


; --- Test Case 1: Single Process Send/Receive (Self-Test with PID1) ---
define i32 @test_ipc_self_send_receive() {
entry_test_self:
  call void @reset_queue_instance(ptr @test_queue_instance_pid1)
  store i32 @PID1, ptr @g_current_simulated_pid, align 4 ; Simulate as PID1

  %msg_data = alloca %message, align 8
  %m_source_ptr = getelementptr inbounds %message, ptr %msg_data, i32 0, i32 0
  %m_type_ptr = getelementptr inbounds %message, ptr %msg_data, i32 0, i32 1
  %m_payload_0_ptr = getelementptr inbounds %message, ptr %msg_data, i32 0, i32 2, i64 0
  %m_ext_ptr_ptr = getelementptr inbounds %message, ptr %msg_data, i32 0, i32 3

  store i32 @PID1, ptr %m_source_ptr, align 4
  store i32 123, ptr %m_type_ptr, align 4
  store i64 789, ptr %m_payload_0_ptr, align 8
  store ptr null, ptr %m_ext_ptr_ptr, align 8

  ; 1. Send message to self
  %send_status = call i32 @minix_send_async(ptr %msg_data, i32 @PID1)
  %send_ok = icmp eq i32 %send_status, 0
  br i1 %send_ok, label %try_receive_specific_match, label %fail_test_self

try_receive_specific_match:
  ; 2. Receive with specific matching PID filter
  %received_msg1_ptr = call ptr @minix_receive_async(i32 @PID1, i64 0)
  %receive1_ok = icmp eq ptr %received_msg1_ptr, %msg_data ; Check pointer and thus content
  br i1 %receive1_ok, label %try_receive_specific_mismatch, label %fail_test_self

try_receive_specific_mismatch:
  ; 3. Queue should be empty. Try receive with a non-matching PID filter (should be null)
  %received_msg2_ptr = call ptr @minix_receive_async(i32 @PID2, i64 0)
  %receive2_is_null = icmp eq ptr %received_msg2_ptr, null
  br i1 %receive2_is_null, label %try_receive_any_empty, label %fail_test_self

try_receive_any_empty:
  ; 4. Queue is empty. Try receive with ANY_SOURCE filter (should be null)
  %received_msg3_ptr = call ptr @minix_receive_async(i32 @ANY_SOURCE_PID, i64 0)
  %receive3_is_null = icmp eq ptr %received_msg3_ptr, null
  br i1 %receive3_is_null, label %pass_test_self, label %fail_test_self

pass_test_self:
  ret i32 1 ; Success
fail_test_self:
  ret i32 0 ; Failure
}

; --- Test Case 2: Inter-PID Send/Receive ---
define i32 @test_ipc_inter_pid_send_receive() {
entry_inter_pid:
  call void @reset_queue_instance(ptr @test_queue_instance_pid1)
  call void @reset_queue_instance(ptr @test_queue_instance_pid2)

  ; Message 1 from PID1 to PID2
  %msg1_data = alloca %message, align 8
  %m1_source_ptr = getelementptr inbounds %message, ptr %msg1_data, i32 0, i32 0
  %m1_type_ptr = getelementptr inbounds %message, ptr %msg1_data, i32 0, i32 1
  store i32 @PID1, ptr %m1_source_ptr, align 4
  store i32 101, ptr %m1_type_ptr, align 4

  ; Message 2 from PID1 to PID2
  %msg2_data = alloca %message, align 8
  %m2_source_ptr = getelementptr inbounds %message, ptr %msg2_data, i32 0, i32 0
  %m2_type_ptr = getelementptr inbounds %message, ptr %msg2_data, i32 0, i32 1
  store i32 @PID1, ptr %m2_source_ptr, align 4
  store i32 102, ptr %m2_type_ptr, align 4

  ; Simulate PID1 sending
  store i32 @PID1, ptr @g_current_simulated_pid, align 4
  %send1_status = call i32 @minix_send_async(ptr %msg1_data, i32 @PID2)
  %send1_ok = icmp eq i32 %send1_status, 0
  %send2_status = call i32 @minix_send_async(ptr %msg2_data, i32 @PID2)
  %send2_ok = icmp eq i32 %send2_status, 0
  %sends_ok = and i1 %send1_ok, %send2_ok
  br i1 %sends_ok, label %pid2_receive_phase, label %fail_test_inter_pid

pid2_receive_phase:
  ; Simulate PID2 receiving
  store i32 @PID2, ptr @g_current_simulated_pid, align 4

  ; Receive Msg1 (filtering for PID1)
  %rmsg1_ptr = call ptr @minix_receive_async(i32 @PID1, i64 0)
  %rmsg1_check1 = icmp eq ptr %rmsg1_ptr, %msg1_data

  ; Receive Msg2 (filtering for PID1)
  %rmsg2_ptr = call ptr @minix_receive_async(i32 @PID1, i64 0)
  %rmsg2_check1 = icmp eq ptr %rmsg2_ptr, %msg2_data

  ; Queue should now be empty for PID1's messages
  %rmsg3_ptr = call ptr @minix_receive_async(i32 @PID1, i64 0)
  %rmsg3_check_null = icmp eq ptr %rmsg3_ptr, null

  %recvs_ok1 = and i1 %rmsg1_check1, %rmsg2_check1
  %recvs_ok_final = and i1 %recvs_ok1, %rmsg3_check_null
  br i1 %recvs_ok_final, label %pass_test_inter_pid, label %fail_test_inter_pid

pass_test_inter_pid:
  ret i32 1
fail_test_inter_pid:
  ret i32 0
}


; --- Main function to run tests ---
define i32 @main() {
entry_main:
  %res_self_ipc = call i32 @test_ipc_self_send_receive()
  %self_ipc_pass = icmp eq i32 %res_self_ipc, 1

  %res_inter_pid_ipc = call i32 @test_ipc_inter_pid_send_receive()
  %inter_pid_ipc_pass = icmp eq i32 %res_inter_pid_ipc, 1

  %all_tests_pass = and i1 %self_ipc_pass, %inter_pid_ipc_pass

  br i1 %all_tests_pass, label %success_main, label %failure_main

success_main:
  ret i32 0 ; All tests passed
failure_main:
  ret i32 1 ; One or more tests failed
; Integration tests for IPC primitives, message pool, and timing.

source_filename = "src/llvm/test/test_ipc.ll"

; --- Type Definitions ---
%message = type { i32, i32, [6 x i64], ptr } ; m_source is field 0 (PID), m_type is field 1
%msg_queue = type { ptr, i64, i64, i32 }    ; buffer_ptr, head, tail, capacity (indices)

; --- External Function Declarations ---

; From ipc_primitives.ll
declare i32 @minix_receive_async(ptr, i32, i64) nounwind ; New signature
declare i32 @minix_send_async(ptr, i32) nounwind

; From atomic.ll
declare i32 @minix_atomic_enqueue(ptr, ptr) nounwind
declare ptr @minix_atomic_dequeue(ptr) nounwind

; From queue_registry.ll
declare void @initialize_global_queue_registry(i32) nounwind
declare i32 @register_process_queue(i32, ptr) nounwind
declare ptr @get_process_queue(i32) nounwind         ; Used by minix_send_async

; From timing.ll
declare void @init_timing_subsystem() nounwind
declare i64 @ns_to_cycles(i64) nounwind

; From message_pool.ll
declare void @init_message_pool(i32) nounwind
declare ptr @alloc_message() nounwind
declare void @free_message(ptr) nounwind

; LLVM intrinsics
declare void @llvm.trap() nounwind noreturn
declare i64 @llvm.readcyclecounter() nounwind readnone

; --- Global Variables for Test Control ---
@test_current_proc_queue = internal global ptr null, align 8
@ANY_SOURCE_PID_CONST = internal constant i32 -1, align 4 ; Updated ANY_SOURCE convention

; External Message Pool Metric Counters (from message_pool.ll)
@pool_alloc_success_count = external global i64, align 8
@pool_alloc_failure_count = external global i64, align 8
@pool_free_count = external global i64, align 8

; From queue_registry.ll
declare void @initialize_global_queue_registry(i32) nounwind
declare i32 @register_process_queue(i32, ptr) nounwind
declare ptr @get_process_queue(i32) nounwind         ; Used by minix_send_async

; From timing.ll
declare void @init_timing_subsystem() nounwind
declare i64 @ns_to_cycles(i64) nounwind

; From message_pool.ll
declare void @init_message_pool(i32) nounwind
declare ptr @alloc_message() nounwind
declare void @free_message(ptr) nounwind

; LLVM intrinsics
declare void @llvm.trap() nounwind noreturn
declare i64 @llvm.readcyclecounter() nounwind readnone

; --- Global Variables for Test Control ---
@test_current_proc_queue = internal global ptr null, align 8
@ANY_SOURCE_PID_CONST = internal constant i32 -1, align 4 ; Updated ANY_SOURCE convention

; External Message Pool Metric Counters (from message_pool.ll)
@pool_alloc_success_count = external global i64, align 8
@pool_alloc_failure_count = external global i64, align 8
@pool_free_count = external global i64, align 8

; --- Mock Implementations ---
; Mock for the current process's queue. Tests will set @test_current_proc_queue.
define ptr @get_current_process_message_queue() nounwind {
entry:
  %q = load ptr, ptr @test_current_proc_queue, align 8
  ret ptr %q
}

; Mock for getting other processes' queues.
; For simplicity in these tests, we'll assume PID 1 and PID 2 map to specific globals if needed,
; or that tests primarily use get_current_process_message_queue and direct enqueues.
; This specific get_process_queue will be simple: return the @test_current_proc_queue if PID matches a target, else null.
; This might need adjustment if tests require more complex inter-PID simulation via send.
@mock_target_pid_for_get_process_queue = internal global i32 0, align 4

define ptr @get_process_queue(i32 %pid) nounwind {
entry:
  ; %target_pid = load i32, ptr @mock_target_pid_for_get_process_queue, align 4
  ; %match = icmp eq i32 %pid, %target_pid
  ; br i1 %match, label %return_test_q, label %return_null
  ; For now, to allow minix_send_async to proceed if a test sets up a target queue:
  %q = load ptr, ptr @test_current_proc_queue, align 8 ; Simplistic: assume send target uses the current test queue
  ret ptr %q                                         ; This is often not what we want for send.
                                                     ; Tests will mostly use direct enqueue for setup.
return_null:
  ret ptr null
}


; --- Simplified Assertion Helpers ---
@assert_eq_i32_msg_str = private unnamed_addr constant [19 x i8] c"Assert_eq_i32 fail\00", align 1
define void @assert_eq_i32(i32 %v1, i32 %v2, ptr %msg) nounwind {
entry:
  %cond = icmp eq i32 %v1, %v2
  br i1 %cond, label %ok, label %fail
fail:
  call void @llvm.trap()
  unreachable
ok:
  ret void
}

@assert_eq_ptr_msg_str = private unnamed_addr constant [19 x i8] c"Assert_eq_ptr fail\00", align 1
define void @assert_eq_ptr(ptr %p1, ptr %p2, ptr %msg) nounwind {
entry:
  %cond = icmp eq ptr %p1, %p2
  br i1 %cond, label %ok, label %fail
fail:
  call void @llvm.trap()
  unreachable
ok:
  ret void
}

@assert_non_null_ptr_msg_str = private unnamed_addr constant [24 x i8] c"Assert_non_null_ptr fail\00", align 1
define void @assert_non_null_ptr(ptr %p1, ptr %msg) nounwind {
entry:
  %cond = icmp ne ptr %p1, null
  br i1 %cond, label %ok, label %fail
fail:
  call void @llvm.trap()
  unreachable
ok:
  ret void
}

@assert_null_ptr_msg_str = private unnamed_addr constant [21 x i8] c"Assert_null_ptr fail\00", align 1
define void @assert_null_ptr(ptr %p1, ptr %msg) nounwind {
entry:
  %cond = icmp eq ptr %p1, null
  br i1 %cond, label %ok, label %fail
fail:
  call void @llvm.trap()
  unreachable
ok:
  ret void
}

@assert_eq_i64_msg_str = private unnamed_addr constant [19 x i8] c"Assert_eq_i64 fail\00", align 1
define void @assert_eq_i64(i64 %v1, i64 %v2, ptr %msg) nounwind {
entry:
  %cond = icmp eq i64 %v1, %v2
  br i1 %cond, label %ok_i64, label %fail_i64
fail_i64:
  ; In a real test, one might print %msg and values before trapping.
  call void @llvm.trap()
  unreachable
ok_i64:
  ret void
}

; --- Test Case String Literals (for messages in assertions) ---
@requeue_test_msg1 = private unnamed_addr constant [20 x i8] c"Requeue: Enqueue A\00", align 1
@requeue_test_msg2 = private unnamed_addr constant [20 x i8] c"Requeue: Enqueue B\00", align 1
@requeue_test_msg3 = private unnamed_addr constant [26 x i8] c"Requeue: Receive B failed\00", align 1
@requeue_test_msg4 = private unnamed_addr constant [23 x i8] c"Requeue: Msg B wrong\00", align 1
@requeue_test_msg5 = private unnamed_addr constant [26 x i8] c"Requeue: Receive A failed\00", align 1
@requeue_test_msg6 = private unnamed_addr constant [23 x i8] c"Requeue: Msg A wrong\00", align 1

@timeout_test_msg1 = private unnamed_addr constant [22 x i8] c"Timeout: Receive no 1\00", align 1
@timeout_test_msg2 = private unnamed_addr constant [26 x i8] c"Timeout: Msg not null\00", align 1

@pool_test_msg1 = private unnamed_addr constant [19 x i8] c"Pool: Alloc 1 null\00", align 1
@pool_test_msg2 = private unnamed_addr constant [19 x i8] c"Pool: Alloc 2 null\00", align 1
@pool_test_msg3 = private unnamed_addr constant [19 x i8] c"Pool: Alloc 3 null\00", align 1
@pool_test_msg4 = private unnamed_addr constant [19 x i8] c"Pool: Alloc 5 null\00", align 1
@pool_test_msg5 = private unnamed_addr constant [27 x i8] c"Pool: Reused msg mismatch\00", align 1

; --- Helper to reset message pool counters ---
define internal void @reset_pool_counters() nounwind {
entry:
  store i64 0, ptr @pool_alloc_success_count, align 8
  store i64 0, ptr @pool_alloc_failure_count, align 8
  store i64 0, ptr @pool_free_count, align 8
  ret void
}

; --- Helper to assert message pool metric counts ---
define internal void @assert_metric_counts(i64 %expected_s, i64 %expected_f, i64 %expected_fr, ptr %msg_prefix) nounwind {
entry:
  %s_val = load i64, ptr @pool_alloc_success_count, align 8
  %f_val = load i64, ptr @pool_alloc_failure_count, align 8
  %fr_val = load i64, ptr @pool_free_count, align 8

  ; In a real test, %msg_prefix could be used to generate more specific error messages.
  call void @assert_eq_i64(i64 %s_val, i64 %expected_s, ptr %msg_prefix)
  call void @assert_eq_i64(i64 %f_val, i64 %expected_f, ptr %msg_prefix)
  call void @assert_eq_i64(i64 %fr_val, i64 %expected_fr, ptr %msg_prefix)
  ret void
}

; --- Test Cases Will Follow ---
; (Existing test_ipc_self_send_receive and test_ipc_inter_pid_send_receive and old main are removed)

define i32 @test_message_requeuing() nounwind {
entry:
  call void @init_timing_subsystem()
  call void @init_message_pool(i32 10) ; Pool for at least 2 messages
  call void @initialize_global_queue_registry(i32 3) ; For PIDs 0, 1, 2

  ; Setup %msg_queue for the current test process (e.g. "self")
  %q_for_test_buffer = alloca ptr, i32 10, align 8 ; Ring buffer for 10 message ptrs
  %q_for_test = alloca %msg_queue, align 8
  %q_buffer_ptr_loc = getelementptr inbounds %msg_queue, ptr %q_for_test, i32 0, i32 0
  %q_head_ptr_loc = getelementptr inbounds %msg_queue, ptr %q_for_test, i32 0, i32 1
  %q_tail_ptr_loc = getelementptr inbounds %msg_queue, ptr %q_for_test, i32 0, i32 2
  %q_capacity_ptr_loc = getelementptr inbounds %msg_queue, ptr %q_for_test, i32 0, i32 3

  store ptr %q_for_test_buffer, ptr %q_buffer_ptr_loc, align 8
  store i64 0, ptr %q_head_ptr_loc, align 8 ; head = {idx=0, tag=0}
  store i64 0, ptr %q_tail_ptr_loc, align 8 ; tail = {idx=0, tag=0}
  store i32 10, ptr %q_capacity_ptr_loc, align 4 ; capacity = 10

  store ptr %q_for_test, ptr @test_current_proc_queue, align 8 ; Set this as current process's queue

  %pid_x = i32 1
  %pid_y = i32 2

  ; Allocate and prepare message A from PID_X
  %msg_a_ptr = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg_a_ptr, ptr @requeue_test_msg1) ; Placeholder msg
  %msg_a_src_ptr = getelementptr inbounds %message, ptr %msg_a_ptr, i32 0, i32 0
  store i32 %pid_x, ptr %msg_a_src_ptr, align 4
  %msg_a_type_ptr = getelementptr inbounds %message, ptr %msg_a_ptr, i32 0, i32 1
  store i32 101, ptr %msg_a_type_ptr, align 4 ; Arbitrary type

  ; Allocate and prepare message B from PID_Y
  %msg_b_ptr = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg_b_ptr, ptr @requeue_test_msg2) ; Placeholder msg
  %msg_b_src_ptr = getelementptr inbounds %message, ptr %msg_b_ptr, i32 0, i32 0
  store i32 %pid_y, ptr %msg_b_src_ptr, align 4
  %msg_b_type_ptr = getelementptr inbounds %message, ptr %msg_b_ptr, i32 0, i32 1
  store i32 202, ptr %msg_b_type_ptr, align 4 ; Arbitrary type

  ; Enqueue A then B directly into the current process's queue
  %enqueue_a_ret = call i32 @minix_atomic_enqueue(ptr %q_for_test, ptr %msg_a_ptr)
  call void @assert_eq_i32(i32 %enqueue_a_ret, i32 0, ptr @requeue_test_msg1)
  %enqueue_b_ret = call i32 @minix_atomic_enqueue(ptr %q_for_test, ptr %msg_b_ptr)
  call void @assert_eq_i32(i32 %enqueue_b_ret, i32 0, ptr @requeue_test_msg2)

  ; Attempt to receive message from PID_Y (should get B, A should be requeued)
  %received_msg_ptr_addr1 = alloca ptr, align 8
  %receive_b_ret = call i32 @minix_receive_async(ptr %received_msg_ptr_addr1, i32 %pid_y, i64 0) ; Non-blocking
  call void @assert_eq_i32(i32 %receive_b_ret, i32 0, ptr @requeue_test_msg3)
  %msg_from_receive1 = load ptr, ptr %received_msg_ptr_addr1, align 8
  call void @assert_eq_ptr(ptr %msg_from_receive1, ptr %msg_b_ptr, ptr @requeue_test_msg4)

  ; Attempt to receive message from PID_X (should get A, which was requeued)
  %received_msg_ptr_addr2 = alloca ptr, align 8
  %receive_a_ret = call i32 @minix_receive_async(ptr %received_msg_ptr_addr2, i32 %pid_x, i64 0) ; Non-blocking
  call void @assert_eq_i32(i32 %receive_a_ret, i32 0, ptr @requeue_test_msg5)
  %msg_from_receive2 = load ptr, ptr %received_msg_ptr_addr2, align 8
  call void @assert_eq_ptr(ptr %msg_from_receive2, ptr %msg_a_ptr, ptr @requeue_test_msg6)

  ; Cleanup
  call void @free_message(ptr %msg_a_ptr)
  call void @free_message(ptr %msg_b_ptr)
  ; Reset global queue for next test if any
  store ptr null, ptr @test_current_proc_queue, align 8
  ret i32 0 ; Success
}

define i32 @test_receive_timeout() nounwind {
entry:
  call void @init_timing_subsystem()
  call void @init_message_pool(i32 10)
  call void @initialize_global_queue_registry(i32 3)

  ; Setup a clean %msg_queue for the current test process
  %q_for_timeout_buf = alloca ptr, i32 10, align 8
  %q_for_timeout = alloca %msg_queue, align 8
  %q_buf_ptr_loc_to = getelementptr inbounds %msg_queue, ptr %q_for_timeout, i32 0, i32 0
  %q_head_ptr_loc_to = getelementptr inbounds %msg_queue, ptr %q_for_timeout, i32 0, i32 1
  %q_tail_ptr_loc_to = getelementptr inbounds %msg_queue, ptr %q_for_timeout, i32 0, i32 2
  %q_cap_ptr_loc_to = getelementptr inbounds %msg_queue, ptr %q_for_timeout, i32 0, i32 3

  store ptr %q_for_timeout_buf, ptr %q_buf_ptr_loc_to, align 8
  store i64 0, ptr %q_head_ptr_loc_to, align 8
  store i64 0, ptr %q_tail_ptr_loc_to, align 8
  store i32 10, ptr %q_cap_ptr_loc_to, align 4

  store ptr %q_for_timeout, ptr @test_current_proc_queue, align 8

  %received_msg_ptr_addr_to = alloca ptr, align 8
  %short_timeout_ns = i64 1000000 ; 1ms

  %any_source_pid = load i32, ptr @ANY_SOURCE_PID_CONST, align 4

  %receive_ret_to = call i32 @minix_receive_async(ptr %received_msg_ptr_addr_to, i32 %any_source_pid, i64 %short_timeout_ns)

  ; Expected return for timeout is 1
  call void @assert_eq_i32(i32 %receive_ret_to, i32 1, ptr @timeout_test_msg1)

  %msg_ptr_timeout = load ptr, ptr %received_msg_ptr_addr_to, align 8
  call void @assert_null_ptr(ptr %msg_ptr_timeout, ptr @timeout_test_msg2)

  store ptr null, ptr @test_current_proc_queue, align 8
  ret i32 0 ; Success
}

define i32 @test_message_pool_metrics() nounwind {
entry:
  call void @init_message_pool(i32 2) ; Pool of capacity 2.
  call void @reset_pool_counters()   ; Reset counters after init, before test operations

  %msg_pfx_alloc1 = private unnamed_addr constant [17 x i8] c"Metrics alloc 1\00", align 1
  %msg1 = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg1, ptr %msg_pfx_alloc1)
  call void @assert_metric_counts(i64 1, i64 0, i64 0, ptr %msg_pfx_alloc1)

  %msg_pfx_alloc2 = private unnamed_addr constant [17 x i8] c"Metrics alloc 2\00", align 1
  %msg2 = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg2, ptr %msg_pfx_alloc2)
  call void @assert_metric_counts(i64 2, i64 0, i64 0, ptr %msg_pfx_alloc2)

  %msg_pfx_alloc_fail = private unnamed_addr constant [24 x i8] c"Metrics alloc exhaust\00", align 1
  %msg3 = call ptr @alloc_message()
  call void @assert_null_ptr(ptr %msg3, ptr %msg_pfx_alloc_fail)
  call void @assert_metric_counts(i64 2, i64 1, i64 0, ptr %msg_pfx_alloc_fail)

  %msg_pfx_free1 = private unnamed_addr constant [16 x i8] c"Metrics free 1\00", align 1
  call void @free_message(ptr %msg1)
  call void @assert_metric_counts(i64 2, i64 1, i64 1, ptr %msg_pfx_free1)

  %msg_pfx_realloc = private unnamed_addr constant [19 x i8] c"Metrics re-alloc\00", align 1
  %msg4 = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg4, ptr %msg_pfx_realloc)
  call void @assert_eq_ptr(ptr %msg4, ptr %msg1, ptr %msg_pfx_realloc) ; Check reuse
  call void @assert_metric_counts(i64 3, i64 1, i64 1, ptr %msg_pfx_realloc)

  %msg_pfx_free_all = private unnamed_addr constant [20 x i8] c"Metrics free all\00", align 1
  call void @free_message(ptr %msg2)
  call void @free_message(ptr %msg4) ; This is effectively msg1 being freed again
  call void @assert_metric_counts(i64 3, i64 1, i64 3, ptr %msg_pfx_free_all)

  ret i32 0 ; Success
}

define i32 @main() nounwind {
entry:
  %overall_result = alloca i32, align 4
  store i32 0, ptr %overall_result, align 4 ; 0 for success, 1 for failure

  ; Run test_message_requeuing
  %ret_requeue = call i32 @test_message_requeuing()
  %failed_requeue = icmp ne i32 %ret_requeue, 0
  br i1 %failed_requeue, label %set_failure, label %continue_to_timeout_test

continue_to_timeout_test:
  ; Run test_receive_timeout
  %ret_timeout = call i32 @test_receive_timeout()
  %failed_timeout = icmp ne i32 %ret_timeout, 0
  br i1 %failed_timeout, label %set_failure, label %continue_to_pool_test

continue_to_pool_test:
  ; Run test_message_pool_metrics
  %ret_pool_metrics = call i32 @test_message_pool_metrics()
  %failed_pool_metrics = icmp ne i32 %ret_pool_metrics, 0
  br i1 %failed_pool_metrics, label %set_failure, label %all_tests_done

set_failure:
  store i32 1, ptr %overall_result, align 4
  br label %all_tests_done

all_tests_done:
  %final_ret_val = load i32, ptr %overall_result, align 4
  ret i32 %final_ret_val
}
