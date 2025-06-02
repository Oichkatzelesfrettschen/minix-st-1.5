#include <lib.h>
#include <unistd.h> /* For FS, CLOSE constants if not in lib.h */

PUBLIC int close(int fd)
{
  return(_callm1(FS, CLOSE, fd, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
