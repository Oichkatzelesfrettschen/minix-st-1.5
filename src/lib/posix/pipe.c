#include <lib.h>
#include <unistd.h> /* For FS, PIPE constants and potentially errno */

PUBLIC int pipe(int fild[2])
{
  int status;
  status = _callm1(FS, PIPE, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  if (status < 0) {
    /* _callm1 is expected to set errno if status < 0 */
    return(-1);
  }
  fild[0] = _M.m1_i1;
  fild[1] = _M.m1_i2;
  return(0);
}
