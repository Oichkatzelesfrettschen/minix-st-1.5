; NOTE: Generated from src/fs/time.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/time.c'
source_filename = "src/fs/time.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.mess_6 = type { i32, i32, i32, i64, ptr }
%struct.mess_4 = type { i64, i64, i64, i64 }

@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16
@fp = external global ptr, align 8
@super_user = external global i32, align 4
@m1 = external global %struct.message, align 8
@clock_mess = internal global %struct.message zeroinitializer, align 8
@.str = private unnamed_addr constant [15 x i8] c"do_stime error\00", align 1
@who = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_utime() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load ptr, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 5), align 8
  %5 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %6 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %4, i32 noundef %5, i32 noundef 1)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = load i32, ptr @err_code, align 4
  store i32 %9, ptr %1, align 4
  br label %46

10:                                               ; preds = %0
  %11 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %11, ptr %2, align 8
  %12 = icmp eq ptr %11, null
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, ptr @err_code, align 4
  store i32 %14, ptr %1, align 4
  br label %46

15:                                               ; preds = %10
  store i32 0, ptr %3, align 4
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.inode, ptr %16, i32 0, i32 1
  %18 = load i16, ptr %17, align 2
  %19 = zext i16 %18 to i32
  %20 = load ptr, ptr @fp, align 8
  %21 = getelementptr inbounds %struct.fproc, ptr %20, i32 0, i32 5
  %22 = load i16, ptr %21, align 2
  %23 = zext i16 %22 to i32
  %24 = icmp ne i32 %19, %23
  br i1 %24, label %25, label %29

25:                                               ; preds = %15
  %26 = load i32, ptr @super_user, align 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %29, label %28

28:                                               ; preds = %25
  store i32 -1, ptr %3, align 4
  br label %29

29:                                               ; preds = %28, %25, %15
  %30 = load ptr, ptr %2, align 8
  %31 = call i32 (ptr, ...) @read_only(ptr noundef %30)
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %34

33:                                               ; preds = %29
  store i32 -30, ptr %3, align 4
  br label %34

34:                                               ; preds = %33, %29
  %35 = load i32, ptr %3, align 4
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %43

37:                                               ; preds = %34
  %38 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %39 = load ptr, ptr %2, align 8
  %40 = getelementptr inbounds %struct.inode, ptr %39, i32 0, i32 3
  store i64 %38, ptr %40, align 8
  %41 = load ptr, ptr %2, align 8
  %42 = getelementptr inbounds %struct.inode, ptr %41, i32 0, i32 12
  store i8 1, ptr %42, align 2
  br label %43

43:                                               ; preds = %37, %34
  %44 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %44)
  %45 = load i32, ptr %3, align 4
  store i32 %45, ptr %1, align 4
  br label %46

46:                                               ; preds = %43, %13, %8
  %47 = load i32, ptr %1, align 4
  ret i32 %47
}

declare i32 @fetch_name(...) #1

declare ptr @eat_path(...) #1

declare i32 @read_only(...) #1

declare void @put_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_time() #0 {
  %1 = call i64 (...) @clock_time()
  store i64 %1, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  ret i32 0
}

declare i64 @clock_time(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_stime() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = load i32, ptr @super_user, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %13

6:                                                ; preds = %0
  store i32 4, ptr getelementptr inbounds (%struct.message, ptr @clock_mess, i32 0, i32 1), align 4
  %7 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  store i64 %7, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @clock_mess, i32 0, i32 2), i32 0, i32 3), align 8
  %8 = call i32 (i32, ptr, ...) @sendrec(i32 noundef -3, ptr noundef @clock_mess)
  store i32 %8, ptr %2, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %12

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef %11)
  br label %12

12:                                               ; preds = %10, %6
  store i32 0, ptr %1, align 4
  br label %13

13:                                               ; preds = %12, %5
  %14 = load i32, ptr %1, align 4
  ret i32 %14
}

declare i32 @sendrec(...) #1

declare void @panic(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_tims() #0 {
  %1 = alloca [4 x i64], align 16
  %2 = load i32, ptr @who, align 4
  %3 = getelementptr inbounds [4 x i64], ptr %1, i64 0, i64 0
  call void (i32, ptr, ...) @sys_times(i32 noundef %2, ptr noundef %3)
  %4 = getelementptr inbounds [4 x i64], ptr %1, i64 0, i64 0
  %5 = load i64, ptr %4, align 16
  store i64 %5, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  %6 = getelementptr inbounds [4 x i64], ptr %1, i64 0, i64 1
  %7 = load i64, ptr %6, align 8
  store i64 %7, ptr getelementptr inbounds (%struct.mess_4, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 8
  %8 = getelementptr inbounds [4 x i64], ptr %1, i64 0, i64 2
  %9 = load i64, ptr %8, align 16
  store i64 %9, ptr getelementptr inbounds (%struct.mess_4, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 2), align 8
  %10 = getelementptr inbounds [4 x i64], ptr %1, i64 0, i64 3
  %11 = load i64, ptr %10, align 8
  store i64 %11, ptr getelementptr inbounds (%struct.mess_4, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  ret i32 0
}

declare void @sys_times(...) #1

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
