# Symbol Fixes Log

This file tracks the resolution of undefined symbols encountered during the MINIX1 C++17 migration.

## 1. `_bintoascii`

*   **Issue**: Undefined reference to `_bintoascii` in `doprintf.cpp` (actually `src/lib/other/doprintf.c`).
*   **Resolution**:
    *   Added a `static` function definition for `_bintoascii(long num, int radix, char *a)` to `src/lib/other/doprintf.c`.
    *   The implementation converts a long integer to an ASCII string representation for the given radix.
    *   It handles negative numbers for base 10.
    *   It uses the existing `MAXDIG` macro (instead of `kMaxDigits` from the issue description) for buffer sizing.
    *   Added a forward declaration: `static void _bintoascii(long num, int radix, char *a);` near other static function forward declarations in the same file.
*   **Verification**: Ensured `src/lib/other/Makefile` compiles `doprintf.c` and `src/lib/LIBORDER` includes `other/doprintf.o` in `libc.a`.
