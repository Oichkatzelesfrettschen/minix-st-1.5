#include <lib.h>
#include <unistd.h> /* For FS, DUP constants if not in lib.h */

PUBLIC int dup(int fd)
{
  return(_callm1(FS, DUP, fd, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
