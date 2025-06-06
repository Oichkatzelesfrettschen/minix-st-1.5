#include <lib.h>
#include <sys/types.h> /* For pid_t */
#include <unistd.h>    /* For MM, GETPID constants if not in lib.h */

PUBLIC pid_t getpid(void)
{
  /* The GETPID call to MM returns the process ID in _M.m1_i1.
   * _callm1 itself returns the status code from the message (_M.m_type).
   * POSIX getpid() is always successful.
   */
  _callm1(MM, GETPID, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  return((pid_t)_M.m1_i1);
}
