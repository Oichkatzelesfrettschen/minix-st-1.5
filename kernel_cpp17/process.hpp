#ifndef KERNEL_CPP17_PROCESS_HPP
#define KERNEL_CPP17_PROCESS_HPP

#include <cstdint> // For std::uint64_t

// Placeholder for pid_t if not available by default in a freestanding context
// In a real kernel, this would come from a types header.
#if __has_include(<sys/types.h>)
#include <sys/types.h>
#else
using pid_t = int; // Simple placeholder
#endif

namespace minix_cpp17 {

// Based on p_flags in original MINIX1 src/kernel/proc.h
// A process is runnable if p_flags == 0 in the original.
enum class ProcessState {
    INACTIVE,       // Corresponds to P_SLOT_FREE
    RUNNABLE,       // Ready to run or currently running
    BLOCKED_SENDING,// Blocked trying to send (SENDING bit)
    BLOCKED_RECEIVING,// Blocked trying to receive (RECEIVING bit)
    STOPPED         // Process is traced/stopped (P_STOP bit)
    // Other flags like NO_MAP, PENDING, SIG_PENDING might be separate boolean members
    // or incorporated into a more complex state enum if they define distinct
    // points in the lifecycle relevant to state transitions.
};

// Forward declaration for Process class
class Process;

// Definition of ReadyQueueNode as specified by The Board
// This struct is intended to be cache-aligned.
struct alignas(64) ReadyQueueNode {
    Process* process {nullptr}; // Pointer to the process instance
    ReadyQueueNode* next {nullptr};   // Pointer to the next node in the ready queue
    std::uint64_t timeslice_remaining {0}; // Remaining timeslice for this process
};


} // namespace minix_cpp17

#endif // KERNEL_CPP17_PROCESS_HPP
