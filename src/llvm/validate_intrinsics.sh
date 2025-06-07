#!/bin/bash
# src/llvm/validate_intrinsics.sh
# Basic script to compile and perform initial checks on LLVM intrinsic modules.

# Assuming this script is located in src/llvm/
BASE_DIR="."
BC_DIR="${BASE_DIR}/bc_files" # Bitcode files will be stored in ./bc_files/

# Ensure output directory for bitcode files exists
mkdir -p "${BC_DIR}"

echo "=== MINIX LLVM Intrinsics Validation Suite ==="
echo "Working directory: $(pwd)" # Should be src/llvm when running this script
echo "Bitcode directory: ${BC_DIR}"
echo ""

# --- Step 1: Compiling LLVM IR modules to bitcode ---
echo "Step 1: Compiling LLVM IR modules to bitcode..."
MODULES=(
  "memory_model.ll"
  "arch_config.ll"
  "types/base_types.ll"
  "intrinsics/memory.ll"
  "intrinsics/atomic.ll"
)

for module_ll in "${MODULES[@]}"; do
  module_bc="${BC_DIR}/$(basename "${module_ll}" .ll).bc"
  echo "Compiling ${BASE_DIR}/${module_ll} to ${module_bc}..."
  llvm-as "${BASE_DIR}/${module_ll}" -o "${module_bc}"
  if [ $? -ne 0 ]; then echo "Error compiling ${module_ll}"; exit 1; fi
done

echo "All .ll modules compiled to bitcode successfully."
echo ""

# --- Step 2: Linking core bitcode modules ---
echo "Step 2: Linking core bitcode modules..."
CORE_BC_FILES=(
  "${BC_DIR}/memory_model.bc"
  "${BC_DIR}/arch_config.bc"
  "${BC_DIR}/base_types.bc"
  "${BC_DIR}/memory.bc"
  "${BC_DIR}/atomic.bc"
)
llvm-link "${CORE_BC_FILES[@]}" -o "${BC_DIR}/minix_intrinsics_core.bc"
if [ $? -ne 0 ]; then echo "Error linking core bitcode modules"; exit 1; fi

echo "Core bitcode modules linked into ${BC_DIR}/minix_intrinsics_core.bc."
echo ""

# --- Step 3: Running functional tests (linking with test_memory_model.ll) ---
echo "Step 3: Running functional tests (linking with test_memory_model.ll)..."
TEST_MEMORY_MODEL_LL="${BASE_DIR}/test/test_memory_model.ll"
TEST_MEMORY_MODEL_BC="${BC_DIR}/test_memory_model.bc"

if [ -f "$TEST_MEMORY_MODEL_LL" ]; then
  echo "Compiling ${TEST_MEMORY_MODEL_LL} to ${TEST_MEMORY_MODEL_BC}..."
  llvm-as "$TEST_MEMORY_MODEL_LL" -o "$TEST_MEMORY_MODEL_BC"
  if [ $? -ne 0 ]; then echo "Error compiling $TEST_MEMORY_MODEL_LL"; exit 1; fi

  echo "Linking core bitcode with test bitcode..."
  llvm-link "${BC_DIR}/minix_intrinsics_core.bc" "$TEST_MEMORY_MODEL_BC" -o "${BC_DIR}/minix_with_tests.bc"
  if [ $? -ne 0 ]; then echo "Error linking core with tests"; exit 1; fi

  echo "Running tests with lli on ${BC_DIR}/minix_with_tests.bc ..."
  lli "${BC_DIR}/minix_with_tests.bc"
  LLI_EXIT_CODE=$?
  if [ ${LLI_EXIT_CODE} -eq 0 ]; then
    echo "LLI tests from test_memory_model.ll PASSED (exit code 0)."
  else
    echo "LLI tests from test_memory_model.ll FAILED (exit code ${LLI_EXIT_CODE})."
  fi
else
  echo "Test file $TEST_MEMORY_MODEL_LL not found, skipping lli tests."
fi
echo ""

# --- Step 4: Checking for vectorization in memory.ll (placeholder for specific pass) ---
echo "Step 4: Checking for vectorization in memory.ll (example with opt -S)..."
# The -minix-vectorize pass mentioned in feedback is hypothetical.
# This example just creates an optimized textual version after verification.
VERIFIED_OPT_MEMORY_LL="${BC_DIR}/memory_opt_verified.ll"
echo "Running opt -S -passes=verify on ${BC_DIR}/memory.bc to output ${VERIFIED_OPT_MEMORY_LL}..."
opt -S -passes=verify "${BC_DIR}/memory.bc" -o "${VERIFIED_OPT_MEMORY_LL}"
if [ $? -ne 0 ]; then
  echo "Error running opt -S -passes=verify on memory.bc";
else
  echo "Optimized (verified) textual IR written to ${VERIFIED_OPT_MEMORY_LL}"
  # Example check for vector types (adjust grep pattern as needed)
  # VECTOR_TYPE_COUNT=$(grep -cE "(<16 x i8>|<32 x i8>)" "${VERIFIED_OPT_MEMORY_LL}")
  # echo "Found ${VECTOR_TYPE_COUNT} potential vector types in ${VERIFIED_OPT_MEMORY_LL}."
fi
echo "Vectorization check placeholder completed."
echo ""

echo "Validation script finished."
echo "To make this script executable, run: chmod +x ${BASE_DIR}/validate_intrinsics.sh"
