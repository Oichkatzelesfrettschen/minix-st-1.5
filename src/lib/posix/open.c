#include <lib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdarg.h>

PUBLIC int open(_CONST char *name, int flags, ...)
{
  if (flags & O_CREAT) {
    va_list ap;
    mode_t mode_val;

    va_start(ap, flags);
    mode_val = (mode_t) va_arg(ap, int); /* mode_t is promoted to int for variadic calls */
    va_end(ap);
    return callm1(FS, OPEN, len(name), flags, (int)mode_val,
                  (char *)name, NIL_PTR, NIL_PTR);
  }
  return(callm3(FS, OPEN, flags, (char *)name));
}
