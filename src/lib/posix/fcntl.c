#include <lib.h>
#include <fcntl.h>		/* for the proto; emphasize varargs kludge */
#include <stdarg.h>

PUBLIC int fcntl(int fd, int cmd, ...)
{
  va_list ap;
  int arg_val;

  va_start(ap, cmd);
  /* The original code passed the 3rd arg 'barf' (an int) as callm1's 3rd int.
   * This attempts to retrieve that int if passed.
   * This does not correctly handle commands that expect a pointer (e.g. struct flock*),
   * but the K&R version was also broken for those. This change primarily
   * addresses the function signature to match the ANSI variadic prototype.
   */
  arg_val = va_arg(ap, int);
  va_end(ap);

  return(callm1(FS, FCNTL, fd, cmd, arg_val, NIL_PTR, NIL_PTR, NIL_PTR));
}
