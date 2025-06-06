; NOTE: Generated from src/fs/table.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/table.c'
source_filename = "src/fs/table.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dmap = type { ptr, ptr, ptr, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.buf = type { %union.anon.0, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon.0 = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }

@fstack = dso_local global [2176 x i8] zeroinitializer, align 16
@stackpt = dso_local global ptr getelementptr (i8, ptr @fstack, i64 2176), align 8
@call_vector = dso_local global [70 x ptr] [ptr @no_sys, ptr @do_exit, ptr @do_fork, ptr @do_read, ptr @do_write, ptr @do_open, ptr @do_close, ptr @no_sys, ptr @do_creat, ptr @do_link, ptr @do_unlink, ptr @no_sys, ptr @do_chdir, ptr @do_time, ptr @do_mknod, ptr @do_chmod, ptr @do_chown, ptr @no_sys, ptr @do_stat, ptr @do_lseek, ptr @no_sys, ptr @do_mount, ptr @do_umount, ptr @do_set, ptr @no_sys, ptr @do_stime, ptr @no_sys, ptr @no_sys, ptr @do_fstat, ptr @no_sys, ptr @do_utime, ptr @no_sys, ptr @no_sys, ptr @do_access, ptr @no_sys, ptr @no_sys, ptr @do_sync, ptr @no_sys, ptr @do_rename, ptr @do_mkdir, ptr @do_unlink, ptr @do_dup, ptr @do_pipe, ptr @do_tims, ptr @no_sys, ptr @no_sys, ptr @do_set, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_ioctl, ptr @do_fcntl, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_umask, ptr @do_chroot, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_unpause, ptr @no_sys, ptr @do_revive, ptr @no_sys, ptr @no_sys], align 16
@dmap = dso_local global [7 x %struct.dmap] [%struct.dmap zeroinitializer, %struct.dmap { ptr @no_call, ptr @rw_dev, ptr @no_call, i32 -4 }, %struct.dmap { ptr @no_call, ptr @rw_dev, ptr @no_call, i32 -5 }, %struct.dmap { ptr @no_call, ptr @rw_dev, ptr @no_call, i32 -6 }, %struct.dmap { ptr @tty_open, ptr @rw_dev, ptr @no_call, i32 -9 }, %struct.dmap { ptr @no_call, ptr @rw_dev2, ptr @no_call, i32 -9 }, %struct.dmap { ptr @no_call, ptr @rw_dev, ptr @no_call, i32 -7 }], align 16
@max_major = dso_local global i32 7, align 4
@fp = dso_local global ptr null, align 8
@super_user = dso_local global i32 0, align 4
@dont_reply = dso_local global i32 0, align 4
@susp_count = dso_local global i32 0, align 4
@reviving = dso_local global i32 0, align 4
@rdahedpos = dso_local global i64 0, align 8
@rdahed_inode = dso_local global ptr null, align 8
@m = dso_local global %struct.message zeroinitializer, align 8
@m1 = dso_local global %struct.message zeroinitializer, align 8
@who = dso_local global i32 0, align 4
@fs_call = dso_local global i32 0, align 4
@user_path = dso_local global [255 x i8] zeroinitializer, align 16
@err_code = dso_local global i32 0, align 4
@rdwt_err = dso_local global i32 0, align 4
@buf = dso_local global [30 x %struct.buf] zeroinitializer, align 16
@buf_hash = dso_local global [32 x ptr] zeroinitializer, align 16
@front = dso_local global ptr null, align 8
@rear = dso_local global ptr null, align 8
@bufs_in_use = dso_local global i32 0, align 4
@filp = dso_local global [64 x %struct.filp] zeroinitializer, align 16
@fproc = dso_local global [32 x %struct.fproc] zeroinitializer, align 16
@inode = dso_local global [32 x %struct.inode] zeroinitializer, align 16
@super_block = dso_local global [5 x %struct.super_block] zeroinitializer, align 16

declare i32 @no_sys(...) #0

declare i32 @do_exit(...) #0

declare i32 @do_fork(...) #0

declare i32 @do_read(...) #0

declare i32 @do_write(...) #0

declare i32 @do_open(...) #0

declare i32 @do_close(...) #0

declare i32 @do_creat(...) #0

declare i32 @do_link(...) #0

declare i32 @do_unlink(...) #0

declare i32 @do_chdir(...) #0

declare i32 @do_time(...) #0

declare i32 @do_mknod(...) #0

declare i32 @do_chmod(...) #0

declare i32 @do_chown(...) #0

declare i32 @do_stat(...) #0

declare i32 @do_lseek(...) #0

declare i32 @do_mount(...) #0

declare i32 @do_umount(...) #0

declare i32 @do_set(...) #0

declare i32 @do_stime(...) #0

declare i32 @do_fstat(...) #0

declare i32 @do_utime(...) #0

declare i32 @do_access(...) #0

declare i32 @do_sync(...) #0

declare i32 @do_rename(...) #0

declare i32 @do_mkdir(...) #0

declare i32 @do_dup(...) #0

declare i32 @do_pipe(...) #0

declare i32 @do_tims(...) #0

declare i32 @do_ioctl(...) #0

declare i32 @do_fcntl(...) #0

declare i32 @do_umask(...) #0

declare i32 @do_chroot(...) #0

declare i32 @do_unpause(...) #0

declare i32 @do_revive(...) #0

declare void @no_call(...) #0

declare void @rw_dev(...) #0

declare void @tty_open(...) #0

declare void @rw_dev2(...) #0

attributes #0 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
