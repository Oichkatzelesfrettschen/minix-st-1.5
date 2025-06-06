#include <lib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h> /* For FS, MKNOD constants if not in lib.h */

PUBLIC int mkfifo(const char *name, mode_t mode)
{
  mode_t new_mode = (mode & 07777) | S_IFIFO; /* Ensure mode_t used for bitwise ops */
  return(_callm1(FS, MKNOD, _len((char *)name), (int)new_mode, 0,
	 (char *)name, NIL_PTR, NIL_PTR));
}
