#include <lib.h>
#include <sys/types.h> /* For pid_t */
#include <unistd.h>    /* For MM, GETPID constants and potentially errno */

PUBLIC pid_t getppid(void) /* Explicit void for no arguments */
{
  int status;

  status = _callm1(MM, GETPID, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  /* The _callm1 wrapper sets errno if status (which is _M.m_type) < 0.
   * Minix GETPID syscall returns parent PID in m2_i1.
   * POSIX getppid() is always successful.
   */
  if (status < 0) return((pid_t)-1); /* Should ideally not happen for getppid */
  return((pid_t)_M.m2_i1);
}
