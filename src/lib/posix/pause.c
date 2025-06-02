#include <lib.h>
#include <unistd.h> /* For MM, PAUSE constants if not in lib.h */

PUBLIC int pause(void)
{
  return(_callm1(MM, PAUSE, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR));
}
