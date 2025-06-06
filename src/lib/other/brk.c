#include <lib.h>
#include <unistd.h>

extern char *brksize;

PUBLIC char *brk(char *addr)
{
  if (_callm1(MM, BRK, 0, 0, 0, addr, NIL_PTR, NIL_PTR) == 0) {
	brksize = _M.m2_p1;
	return(NIL_PTR);
  } else {
	return((char *) -1);
  }
}


PUBLIC char *sbrk(int incr)
{
  char *newsize, *oldsize;

  oldsize = brksize;
  newsize = brksize + incr;
  if (incr > 0 && newsize < oldsize || incr < 0 && newsize > oldsize)
	return((char *) -1);
  if (brk(newsize) == 0)
	return(oldsize);
  else
	return((char *) -1);
}
