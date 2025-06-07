; src/llvm/queue_registry.ll
; Manages message queues for processes.

; --- Standardized Error Codes ---
@E_SUCCESS = internal constant i32 0, align 4
@E_INVALID_INPUT = internal constant i32 -1, align 4
@E_NOT_INITIALIZED = internal constant i32 -2, align 4
@E_INVALID_PID = internal constant i32 -3, align 4
@E_ALREADY_REGISTERED = internal constant i32 -4, align 4
@E_LOCK_FAILED = internal constant i32 -5, align 4 ; Note: Current lock failures lead to panic, not error codes.
@E_NOT_REGISTERED = internal constant i32 -6, align 4

; Forward declaration for %msg_queue (defined in intrinsics/atomic.ll)
%msg_queue = type { ptr, i64, i64, i32 }

; Per-process queue metadata and statistics
%proc_queue_entry = type {
  i32,              ; owner_pid
  ptr,              ; actual_queue (ptr to %msg_queue)
  i64,              ; stats_messages_received
  i64               ; stats_messages_sent
}

; Process queue registry structure
%queue_registry = type {
  i32,              ; num_processes_configured (max capacity of registry)
  ptr,              ; queue_array (ptr to array of %proc_queue_entry)
  ptr               ; registry_rwlock (ptr to an opaque rwlock structure)
}

; --- Global Instance of the Queue Registry ---
; This would be initialized by the kernel/IPC system.
; Global pointer to the queue registry instance, initialized to null.
@global_queue_registry_ptr = global ptr null, align 8

; Global atomic flag for registry initialization guard (0 = false, 1 = true)
@global_registry_initialized_flag = global i32 0, align 4

; --- Lock-Related Types and Globals ---
%pthread_rwlock_t_opaque = type opaque

; Global lock object for the registry
@registry_rw_lock = global %pthread_rwlock_t_opaque zeroinitializer, align 8

; Global atomic flag for initialization guard (0 = false, 1 = true)
@registry_rw_lock_initialized = global i32 0, align 4

; Global counters for lock contentions (symbolic)
@read_lock_contentions = global i64 0, align 8
@write_lock_contentions = global i64 0, align 8

; Error message strings
@str_lock_init_failed = private unnamed_addr constant [19 x i8] c"Lock init failed\00", align 1
@str_read_lock_failed = private unnamed_addr constant [18 x i8] c"Read lock failed\00", align 1
@str_read_unlock_failed = private unnamed_addr constant [20 x i8] c"Read unlock failed\00", align 1
@str_write_lock_failed = private unnamed_addr constant [19 x i8] c"Write lock failed\00", align 1
@str_write_unlock_failed = private unnamed_addr constant [21 x i8] c"Write unlock failed\00", align 1
@str_invalid_max_procs = private unnamed_addr constant [23 x i8] c"Invalid max_processes\00", align 1
@str_reg_alloc_fail = private unnamed_addr constant [29 x i8] c"Registry allocation failed\00", align 1
@str_q_arr_alloc_fail = private unnamed_addr constant [32 x i8] c"Queue array allocation failed\00", align 1
@str_q_arr_retry_fail = private unnamed_addr constant [39 x i8] c"Queue array allocation retry failed\00", align 1
@str_reduced_alloc_zero = private unnamed_addr constant [33 x i8] c"Reduced allocation size is zero\00", align 1
@str_reg_not_init_reg = private unnamed_addr constant [40 x i8] c"Registry not initialized for register\00", align 1
@str_reg_not_init_unreg = private unnamed_addr constant [42 x i8] c"Registry not initialized for unregister\00", align 1


; --- External C Standard Library and Panic Function Declarations ---
declare ptr @malloc(i64) nounwind ; To be replaced by calloc for queue_array
declare ptr @calloc(i64, i64) nounwind ; For allocating and zero-initializing memory
declare ptr @memset(ptr, i32, i64) nounwind ; May not be needed if calloc is used for queue_array
declare i32 @pthread_rwlock_init(ptr nocapture, ptr nocapture) nounwind
declare i32 @pthread_rwlock_rdlock(ptr nocapture) nounwind
declare i32 @pthread_rwlock_wrlock(ptr nocapture) nounwind
declare i32 @pthread_rwlock_unlock(ptr nocapture) nounwind
declare void @minix_panic(ptr nocapture) noreturn nounwind

; --- Queue Registry Management Functions (Declarations/Placeholders) ---

; --- Global Queue Registry Initialization Function ---
define void @initialize_global_queue_registry(i32 %max_processes) nounwind {
entry:
  ; 1. Atomically check and set @global_registry_initialized_flag
  %current_init_flag_val = load atomic i32, ptr @global_registry_initialized_flag acquire, align 4
  %is_already_initialized_check = icmp eq i32 %current_init_flag_val, 1
  br i1 %is_already_initialized_check, label %already_initialized, label %try_init_flag

try_init_flag:
  %cas_result = cmpxchg ptr @global_registry_initialized_flag, i32 0, i32 1 release acquire
  %stored_val = extractvalue { i32, i1 } %cas_result, 0
  %did_exchange = extractvalue { i32, i1 } %cas_result, 1

  br i1 %did_exchange, label %proceed_with_initialization, label %spin_wait_initialization

spin_wait_initialization:
  ; Another thread is initializing, or flag was already 1. Load again.
  %spin_val = load atomic i32, ptr @global_registry_initialized_flag acquire, align 4
  %is_now_initialized = icmp eq i32 %spin_val, 1
  br i1 %is_now_initialized, label %already_initialized, label %spin_wait_initialization ; Spin

proceed_with_initialization:
  ; This thread has acquired the right to initialize.

  ; Ensure the underlying lock mechanism for the registry is ready.
  call void @init_registry_lock()

  ; 2. Input Validation
  %is_max_procs_invalid = icmp sle i32 %max_processes, 0
  br i1 %is_max_procs_invalid, label %panic_invalid_max_procs, label %allocate_registry_struct

panic_invalid_max_procs:
  call void @minix_panic(ptr @str_invalid_max_procs)
  unreachable

allocate_registry_struct:
  ; 3. Allocate memory for %queue_registry structure
  %registry_struct_size = ptrtoint ptr getelementptr (%queue_registry, ptr null, i32 1) to i64
  %registry_struct_ptr_raw = call ptr @malloc(i64 %registry_struct_size)
  %is_registry_alloc_failed = icmp eq ptr %registry_struct_ptr_raw, null
  br i1 %is_registry_alloc_failed, label %panic_reg_alloc_fail, label %allocate_queue_array

panic_reg_alloc_fail:
  call void @minix_panic(ptr @str_reg_alloc_fail)
  unreachable

allocate_queue_array:
  ; 4. Allocate memory for the queue_array using calloc
  %proc_queue_entry_size_64 = ptrtoint ptr getelementptr (%proc_queue_entry, ptr null, i32 1) to i64
  %max_procs_param_64 = sext i32 %max_processes to i64 ; Use original %max_processes parameter for first attempt

  ; Initial allocation attempt for queue_array
  %queue_array_ptr_raw = call ptr @calloc(i64 %max_procs_param_64, i64 %proc_queue_entry_size_64)
  %initial_alloc_failed = icmp eq ptr %queue_array_ptr_raw, null
  br i1 %initial_alloc_failed, label %handle_initial_alloc_failure, label %initial_alloc_succeeded

handle_initial_alloc_failure:
  %reduced_max_procs_val = sdiv i32 %max_processes, 2
  %is_reduced_zero = icmp eq i32 %reduced_max_procs_val, 0
  br i1 %is_reduced_zero, label %panic_reduced_zero, label %attempt_retry_alloc

panic_reduced_zero:
  call void @minix_panic(ptr @str_reduced_alloc_zero)
  unreachable

attempt_retry_alloc:
  %reduced_max_procs_64 = sext i32 %reduced_max_procs_val to i64
  %retry_queue_array_ptr_raw = call ptr @calloc(i64 %reduced_max_procs_64, i64 %proc_queue_entry_size_64)
  %retry_alloc_failed = icmp eq ptr %retry_queue_array_ptr_raw, null
  br i1 %retry_alloc_failed, label %panic_retry_failed, label %retry_alloc_succeeded

panic_retry_failed:
  call void @minix_panic(ptr @str_q_arr_retry_fail)
  unreachable

retry_alloc_succeeded:
  br label %join_alloc_paths

initial_alloc_succeeded:
  br label %join_alloc_paths

join_alloc_paths:
  %final_queue_array_ptr = phi ptr [ %queue_array_ptr_raw, %initial_alloc_succeeded ], [ %retry_queue_array_ptr_raw, %retry_alloc_succeeded ]
  %effective_max_processes = phi i32 [ %max_processes, %initial_alloc_succeeded ], [ %reduced_max_procs_val, %retry_alloc_succeeded ]
  ; TODO: In a real scenario, if retry_alloc_succeeded, should free %registry_struct_ptr_raw if that was allocated before this whole block.
  ; However, current structure allocates registry_struct_ptr_raw first, then this queue_array block. If this block fully fails, registry_struct_ptr_raw is leaked before panic.
  ; For this subtask, focusing on the retry logic for queue_array.

initialize_queue_array_loop_header:
  ; 5. Initialize queue_array elements
  %has_elements_to_init = icmp sgt i32 %effective_max_processes, 0
  br i1 %has_elements_to_init, label %loop_entry_block, label %loop_done_initialization

loop_entry_block:
  br label %init_loop_header

init_loop_header:
  %loop_idx = phi i32 [ 0, %loop_entry_block ], [ %next_idx, %loop_body_continue ]
  %is_loop_done = icmp sge i32 %loop_idx, %effective_max_processes
  br i1 %is_loop_done, label %loop_done_initialization, label %loop_body

loop_body:
  %current_entry_ptr = getelementptr %proc_queue_entry, ptr %final_queue_array_ptr, i32 %loop_idx
  %owner_pid_ptr = getelementptr %proc_queue_entry, ptr %current_entry_ptr, i32 0, i32 0
  store i32 -1, ptr %owner_pid_ptr, align 4 ; Sentinel for unused. Other fields zeroed by calloc.
  %next_idx = add i32 %loop_idx, 1
  br label %loop_body_continue

loop_body_continue:
  br label %init_loop_header

loop_done_initialization:
  ; 6. Initialize fields of the allocated %queue_registry structure
  %registry_struct_ptr = bitcast ptr %registry_struct_ptr_raw to ptr
  %populated_queue_array_ptr = bitcast ptr %final_queue_array_ptr to ptr

  %num_procs_field_ptr = getelementptr %queue_registry, ptr %registry_struct_ptr, i32 0, i32 0
  store i32 %effective_max_processes, ptr %num_procs_field_ptr, align 4

  %queue_array_field_ptr = getelementptr %queue_registry, ptr %registry_struct_ptr, i32 0, i32 1
  store ptr %populated_queue_array_ptr, ptr %queue_array_field_ptr, align 8

  %registry_rwlock_field_ptr = getelementptr %queue_registry, ptr %registry_struct_ptr, i32 0, i32 2
  ; @registry_rw_lock is type %pthread_rwlock_t_opaque. The field is ptr.
  ; We store the address of the global lock object.
  store ptr @registry_rw_lock, ptr %registry_rwlock_field_ptr, align 8

  ; 7. Publish the registry
  store atomic ptr %registry_struct_ptr, ptr @global_queue_registry_ptr release, align 8

  ; Flag already set by cmpxchg, initialization complete.
  br label %already_initialized ; Jump to common exit point

already_initialized:
  ret void
}

; --- Thread-Safe Queue Registration Function ---
define i32 @register_process_queue(i32 %pid, ptr %queue_instance) nounwind {
entry:
  ; Input validation for queue_instance (can be done before locking)
  %is_queue_instance_null = icmp eq ptr %queue_instance, null
  br i1 %is_queue_instance_null, label %return_invalid_input_err, label %proceed_to_lock

return_invalid_input_err:
  %err_val_invalid_input = load i32, ptr @E_INVALID_INPUT, align 4
  ret i32 %err_val_invalid_input

proceed_to_lock:
  call void @internal_rwlock_write_lock()

  %registry_instance_ptr = load ptr, ptr @global_queue_registry_ptr, align 8 ; Not specified as atomic in feedback for this func, assuming write lock covers.
  %is_registry_null = icmp eq ptr %registry_instance_ptr, null
  br i1 %is_registry_null, label %return_not_initialized_err, label %validate_pid_bounds

return_not_initialized_err:
  call void @internal_rwlock_write_unlock()
  %err_val_not_init = load i32, ptr @E_NOT_INITIALIZED, align 4
  ret i32 %err_val_not_init

validate_pid_bounds:
  %num_procs_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 0
  %num_procs = load i32, ptr %num_procs_addr, align 4

  %is_pid_negative = icmp slt i32 %pid, 0
  %is_pid_out_of_upper_bound = icmp sge i32 %pid, %num_procs
  %is_pid_invalid = or i1 %is_pid_negative, %is_pid_out_of_upper_bound
  br i1 %is_pid_invalid, label %return_invalid_pid_err, label %check_existing_reg

return_invalid_pid_err:
  call void @internal_rwlock_write_unlock()
  %err_val_invalid_pid = load i32, ptr @E_INVALID_PID, align 4
  ret i32 %err_val_invalid_pid

check_existing_reg:
  %queue_array_base_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 1
  %queue_array_base_ptr = load ptr, ptr %queue_array_base_ptr_addr, align 8
  %proc_queue_entry_ptr = getelementptr inbounds %proc_queue_entry, ptr %queue_array_base_ptr, i32 %pid

  %actual_queue_field_ptr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 1
  %existing_queue_ptr = load ptr, ptr %actual_queue_field_ptr, align 8 ; Non-atomic load, assuming covered by write lock for check
  %is_slot_taken = icmp ne ptr %existing_queue_ptr, null
  br i1 %is_slot_taken, label %return_already_registered_err, label %perform_registration

return_already_registered_err:
  call void @internal_rwlock_write_unlock()
  %err_val_already_reg = load i32, ptr @E_ALREADY_REGISTERED, align 4
  ret i32 %err_val_already_reg

perform_registration:
  %owner_pid_field_ptr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 0
  store i32 %pid, ptr %owner_pid_field_ptr, align 4

  ; %actual_queue_field_ptr is already computed from check_existing_reg block
  store atomic ptr %queue_instance, ptr %actual_queue_field_ptr release, align 8

  ; Reset stats
  %stats_recv_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 2
  store i64 0, ptr %stats_recv_ptr_addr, align 8
  %stats_sent_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 3
  store i64 0, ptr %stats_sent_ptr_addr, align 8

  call void @internal_rwlock_write_unlock()
  %ret_success = load i32, ptr @E_SUCCESS, align 4
  ret i32 %ret_success
}

; --- Thread-Safe Queue Unregistration Function ---
define i32 @unregister_process_queue(i32 %pid) nounwind {
entry:
  call void @internal_rwlock_write_lock()

  %registry_instance_ptr = load ptr, ptr @global_queue_registry_ptr, align 8 ; Not specified as atomic, assuming write lock covers
  %is_registry_null = icmp eq ptr %registry_instance_ptr, null
  br i1 %is_registry_null, label %return_not_initialized_err, label %validate_pid_bounds

return_not_initialized_err:
  call void @internal_rwlock_write_unlock()
  %err_val_not_init = load i32, ptr @E_NOT_INITIALIZED, align 4
  ret i32 %err_val_not_init

validate_pid_bounds:
  %num_procs_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 0
  %num_procs = load i32, ptr %num_procs_addr, align 4

  %is_pid_negative = icmp slt i32 %pid, 0
  %is_pid_out_of_upper_bound = icmp sge i32 %pid, %num_procs
  %is_pid_invalid = or i1 %is_pid_negative, %is_pid_out_of_upper_bound
  br i1 %is_pid_invalid, label %return_invalid_pid_err, label %find_entry_and_check_ownership

return_invalid_pid_err:
  call void @internal_rwlock_write_unlock()
  %err_val_invalid_pid = load i32, ptr @E_INVALID_PID, align 4
  ret i32 %err_val_invalid_pid

find_entry_and_check_ownership:
  %queue_array_base_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 1
  %queue_array_base_ptr = load ptr, ptr %queue_array_base_ptr_addr, align 8
  %proc_queue_entry_ptr = getelementptr inbounds %proc_queue_entry, ptr %queue_array_base_ptr, i32 %pid

  %actual_queue_field_ptr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 1
  %current_queue_ptr = load atomic ptr, ptr %actual_queue_field_ptr acquire, align 8

  %is_not_registered = icmp eq ptr %current_queue_ptr, null
  br i1 %is_not_registered, label %return_not_registered_err, label %perform_unregistration

return_not_registered_err:
  call void @internal_rwlock_write_unlock()
  %err_val_not_reg = load i32, ptr @E_NOT_REGISTERED, align 4
  ret i32 %err_val_not_reg

perform_unregistration:
  ; %actual_queue_field_ptr is already computed
  store atomic ptr null, ptr %actual_queue_field_ptr release, align 8

  fence seq_cst ; Ensure store to actual_queue is globally visible before owner_pid change

  %owner_pid_field_ptr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 0
  store i32 -1, ptr %owner_pid_field_ptr, align 4 ; Mark as unused

  ; Clear stats
  %stats_recv_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 2
  store i64 0, ptr %stats_recv_ptr_addr, align 8
  %stats_sent_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 3
  store i64 0, ptr %stats_sent_ptr_addr, align 8

  call void @internal_rwlock_write_unlock()
  %ret_success = load i32, ptr @E_SUCCESS, align 4
  ret i32 %ret_success
}

; --- Thread-Safe Queue Lookup Function (Safe Version) ---
define ptr @get_process_queue_safe(i32 %pid) nounwind {
entry:
  call void @internal_rwlock_read_lock()

  %registry_instance_ptr = load atomic ptr, ptr @global_queue_registry_ptr acquire, align 8
  %is_registry_null = icmp eq ptr %registry_instance_ptr, null
  br i1 %is_registry_null, label %fail_unlock_and_return_null, label %validate_pid_bounds

validate_pid_bounds:
  %num_procs_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 0
  %num_procs = load i32, ptr %num_procs_addr, align 4

  %is_pid_negative = icmp slt i32 %pid, 0
  %is_pid_out_of_upper_bound = icmp sge i32 %pid, %num_procs ; Using SGE for signed comparison
  %is_pid_invalid = or i1 %is_pid_negative, %is_pid_out_of_upper_bound
  br i1 %is_pid_invalid, label %fail_unlock_and_return_null, label %access_entry

access_entry:
  %queue_array_base_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 1
  %queue_array_base_ptr = load ptr, ptr %queue_array_base_ptr_addr, align 8
  %proc_queue_entry_ptr = getelementptr inbounds %proc_queue_entry, ptr %queue_array_base_ptr, i32 %pid

  %owner_pid_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 0
  %current_owner_pid = load i32, ptr %owner_pid_addr, align 4
  %is_owner_mismatch = icmp ne i32 %current_owner_pid, %pid
  br i1 %is_owner_mismatch, label %fail_unlock_and_return_null, label %retrieve_queue

retrieve_queue:
  %actual_queue_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 1
  %actual_msg_queue_ptr = load ptr, ptr %actual_queue_ptr_addr, align 8 ; No atomic load specified for queue ptr itself in this path by feedback
  call void @internal_rwlock_read_unlock()
  ret ptr %actual_msg_queue_ptr

fail_unlock_and_return_null:
  call void @internal_rwlock_read_unlock()
  ret ptr null
}

; --- Core Queue Lookup Function ---

; @get_process_queue
; Retrieves the message queue for a given PID from the global registry.
; Arguments:
;   %pid: The i32 Process ID.
; Returns:
;   ptr: Pointer to the %msg_queue for the PID, or ptr null if not found/invalid.
define ptr @get_process_queue(i32 %pid) nounwind {
entry:
  call void @internal_rwlock_read_lock()

  %registry_instance_ptr = load ptr, ptr @global_queue_registry_ptr, align 8
  %is_registry_null = icmp eq ptr %registry_instance_ptr, null
  br i1 %is_registry_null, label %fail_return_null_locked, label %validate_pid

validate_pid:
  %num_procs_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 0
  %num_procs = load i32, ptr %num_procs_addr, align 4
  %is_pid_negative = icmp slt i32 %pid, 0
  %is_pid_too_large = icmp sge i32 %pid, %num_procs
  %is_pid_invalid = or i1 %is_pid_negative, %is_pid_too_large
  br i1 %is_pid_invalid, label %fail_return_null_locked, label %access_entry

access_entry:
  %queue_array_base_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 1
  %queue_array_base_ptr = load ptr, ptr %queue_array_base_ptr_addr, align 8
  %proc_queue_entry_ptr = getelementptr inbounds %proc_queue_entry, ptr %queue_array_base_ptr, i32 %pid

  %owner_pid_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 0
  %current_owner_pid = load i32, ptr %owner_pid_addr, align 4
  %is_pid_mismatch = icmp ne i32 %current_owner_pid, %pid ; Check if slot is owned by THIS pid
  br i1 %is_pid_mismatch, label %fail_return_null_locked, label %retrieve_queue

retrieve_queue:
  %actual_queue_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 1
  %actual_msg_queue_ptr = load ptr, ptr %actual_queue_ptr_addr, align 8
  call void @internal_rwlock_read_unlock()
  ret ptr %actual_msg_queue_ptr

fail_return_null_locked:
  call void @internal_rwlock_read_unlock()
  ret ptr null
}

; --- Lock Initialization Function ---
define void @init_registry_lock() nounwind {
entry:
  ; Check if already initialized. Use 'acquire' to ensure subsequent reads (if any) are not reordered before this.
  %current_val = load atomic i32, ptr @registry_rw_lock_initialized acquire, align 4
  %is_initialized = icmp eq i32 %current_val, 1
  br i1 %is_initialized, label %already_initialized, label %try_initialize

try_initialize:
  ; Attempt to set from 0 to 1.
  ; success_ordering: acq_rel (release for the write, acquire for subsequent reads by this thread)
  ; failure_ordering: acquire (to see writes from other threads)
  %cas_result = cmpxchg ptr @registry_rw_lock_initialized, i32 0, i32 1 acq_rel acquire
  %stored_val = extractvalue { i32, i1 } %cas_result, 0 ; The value that was read from memory
  %did_exchange = extractvalue { i32, i1 } %cas_result, 1 ; Boolean: true if exchange happened

  br i1 %did_exchange, label %perform_initialization, label %already_initialized_or_concurrent_init

perform_initialization:
  ; This thread acquired the right to initialize.
  %ret_code = call i32 @pthread_rwlock_init(ptr @registry_rw_lock, ptr null)
  %init_failed = icmp ne i32 %ret_code, 0
  br i1 %init_failed, label %panic_init_failed, label %init_done

panic_init_failed:
  call void @minix_panic(ptr @str_lock_init_failed)
  unreachable ; Panic does not return

init_done:
  ; The flag @registry_rw_lock_initialized was already set to 1 by cmpxchg.
  br label %already_initialized

already_initialized_or_concurrent_init:
  ; Another thread successfully initialized, or is in the process of initializing.
  ; Spin until the flag is 1. This handles the case where another thread's pthread_rwlock_init is slow.
  %spin_val = load atomic i32, ptr @registry_rw_lock_initialized acquire, align 4
  %is_now_initialized = icmp eq i32 %spin_val, 1
  br i1 %is_now_initialized, label %already_initialized, label %already_initialized_or_concurrent_init ; Spin

already_initialized:
  ret void
}

; --- Lock Wrapper Functions ---

define void @internal_rwlock_read_lock() nounwind {
entry:
  call void @init_registry_lock()

  ; Increment read lock contention counter (symbolic)
  %current_read_contention = load atomic i64, ptr @read_lock_contentions monotonic, align 8
  %next_read_contention = add i64 %current_read_contention, 1
  store atomic i64 %next_read_contention, ptr @read_lock_contentions monotonic, align 8

  %ret_code_rdlock = call i32 @pthread_rwlock_rdlock(ptr @registry_rw_lock)
  %lock_failed = icmp ne i32 %ret_code_rdlock, 0
  br i1 %lock_failed, label %panic_lock_failed, label %lock_successful

panic_lock_failed:
  call void @minix_panic(ptr @str_read_lock_failed)
  unreachable

lock_successful:
  ret void
}

define void @internal_rwlock_read_unlock() nounwind {
entry:
  %ret_code = call i32 @pthread_rwlock_unlock(ptr @registry_rw_lock)
  %unlock_failed = icmp ne i32 %ret_code, 0
  br i1 %unlock_failed, label %panic_unlock_failed, label %unlock_successful

panic_unlock_failed:
  call void @minix_panic(ptr @str_read_unlock_failed)
  unreachable

unlock_successful:
  ret void
}

define void @internal_rwlock_write_lock() nounwind {
entry:
  call void @init_registry_lock()

  ; Increment write lock contention counter (symbolic)
  %current_write_contention = load atomic i64, ptr @write_lock_contentions monotonic, align 8
  %next_write_contention = add i64 %current_write_contention, 1
  store atomic i64 %next_write_contention, ptr @write_lock_contentions monotonic, align 8

  %ret_code_wrlock = call i32 @pthread_rwlock_wrlock(ptr @registry_rw_lock)
  %lock_failed = icmp ne i32 %ret_code_wrlock, 0
  br i1 %lock_failed, label %panic_lock_failed, label %lock_successful

panic_lock_failed:
  call void @minix_panic(ptr @str_write_lock_failed)
  unreachable

lock_successful:
  ret void
}

define void @internal_rwlock_write_unlock() nounwind {
entry:
  %ret_code = call i32 @pthread_rwlock_unlock(ptr @registry_rw_lock)
  %unlock_failed = icmp ne i32 %ret_code, 0
  br i1 %unlock_failed, label %panic_unlock_failed, label %unlock_successful

panic_unlock_failed:
  call void @minix_panic(ptr @str_write_unlock_failed)
  unreachable

unlock_successful:
  ret void
}
