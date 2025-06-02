#include <lib.h>
#include <string.h>
#include <unistd.h>
#include <stdarg.h> /* For variadic functions */

extern char **environ;		/* environment pointer */

#define	PTRSIZE	(sizeof(char *))

PUBLIC int execl(char *name, char *arg0, ...)
{
  /* Body relies on stack layout for variadic args to be accessible via &arg0.
   * This matches the K&R behavior.
   */
  return(execve(name, (char **)&arg0, environ));
}

PUBLIC int execle(char *name, char *arg0, ...) /* K&R 'argv' becomes 'arg0' */
{
  /* Body relies on stack layout for variadic args and envp to be accessible via &arg0.
   * This matches the K&R behavior.
   */
  char **p;
  p = (char **) &arg0; /* Start from the first variadic argument */
  while (*p++)			/* Scan past arguments until NULL */
	;
  /* *p is now envp, which followed the NULL after arguments */
  return(execve(name, (char **)&arg0, (char **) *p));
}

PUBLIC int execv(char *name, char *argv[])
{
  return(execve(name, argv, environ));
}


PUBLIC int execve(char *path, char *argv[], char *envp[])
{
  register char **argtop;
  register char **envtop;

  /* Count the argument pointers and environment pointers. */
  for (argtop = argv; *argtop != (char *) NULL; ) argtop++;
  for (envtop = envp; *envtop != (char *) NULL; ) envtop++;
  return(__execve(path, argv, envp, argtop - argv, envtop - envp));
}


PUBLIC int __execve(char *path, char *argv[], char *envp[], int nargs, int nenvps)
{
/* This is split off from execve to be called from execvp, so execvp does not
 * have to allocate up to ARG_MAX bytes just to prepend "sh" to the arg array.
 */

  char *hp, **ap, *p;
  int i, stackbytes, npointers, overflow, temp;
  char *stack;

  /* Decide how big a stack is needed. Be paranoid about overflow. */
#if ARG_MAX > INT_MAX
#error /* overflow checks and sbrk depend on sizes being ints */
#endif
  overflow = FALSE;
  npointers = 1 + nargs + 1 + nenvps + 1;	/* 1's for argc and NULLs */
  stackbytes = nargs + nenvps;		/* for nulls in strings */
  if (nargs < 0 || nenvps < 0 || stackbytes < nargs || npointers < stackbytes)
	overflow = TRUE;
  for (i = PTRSIZE; i != 0; i--) {
	temp = stackbytes + npointers;
	if (temp < stackbytes) overflow = TRUE;
	stackbytes = temp;
  }
  for (i = 0, ap = argv; i < nargs; i++) {
	temp = stackbytes + strlen(*ap++);
	if (temp < stackbytes) overflow = TRUE;
	stackbytes = temp;
  }
  for (i = 0, ap = envp; i < nenvps; i++) {
	temp = stackbytes + strlen(*ap++);
	if (temp < stackbytes) overflow = TRUE;
	stackbytes = temp;
  }
  temp = stackbytes + PTRSIZE - 1;
  if (temp < stackbytes) overflow = TRUE;
  stackbytes = (temp / PTRSIZE) * PTRSIZE;

  /* Check for overflow before committing sbrk. */
  if (overflow || stackbytes > ARG_MAX) {
	errno = E2BIG;
	return(-1);
  }

  /* Allocate the stack. */
  stack = sbrk(stackbytes);
  if (stack == (char *) -1) {
	errno = E2BIG;
	return(-1);
  }

  /* Prepare the stack vector and argc. */
  ap = (char **) stack;
  hp = &stack[npointers * PTRSIZE];
  *ap++ = (char *) nargs;

  /* Prepare the argument pointers and strings. */
  for (i = 0; i < nargs; i++) {
	*ap++ = (char *) (hp - stack);
	p = *argv++;
	while ((*hp++ = *p++) != 0)
		;
  }
  *ap++ = (char *) NULL;

  /* Prepare the environment pointers and strings. */
  for (i = 0; i < nenvps; i++) {
	*ap++ = (char *) (hp - stack);
	p = *envp++;
	while ((*hp++ = *p++) != 0)
		;
  }
  *ap++ = (char *) NULL;

  /* Do the real work. */
  temp = _callm1(MM, EXEC, _len(path), stackbytes, 0, path, stack, NIL_PTR);
  sbrk(-stackbytes);
  return(temp);
}
