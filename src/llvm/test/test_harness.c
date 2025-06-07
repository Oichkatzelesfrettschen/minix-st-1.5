#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>

#define DEFAULT_NUM_THREADS 50
#define MAX_ALLOWED_THREADS 200
#define REGISTRY_SIZE MAX_ALLOWED_THREADS

extern void initialize_global_queue_registry(int max_processes);
extern int concurrent_registration_worker(int pid, void* dummy_queue_addr);
extern int verify_concurrent_registrations(int num_threads_attempted, int max_pid_to_check, void* expected_queue_addr);

void minix_panic(const char* message) {
    fprintf(stderr, "MINIX PANIC (from LLVM assertion): %s\n", message);
    exit(2);
}

typedef struct {
    void* field1;
    long long field2;
    long long field3;
    int field4;
} dummy_msg_queue_t;

static dummy_msg_queue_t shared_dummy_queue = {NULL, 0LL, 0LL, 0};

typedef struct {
    int pid;
    void* queue_addr;
    int result;
} thread_data_t;

void* thread_func(void* arg) {
    thread_data_t* data = (thread_data_t*)arg;
    data->result = concurrent_registration_worker(data->pid, data->queue_addr);
    return NULL;
}

int main(int argc, char *argv[]) {
    pthread_t threads[MAX_ALLOWED_THREADS];
    thread_data_t thread_args[MAX_ALLOWED_THREADS];
    int i;
    int num_threads_to_run = DEFAULT_NUM_THREADS;
    int registry_init_size = REGISTRY_SIZE;

    if (argc > 1) {
        if (strcmp(argv[1], "--help") == 0) {
            printf("Usage: %s [num_threads]\n", argv[0]);
            printf("  num_threads: Number of concurrent threads to run (default: %d, max: %d)\n", DEFAULT_NUM_THREADS, MAX_ALLOWED_THREADS);
            return 0;
        }
        num_threads_to_run = atoi(argv[1]);
        if (num_threads_to_run <= 0 || num_threads_to_run > MAX_ALLOWED_THREADS) {
            fprintf(stderr, "Invalid number of threads specified. Using default %d\n", DEFAULT_NUM_THREADS);
            num_threads_to_run = DEFAULT_NUM_THREADS;
        }
    }

    initialize_global_queue_registry(registry_init_size);

    for (i = 0; i < num_threads_to_run; ++i) {
        thread_args[i].pid = i;
        thread_args[i].queue_addr = &shared_dummy_queue;
        if (pthread_create(&threads[i], NULL, thread_func, &thread_args[i]) != 0) {
            perror("Failed to create thread");
            for (int k = 0; k < i; ++k) pthread_join(threads[k], NULL);
            return 1;
        }
    }

    int successful_registrations_by_threads = 0;
    for (i = 0; i < num_threads_to_run; ++i) {
        pthread_join(threads[i], NULL);
        if (thread_args[i].result == 0) {
            successful_registrations_by_threads++;
        }
    }

    printf("All %d threads completed registration attempts. Reported successes by threads: %d\n", num_threads_to_run, successful_registrations_by_threads);

    int verified_count = verify_concurrent_registrations(num_threads_to_run, num_threads_to_run, &shared_dummy_queue);
    printf("LLVM-side verification: Found %d PIDs (0 to %d) correctly registered to the shared queue.\n", verified_count, num_threads_to_run - 1);

    if (verified_count != num_threads_to_run) {
        fprintf(stderr, "Verification failed: Expected %d successful and verifiable registrations, LLVM-side verification found %d for PIDs 0-%d.\n", num_threads_to_run, verified_count, num_threads_to_run -1);
        if (successful_registrations_by_threads != num_threads_to_run) {
             fprintf(stderr, "Additionally, threads reported %d successful registrations, expected %d.\n", successful_registrations_by_threads, num_threads_to_run);
        }
        return 1;
    }

    printf("Concurrent registration test passed!\n");
    return 0;
}
