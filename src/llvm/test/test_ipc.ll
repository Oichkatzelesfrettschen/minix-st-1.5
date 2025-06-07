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
}
