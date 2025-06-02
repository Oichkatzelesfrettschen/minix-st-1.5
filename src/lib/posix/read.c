#include <lib.h>
#include <sys/types.h> /* For ssize_t, size_t */
#include <unistd.h>    /* For FS, READ constants and read prototype */

PUBLIC ssize_t read(int fd, void *buffer, size_t nbytes)
{
  /* _callm1 expects nbytes as int, char* for buffer */
  return((ssize_t)_callm1(FS, READ, fd, (int)nbytes, 0,
                         (char *)buffer, NIL_PTR, NIL_PTR));
}
