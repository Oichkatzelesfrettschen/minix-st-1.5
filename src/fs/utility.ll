; NOTE: Generated from src/fs/utility.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/utility.c'
source_filename = "src/fs/utility.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.mess_6 = type { i32, i32, i32, i64, ptr }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }

@clock_mess = internal global %struct.message zeroinitializer, align 8
@.str = private unnamed_addr constant [15 x i8] c"clock_time err\00", align 1
@boot_parameters = external global %struct.bparam_s, align 2
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16
@m = external global %struct.message, align 8
@who = external global i32, align 4
@panicking = internal global i32 0, align 4
@.str.1 = private unnamed_addr constant [23 x i8] c"File system panic: %s \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i64 @clock_time() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  store i32 3, ptr getelementptr inbounds (%struct.message, ptr @clock_mess, i32 0, i32 1), align 4
  %3 = call i32 (i32, ptr, ...) @sendrec(i32 noundef -3, ptr noundef @clock_mess)
  store i32 %3, ptr %1, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %0
  %6 = load i32, ptr %1, align 4
  call void @panic(ptr noundef @.str, i32 noundef %6)
  br label %7

7:                                                ; preds = %5, %0
  %8 = load i16, ptr @boot_parameters, align 2
  %9 = zext i16 %8 to i32
  %10 = call ptr (i32, ...) @get_super(i32 noundef %9)
  store ptr %10, ptr %2, align 8
  %11 = load ptr, ptr %2, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %13, label %26

13:                                               ; preds = %7
  %14 = load i64, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @clock_mess, i32 0, i32 2), i32 0, i32 3), align 8
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %struct.super_block, ptr %15, i32 0, i32 13
  store i64 %14, ptr %16, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = getelementptr inbounds %struct.super_block, ptr %17, i32 0, i32 14
  %19 = load i8, ptr %18, align 8
  %20 = sext i8 %19 to i32
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %25

22:                                               ; preds = %13
  %23 = load ptr, ptr %2, align 8
  %24 = getelementptr inbounds %struct.super_block, ptr %23, i32 0, i32 15
  store i8 1, ptr %24, align 1
  br label %25

25:                                               ; preds = %22, %13
  br label %26

26:                                               ; preds = %25, %7
  %27 = load i64, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @clock_mess, i32 0, i32 2), i32 0, i32 3), align 8
  ret i64 %27
}

declare i32 @sendrec(...) #1

declare ptr @get_super(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @copy(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %15 = load i32, ptr %6, align 4
  %16 = icmp sle i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %3
  br label %70

18:                                               ; preds = %3
  %19 = load ptr, ptr %5, align 8
  %20 = ptrtoint ptr %19 to i32
  store i32 %20, ptr %7, align 4
  %21 = load ptr, ptr %4, align 8
  %22 = ptrtoint ptr %21 to i32
  store i32 %22, ptr %8, align 4
  %23 = load i32, ptr %6, align 4
  %24 = sext i32 %23 to i64
  %25 = urem i64 %24, 4
  %26 = icmp eq i64 %25, 0
  br i1 %26, label %27, label %55

27:                                               ; preds = %18
  %28 = load i32, ptr %7, align 4
  %29 = sext i32 %28 to i64
  %30 = urem i64 %29, 4
  %31 = icmp eq i64 %30, 0
  br i1 %31, label %32, label %55

32:                                               ; preds = %27
  %33 = load i32, ptr %8, align 4
  %34 = sext i32 %33 to i64
  %35 = urem i64 %34, 4
  %36 = icmp eq i64 %35, 0
  br i1 %36, label %37, label %55

37:                                               ; preds = %32
  %38 = load i32, ptr %6, align 4
  %39 = sext i32 %38 to i64
  %40 = udiv i64 %39, 4
  %41 = trunc i64 %40 to i32
  store i32 %41, ptr %9, align 4
  %42 = load ptr, ptr %4, align 8
  store ptr %42, ptr %10, align 8
  %43 = load ptr, ptr %5, align 8
  store ptr %43, ptr %11, align 8
  br label %44

44:                                               ; preds = %50, %37
  %45 = load ptr, ptr %11, align 8
  %46 = getelementptr inbounds i32, ptr %45, i32 1
  store ptr %46, ptr %11, align 8
  %47 = load i32, ptr %45, align 4
  %48 = load ptr, ptr %10, align 8
  %49 = getelementptr inbounds i32, ptr %48, i32 1
  store ptr %49, ptr %10, align 8
  store i32 %47, ptr %48, align 4
  br label %50

50:                                               ; preds = %44
  %51 = load i32, ptr %9, align 4
  %52 = add nsw i32 %51, -1
  store i32 %52, ptr %9, align 4
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %44, label %54

54:                                               ; preds = %50
  br label %70

55:                                               ; preds = %32, %27, %18
  %56 = load i32, ptr %6, align 4
  store i32 %56, ptr %12, align 4
  %57 = load ptr, ptr %4, align 8
  store ptr %57, ptr %13, align 8
  %58 = load ptr, ptr %5, align 8
  store ptr %58, ptr %14, align 8
  br label %59

59:                                               ; preds = %65, %55
  %60 = load ptr, ptr %14, align 8
  %61 = getelementptr inbounds i8, ptr %60, i32 1
  store ptr %61, ptr %14, align 8
  %62 = load i8, ptr %60, align 1
  %63 = load ptr, ptr %13, align 8
  %64 = getelementptr inbounds i8, ptr %63, i32 1
  store ptr %64, ptr %13, align 8
  store i8 %62, ptr %63, align 1
  br label %65

65:                                               ; preds = %59
  %66 = load i32, ptr %12, align 4
  %67 = add nsw i32 %66, -1
  store i32 %67, ptr %12, align 4
  %68 = icmp ne i32 %67, 0
  br i1 %68, label %59, label %69

69:                                               ; preds = %65
  br label %70

70:                                               ; preds = %17, %69, %54
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @fetch_name(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i64, align 8
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %11 = load i32, ptr %6, align 4
  %12 = icmp sle i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %3
  store i32 -22, ptr @err_code, align 4
  store i32 -99, ptr %4, align 4
  br label %45

14:                                               ; preds = %3
  %15 = load i32, ptr %7, align 4
  %16 = icmp eq i32 %15, 3
  br i1 %16, label %17, label %32

17:                                               ; preds = %14
  %18 = load i32, ptr %6, align 4
  %19 = icmp sle i32 %18, 14
  br i1 %19, label %20, label %32

20:                                               ; preds = %17
  store ptr @user_path, ptr %8, align 8
  store ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), ptr %9, align 8
  br label %21

21:                                               ; preds = %27, %20
  %22 = load ptr, ptr %9, align 8
  %23 = getelementptr inbounds i8, ptr %22, i32 1
  store ptr %23, ptr %9, align 8
  %24 = load i8, ptr %22, align 1
  %25 = load ptr, ptr %8, align 8
  %26 = getelementptr inbounds i8, ptr %25, i32 1
  store ptr %26, ptr %8, align 8
  store i8 %24, ptr %25, align 1
  br label %27

27:                                               ; preds = %21
  %28 = load i32, ptr %6, align 4
  %29 = add nsw i32 %28, -1
  store i32 %29, ptr %6, align 4
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %21, label %31

31:                                               ; preds = %27
  store i32 0, ptr %4, align 4
  br label %45

32:                                               ; preds = %17, %14
  %33 = load i32, ptr %6, align 4
  %34 = icmp sgt i32 %33, 255
  br i1 %34, label %35, label %36

35:                                               ; preds = %32
  store i32 -36, ptr @err_code, align 4
  store i32 -99, ptr %4, align 4
  br label %45

36:                                               ; preds = %32
  %37 = load ptr, ptr %5, align 8
  %38 = ptrtoint ptr %37 to i64
  store i64 %38, ptr %10, align 8
  %39 = load i32, ptr @who, align 4
  %40 = load i64, ptr %10, align 8
  %41 = load i32, ptr %6, align 4
  %42 = sext i32 %41 to i64
  %43 = call i32 (i32, i32, i64, i64, ptr, i32, ...) @rw_user(i32 noundef 1, i32 noundef %39, i64 noundef %40, i64 noundef %42, ptr noundef @user_path, i32 noundef 1)
  store i32 %43, ptr @err_code, align 4
  %44 = load i32, ptr @err_code, align 4
  store i32 %44, ptr %4, align 4
  br label %45

45:                                               ; preds = %36, %35, %31, %13
  %46 = load i32, ptr %4, align 4
  ret i32 %46
}

declare i32 @rw_user(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @no_sys() #0 {
  ret i32 -22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @panic(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr @panicking, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %16

8:                                                ; preds = %2
  store i32 1, ptr @panicking, align 4
  %9 = load ptr, ptr %3, align 8
  call void (ptr, ptr, ...) @printk(ptr noundef @.str.1, ptr noundef %9)
  %10 = load i32, ptr %4, align 4
  %11 = icmp ne i32 %10, 32768
  br i1 %11, label %12, label %14

12:                                               ; preds = %8
  %13 = load i32, ptr %4, align 4
  call void (ptr, i32, ...) @printk(ptr noundef @.str.2, i32 noundef %13)
  br label %14

14:                                               ; preds = %12, %8
  call void (ptr, ...) @printk(ptr noundef @.str.3)
  %15 = call i32 (...) @do_sync()
  call void (...) @sys_abort()
  br label %16

16:                                               ; preds = %14, %7
  ret void
}

declare void @printk(...) #1

declare i32 @do_sync(...) #1

declare void @sys_abort(...) #1

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
