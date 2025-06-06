#include <lib.h>
#include <sys/types.h>
#include <unistd.h> /* For MM, GETUID constants and potentially errno */

PUBLIC uid_t getuid(void) /* Explicit void for no arguments */
{
  int k;
  k = _callm1(MM, GETUID, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  /* The _callm1 wrapper sets errno if k (which is _M.m_type) < 0.
   * Minix GETUID syscall returns real UID in m2_i1 and effective UID in m2_i2.
   */
  if (k < 0) return((uid_t) -1); /* Error occurred, errno is set */
  return((uid_t) _M.m2_i1);      /* Return real UID */
}
