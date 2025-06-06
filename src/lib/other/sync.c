#include <lib.h>
#include <unistd.h> /* For SYNC, FS constants if not in lib.h */

PUBLIC void sync(void)
{
  _callm1(FS, SYNC, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  /* Prototype is void, so no return value. */
}
