; NOTE: Generated from src/mm/putc.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/putc.c'
source_filename = "src/mm/putc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@print_buf = internal global [100 x i8] zeroinitializer, align 16
@buf_count = internal global i32 0, align 4
@putch_msg = internal global %struct.message zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @putc(i32 noundef %0) #0 {
  %2 = alloca i8, align 1
  %3 = trunc i32 %0 to i8
  store i8 %3, ptr %2, align 1
  %4 = load i8, ptr %2, align 1
  %5 = load i32, ptr @buf_count, align 4
  %6 = add nsw i32 %5, 1
  store i32 %6, ptr @buf_count, align 4
  %7 = sext i32 %5 to i64
  %8 = getelementptr inbounds [100 x i8], ptr @print_buf, i64 0, i64 %7
  store i8 %4, ptr %8, align 1
  %9 = load i8, ptr %2, align 1
  %10 = sext i8 %9 to i32
  %11 = icmp eq i32 %10, 10
  br i1 %11, label %15, label %12

12:                                               ; preds = %1
  %13 = load i32, ptr @buf_count, align 4
  %14 = icmp eq i32 %13, 100
  br i1 %14, label %15, label %16

15:                                               ; preds = %12, %1
  call void @F_l_u_s_h()
  br label %16

16:                                               ; preds = %15, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @F_l_u_s_h() #0 {
  %1 = load i32, ptr @buf_count, align 4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %0
  br label %7

4:                                                ; preds = %0
  store i32 4, ptr getelementptr inbounds (%struct.message, ptr @putch_msg, i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putch_msg, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.message, ptr @putch_msg, i32 0, i32 2), align 8
  store ptr @print_buf, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putch_msg, i32 0, i32 2), i32 0, i32 5), align 8
  %5 = load i32, ptr @buf_count, align 4
  store i32 %5, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @putch_msg, i32 0, i32 2), i32 0, i32 2), align 8
  %6 = call i32 @sendrec(i32 noundef -9, ptr noundef @putch_msg)
  store i32 0, ptr @buf_count, align 4
  br label %7

7:                                                ; preds = %4, %3
  ret void
}

declare i32 @sendrec(i32 noundef, ptr noundef) #1

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
