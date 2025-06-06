#include <lib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h> /* For FS, FSTAT constants if not in lib.h */

PUBLIC int fstat(int fd, struct stat *buffer)
{
  return(_callm1(FS, FSTAT, fd, 0, 0, (char *)buffer, NIL_PTR, NIL_PTR));
}
