#include <lib.h>
#include <minix/com.h>

/*----------------------------------------------------------------------------
		Messages to systask (special calls)
----------------------------------------------------------------------------*/

#if (CHIP == M68000)
PUBLIC void sys_xit(int parent, int proc, phys_clicks *basep, phys_clicks *sizep)
#else
PUBLIC void sys_xit(int parent, int proc)
#endif
{
/* A proc has exited.  Tell the kernel. */

  _callm1(SYSTASK, SYS_XIT, parent, proc, 0, NIL_PTR, NIL_PTR, NIL_PTR);
#if (CHIP == M68000)
  *basep = (phys_clicks) _M.m1_i1;
  *sizep = (phys_clicks) _M.m1_i2;
#endif
}


PUBLIC void sys_getsp(int proc, vir_bytes *newsp)
{
/* Ask the kernel what the sp is. */


  _callm1(SYSTASK, SYS_GETSP, proc, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
  *newsp = (vir_bytes) _M.STACK_PTR;
}


PUBLIC void sys_sig(int proc, int sig, void (*sighandler) ())
{
/* A proc has to be signaled.  Tell the kernel. */

  _M.m6_i1 = proc;
  _M.m6_i2 = sig;
  _M.m6_f1 = sighandler;
  _callx(SYSTASK, SYS_SIG);
}


#if (CHIP == M68000)
PUBLIC void sys_fork(int parent, int child, int pid, phys_clicks shadow)
#else
PUBLIC void sys_fork(int parent, int child, int pid)
#endif
{
/* A proc has forked.  Tell the kernel. */

#if (CHIP == M68000)
  _callm1(SYSTASK, SYS_FORK, parent, child, pid, (char *) shadow, NIL_PTR, NIL_PTR);
#else
  _callm1(SYSTASK, SYS_FORK, parent, child, pid, NIL_PTR, NIL_PTR, NIL_PTR);
#endif
}


PUBLIC void sys_exec(int proc, char *ptr, int traced)
{
/* A proc has exec'd.  Tell the kernel. */

  _callm1(SYSTASK, SYS_EXEC, proc, traced, 0, ptr, NIL_PTR, NIL_PTR);
}

PUBLIC void sys_newmap(int proc, char *ptr)
{
/* A proc has been assigned a new memory map.  Tell the kernel. */


  _callm1(SYSTASK, SYS_NEWMAP, proc, 0, 0, ptr, NIL_PTR, NIL_PTR);
}

PUBLIC void sys_copy(message *mptr)
{
/* A proc wants to use local copy. */

  /* Make this routine better.  Also check other guys' error handling
   * -DEBUG */
  mptr->m_type = SYS_COPY;
  if (_sendrec(SYSTASK, mptr) != 0) panic("sys_copy can't send", NO_NUM);
}

PUBLIC void sys_times(int proc, time_t ptr[4])
{
/* Fetch the accounting info for a proc. */

  _callm1(SYSTASK, SYS_TIMES, proc, 0, 0, (char *)ptr, NIL_PTR, NIL_PTR);
  ptr[0] = _M.USER_TIME;
  ptr[1] = _M.SYSTEM_TIME;
  ptr[2] = _M.CHILD_UTIME;
  ptr[3] = _M.CHILD_STIME;
}


PUBLIC void sys_abort(void)
{
/* Something awful has happened.  Abandon ship. */

  _callm1(SYSTASK, SYS_ABORT, 0, 0, 0, NIL_PTR, NIL_PTR, NIL_PTR);
}

#if (CHIP == M68000)
PUBLIC void sys_fresh(int proc, char *ptr, phys_clicks dc, phys_clicks *basep, phys_clicks *sizep)
{
/* Create a fresh process image for exec().  Tell the kernel. */

  _callm1(SYSTASK, SYS_FRESH, proc, (int) dc, 0, ptr, NIL_PTR, NIL_PTR);
  *basep = (phys_clicks) _M.m1_i1;
  *sizep = (phys_clicks) _M.m1_i2;
}

#endif


PUBLIC void sys_kill(int proc, int sig)
{
/* A proc has to be signaled via MM.  Tell the kernel. */

  _M.m6_i1 = proc;
  _M.m6_i2 = sig;
  _callx(SYSTASK, SYS_KILL);
}

PUBLIC int sys_trace(int req, int procnr, long addr, long *data_p)
{
  int r;

  _M.m2_i1 = procnr;
  _M.m2_i2 = req;
  _M.m2_l1 = addr;
  if (data_p) _M.m2_l2 = *data_p;
  r = _callx(SYSTASK, SYS_TRACE);
  if (data_p) *data_p = _M.m2_l2;
  return(r);
}

PUBLIC void tell_fs(int what, int p1, int p2, int p3)
{
/* This routine is only used by MM to inform FS of certain events:
 *      tell_fs(CHDIR, slot, dir, 0)
 *      tell_fs(EXIT, proc, 0, 0)
 *      tell_fs(FORK, parent, child, pid)
 *      tell_fs(SETGID, proc, realgid, effgid)
 *      tell_fs(SETUID, proc, realuid, effuid)
 *      tell_fs(SYNC, 0, 0, 0)
 *      tell_fs(UNPAUSE, proc, signr, 0)
 *      tell_fs(SETPGRP, proc, 0, 0)
 */
  _callm1(FS, what, p1, p2, p3, NIL_PTR, NIL_PTR, NIL_PTR);
}
