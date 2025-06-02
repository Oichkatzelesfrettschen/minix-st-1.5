#include <lib.h>
#include <unistd.h> /* For FS, LINK constants if not in lib.h */

PUBLIC int link(const char *name, const char *name2)
{
  return(_callm1(FS, LINK, _len((char *)name), _len((char *)name2), 0,
	 (char *) name, (char *) name2,	/* perhaps callm1 preserves these */
	 NIL_PTR));
}
