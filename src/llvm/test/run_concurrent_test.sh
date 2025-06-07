#!/bin/bash
set -e

LLVM_TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
QUEUE_REGISTRY_LL_FILE="$LLVM_TEST_DIR/../queue_registry.ll"
TEST_LLVM_FILE="$LLVM_TEST_DIR/test_queue_registry.ll"
C_HARNESS_FILE="$LLVM_TEST_DIR/test_harness.c"

REGISTRY_OBJ_FILE="$LLVM_TEST_DIR/queue_registry.o"
TEST_LLVM_OBJ_FILE="$LLVM_TEST_DIR/test_llvm_parts.o"
C_OBJ_FILE="$LLVM_TEST_DIR/test_harness.o"
EXECUTABLE="$LLVM_TEST_DIR/concurrent_test_runner"

echo "Attempting to install necessary packages (clang, lld)..."
if [ "$(id -u)" -eq 0 ]; then
    apt-get update -y && apt-get install -y clang lld
elif command -v sudo >/dev/null; then
    sudo apt-get update -y && sudo apt-get install -y clang lld
else
    echo "Cannot run apt-get. Please ensure clang and lld are installed."
fi || echo "apt-get failed/skipped, continuing, hoping tools are present..."

echo "Compiling main LLVM code (queue_registry.ll) to object file..."
clang -c "$QUEUE_REGISTRY_LL_FILE" -o "$REGISTRY_OBJ_FILE" -Wno-override-module -fPIC

echo "Compiling LLVM test functions (test_queue_registry.ll) to object file..."
clang -c "$TEST_LLVM_FILE" -o "$TEST_LLVM_OBJ_FILE" -Wno-override-module -fPIC

echo "Compiling C harness to object file..."
clang -c "$C_HARNESS_FILE" -o "$C_OBJ_FILE" -pthread -fPIC

echo "Linking object files..."
clang "$REGISTRY_OBJ_FILE" "$TEST_LLVM_OBJ_FILE" "$C_OBJ_FILE" -o "$EXECUTABLE" -pthread

echo "Running concurrent test executable..."
"$EXECUTABLE" "$@"

echo "Concurrent test script finished."
