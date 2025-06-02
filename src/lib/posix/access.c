#include <lib.h>

PUBLIC int access(name, mode)
char *name;
int mode;
{
  return(_callm3(FS, ACCESS, mode, name));
}
