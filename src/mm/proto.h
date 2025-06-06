/* Function prototypes. */

/* alloc.c */
extern phys_clicks alloc_mem(phys_clicks clicks);
extern void free_mem(phys_clicks base, phys_clicks clicks);
extern phys_clicks max_hole(void);
extern void mem_init(void);
extern phys_clicks mem_left(void);

/* amoeba.c */
#if AM_KERNEL
extern do_amoeba();
#endif

/* break.c */
extern int adjust();
extern int do_brk();
extern int size_ok();
extern void stack_fault();

/* exec.c */
extern int do_exec();

/* forkexit.c */
extern int do_fork();
extern int do_mm_exit();
extern int do_wait();
extern void mm_exit();

/* getset.c */
extern int do_getset();

/* main.c */
extern int do_brk2(void);
extern phys_clicks get_mem(phys_clicks *pbase, int extflag);
#if (MACHINE == MACINTOSH)
extern phys_clicks start_click(void);
#endif
extern int main(void);
extern void reply(int proc_nr, int result, int res2, char *respt);

/* putc.c */
extern void putc();

/* signal.c */
extern int do_alarm();
extern int do_kill();
extern int do_ksig();
extern int do_pause();
extern int do_signal();
extern int set_alarm();
extern void sig_proc();

/* trace.c */
extern int do_trace();
extern void stop_proc();

/* utility.c */
extern int allowed();
extern int mem_copy();
extern int no_sys();
extern void panic(const char *message, int errnum);

/* library */
extern int close();
extern int creat();
extern int fstat();
extern long lseek();
extern int open();
extern void printk(const char *fmt, ...);
extern int read();
extern int receive(int src, message *m_ptr);
extern int send(int dest, message *m_ptr);
extern int sendrec(int srcdest, message *m_ptr);
extern void sys_abort();
extern void sys_copy();
extern void sys_exec();
extern void sys_fork();
extern void sys_getsp();
extern void sys_newmap();
extern void sys_sig();
extern int sys_trace();
extern void sys_xit();
extern void tell_fs();
extern int write();
