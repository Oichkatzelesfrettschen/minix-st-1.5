; NOTE: Generated from src/mm/table.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/table.c'
source_filename = "src/mm/table.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }

@core_name = dso_local global [5 x i8] c"core\00", align 1
@core_bits = dso_local global i16 3836, align 2
@mm_stack = dso_local global [6656 x i8] zeroinitializer, align 16
@stackpt = dso_local global ptr getelementptr (i8, ptr @mm_stack, i64 6656), align 8
@call_vec = dso_local global [70 x ptr] [ptr @no_sys, ptr @do_mm_exit, ptr @do_fork, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_wait, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_brk, ptr @no_sys, ptr @no_sys, ptr @do_getset, ptr @no_sys, ptr @no_sys, ptr @do_getset, ptr @do_getset, ptr @no_sys, ptr @do_trace, ptr @do_alarm, ptr @no_sys, ptr @do_pause, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_kill, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_getset, ptr @do_getset, ptr @do_signal, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_exec, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @no_sys, ptr @do_ksig, ptr @no_sys, ptr @do_brk2, ptr @no_sys, ptr @no_sys, ptr null], align 16
@mp = dso_local global ptr null, align 8
@dont_reply = dso_local global i32 0, align 4
@procs_in_use = dso_local global i32 0, align 4
@mm_in = dso_local global %struct.message zeroinitializer, align 8
@mm_out = dso_local global %struct.message zeroinitializer, align 8
@who = dso_local global i32 0, align 4
@mm_call = dso_local global i32 0, align 4
@err_code = dso_local global i32 0, align 4
@result2 = dso_local global i32 0, align 4
@res_ptr = dso_local global ptr null, align 8
@mproc = dso_local global [32 x %struct.mproc] zeroinitializer, align 16

declare i32 @no_sys(...) #0

declare i32 @do_mm_exit(...) #0

declare i32 @do_fork(...) #0

declare i32 @do_wait(...) #0

declare i32 @do_brk(...) #0

declare i32 @do_getset(...) #0

declare i32 @do_trace(...) #0

declare i32 @do_alarm(...) #0

declare i32 @do_pause(...) #0

declare i32 @do_kill(...) #0

declare i32 @do_signal(...) #0

declare i32 @do_exec(...) #0

declare i32 @do_ksig(...) #0

declare i32 @do_brk2() #0

attributes #0 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
