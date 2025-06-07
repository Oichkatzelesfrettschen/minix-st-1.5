; src/llvm/test/test_ipc.ll
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

define i32 @test_message_pool_alloc_free() nounwind {
entry:
  ; No need for timing or queue registry for this specific pool test.
  ; Only init_message_pool.
  call void @init_message_pool(i32 2) ; Pool for 2 messages

  %msg1 = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg1, ptr @pool_test_msg1)

  %msg2 = call ptr @alloc_message()
  call void @assert_non_null_ptr(ptr %msg2, ptr @pool_test_msg2)

  ; Pool of 2 is now exhausted. Next alloc should return null.
  %msg3 = call ptr @alloc_message()
  call void @assert_null_ptr(ptr %msg3, ptr @pool_test_msg3) ; Expect null due to exhaustion

  call void @free_message(ptr %msg1) ; Free the first message

  %msg4 = call ptr @alloc_message() ; Should get back the slot from msg1
  call void @assert_non_null_ptr(ptr %msg4, ptr @pool_test_msg4)
  call void @assert_eq_ptr(ptr %msg4, ptr %msg1, ptr @pool_test_msg5)

  ; Cleanup remaining messages
  call void @free_message(ptr %msg4) ; Which is actually msg1's slot
  call void @free_message(ptr %msg2)

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
  ; Run test_message_pool_alloc_free
  %ret_pool = call i32 @test_message_pool_alloc_free()
  %failed_pool = icmp ne i32 %ret_pool, 0
  br i1 %failed_pool, label %set_failure, label %all_tests_done

set_failure:
  store i32 1, ptr %overall_result, align 4
  br label %all_tests_done

all_tests_done:
  %final_ret_val = load i32, ptr %overall_result, align 4
  ret i32 %final_ret_val
}
