#include <lib.h>
#include <sys/types.h> /* For pid_t */
#include <unistd.h>    /* For MM, FORK constants if not in lib.h */

PUBLIC pid_t fork(void)
{
  return((pid_t)_callm1(MM, FORK, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
