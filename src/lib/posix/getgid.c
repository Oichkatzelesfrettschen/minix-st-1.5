#include <lib.h>
#include <sys/types.h>
#include <unistd.h> /* For MM, GETGID constants and potentially errno */

PUBLIC gid_t getgid(void) /* Explicit void for no arguments */
{
  int k;
  k = _callm1(MM, GETGID, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  /* The _callm1 wrapper sets errno if k (which is _M.m_type) < 0.
   * Minix GETGID syscall returns real GID in m2_i1 and effective GID in m2_i2.
   */
  if (k < 0) return((gid_t) -1); /* Error occurred, errno is set */
  return((gid_t) _M.m2_i1);      /* Return real GID */
}
