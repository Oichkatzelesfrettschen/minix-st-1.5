#include <lib.h>
#include <unistd.h> /* For MOUNT, FS constants if not in lib.h */

PUBLIC int mount(const char *special, const char *name, int rwflag)
{
  return(_callm1(FS, MOUNT, _len((char *)special), _len((char *)name), rwflag,
                 (char *)special, (char *)name, NIL_PTR));
}
