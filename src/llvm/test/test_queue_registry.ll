; Test suite for src/llvm/queue_registry.ll

; --- Type Definitions ---
%msg_queue = type { ptr, i64, i64, i32 } ; Matches definition in queue_registry.ll

; --- External Function Declarations (from queue_registry.ll) ---
declare void @initialize_global_queue_registry(i32 %max_processes) nounwind
declare void @init_registry_lock() nounwind
declare i32 @register_process_queue(i32 %pid, ptr %queue_instance) nounwind
declare i32 @unregister_process_queue(i32 %pid) nounwind
declare ptr @get_process_queue_safe(i32 %pid) nounwind

; --- Utility Function Declarations ---
; In a real scenario, minix_panic might be linked from elsewhere or be a test-specific stub.
declare void @minix_panic(ptr %message) noreturn nounwind

; --- External Global Variable Declarations (from queue_registry.ll) ---
@global_queue_registry_ptr = external global ptr, align 8
@registry_rw_lock_initialized = external global i32, align 4
@global_registry_initialized_flag = external global i32, align 4

; --- External Error Code Declarations (from queue_registry.ll) ---
@E_SUCCESS = external global i32, align 4
@E_INVALID_INPUT = external global i32, align 4
@E_NOT_INITIALIZED = external global i32, align 4
@E_INVALID_PID = external global i32, align 4
@E_ALREADY_REGISTERED = external global i32, align 4
@E_LOCK_FAILED = external global i32, align 4 ; Likely not directly tested as it causes panic
@E_NOT_REGISTERED = external global i32, align 4

; External contention counters (from queue_registry.ll)
@read_lock_contentions = external global i64, align 8
@write_lock_contentions = external global i64, align 8 ; Though not directly used in this test, good to have if needed

; --- Global Variables for Storing Baseline Contention from Last Test Run ---
@last_run_phase3_delta_read_contentions = internal global i64 0, align 8
@last_run_phase3_delta_write_contentions = internal global i64 0, align 8

; --- Global String Constants for Assertion Messages ---
@err_generic_assert_fail = private unnamed_addr constant [20 x i8] c"Assertion Failed: \00", align 1 ; Generic prefix

; Initialization Idempotency Test Messages
@err_init_idem_1 = private unnamed_addr constant [30 x i8] c"Init idempotency panic: GQRptr\00", align 1

; Registration and Retrieval Test Messages
@err_reg_ret_reg0_fail = private unnamed_addr constant [27 x i8] c"Reg/Ret: Reg PID 0 failed\00", align 1
@err_reg_ret_reg1_fail = private unnamed_addr constant [27 x i8] c"Reg/Ret: Reg PID 1 failed\00", align 1
@err_reg_ret_get0_val = private unnamed_addr constant [33 x i8] c"Reg/Ret: Get PID 0 value mismatch\00", align 1
@err_reg_ret_get1_val = private unnamed_addr constant [33 x i8] c"Reg/Ret: Get PID 1 value mismatch\00", align 1
@err_reg_ret_get2_null = private unnamed_addr constant [35 x i8] c"Reg/Ret: Get PID 2 not null as exp\00", align 1

; Registration Errors Test Messages
@err_reg_err_neg_pid = private unnamed_addr constant [30 x i8] c"RegErr: Negative PID not err 1\00", align 1
@err_reg_err_large_pid = private unnamed_addr constant [28 x i8] c"RegErr: Large PID not err 1\00", align 1
@err_reg_err_null_q = private unnamed_addr constant [30 x i8] c"RegErr: Null Queue not err 2\00", align 1
@err_reg_err_reg_ok = private unnamed_addr constant [31 x i8] c"RegErr: Initial Reg not err 0\00", align 1
@err_reg_err_slot_taken = private unnamed_addr constant [32 x i8] c"RegErr: Slot taken not err 3\00", align 1

; Unregistration Test Messages
@err_unreg_reg1_fail = private unnamed_addr constant [29 x i8] c"Unreg: Reg PID 1 failed init\00", align 1
@err_unreg_unreg1_fail = private unnamed_addr constant [29 x i8] c"Unreg: Unreg PID 1 not err 0\00", align 1
@err_unreg_get1_after = private unnamed_addr constant [37 x i8] c"Unreg: Get PID 1 after unreg not null\00", align 1
@err_unreg_rereg1_fail = private unnamed_addr constant [31 x i8] c"Unreg: Rereg PID 1 not err 0\00", align 1

; Unregistration Errors Test Messages
@err_unreg_err_neg_pid = private unnamed_addr constant [32 x i8] c"UnregErr: Negative PID not err 1\00", align 1
@err_unreg_err_large_pid = private unnamed_addr constant [30 x i8] c"UnregErr: Large PID not err 1\00", align 1
@err_unreg_err_slot_empty = private unnamed_addr constant [33 x i8] c"UnregErr: Slot empty not err 2\00", align 1
@err_unreg_err_reg_ok = private unnamed_addr constant [33 x i8] c"UnregErr: Reg PID 1 not err 0\00", align 1
@err_unreg_err_mismatch = private unnamed_addr constant [37 x i8] c"UnregErr: PID mismatch slot not err 2\00", align 1

; Get Queue Various Scenarios Test Messages
@err_get_q_neg_pid = private unnamed_addr constant [31 x i8] c"GetQ: Negative PID not null\00", align 1
@err_get_q_large_pid = private unnamed_addr constant [29 x i8] c"GetQ: Large PID not null\00", align 1
@err_get_q_empty_slot = private unnamed_addr constant [32 x i8] c"GetQ: Empty slot not null\00", align 1
@err_get_q_reg_fail = private unnamed_addr constant [30 x i8] c"GetQ: Reg PID 0 not err 0\00", align 1
@err_get_q_val_mismatch = private unnamed_addr constant [34 x i8] c"GetQ: Get PID 0 value mismatch\00", align 1
@err_get_q_unreg_fail = private unnamed_addr constant [32 x i8] c"GetQ: Unreg PID 0 not err 0\00", align 1
@err_get_q_after_unreg = private unnamed_addr constant [36 x i8] c"GetQ: Get PID 0 after unreg not null\00", align 1

; Dummy queue instances for tests (internal linkage)
@dummy_q1_trar = internal global %msg_queue zeroinitializer, align 8
@dummy_q2_trar = internal global %msg_queue zeroinitializer, align 8
@dummy_q1_tre = internal global %msg_queue zeroinitializer, align 8
@dummy_q1_tu = internal global %msg_queue zeroinitializer, align 8
@dummy_q1_tue = internal global %msg_queue zeroinitializer, align 8
@dummy_q1_tgqvs = internal global %msg_queue zeroinitializer, align 8

; --- Assertion Helper Functions ---

; Asserts two i32 values are equal. Calls minix_panic if not.
define void @assert_eq_i32(i32 %v1, i32 %v2, ptr %err_msg) nounwind {
entry:
  %cmp_result = icmp eq i32 %v1, %v2
  br i1 %cmp_result, label %assert_ok, label %assert_fail

assert_fail:
  ; For more detailed error, one might concatenate %err_msg with actual values.
  call void @minix_panic(ptr %err_msg)
  unreachable

assert_ok:
  ret void
}

; Test 6: Get Queue Various Scenarios
define void @test_get_queue_various_scenarios() nounwind {
entry:
  ; Ensure clean state
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8

  call void @initialize_global_queue_registry(i32 2)

  ; PID < 0
  %q_neg = call ptr @get_process_queue_safe(i32 -1)
  call void @assert_null(ptr %q_neg, ptr @err_get_q_neg_pid)

  ; PID >= num_processes_configured
  %q_large = call ptr @get_process_queue_safe(i32 2)
  call void @assert_null(ptr %q_large, ptr @err_get_q_large_pid)

  ; Empty slot (owner_pid is -1)
  %q_empty = call ptr @get_process_queue_safe(i32 0)
  call void @assert_null(ptr %q_empty, ptr @err_get_q_empty_slot)

  ; Register PID 0
  %expected_success = load i32, ptr @E_SUCCESS, align 4
  %reg_res = call i32 @register_process_queue(i32 0, ptr @dummy_q1_tgqvs)
  call void @assert_eq_i32(i32 %reg_res, i32 %expected_success, ptr @err_get_q_reg_fail)

  ; Successful retrieval
  %q_ok = call ptr @get_process_queue_safe(i32 0)
  call void @assert_eq_ptr(ptr %q_ok, ptr @dummy_q1_tgqvs, ptr @err_get_q_val_mismatch)

  ; Unregister PID 0
  %unreg_res = call i32 @unregister_process_queue(i32 0)
  call void @assert_eq_i32(i32 %unreg_res, i32 %expected_success, ptr @err_get_q_unreg_fail)

  ; Retrieve after unregistration
  %q_after_unreg = call ptr @get_process_queue_safe(i32 0)
  call void @assert_null(ptr %q_after_unreg, ptr @err_get_q_after_unreg)

  ret void
}

; Test 5: Unregistration Errors
define void @test_unregistration_errors() nounwind {
entry:
  ; Ensure clean state
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8

  call void @initialize_global_queue_registry(i32 3)

  ; PID < 0
  %err_invalid_pid_val = load i32, ptr @E_INVALID_PID, align 4
  %res_neg_pid = call i32 @unregister_process_queue(i32 -1)
  call void @assert_eq_i32(i32 %res_neg_pid, i32 %err_invalid_pid_val, ptr @err_unreg_err_neg_pid)

  ; PID >= num_processes_configured
  %res_large_pid = call i32 @unregister_process_queue(i32 3)
  call void @assert_eq_i32(i32 %res_large_pid, i32 %err_invalid_pid_val, ptr @err_unreg_err_large_pid)

  ; Slot not registered (actual_queue is null for PID 0)
  %err_not_registered_val = load i32, ptr @E_NOT_REGISTERED, align 4
  %res_slot_empty = call i32 @unregister_process_queue(i32 0)
  call void @assert_eq_i32(i32 %res_slot_empty, i32 %err_not_registered_val, ptr @err_unreg_err_slot_empty)

  ; Register PID 1 for next test
  %expected_success = load i32, ptr @E_SUCCESS, align 4
  %reg_res1 = call i32 @register_process_queue(i32 1, ptr @dummy_q1_tue)
  call void @assert_eq_i32(i32 %reg_res1, i32 %expected_success, ptr @err_unreg_err_reg_ok)

  ; Attempt to unregister PID 0 again (still not registered)
  %res_mismatch = call i32 @unregister_process_queue(i32 0)
  call void @assert_eq_i32(i32 %res_mismatch, i32 %err_not_registered_val, ptr @err_unreg_err_mismatch)

  ret void
}

; Test 4: Unregistration
define void @test_unregistration() nounwind {
entry:
  ; Ensure clean state
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8

  call void @initialize_global_queue_registry(i32 3)

  ; Register PID 1
  %expected_success = load i32, ptr @E_SUCCESS, align 4
  %reg_res1 = call i32 @register_process_queue(i32 1, ptr @dummy_q1_tu)
  call void @assert_eq_i32(i32 %reg_res1, i32 %expected_success, ptr @err_unreg_reg1_fail)

  ; Unregister PID 1
  %unreg_res1 = call i32 @unregister_process_queue(i32 1)
  call void @assert_eq_i32(i32 %unreg_res1, i32 %expected_success, ptr @err_unreg_unreg1_fail)

  ; Verify PID 1 is gone
  %q_after_unreg = call ptr @get_process_queue_safe(i32 1)
  call void @assert_null(ptr %q_after_unreg, ptr @err_unreg_get1_after)

  ; Re-register PID 1
  %rereg_res1 = call i32 @register_process_queue(i32 1, ptr @dummy_q1_tu)
  call void @assert_eq_i32(i32 %rereg_res1, i32 %expected_success, ptr @err_unreg_rereg1_fail)

  ret void
}

; Test 3: Registration Errors
define void @test_registration_errors() nounwind {
entry:
  ; Ensure clean state
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8

  call void @initialize_global_queue_registry(i32 3)

  ; PID < 0
  %err_invalid_pid_val = load i32, ptr @E_INVALID_PID, align 4
  %res_neg_pid = call i32 @register_process_queue(i32 -1, ptr @dummy_q1_tre)
  call void @assert_eq_i32(i32 %res_neg_pid, i32 %err_invalid_pid_val, ptr @err_reg_err_neg_pid)

  ; PID >= num_processes_configured
  %res_large_pid = call i32 @register_process_queue(i32 3, ptr @dummy_q1_tre)
  call void @assert_eq_i32(i32 %res_large_pid, i32 %err_invalid_pid_val, ptr @err_reg_err_large_pid)

  ; Null queue instance
  %err_invalid_input_val = load i32, ptr @E_INVALID_INPUT, align 4
  %res_null_q = call i32 @register_process_queue(i32 0, ptr null)
  call void @assert_eq_i32(i32 %res_null_q, i32 %err_invalid_input_val, ptr @err_reg_err_null_q)

  ; Successful registration
  %expected_success = load i32, ptr @E_SUCCESS, align 4
  %res_reg_ok = call i32 @register_process_queue(i32 0, ptr @dummy_q1_tre)
  call void @assert_eq_i32(i32 %res_reg_ok, i32 %expected_success, ptr @err_reg_err_reg_ok)

  ; Slot taken (actual_queue is now non-null for PID 0)
  %err_already_registered_val = load i32, ptr @E_ALREADY_REGISTERED, align 4
  %res_slot_taken = call i32 @register_process_queue(i32 0, ptr @dummy_q1_tre)
  call void @assert_eq_i32(i32 %res_slot_taken, i32 %err_already_registered_val, ptr @err_reg_err_slot_taken)

  ret void
}

; Test 2: Registration and Retrieval
define void @test_registration_and_retrieval() nounwind {
entry:
  ; Ensure clean state for this test
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8

  call void @initialize_global_queue_registry(i32 5)

  ; Register PID 0 with @dummy_q1_trar
  %expected_success = load i32, ptr @E_SUCCESS, align 4
  %reg_res0 = call i32 @register_process_queue(i32 0, ptr @dummy_q1_trar)
  call void @assert_eq_i32(i32 %reg_res0, i32 %expected_success, ptr @err_reg_ret_reg0_fail)

  ; Register PID 1 with @dummy_q2_trar
  %reg_res1 = call i32 @register_process_queue(i32 1, ptr @dummy_q2_trar)
  call void @assert_eq_i32(i32 %reg_res1, i32 %expected_success, ptr @err_reg_ret_reg1_fail)

  ; Retrieve and verify PID 0
  %q0 = call ptr @get_process_queue_safe(i32 0)
  call void @assert_eq_ptr(ptr %q0, ptr @dummy_q1_trar, ptr @err_reg_ret_get0_val)

  ; Retrieve and verify PID 1
  %q1 = call ptr @get_process_queue_safe(i32 1)
  call void @assert_eq_ptr(ptr %q1, ptr @dummy_q2_trar, ptr @err_reg_ret_get1_val)

  ; Retrieve non-existent PID 2
  %q_non_existent = call ptr @get_process_queue_safe(i32 2)
  call void @assert_null(ptr %q_non_existent, ptr @err_reg_ret_get2_null)

  ret void
}

; --- Test Case Implementations ---

; Test 1: Initialization Idempotency
define void @test_initialization_idempotency() nounwind {
entry:
  ; Reset global flags for this test to simulate first-time init
  ; This is a simplified approach for this test environment.
  ; A more robust test framework would handle state better.
  store i32 0, ptr @global_registry_initialized_flag, align 4
  store i32 0, ptr @registry_rw_lock_initialized, align 4
  store ptr null, ptr @global_queue_registry_ptr, align 8


  call void @initialize_global_queue_registry(i32 10)
  call void @initialize_global_queue_registry(i32 10) ; Should be idempotent

  call void @init_registry_lock()
  call void @init_registry_lock() ; Should be idempotent

  %reg_ptr = load ptr, ptr @global_queue_registry_ptr, align 8
  call void @assert_non_null(ptr %reg_ptr, ptr @err_init_idem_1)

  ret void
}

; Asserts two ptr values are equal. Calls minix_panic if not.
define void @assert_eq_ptr(ptr %p1, ptr %p2, ptr %err_msg) nounwind {
entry:
  %cmp_result = icmp eq ptr %p1, %p2
  br i1 %cmp_result, label %assert_ok, label %assert_fail

assert_fail:
  call void @minix_panic(ptr %err_msg)
  unreachable

assert_ok:
  ret void
}

; Asserts a ptr is null. Calls minix_panic if not.
define void @assert_null(ptr %p, ptr %err_msg) nounwind {
entry:
  %cmp_result = icmp eq ptr %p, null
  br i1 %cmp_result, label %assert_ok, label %assert_fail

assert_fail:
  call void @minix_panic(ptr %err_msg)
  unreachable

assert_ok:
  ret void
}

; Asserts a ptr is non-null. Calls minix_panic if not.
define void @assert_non_null(ptr %p, ptr %err_msg) nounwind {
entry:
  %cmp_result = icmp ne ptr %p, null
  br i1 %cmp_result, label %assert_ok, label %assert_fail

assert_fail:
  call void @minix_panic(ptr %err_msg)
  unreachable

assert_ok:
  ret void
}

; --- Main Test Runner ---
define i32 @main() nounwind {
entry:
  ; --- Call existing basic tests (assume they panic on failure) ---
  ; Reset before the block of basic tests as they might share initialization context
  ; or rely on specific sequences.
  call void @reset_registry_globals_for_test()
  call void @test_initialization_idempotency()
  call void @test_registration_and_retrieval()
  call void @test_registration_errors()
  call void @test_unregistration()
  call void @test_unregistration_errors()
  call void @test_get_queue_various_scenarios()
  ; If any of these panic, execution stops here.

  ; --- Call new advanced tests (that return i32) ---
  %overall_new_tests_result = alloca i32, align 4
  store i32 0, ptr %overall_new_tests_result, align 4 ; 0 for success, 1 for failure

  ; Test test_lock_timeout_behavior
  call void @reset_registry_globals_for_test() ; Reset before this specific test
  %ret_lock_timeout = call i32 @test_lock_timeout_behavior()
  %failed_lock_timeout = icmp ne i32 %ret_lock_timeout, 0
  br i1 %failed_lock_timeout, label %set_new_test_failure, label %continue_to_mem_ord

continue_to_mem_ord:
  ; Test test_memory_ordering_consistency
  call void @reset_registry_globals_for_test() ; Reset before this specific test
  %ret_mem_ord = call i32 @test_memory_ordering_consistency()
  %failed_mem_ord = icmp ne i32 %ret_mem_ord, 0
  br i1 %failed_mem_ord, label %set_new_test_failure, label %continue_to_concurrent_reg

continue_to_concurrent_reg:
  ; Test test_concurrent_registration
  call void @reset_registry_globals_for_test() ; Reset before this specific test
  %ret_concurrent_reg = call i32 @test_concurrent_registration()
  %failed_concurrent_reg = icmp ne i32 %ret_concurrent_reg, 0
  br i1 %failed_concurrent_reg, label %set_new_test_failure, label %all_new_tests_done

set_new_test_failure:
  store i32 1, ptr %overall_new_tests_result, align 4
  br label %all_new_tests_done

all_new_tests_done:
  %final_ret_val = load i32, ptr %overall_new_tests_result, align 4
  ret i32 %final_ret_val ; Returns 0 if all new tests passed, 1 otherwise.
                        ; Assumes basic tests passed (didn't panic).
}

; --- Helper functions for C Test Harness ---

; Worker function to be called by each thread for registration
define i32 @concurrent_registration_worker(i32 %pid, ptr %dummy_queue_addr) nounwind {
entry:
  %ret = call i32 @register_process_queue(i32 %pid, ptr %dummy_queue_addr)
  ret i32 %ret
}

; Verification function to be called by C after threads complete
define i32 @verify_concurrent_registrations(i32 %num_threads_attempted, i32 %max_pid_to_check_exclusive, ptr %expected_queue_addr) nounwind {
entry:
  %verified_count_alloc = alloca i32, align 4
  store i32 0, ptr %verified_count_alloc, align 4

  %i_alloc = alloca i32, align 4
  store i32 0, ptr %i_alloc, align 4
  br label %loop_header

loop_header:
  %current_i = load i32, ptr %i_alloc, align 4
  %loop_cond = icmp slt i32 %current_i, %max_pid_to_check_exclusive
  br i1 %loop_cond, label %loop_body, label %loop_exit

loop_body:
  %q_ptr = call ptr @get_process_queue_safe(i32 %current_i)
  %is_expected_q = icmp eq ptr %q_ptr, %expected_queue_addr
  br i1 %is_expected_q, label %increment_verified, label %next_iteration

increment_verified:
  %current_verified_val = load i32, ptr %verified_count_alloc, align 4
  %next_verified_val = add i32 %current_verified_val, 1
  store i32 %next_verified_val, ptr %verified_count_alloc, align 4
  br label %next_iteration

next_iteration:
  %next_i_val = add i32 %current_i, 1
  store i32 %next_i_val, ptr %i_alloc, align 4
  br label %loop_header

loop_exit:
  %final_verified_count = load i32, ptr %verified_count_alloc, align 4
  ret i32 %final_verified_count
}

; --- Standalone Test for Concurrent Operations (callable from @main or other LLVM test runners) ---
define i32 @test_concurrent_registration() nounwind {
entry:
  ; Initialize registry for this test - This assumes initialize_global_queue_registry can be called
  ; multiple times or that the test runner ensures a fresh state or appropriate initial call.
  ; The C harness calls this once. If running this test via lli on test_queue_registry.ll's @main,
  ; @main should call initialize_global_queue_registry first.
  ; For this specific function, we include it to ensure the requested capacity.
  call void @initialize_global_queue_registry(i32 256)

  ; Phase 1: Rapid Sequential Registration
  %test_queues = alloca %msg_queue, i32 100, align 16
  %idx_p1 = alloca i32, align 4
  store i32 0, ptr %idx_p1, align 4
  br label %phase1_loop_header

phase1_loop_header:
  %current_idx_p1 = load i32, ptr %idx_p1, align 4
  %phase1_loop_cond = icmp slt i32 %current_idx_p1, 100
  br i1 %phase1_loop_cond, label %phase1_loop_body, label %phase1_verify_loop_header

phase1_loop_body:
  %queue_ptr_p1 = getelementptr inbounds %msg_queue, ptr %test_queues, i32 %current_idx_p1
  %field3_ptr_p1 = getelementptr inbounds %msg_queue, ptr %queue_ptr_p1, i32 0, i32 3
  store i32 %current_idx_p1, ptr %field3_ptr_p1, align 4 ; Mark the queue (simulates unique init)

  %reg_ret_p1 = call i32 @register_process_queue(i32 %current_idx_p1, ptr %queue_ptr_p1)
  %expected_success_p1 = load i32, ptr @E_SUCCESS, align 4
  %reg_failed_p1 = icmp ne i32 %reg_ret_p1, %expected_success_p1
  br i1 %reg_failed_p1, label %phase1_fail_ret_neg1, label %phase1_next_idx

phase1_next_idx:
  %next_idx_val_p1 = add i32 %current_idx_p1, 1
  store i32 %next_idx_val_p1, ptr %idx_p1, align 4
  br label %phase1_loop_header

phase1_fail_ret_neg1:
  ret i32 -1

phase1_verify_loop_header:
  %idx_p1_verify = alloca i32, align 4
  store i32 0, ptr %idx_p1_verify, align 4
  br label %phase1_verify_inner_loop_header

phase1_verify_inner_loop_header:
  %current_vid_p1 = load i32, ptr %idx_p1_verify, align 4
  %phase1_verify_loop_cond = icmp slt i32 %current_vid_p1, 100
  br i1 %phase1_verify_loop_cond, label %phase1_verify_loop_body, label %phase2_loop_header

phase1_verify_loop_body:
  %retrieved_q_ptr_p1 = call ptr @get_process_queue_safe(i32 %current_vid_p1)
  %is_null_p1 = icmp eq ptr %retrieved_q_ptr_p1, null
  br i1 %is_null_p1, label %phase1_fail_ret_neg2, label %phase1_verify_match

phase1_verify_match:
  %expected_q_ptr_p1 = getelementptr inbounds %msg_queue, ptr %test_queues, i32 %current_vid_p1
  %is_mismatch_p1 = icmp ne ptr %retrieved_q_ptr_p1, %expected_q_ptr_p1
  br i1 %is_mismatch_p1, label %phase1_fail_ret_neg2, label %phase1_verify_next_idx

phase1_verify_next_idx:
  %next_vid_val_p1 = add i32 %current_vid_p1, 1
  store i32 %next_vid_val_p1, ptr %idx_p1_verify, align 4
  br label %phase1_verify_inner_loop_header

phase1_fail_ret_neg2:
  ret i32 -2

phase2_loop_header:
  %idx_p2 = alloca i32, align 4
  store i32 0, ptr %idx_p2, align 4 ; iid from 0 to 49
  br label %phase2_inner_loop_header

phase2_inner_loop_header:
  %current_iid_p2 = load i32, ptr %idx_p2, align 4
  %phase2_loop_cond = icmp slt i32 %current_iid_p2, 50
  br i1 %phase2_loop_cond, label %phase2_loop_body, label %phase3_stress_test_entry

phase2_loop_body:
  %double_idx_p2 = mul i32 %current_iid_p2, 2
  %unreg_ret_p2 = call i32 @unregister_process_queue(i32 %double_idx_p2)
  %expected_success_p2u = load i32, ptr @E_SUCCESS, align 4
  %unreg_failed_p2 = icmp ne i32 %unreg_ret_p2, %expected_success_p2u
  br i1 %unreg_failed_p2, label %phase2_fail_ret_neg3, label %phase2_register_new

phase2_register_new:
  %new_pid_p2 = add i32 %double_idx_p2, 100
  %new_queue_ptr_p2 = getelementptr inbounds %msg_queue, ptr %test_queues, i32 %current_iid_p2
  %reg_new_ret_p2 = call i32 @register_process_queue(i32 %new_pid_p2, ptr %new_queue_ptr_p2)
  %expected_success_p2r = load i32, ptr @E_SUCCESS, align 4
  %reg_new_failed_p2 = icmp ne i32 %reg_new_ret_p2, %expected_success_p2r
  br i1 %reg_new_failed_p2, label %phase2_fail_ret_neg3, label %phase2_next_iid

phase2_next_iid:
  %next_iid_val_p2 = add i32 %current_iid_p2, 1
  store i32 %next_iid_val_p2, ptr %idx_p2, align 4
  br label %phase2_inner_loop_header

phase2_fail_ret_neg3:
  ret i32 -3

phase3_stress_test_entry:
  ; Store initial contention counts before Phase 3 stress loop
  %initial_read_cont_addr = alloca i64, align 8
  %initial_write_cont_addr = alloca i64, align 8

  %initial_read_val = load atomic i64, ptr @read_lock_contentions monotonic, align 8
  store i64 %initial_read_val, ptr %initial_read_cont_addr, align 8

  %initial_write_val = load atomic i64, ptr @write_lock_contentions monotonic, align 8
  store i64 %initial_write_val, ptr %initial_write_cont_addr, align 8

  ; %contention_before_p3 was used for read contentions only, keeping it for now if needed,
  ; but the new logic will use the alloca'd values.
  ; Let's ensure %contention_before_p3 is the same as initial_read_val for consistency if it's used later.
  %contention_before_p3 = load i64, ptr %initial_read_cont_addr, align 8


  %idx_p3 = alloca i32, align 4
  store i32 0, ptr %idx_p3, align 4 ; sid from 0 to 999
  br label %phase3_loop_header

phase3_loop_header:
  %current_sid_p3 = load i32, ptr %idx_p3, align 4
  %phase3_loop_cond = icmp slt i32 %current_sid_p3, 1000
  br i1 %phase3_loop_cond, label %phase3_loop_body, label %phase3_contention_analysis

phase3_loop_body:
  %op_type_p3 = and i32 %current_sid_p3, 3
  switch i32 %op_type_p3, label %stress_next_p3 [
    i32 0, label %do_lookup_p3
    i32 1, label %do_register_attempt_p3
    i32 2, label %do_unregister_attempt_p3
    i32 3, label %do_reregister_p3
  ]

do_lookup_p3:
  %lookup_pid_rem_p3 = srem i32 %current_sid_p3, 150
  %lookup_pid_abs_p3 = call i32 @llvm.abs.i32(i32 %lookup_pid_rem_p3, i1 false)
  %dummy_val_lookup_p3 = call ptr @get_process_queue_safe(i32 %lookup_pid_abs_p3)
  br label %stress_next_p3

do_register_attempt_p3:
  %reg_pid_p3 = add i32 %current_sid_p3, 200
  %temp_dummy_q_p3 = alloca %msg_queue, align 16
  %dummy_val_reg_p3 = call i32 @register_process_queue(i32 %reg_pid_p3, ptr %temp_dummy_q_p3)
  br label %stress_next_p3

do_unregister_attempt_p3:
  %unreg_pid_rem_p3 = srem i32 %current_sid_p3, 100
  %unreg_pid_abs_p3 = call i32 @llvm.abs.i32(i32 %unreg_pid_rem_p3, i1 false)
  %dummy_val_unreg_p3 = call i32 @unregister_process_queue(i32 %unreg_pid_abs_p3)
  br label %stress_next_p3

do_reregister_p3:
  %existing_pid_rem_p3 = srem i32 %current_sid_p3, 50
  %existing_pid_abs_p3 = call i32 @llvm.abs.i32(i32 %existing_pid_rem_p3, i1 false) ; PIDs 0-49
  %pid_to_reregister_p3 = add i32 %existing_pid_abs_p3, 1 ; Try to get an odd PID (1, 3, .. 49)
  %is_pid_still_odd_and_in_phase1_range = and i1 (icmp ult i32 %pid_to_reregister_p3, 100), (icmp eq i32 (and i32 %pid_to_reregister_p3, 1), 1)

  br i1 %is_pid_still_odd_and_in_phase1_range, label %do_reregister_valid_pid_p3, label %stress_next_p3 ; Skip if not valid for this test logic

do_reregister_valid_pid_p3:
  %queue_for_reregister_p3 = getelementptr inbounds %msg_queue, ptr %test_queues, i32 %pid_to_reregister_p3
  %rereg_ret_p3 = call i32 @register_process_queue(i32 %pid_to_reregister_p3, ptr %queue_for_reregister_p3)
  %err_already_reg_val_p3 = load i32, ptr @E_ALREADY_REGISTERED, align 4
  %is_not_already_reg_p3 = icmp ne i32 %rereg_ret_p3, %err_already_reg_val_p3
  br i1 %is_not_already_reg_p3, label %phase3_fail_ret_neg4, label %stress_next_p3

phase3_fail_ret_neg4:
  ret i32 -4

stress_next_p3:
  %next_sid_val_p3 = add i32 %current_sid_p3, 1
  store i32 %next_sid_val_p3, ptr %idx_p3, align 4
  br label %phase3_loop_header

phase3_contention_analysis: ; This label now marks the completion of the Phase 3 stress loop
  br label %phase4_boundaries ; Branch to the new Phase 4

phase4_boundaries:
  %num_procs_phase4 = i32 256
  %max_pid_phase4 = sub i32 %num_procs_phase4, 1 ; max_pid = 255

  %boundary_q_p4 = alloca %msg_queue, align 8
  ; Initialize dummy queue (e.g., store a value to its last i32 field)
  %field3_ptr_p4 = getelementptr inbounds %msg_queue, ptr %boundary_q_p4, i32 0, i32 3
  store i32 4242, ptr %field3_ptr_p4, align 4

  ; Test registration at max_pid (255)
  %reg_at_max_pid_ret_p4 = call i32 @register_process_queue(i32 %max_pid_phase4, ptr %boundary_q_p4)
  %e_success_ph4 = load i32, ptr @E_SUCCESS, align 4
  %reg_at_max_ok_p4 = icmp eq i32 %reg_at_max_pid_ret_p4, %e_success_ph4
  br i1 %reg_at_max_ok_p4, label %test_overflow_pid_p4, label %phase4_failure

test_overflow_pid_p4:
  %overflow_pid_val_p4 = i32 256 ; This is num_procs_phase4, so it's out of bounds
  %overflow_q_p4 = alloca %msg_queue, align 8
  ; Initialize dummy overflow queue
  %field3_ptr_overflow_p4 = getelementptr inbounds %msg_queue, ptr %overflow_q_p4, i32 0, i32 3
  store i32 4343, ptr %field3_ptr_overflow_p4, align 4

  %reg_at_overflow_ret_p4 = call i32 @register_process_queue(i32 %overflow_pid_val_p4, ptr %overflow_q_p4)
  %e_invalid_pid_ph4 = load i32, ptr @E_INVALID_PID, align 4
  %reg_at_overflow_ok_p4 = icmp eq i32 %reg_at_overflow_ret_p4, %e_invalid_pid_ph4
  br i1 %reg_at_overflow_ok_p4, label %continue_phase4_extended_tests, label %phase4_failure

continue_phase4_extended_tests: ; New label for additional boundary tests
  ; Test PID -1
  %pid_minus_1_p4 = i32 -1
  %q_minus_1_p4 = alloca %msg_queue, align 8
  ; Optionally initialize q_minus_1_p4 if desired, though not strictly necessary for this error check
  %field3_ptr_neg1_p4 = getelementptr inbounds %msg_queue, ptr %q_minus_1_p4, i32 0, i32 3
  store i32 -1010, ptr %field3_ptr_neg1_p4, align 4

  %reg_minus_1_ret_p4 = call i32 @register_process_queue(i32 %pid_minus_1_p4, ptr %q_minus_1_p4)
  ; %e_invalid_pid_ph4 is already loaded and holds E_INVALID_PID
  %reg_minus_1_ok_p4 = icmp eq i32 %reg_minus_1_ret_p4, %e_invalid_pid_ph4
  br i1 %reg_minus_1_ok_p4, label %test_pid_int_max_p4, label %phase4_failure

test_pid_int_max_p4:
  %pid_i32_max_p4 = i32 2147483647 ; i32_max
  %q_i32_max_p4 = alloca %msg_queue, align 8
  ; Optionally initialize q_i32_max_p4
  %field3_ptr_max_p4 = getelementptr inbounds %msg_queue, ptr %q_i32_max_p4, i32 0, i32 3
  store i32 9898, ptr %field3_ptr_max_p4, align 4

  %reg_i32_max_ret_p4 = call i32 @register_process_queue(i32 %pid_i32_max_p4, ptr %q_i32_max_p4)
  ; %e_invalid_pid_ph4 still holds E_INVALID_PID
  %reg_i32_max_ok_p4 = icmp eq i32 %reg_i32_max_ret_p4, %e_invalid_pid_ph4
  br i1 %reg_i32_max_ok_p4, label %phase4_all_extended_tests_ok, label %phase4_failure

phase4_all_extended_tests_ok:
  br label %phase4_passed_to_final_contention_analysis ; Proceed to contention analysis

phase4_failure:
  ret i32 -5 ; New error code for Phase 4 failure

phase4_passed_to_final_contention_analysis:
  ; Contention Analysis (now effectively Phase 5)
  %loaded_initial_read_cont = load i64, ptr %initial_read_cont_addr, align 8
  %final_read_cont = load atomic i64, ptr @read_lock_contentions monotonic, align 8
  %delta_reads = sub i64 %final_read_cont, %loaded_initial_read_cont

  ; Store delta_reads for baseline
  store i64 %delta_reads, ptr @last_run_phase3_delta_read_contentions, align 8

  %reads_ok = icmp sge i64 %delta_reads, 0 ; Signed Greater or Equal (delta can be 0)
  br i1 %reads_ok, label %check_write_contentions, label %contention_failure

check_write_contentions:
  %loaded_initial_write_cont = load i64, ptr %initial_write_cont_addr, align 8
  %final_write_cont = load atomic i64, ptr @write_lock_contentions monotonic, align 8
  %delta_writes = sub i64 %final_write_cont, %loaded_initial_write_cont

  ; Store delta_writes for baseline
  store i64 %delta_writes, ptr @last_run_phase3_delta_write_contentions, align 8

  %writes_ok = icmp sge i64 %delta_writes, 0 ; Signed Greater or Equal
  br i1 %writes_ok, label %check_total_new_contentions, label %contention_failure

check_total_new_contentions:
  %total_delta_contentions = add i64 %delta_reads, %delta_writes
  ; Phase 3 performs 1000 operations, many of which acquire locks.
  ; Expect at least some new contention/lock activity to be recorded.
  %any_new_contention = icmp sgt i64 %total_delta_contentions, 0 ; Signed Greater Than
  br i1 %any_new_contention, label %test_success_p3, label %contention_failure

contention_failure:
  ret i32 -6 ; New error code for contention check failure

test_success_p3: ; This label remains the final success exit for the whole function
  ret i32 0
}

; Declaration for llvm.abs.i32 intrinsic
declare i32 @llvm.abs.i32(i32, i1) nounwind readnone

; --- Test for Memory Ordering Consistency ---
define i32 @test_memory_ordering_consistency() nounwind {
entry:
  call void @initialize_global_queue_registry(i32 50) ; Ensure PID 42 is valid

  %test_queue = alloca %msg_queue, align 8
  %magic_value = i64 0xDEADBEEFCAFEBABE

  ; %msg_queue = type { ptr, i64, i64, i32 }
  ; Field at index 1 is the first i64
  %field_ptr = getelementptr inbounds %msg_queue, ptr %test_queue, i32 0, i32 1
  store i64 %magic_value, ptr %field_ptr, align 8

  %pid = i32 42
  %reg_result = call i32 @register_process_queue(i32 %pid, ptr %test_queue)
  %e_success = load i32, ptr @E_SUCCESS, align 4
  %reg_ok = icmp eq i32 %reg_result, %e_success
  br i1 %reg_ok, label %registration_succeeded, label %registration_failed

registration_failed:
  ret i32 -2 ; Registration failed

registration_succeeded:
  fence seq_cst ; Ensure registration is visible

  %retrieved_queue_ptr = call ptr @get_process_queue_safe(i32 %pid)
  %is_retrieved_null = icmp eq ptr %retrieved_queue_ptr, null
  br i1 %is_retrieved_null, label %retrieval_failed_null, label %check_retrieved_ptr

retrieval_failed_null:
  ret i32 -3 ; Retrieval failed (got null)

check_retrieved_ptr:
  %is_wrong_ptr = icmp ne ptr %retrieved_queue_ptr, %test_queue
  br i1 %is_wrong_ptr, label %retrieval_failed_wrong_ptr, label %load_magic_value

retrieval_failed_wrong_ptr:
  ret i32 -4 ; Retrieval failed (wrong queue pointer)

load_magic_value:
  %retrieved_field_ptr = getelementptr inbounds %msg_queue, ptr %retrieved_queue_ptr, i32 0, i32 1
  %loaded_magic_value = load i64, ptr %retrieved_field_ptr, align 8

  %marker_intact = icmp eq i64 %loaded_magic_value, %magic_value
  %retval = select i1 %marker_intact, i32 0, i32 -1
  ret i32 %retval
}

; --- Helper to Reset Registry Globals (for specific test scenarios) ---
; Note: Effectiveness on 'internal global' variables in queue_registry.ll
; depends on whether this test code is linked into the same module as
; queue_registry.ll before execution, or if those globals were defined with
; external linkage. Assuming for now that direct store is possible for test setup.
define void @reset_registry_globals_for_test() nounwind {
entry:
  store ptr null, ptr @global_queue_registry_ptr, align 8
  store atomic i32 0, ptr @global_registry_initialized_flag monotonic, align 4
  store atomic i32 0, ptr @registry_rw_lock_initialized monotonic, align 4
  ; Reset contention counters too for cleanliness
  store atomic i64 0, ptr @read_lock_contentions monotonic, align 8
  store atomic i64 0, ptr @write_lock_contentions monotonic, align 8
  ret void
}

; --- Test for Behavior with Uninitialized Registry (Simulates Timeout/Early Access) ---
define i32 @test_lock_timeout_behavior() nounwind {
entry:
  ; DO NOT call initialize_global_queue_registry here.
  ; This test specifically checks behavior on an uninitialized registry.
  ; Assumes @reset_registry_globals_for_test has been called by @main or test runner.

  ; Test get_process_queue_safe
  %result_get = call ptr @get_process_queue_safe(i32 0)
  %get_is_null = icmp eq ptr %result_get, null
  br i1 %get_is_null, label %get_check_passed, label %get_check_failed

get_check_failed:
  ret i32 -1 ; Failure: get_process_queue_safe did not return null

get_check_passed:
  ; Test register_process_queue
  %dummy_q_reg = alloca %msg_queue, align 8
  %result_reg = call i32 @register_process_queue(i32 0, ptr %dummy_q_reg)
  %e_not_init_val_reg = load i32, ptr @E_NOT_INITIALIZED, align 4
  %reg_is_expected_err = icmp eq i32 %result_reg, %e_not_init_val_reg
  br i1 %reg_is_expected_err, label %reg_check_passed, label %reg_check_failed

reg_check_failed:
  ret i32 -2 ; Failure: register_process_queue did not return E_NOT_INITIALIZED

reg_check_passed:
  ; Test unregister_process_queue
  %result_unreg = call i32 @unregister_process_queue(i32 0)
  %e_not_init_val_unreg = load i32, ptr @E_NOT_INITIALIZED, align 4 ; Reload or reuse
  %unreg_is_expected_err = icmp eq i32 %result_unreg, %e_not_init_val_unreg
  br i1 %unreg_is_expected_err, label %unreg_check_passed, label %unreg_check_failed

unreg_check_failed:
  ret i32 -3 ; Failure: unregister_process_queue did not return E_NOT_INITIALIZED

unreg_check_passed:
  ret i32 0 ; All checks passed
}
