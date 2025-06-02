#include <lib.h>
#include <sys/types.h> /* For pid_t */
#include <signal.h>    /* For kill prototype consistency */
#include <unistd.h>    /* For MM, KILL constants if not in lib.h */

PUBLIC int kill(pid_t proc, int sig)
{
  return(_callm1(MM, KILL, (int)proc, sig, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
