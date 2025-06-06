; NOTE: Generated from src/fs/misc.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/misc.c'
source_filename = "src/fs/misc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.buf = type { %union.anon.0, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon.0 = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@fp = external global ptr, align 8
@.str = private unnamed_addr constant [36 x i8] c"do_fcntl: flag not yet implemented\0A\00", align 1
@boot_parameters = external global %struct.bparam_s, align 2
@inode = external global [32 x %struct.inode], align 16
@super_block = external global [5 x %struct.super_block], align 16
@buf = external global [30 x %struct.buf], align 16
@who = external global i32, align 4
@fproc = external global [32 x %struct.fproc], align 16
@susp_count = external global i32, align 4
@fs_call = external global i32, align 4
@dont_reply = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_dup() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %7 = and i32 %6, -65
  store i32 %7, ptr %2, align 4
  %8 = load i32, ptr %2, align 4
  %9 = call ptr (i32, ...) @get_filp(i32 noundef %8)
  store ptr %9, ptr %3, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %11, label %13

11:                                               ; preds = %0
  %12 = load i32, ptr @err_code, align 4
  store i32 %12, ptr %1, align 4
  br label %51

13:                                               ; preds = %0
  %14 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %15 = load i32, ptr %2, align 4
  %16 = icmp eq i32 %14, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %13
  %18 = call i32 (i32, i32, ptr, ptr, ...) @get_fd(i32 noundef 0, i32 noundef 0, ptr noundef getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), ptr noundef %4)
  store i32 %18, ptr %5, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %22

20:                                               ; preds = %17
  %21 = load i32, ptr %5, align 4
  store i32 %21, ptr %1, align 4
  br label %51

22:                                               ; preds = %17
  br label %39

23:                                               ; preds = %13
  %24 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %25 = icmp slt i32 %24, 0
  br i1 %25, label %29, label %26

26:                                               ; preds = %23
  %27 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %28 = icmp sge i32 %27, 20
  br i1 %28, label %29, label %30

29:                                               ; preds = %26, %23
  store i32 -9, ptr %1, align 4
  br label %51

30:                                               ; preds = %26
  %31 = load i32, ptr %2, align 4
  %32 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %33 = icmp eq i32 %31, %32
  br i1 %33, label %34, label %36

34:                                               ; preds = %30
  %35 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %35, ptr %1, align 4
  br label %51

36:                                               ; preds = %30
  %37 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %37, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %38 = call i32 (...) @do_close()
  br label %39

39:                                               ; preds = %36, %22
  %40 = load ptr, ptr %3, align 8
  %41 = getelementptr inbounds %struct.filp, ptr %40, i32 0, i32 2
  %42 = load i32, ptr %41, align 8
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %41, align 8
  %44 = load ptr, ptr %3, align 8
  %45 = load ptr, ptr @fp, align 8
  %46 = getelementptr inbounds %struct.fproc, ptr %45, i32 0, i32 3
  %47 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [20 x ptr], ptr %46, i64 0, i64 %48
  store ptr %44, ptr %49, align 8
  %50 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %50, ptr %1, align 4
  br label %51

51:                                               ; preds = %39, %34, %29, %20, %11
  %52 = load i32, ptr %1, align 4
  ret i32 %52
}

declare ptr @get_filp(...) #1

declare i32 @get_fd(...) #1

declare i32 @do_close(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_fcntl() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %8 = call ptr (i32, ...) @get_filp(i32 noundef %7)
  store ptr %8, ptr %2, align 8
  %9 = icmp eq ptr %8, null
  br i1 %9, label %10, label %12

10:                                               ; preds = %0
  %11 = load i32, ptr @err_code, align 4
  store i32 %11, ptr %1, align 4
  br label %60

12:                                               ; preds = %0
  %13 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  switch i32 %13, label %59 [
    i32 0, label %14
    i32 1, label %39
    i32 2, label %40
    i32 3, label %41
    i32 4, label %45
    i32 5, label %58
    i32 6, label %58
    i32 7, label %58
  ]

14:                                               ; preds = %12
  %15 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %16 = icmp slt i32 %15, 0
  br i1 %16, label %20, label %17

17:                                               ; preds = %14
  %18 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %19 = icmp sge i32 %18, 20
  br i1 %19, label %20, label %21

20:                                               ; preds = %17, %14
  br label %59

21:                                               ; preds = %17
  %22 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %23 = call i32 (i32, i32, ptr, ptr, ...) @get_fd(i32 noundef %22, i32 noundef 0, ptr noundef %3, ptr noundef %6)
  store i32 %23, ptr %4, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %21
  %26 = load i32, ptr %4, align 4
  store i32 %26, ptr %1, align 4
  br label %60

27:                                               ; preds = %21
  %28 = load ptr, ptr %2, align 8
  %29 = getelementptr inbounds %struct.filp, ptr %28, i32 0, i32 2
  %30 = load i32, ptr %29, align 8
  %31 = add nsw i32 %30, 1
  store i32 %31, ptr %29, align 8
  %32 = load ptr, ptr %2, align 8
  %33 = load ptr, ptr @fp, align 8
  %34 = getelementptr inbounds %struct.fproc, ptr %33, i32 0, i32 3
  %35 = load i32, ptr %3, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [20 x ptr], ptr %34, i64 0, i64 %36
  store ptr %32, ptr %37, align 8
  %38 = load i32, ptr %3, align 4
  store i32 %38, ptr %1, align 4
  br label %60

39:                                               ; preds = %12
  br label %59

40:                                               ; preds = %12
  br label %59

41:                                               ; preds = %12
  %42 = load ptr, ptr %2, align 8
  %43 = getelementptr inbounds %struct.filp, ptr %42, i32 0, i32 1
  %44 = load i32, ptr %43, align 4
  store i32 %44, ptr %1, align 4
  br label %60

45:                                               ; preds = %12
  store i32 3072, ptr %5, align 4
  %46 = load ptr, ptr %2, align 8
  %47 = getelementptr inbounds %struct.filp, ptr %46, i32 0, i32 1
  %48 = load i32, ptr %47, align 4
  %49 = load i32, ptr %5, align 4
  %50 = xor i32 %49, -1
  %51 = and i32 %48, %50
  %52 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %53 = load i32, ptr %5, align 4
  %54 = and i32 %52, %53
  %55 = or i32 %51, %54
  %56 = load ptr, ptr %2, align 8
  %57 = getelementptr inbounds %struct.filp, ptr %56, i32 0, i32 1
  store i32 %55, ptr %57, align 4
  store i32 0, ptr %1, align 4
  br label %60

58:                                               ; preds = %12, %12, %12
  call void (ptr, ...) @printk(ptr noundef @.str)
  br label %59

59:                                               ; preds = %58, %12, %40, %39, %20
  store i32 -22, ptr %1, align 4
  br label %60

60:                                               ; preds = %59, %45, %41, %27, %25, %10
  %61 = load i32, ptr %1, align 4
  ret i32 %61
}

declare void @printk(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_sync() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = load i16, ptr @boot_parameters, align 2
  %5 = zext i16 %4 to i32
  %6 = call ptr (i32, ...) @get_super(i32 noundef %5)
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %9, label %22

9:                                                ; preds = %0
  %10 = call i64 (...) @clock_time()
  %11 = load ptr, ptr %3, align 8
  %12 = getelementptr inbounds %struct.super_block, ptr %11, i32 0, i32 13
  store i64 %10, ptr %12, align 8
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.super_block, ptr %13, i32 0, i32 14
  %15 = load i8, ptr %14, align 8
  %16 = sext i8 %15 to i32
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %21

18:                                               ; preds = %9
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.super_block, ptr %19, i32 0, i32 15
  store i8 1, ptr %20, align 1
  br label %21

21:                                               ; preds = %18, %9
  br label %22

22:                                               ; preds = %21, %0
  store ptr @inode, ptr %1, align 8
  br label %23

23:                                               ; preds = %41, %22
  %24 = load ptr, ptr %1, align 8
  %25 = icmp ult ptr %24, getelementptr inbounds ([32 x %struct.inode], ptr @inode, i64 0, i64 32)
  br i1 %25, label %26, label %44

26:                                               ; preds = %23
  %27 = load ptr, ptr %1, align 8
  %28 = getelementptr inbounds %struct.inode, ptr %27, i32 0, i32 11
  %29 = load i16, ptr %28, align 4
  %30 = sext i16 %29 to i32
  %31 = icmp sgt i32 %30, 0
  br i1 %31, label %32, label %40

32:                                               ; preds = %26
  %33 = load ptr, ptr %1, align 8
  %34 = getelementptr inbounds %struct.inode, ptr %33, i32 0, i32 12
  %35 = load i8, ptr %34, align 2
  %36 = sext i8 %35 to i32
  %37 = icmp eq i32 %36, 1
  br i1 %37, label %38, label %40

38:                                               ; preds = %32
  %39 = load ptr, ptr %1, align 8
  call void (ptr, i32, ...) @rw_inode(ptr noundef %39, i32 noundef 1)
  br label %40

40:                                               ; preds = %38, %32, %26
  br label %41

41:                                               ; preds = %40
  %42 = load ptr, ptr %1, align 8
  %43 = getelementptr inbounds %struct.inode, ptr %42, i32 1
  store ptr %43, ptr %1, align 8
  br label %23

44:                                               ; preds = %23
  store ptr @super_block, ptr %3, align 8
  br label %45

45:                                               ; preds = %63, %44
  %46 = load ptr, ptr %3, align 8
  %47 = icmp ult ptr %46, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %47, label %48, label %66

48:                                               ; preds = %45
  %49 = load ptr, ptr %3, align 8
  %50 = getelementptr inbounds %struct.super_block, ptr %49, i32 0, i32 10
  %51 = load i16, ptr %50, align 8
  %52 = zext i16 %51 to i32
  %53 = icmp ne i32 %52, 65535
  br i1 %53, label %54, label %62

54:                                               ; preds = %48
  %55 = load ptr, ptr %3, align 8
  %56 = getelementptr inbounds %struct.super_block, ptr %55, i32 0, i32 15
  %57 = load i8, ptr %56, align 1
  %58 = sext i8 %57 to i32
  %59 = icmp eq i32 %58, 1
  br i1 %59, label %60, label %62

60:                                               ; preds = %54
  %61 = load ptr, ptr %3, align 8
  call void (ptr, i32, ...) @rw_super(ptr noundef %61, i32 noundef 1)
  br label %62

62:                                               ; preds = %60, %54, %48
  br label %63

63:                                               ; preds = %62
  %64 = load ptr, ptr %3, align 8
  %65 = getelementptr inbounds %struct.super_block, ptr %64, i32 1
  store ptr %65, ptr %3, align 8
  br label %45

66:                                               ; preds = %45
  store ptr @buf, ptr %2, align 8
  br label %67

67:                                               ; preds = %88, %66
  %68 = load ptr, ptr %2, align 8
  %69 = icmp ult ptr %68, getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 30)
  br i1 %69, label %70, label %91

70:                                               ; preds = %67
  %71 = load ptr, ptr %2, align 8
  %72 = getelementptr inbounds %struct.buf, ptr %71, i32 0, i32 5
  %73 = load i16, ptr %72, align 2
  %74 = zext i16 %73 to i32
  %75 = icmp ne i32 %74, 65535
  br i1 %75, label %76, label %87

76:                                               ; preds = %70
  %77 = load ptr, ptr %2, align 8
  %78 = getelementptr inbounds %struct.buf, ptr %77, i32 0, i32 6
  %79 = load i8, ptr %78, align 4
  %80 = sext i8 %79 to i32
  %81 = icmp eq i32 %80, 1
  br i1 %81, label %82, label %87

82:                                               ; preds = %76
  %83 = load ptr, ptr %2, align 8
  %84 = getelementptr inbounds %struct.buf, ptr %83, i32 0, i32 5
  %85 = load i16, ptr %84, align 2
  %86 = zext i16 %85 to i32
  call void (i32, ...) @flushall(i32 noundef %86)
  br label %87

87:                                               ; preds = %82, %76, %70
  br label %88

88:                                               ; preds = %87
  %89 = load ptr, ptr %2, align 8
  %90 = getelementptr inbounds %struct.buf, ptr %89, i32 1
  store ptr %90, ptr %2, align 8
  br label %67

91:                                               ; preds = %67
  ret i32 0
}

declare ptr @get_super(...) #1

declare i64 @clock_time(...) #1

declare void @rw_inode(...) #1

declare void @rw_super(...) #1

declare void @flushall(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_fork() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = load i32, ptr @who, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %0
  store i32 -99, ptr %1, align 4
  br label %72

9:                                                ; preds = %0
  %10 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %11
  store ptr %12, ptr %3, align 8
  %13 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %14
  store ptr %15, ptr %4, align 8
  store i32 224, ptr %5, align 4
  br label %16

16:                                               ; preds = %20, %9
  %17 = load i32, ptr %5, align 4
  %18 = add nsw i32 %17, -1
  store i32 %18, ptr %5, align 4
  %19 = icmp ne i32 %17, 0
  br i1 %19, label %20, label %26

20:                                               ; preds = %16
  %21 = load ptr, ptr %3, align 8
  %22 = getelementptr inbounds i8, ptr %21, i32 1
  store ptr %22, ptr %3, align 8
  %23 = load i8, ptr %21, align 1
  %24 = load ptr, ptr %4, align 8
  %25 = getelementptr inbounds i8, ptr %24, i32 1
  store ptr %25, ptr %4, align 8
  store i8 %23, ptr %24, align 1
  br label %16

26:                                               ; preds = %16
  %27 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %28
  store ptr %29, ptr %2, align 8
  store i32 0, ptr %5, align 4
  br label %30

30:                                               ; preds = %52, %26
  %31 = load i32, ptr %5, align 4
  %32 = icmp slt i32 %31, 20
  br i1 %32, label %33, label %55

33:                                               ; preds = %30
  %34 = load ptr, ptr %2, align 8
  %35 = getelementptr inbounds %struct.fproc, ptr %34, i32 0, i32 3
  %36 = load i32, ptr %5, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [20 x ptr], ptr %35, i64 0, i64 %37
  %39 = load ptr, ptr %38, align 8
  %40 = icmp ne ptr %39, null
  br i1 %40, label %41, label %51

41:                                               ; preds = %33
  %42 = load ptr, ptr %2, align 8
  %43 = getelementptr inbounds %struct.fproc, ptr %42, i32 0, i32 3
  %44 = load i32, ptr %5, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds [20 x ptr], ptr %43, i64 0, i64 %45
  %47 = load ptr, ptr %46, align 8
  %48 = getelementptr inbounds %struct.filp, ptr %47, i32 0, i32 2
  %49 = load i32, ptr %48, align 8
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %48, align 8
  br label %51

51:                                               ; preds = %41, %33
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %5, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %5, align 4
  br label %30

55:                                               ; preds = %30
  %56 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %57 = load ptr, ptr %2, align 8
  %58 = getelementptr inbounds %struct.fproc, ptr %57, i32 0, i32 15
  store i32 %56, ptr %58, align 8
  %59 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %60 = icmp eq i32 %59, 2
  br i1 %60, label %61, label %65

61:                                               ; preds = %55
  %62 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %63 = load ptr, ptr %2, align 8
  %64 = getelementptr inbounds %struct.fproc, ptr %63, i32 0, i32 16
  store i32 %62, ptr %64, align 4
  br label %65

65:                                               ; preds = %61, %55
  %66 = load ptr, ptr %2, align 8
  %67 = getelementptr inbounds %struct.fproc, ptr %66, i32 0, i32 2
  %68 = load ptr, ptr %67, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %68)
  %69 = load ptr, ptr %2, align 8
  %70 = getelementptr inbounds %struct.fproc, ptr %69, i32 0, i32 1
  %71 = load ptr, ptr %70, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %71)
  store i32 0, ptr %1, align 4
  br label %72

72:                                               ; preds = %65, %8
  %73 = load i32, ptr %1, align 4
  ret i32 %73
}

declare void @dup_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_exit() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = load i32, ptr @who, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %0
  store i32 -99, ptr %1, align 4
  br label %74

8:                                                ; preds = %0
  %9 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %10
  store ptr %11, ptr @fp, align 8
  %12 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  store i32 %12, ptr %3, align 4
  %13 = load ptr, ptr @fp, align 8
  %14 = getelementptr inbounds %struct.fproc, ptr %13, i32 0, i32 15
  %15 = load i32, ptr %14, align 8
  %16 = load ptr, ptr @fp, align 8
  %17 = getelementptr inbounds %struct.fproc, ptr %16, i32 0, i32 16
  %18 = load i32, ptr %17, align 4
  %19 = icmp eq i32 %15, %18
  br i1 %19, label %20, label %28

20:                                               ; preds = %8
  %21 = load ptr, ptr @fp, align 8
  %22 = getelementptr inbounds %struct.fproc, ptr %21, i32 0, i32 8
  %23 = load i16, ptr %22, align 2
  %24 = zext i16 %23 to i32
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %28

26:                                               ; preds = %20
  %27 = call i32 (...) @tty_exit()
  br label %28

28:                                               ; preds = %26, %20, %8
  %29 = load ptr, ptr @fp, align 8
  %30 = getelementptr inbounds %struct.fproc, ptr %29, i32 0, i32 12
  %31 = load i8, ptr %30, align 4
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 1
  br i1 %33, label %34, label %53

34:                                               ; preds = %28
  %35 = load ptr, ptr @fp, align 8
  %36 = getelementptr inbounds %struct.fproc, ptr %35, i32 0, i32 14
  %37 = load i8, ptr %36, align 2
  %38 = sext i8 %37 to i32
  %39 = sub nsw i32 0, %38
  store i32 %39, ptr %4, align 4
  %40 = load i32, ptr %4, align 4
  %41 = icmp eq i32 %40, -10
  br i1 %41, label %45, label %42

42:                                               ; preds = %34
  %43 = load i32, ptr %4, align 4
  %44 = icmp eq i32 %43, -11
  br i1 %44, label %45, label %48

45:                                               ; preds = %42, %34
  %46 = load i32, ptr @susp_count, align 4
  %47 = add nsw i32 %46, -1
  store i32 %47, ptr @susp_count, align 4
  br label %48

48:                                               ; preds = %45, %42
  %49 = load i32, ptr %3, align 4
  store i32 %49, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %50 = call i32 (...) @do_unpause()
  %51 = load ptr, ptr @fp, align 8
  %52 = getelementptr inbounds %struct.fproc, ptr %51, i32 0, i32 12
  store i8 0, ptr %52, align 4
  br label %53

53:                                               ; preds = %48, %28
  store i32 0, ptr %2, align 4
  br label %54

54:                                               ; preds = %60, %53
  %55 = load i32, ptr %2, align 4
  %56 = icmp slt i32 %55, 20
  br i1 %56, label %57, label %63

57:                                               ; preds = %54
  %58 = load i32, ptr %2, align 4
  store i32 %58, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %59 = call i32 (...) @do_close()
  br label %60

60:                                               ; preds = %57
  %61 = load i32, ptr %2, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %2, align 4
  br label %54

63:                                               ; preds = %54
  %64 = load ptr, ptr @fp, align 8
  %65 = getelementptr inbounds %struct.fproc, ptr %64, i32 0, i32 2
  %66 = load ptr, ptr %65, align 8
  call void (ptr, ...) @put_inode(ptr noundef %66)
  %67 = load ptr, ptr @fp, align 8
  %68 = getelementptr inbounds %struct.fproc, ptr %67, i32 0, i32 1
  %69 = load ptr, ptr %68, align 8
  call void (ptr, ...) @put_inode(ptr noundef %69)
  %70 = load ptr, ptr @fp, align 8
  %71 = getelementptr inbounds %struct.fproc, ptr %70, i32 0, i32 2
  store ptr null, ptr %71, align 8
  %72 = load ptr, ptr @fp, align 8
  %73 = getelementptr inbounds %struct.fproc, ptr %72, i32 0, i32 1
  store ptr null, ptr %73, align 8
  store i32 0, ptr %1, align 4
  br label %74

74:                                               ; preds = %63, %7
  %75 = load i32, ptr %1, align 4
  ret i32 %75
}

declare i32 @tty_exit(...) #1

declare i32 @do_unpause(...) #1

declare void @put_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_set() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = load i32, ptr @who, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 -99, ptr %1, align 4
  br label %34

6:                                                ; preds = %0
  %7 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %8
  store ptr %9, ptr %2, align 8
  %10 = load i32, ptr @fs_call, align 4
  %11 = icmp eq i32 %10, 23
  br i1 %11, label %12, label %21

12:                                               ; preds = %6
  %13 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %14 = trunc i32 %13 to i16
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %struct.fproc, ptr %15, i32 0, i32 4
  store i16 %14, ptr %16, align 8
  %17 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %18 = trunc i32 %17 to i16
  %19 = load ptr, ptr %2, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 5
  store i16 %18, ptr %20, align 2
  br label %21

21:                                               ; preds = %12, %6
  %22 = load i32, ptr @fs_call, align 4
  %23 = icmp eq i32 %22, 46
  br i1 %23, label %24, label %33

24:                                               ; preds = %21
  %25 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %26 = trunc i32 %25 to i8
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.fproc, ptr %27, i32 0, i32 7
  store i8 %26, ptr %28, align 1
  %29 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %30 = trunc i32 %29 to i8
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.fproc, ptr %31, i32 0, i32 6
  store i8 %30, ptr %32, align 4
  br label %33

33:                                               ; preds = %24, %21
  store i32 0, ptr %1, align 4
  br label %34

34:                                               ; preds = %33, %5
  %35 = load i32, ptr %1, align 4
  ret i32 %35
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_revive() #0 {
  %1 = alloca i32, align 4
  %2 = load i32, ptr @who, align 4
  %3 = icmp sgt i32 %2, 0
  br i1 %3, label %4, label %5

4:                                                ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %8

5:                                                ; preds = %0
  %6 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %7 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  call void (i32, i32, ...) @revive(i32 noundef %6, i32 noundef %7)
  store i32 1, ptr @dont_reply, align 4
  store i32 0, ptr %1, align 4
  br label %8

8:                                                ; preds = %5, %4
  %9 = load i32, ptr %1, align 4
  ret i32 %9
}

declare void @revive(...) #1

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
