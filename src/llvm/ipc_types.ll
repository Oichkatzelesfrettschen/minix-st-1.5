; src/llvm/ipc_types.ll
; Defines types related to Inter-Process Communication (IPC)

; Modern message structure (as per Phase 2.1 of original specification)
; This structure will be pointed to by elements in the %msg_queue
%message = type {
  i32,          ; m_source: PID of the source process.
                ; Marked 'atomic for lock-free access' in spec, implying careful concurrent handling of this field if necessary.
  i32,          ; m_type:   Type of the message.
  [6 x i64],    ; m_payload: Unified payload, designed to handle various fixed-size message contents.
                ; (Original spec: "handles all mess_* variants")
  ptr           ; m_extension_ptr: Pointer to a larger buffer if the message content exceeds the fixed payload.
                ; (Original spec: "Extension pointer for large messages")
}

; Note: The %msg_queue type itself is already defined in src/llvm/intrinsics/atomic.ll
; and stores 'ptr to %message'. This %message type definition is compatible with that.
