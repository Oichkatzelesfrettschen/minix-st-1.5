; NOTE: Generated from src/fs/putc.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/putc.c'
source_filename = "src/fs/putc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@printbuf = internal global [100 x i8] zeroinitializer, align 16
@bufcount = internal global i32 0, align 4
@putchmsg = internal global %struct.message zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putc(i32 noundef %0) #0 {
  %2 = alloca i8, align 1
  %3 = trunc i32 %0 to i8
  store i8 %3, ptr %2, align 1
  %4 = load i8, ptr %2, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  call void @flush()
  br label %22

8:                                                ; preds = %1
  %9 = load i8, ptr %2, align 1
  %10 = load i32, ptr @bufcount, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr @bufcount, align 4
  %12 = sext i32 %10 to i64
  %13 = getelementptr inbounds [100 x i8], ptr @printbuf, i64 0, i64 %12
  store i8 %9, ptr %13, align 1
  %14 = load i32, ptr @bufcount, align 4
  %15 = icmp eq i32 %14, 100
  br i1 %15, label %16, label %17

16:                                               ; preds = %8
  call void @flush()
  br label %17

17:                                               ; preds = %16, %8
  %18 = load i8, ptr %2, align 1
  %19 = sext i8 %18 to i32
  %20 = icmp eq i32 %19, 10
  br i1 %20, label %21, label %22

21:                                               ; preds = %17
  call void @flush()
  br label %22

22:                                               ; preds = %7, %21, %17
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @flush() #0 {
  %1 = load i32, ptr @bufcount, align 4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %0
  br label %6

4:                                                ; preds = %0
  store i32 4, ptr getelementptr inbounds (%struct.message, ptr @putchmsg, i32 0, i32 1), align 4
  store i32 1, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putchmsg, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.message, ptr @putchmsg, i32 0, i32 2), align 8
  store ptr @printbuf, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putchmsg, i32 0, i32 2), i32 0, i32 5), align 8
  %5 = load i32, ptr @bufcount, align 4
  store i32 %5, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putchmsg, i32 0, i32 2), i32 0, i32 2), align 8
  call void (i32, ptr, ...) @rw_dev(i32 noundef -9, ptr noundef @putchmsg)
  store i32 0, ptr @bufcount, align 4
  br label %6

6:                                                ; preds = %4, %3
  ret void
}

declare void @rw_dev(...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
