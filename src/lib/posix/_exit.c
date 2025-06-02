#include <lib.h>
#include <unistd.h> /* For MM, EXIT constants if not in lib.h */

PUBLIC void _exit(int status)
{
  _callm1(MM, EXIT, status, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
}
