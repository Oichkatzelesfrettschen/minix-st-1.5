#include <lib.h>

PUBLIC void (*__cleanup) ();

PUBLIC void exit(int status)
{
  if (__cleanup) (*__cleanup) ();
  _callm1(MM, EXIT, status, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
}
