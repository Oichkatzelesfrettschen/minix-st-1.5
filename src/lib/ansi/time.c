#include <lib.h>
#include <sys/types.h> /* For time_t */
#include <time.h> /* For time_t prototype consistency */

PUBLIC time_t time(time_t *tp)
{
  int k;
  time_t l; /* Use time_t for consistency */
  k = _callm1(FS, TIME, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  if (_M.m_type < 0 || k != 0) {
	errno = -_M.m_type;
	return((time_t)-1L);
  }
  l = (time_t)_M.m2_l1;
  if (tp != (time_t *) 0) *tp = l;
  return(l);
}
