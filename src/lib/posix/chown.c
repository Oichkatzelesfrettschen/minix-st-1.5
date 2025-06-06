#include <lib.h>
#include <sys/types.h> /* For uid_t, gid_t */
#include <unistd.h>    /* For FS, CHOWN constants if not in lib.h */

PUBLIC int chown(const char *name, uid_t owner, gid_t grp)
{
  return(_callm1(FS, CHOWN, _len((char *)name), (int)owner, (int)grp,
                 (char *)name, NIL_PTR, NIL_PTR));
}
