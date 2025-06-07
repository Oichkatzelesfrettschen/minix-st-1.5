; src/llvm/queue_registry.ll
; Manages message queues for processes.

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
; For now, it's a declaration. A proper definition with initialization is needed.
@global_queue_registry_ptr = external global ptr ; ptr to %queue_registry

; --- Placeholder Lock Functions ---
; These would interact with a real read-write lock implementation.
declare void @rwlock_read_lock(ptr %lock_ptr) nounwind
declare void @rwlock_read_unlock(ptr %lock_ptr) nounwind
; declare void @rwlock_write_lock(ptr %lock_ptr) nounwind
; declare void @rwlock_write_unlock(ptr %lock_ptr) nounwind

; --- Queue Registry Management Functions (Declarations/Placeholders) ---

; Initializes the global queue registry.
declare void @init_queue_registry(i32 %max_processes) nounwind

; Registers a message queue for a given PID.
; Returns 0 on success, non-zero on failure.
declare i32 @register_process_queue(i32 %pid, ptr %queue_instance) nounwind

; Unregisters a message queue for a given PID.
declare void @unregister_process_queue(i32 %pid) nounwind


; --- Core Queue Lookup Function ---

; @get_process_queue
; Retrieves the message queue for a given PID from the global registry.
; Arguments:
;   %pid: The i32 Process ID.
; Returns:
;   ptr: Pointer to the %msg_queue for the PID, or ptr null if not found/invalid.
define ptr @get_process_queue(i32 %pid) nounwind {
entry:
  %registry_instance_ptr = load ptr, ptr @global_queue_registry_ptr, align 8
  %is_registry_null = icmp eq ptr %registry_instance_ptr, null
  br i1 %is_registry_null, label %fail_no_registry, label %proceed_lock

fail_no_registry:
  ret ptr null

proceed_lock:
  %lock_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 2
  %lock_ptr = load ptr, ptr %lock_ptr_addr, align 8
  call void @rwlock_read_lock(ptr %lock_ptr)

  ; Check PID bounds
  %num_procs_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 0
  %num_procs = load i32, ptr %num_procs_addr, align 4
  %is_pid_negative = icmp slt i32 %pid, 0
  %is_pid_too_large = icmp sge i32 %pid, %num_procs
  %is_pid_invalid = or i1 %is_pid_negative, %is_pid_too_large
  br i1 %is_pid_invalid, label %fail_pid_invalid, label %lookup_entry

fail_pid_invalid:
  call void @rwlock_read_unlock(ptr %lock_ptr)
  ret ptr null

lookup_entry:
  %queue_array_base_ptr_addr = getelementptr inbounds %queue_registry, ptr %registry_instance_ptr, i32 0, i32 1
  %queue_array_base_ptr = load ptr, ptr %queue_array_base_ptr_addr, align 8 ; This is ptr to %proc_queue_entry

  %proc_queue_entry_ptr = getelementptr inbounds %proc_queue_entry, ptr %queue_array_base_ptr, i32 %pid

  ; Optional: Check if this slot is actually active/initialized for the PID
  ; For now, assume direct mapping if PID is in bounds.

  %actual_queue_ptr_addr = getelementptr inbounds %proc_queue_entry, ptr %proc_queue_entry_ptr, i32 0, i32 1
  %actual_msg_queue_ptr = load ptr, ptr %actual_queue_ptr_addr, align 8 ; This is ptr to %msg_queue

  call void @rwlock_read_unlock(ptr %lock_ptr)
  ret ptr %actual_msg_queue_ptr
}
