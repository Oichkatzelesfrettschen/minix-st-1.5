#include <lib.h>
#include <unistd.h> /* For MM, ALARM constants if not in lib.h */

PUBLIC unsigned int alarm(unsigned int sec)
{
  return(_callm1(MM, ALARM, (int) sec, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
