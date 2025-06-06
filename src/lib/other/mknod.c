#include <lib.h>
#include <sys/types.h> /* For mode_t, dev_t */
#include <unistd.h>    /* For MKNOD, FS constants if not in lib.h */

/* Corrected ANSI signature to match POSIX and unistd.h prototype */
PUBLIC int mknod(const char *name, mode_t mode, dev_t dev)
{
  /* The 'size' parameter from the K&R version was non-standard and incorrectly used.
   * Standard mknod takes path, mode, and dev.
   * The system call expects: name_ptr, len(name), mode, dev.
   */
  return(_callm1(FS, MKNOD, _len((char *)name), (int)mode, (int)dev,
                 (char *)name, NIL_PTR, NIL_PTR));
}
