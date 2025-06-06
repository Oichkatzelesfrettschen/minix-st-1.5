#include <lib.h>
#include <unistd.h> /* For FS, DUP constants if not in lib.h */

PUBLIC int dup2(int fd, int fd2)
{
  return(_callm1(FS, DUP, fd + 0100, fd2, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
