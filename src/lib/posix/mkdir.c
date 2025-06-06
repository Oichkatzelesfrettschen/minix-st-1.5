#include <lib.h>
#include <sys/types.h> /* For mode_t */
#include <unistd.h>    /* For FS, MKDIR constants if not in lib.h */

PUBLIC int mkdir(const char *name, mode_t mode)
{
  return(_callm1(FS, MKDIR, _len((char *)name), (int)mode, 0,
                 (char *)name, NIL_PTR, NIL_PTR));
}
