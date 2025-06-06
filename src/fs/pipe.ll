; NOTE: Generated from src/fs/pipe.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/pipe.c'
source_filename = "src/fs/pipe.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.dmap = type { ptr, ptr, ptr, i32 }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@fp = external global ptr, align 8
@err_code = external global i32, align 4
@m1 = external global %struct.message, align 8
@susp_count = external global i32, align 4
@fproc = external global [32 x %struct.fproc], align 16
@m = external global %struct.message, align 8
@fs_call = external global i32, align 4
@dont_reply = external global i32, align 4
@.str = private unnamed_addr constant [11 x i8] c"revive err\00", align 1
@reviving = external global i32, align 4
@who = external global i32, align 4
@.str.1 = private unnamed_addr constant [14 x i8] c"unpause err 1\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"unpause err 2\00", align 1
@mess = internal global %struct.message zeroinitializer, align 8
@dmap = external global [0 x %struct.dmap], align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_pipe() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca [2 x i32], align 4
  %9 = load ptr, ptr @fp, align 8
  store ptr %9, ptr %2, align 8
  %10 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 0
  %11 = call i32 (i32, i32, ptr, ptr, ...) @get_fd(i32 noundef 0, i32 noundef 4, ptr noundef %10, ptr noundef %6)
  store i32 %11, ptr %4, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %0
  %14 = load i32, ptr %4, align 4
  store i32 %14, ptr %1, align 4
  br label %90

15:                                               ; preds = %0
  %16 = load ptr, ptr %6, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = getelementptr inbounds %struct.fproc, ptr %17, i32 0, i32 3
  %19 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 0
  %20 = load i32, ptr %19, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [20 x ptr], ptr %18, i64 0, i64 %21
  store ptr %16, ptr %22, align 8
  %23 = load ptr, ptr %6, align 8
  %24 = getelementptr inbounds %struct.filp, ptr %23, i32 0, i32 2
  store i32 1, ptr %24, align 8
  %25 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 1
  %26 = call i32 (i32, i32, ptr, ptr, ...) @get_fd(i32 noundef 0, i32 noundef 2, ptr noundef %25, ptr noundef %7)
  store i32 %26, ptr %4, align 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %38

28:                                               ; preds = %15
  %29 = load ptr, ptr %2, align 8
  %30 = getelementptr inbounds %struct.fproc, ptr %29, i32 0, i32 3
  %31 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 0
  %32 = load i32, ptr %31, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [20 x ptr], ptr %30, i64 0, i64 %33
  store ptr null, ptr %34, align 8
  %35 = load ptr, ptr %6, align 8
  %36 = getelementptr inbounds %struct.filp, ptr %35, i32 0, i32 2
  store i32 0, ptr %36, align 8
  %37 = load i32, ptr %4, align 4
  store i32 %37, ptr %1, align 4
  br label %90

38:                                               ; preds = %15
  %39 = load ptr, ptr %7, align 8
  %40 = load ptr, ptr %2, align 8
  %41 = getelementptr inbounds %struct.fproc, ptr %40, i32 0, i32 3
  %42 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 1
  %43 = load i32, ptr %42, align 4
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds [20 x ptr], ptr %41, i64 0, i64 %44
  store ptr %39, ptr %45, align 8
  %46 = load ptr, ptr %7, align 8
  %47 = getelementptr inbounds %struct.filp, ptr %46, i32 0, i32 2
  store i32 1, ptr %47, align 8
  %48 = load ptr, ptr %2, align 8
  %49 = getelementptr inbounds %struct.fproc, ptr %48, i32 0, i32 1
  %50 = load ptr, ptr %49, align 8
  %51 = getelementptr inbounds %struct.inode, ptr %50, i32 0, i32 9
  %52 = load i16, ptr %51, align 8
  store i16 %52, ptr %5, align 2
  %53 = load i16, ptr %5, align 2
  %54 = zext i16 %53 to i32
  %55 = call ptr (i32, i32, ...) @alloc_inode(i32 noundef %54, i32 noundef 32768)
  store ptr %55, ptr %3, align 8
  %56 = icmp eq ptr %55, null
  br i1 %56, label %57, label %75

57:                                               ; preds = %38
  %58 = load ptr, ptr %2, align 8
  %59 = getelementptr inbounds %struct.fproc, ptr %58, i32 0, i32 3
  %60 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 0
  %61 = load i32, ptr %60, align 4
  %62 = sext i32 %61 to i64
  %63 = getelementptr inbounds [20 x ptr], ptr %59, i64 0, i64 %62
  store ptr null, ptr %63, align 8
  %64 = load ptr, ptr %6, align 8
  %65 = getelementptr inbounds %struct.filp, ptr %64, i32 0, i32 2
  store i32 0, ptr %65, align 8
  %66 = load ptr, ptr %2, align 8
  %67 = getelementptr inbounds %struct.fproc, ptr %66, i32 0, i32 3
  %68 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 1
  %69 = load i32, ptr %68, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds [20 x ptr], ptr %67, i64 0, i64 %70
  store ptr null, ptr %71, align 8
  %72 = load ptr, ptr %7, align 8
  %73 = getelementptr inbounds %struct.filp, ptr %72, i32 0, i32 2
  store i32 0, ptr %73, align 8
  %74 = load i32, ptr @err_code, align 4
  store i32 %74, ptr %1, align 4
  br label %90

75:                                               ; preds = %38
  %76 = load ptr, ptr %3, align 8
  %77 = getelementptr inbounds %struct.inode, ptr %76, i32 0, i32 13
  store i8 1, ptr %77, align 1
  %78 = load ptr, ptr %3, align 8
  %79 = load ptr, ptr %6, align 8
  %80 = getelementptr inbounds %struct.filp, ptr %79, i32 0, i32 3
  store ptr %78, ptr %80, align 8
  %81 = load ptr, ptr %3, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %81)
  %82 = load ptr, ptr %3, align 8
  %83 = load ptr, ptr %7, align 8
  %84 = getelementptr inbounds %struct.filp, ptr %83, i32 0, i32 3
  store ptr %82, ptr %84, align 8
  %85 = load ptr, ptr %3, align 8
  call void (ptr, i32, ...) @rw_inode(ptr noundef %85, i32 noundef 1)
  %86 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 0
  %87 = load i32, ptr %86, align 4
  store i32 %87, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  %88 = getelementptr inbounds [2 x i32], ptr %8, i64 0, i64 1
  %89 = load i32, ptr %88, align 4
  store i32 %89, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 0, ptr %1, align 4
  br label %90

90:                                               ; preds = %75, %57, %28, %13
  %91 = load i32, ptr %1, align 4
  ret i32 %91
}

declare i32 @get_fd(...) #1

declare ptr @alloc_inode(...) #1

declare void @dup_inode(...) #1

declare void @rw_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pipe_check(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i64 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %7, align 8
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store i64 %4, ptr %11, align 8
  store i32 0, ptr %12, align 4
  %13 = load i32, ptr %8, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %41

15:                                               ; preds = %5
  %16 = load i64, ptr %11, align 8
  %17 = load ptr, ptr %7, align 8
  %18 = getelementptr inbounds %struct.inode, ptr %17, i32 0, i32 2
  %19 = load i64, ptr %18, align 8
  %20 = icmp sge i64 %16, %19
  br i1 %20, label %21, label %40

21:                                               ; preds = %15
  %22 = load ptr, ptr %7, align 8
  %23 = call ptr (ptr, i32, ...) @find_filp(ptr noundef %22, i32 noundef 2)
  %24 = icmp ne ptr %23, null
  br i1 %24, label %25, label %38

25:                                               ; preds = %21
  %26 = load i32, ptr %9, align 4
  %27 = and i32 %26, 2048
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %25
  store i32 -11, ptr %12, align 4
  br label %31

30:                                               ; preds = %25
  call void @suspend(i32 noundef -10)
  br label %31

31:                                               ; preds = %30, %29
  %32 = load i32, ptr @susp_count, align 4
  %33 = icmp sgt i32 %32, 0
  br i1 %33, label %34, label %37

34:                                               ; preds = %31
  %35 = load ptr, ptr %7, align 8
  %36 = load i32, ptr @susp_count, align 4
  call void @release(ptr noundef %35, i32 noundef 4, i32 noundef %36)
  br label %37

37:                                               ; preds = %34, %31
  br label %38

38:                                               ; preds = %37, %21
  %39 = load i32, ptr %12, align 4
  store i32 %39, ptr %6, align 4
  br label %75

40:                                               ; preds = %15
  br label %74

41:                                               ; preds = %5
  %42 = load i32, ptr %10, align 4
  %43 = icmp sgt i32 %42, 7168
  br i1 %43, label %44, label %45

44:                                               ; preds = %41
  store i32 -27, ptr %6, align 4
  br label %75

45:                                               ; preds = %41
  %46 = load ptr, ptr %7, align 8
  %47 = call ptr (ptr, i32, ...) @find_filp(ptr noundef %46, i32 noundef 4)
  %48 = icmp eq ptr %47, null
  br i1 %48, label %49, label %55

49:                                               ; preds = %45
  %50 = load ptr, ptr @fp, align 8
  %51 = ptrtoint ptr %50 to i64
  %52 = sub i64 %51, ptrtoint (ptr @fproc to i64)
  %53 = sdiv exact i64 %52, 224
  %54 = trunc i64 %53 to i32
  call void (i32, i32, ...) @sys_kill(i32 noundef %54, i32 noundef 13)
  store i32 -32, ptr %6, align 4
  br label %75

55:                                               ; preds = %45
  %56 = load i64, ptr %11, align 8
  %57 = load i32, ptr %10, align 4
  %58 = sext i32 %57 to i64
  %59 = add nsw i64 %56, %58
  %60 = icmp sgt i64 %59, 7168
  br i1 %60, label %61, label %67

61:                                               ; preds = %55
  %62 = load i32, ptr %9, align 4
  %63 = and i32 %62, 2048
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %65, label %66

65:                                               ; preds = %61
  store i32 -11, ptr %6, align 4
  br label %75

66:                                               ; preds = %61
  call void @suspend(i32 noundef -10)
  store i32 0, ptr %6, align 4
  br label %75

67:                                               ; preds = %55
  %68 = load i64, ptr %11, align 8
  %69 = icmp eq i64 %68, 0
  br i1 %69, label %70, label %73

70:                                               ; preds = %67
  %71 = load ptr, ptr %7, align 8
  %72 = load i32, ptr @susp_count, align 4
  call void @release(ptr noundef %71, i32 noundef 3, i32 noundef %72)
  br label %73

73:                                               ; preds = %70, %67
  br label %74

74:                                               ; preds = %73, %40
  store i32 1, ptr %6, align 4
  br label %75

75:                                               ; preds = %74, %66, %65, %49, %44, %38
  %76 = load i32, ptr %6, align 4
  ret i32 %76
}

declare ptr @find_filp(...) #1

declare void @sys_kill(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @suspend(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, -10
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = icmp eq i32 %6, -11
  br i1 %7, label %8, label %11

8:                                                ; preds = %5, %1
  %9 = load i32, ptr @susp_count, align 4
  %10 = add nsw i32 %9, 1
  store i32 %10, ptr @susp_count, align 4
  br label %11

11:                                               ; preds = %8, %5
  %12 = load ptr, ptr @fp, align 8
  %13 = getelementptr inbounds %struct.fproc, ptr %12, i32 0, i32 12
  store i8 1, ptr %13, align 4
  %14 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %15 = shl i32 %14, 8
  %16 = load i32, ptr @fs_call, align 4
  %17 = or i32 %15, %16
  %18 = load ptr, ptr @fp, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 9
  store i32 %17, ptr %19, align 8
  %20 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %21 = load ptr, ptr @fp, align 8
  %22 = getelementptr inbounds %struct.fproc, ptr %21, i32 0, i32 10
  store ptr %20, ptr %22, align 8
  %23 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %24 = load ptr, ptr @fp, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 11
  store i32 %23, ptr %25, align 8
  %26 = load i32, ptr %2, align 4
  %27 = sub nsw i32 0, %26
  %28 = trunc i32 %27 to i8
  %29 = load ptr, ptr @fp, align 8
  %30 = getelementptr inbounds %struct.fproc, ptr %29, i32 0, i32 14
  store i8 %28, ptr %30, align 2
  store i32 1, ptr @dont_reply, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @release(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store ptr @fproc, ptr %7, align 8
  br label %8

8:                                                ; preds = %58, %3
  %9 = load ptr, ptr %7, align 8
  %10 = icmp ult ptr %9, getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 32)
  br i1 %10, label %11, label %61

11:                                               ; preds = %8
  %12 = load ptr, ptr %7, align 8
  %13 = getelementptr inbounds %struct.fproc, ptr %12, i32 0, i32 12
  %14 = load i8, ptr %13, align 4
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %57

17:                                               ; preds = %11
  %18 = load ptr, ptr %7, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 13
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %57

23:                                               ; preds = %17
  %24 = load ptr, ptr %7, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 9
  %26 = load i32, ptr %25, align 8
  %27 = and i32 %26, 255
  %28 = load i32, ptr %5, align 4
  %29 = icmp eq i32 %27, %28
  br i1 %29, label %30, label %57

30:                                               ; preds = %23
  %31 = load ptr, ptr %7, align 8
  %32 = getelementptr inbounds %struct.fproc, ptr %31, i32 0, i32 3
  %33 = load ptr, ptr %7, align 8
  %34 = getelementptr inbounds %struct.fproc, ptr %33, i32 0, i32 9
  %35 = load i32, ptr %34, align 8
  %36 = ashr i32 %35, 8
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [20 x ptr], ptr %32, i64 0, i64 %37
  %39 = load ptr, ptr %38, align 8
  %40 = getelementptr inbounds %struct.filp, ptr %39, i32 0, i32 3
  %41 = load ptr, ptr %40, align 8
  %42 = load ptr, ptr %4, align 8
  %43 = icmp eq ptr %41, %42
  br i1 %43, label %44, label %57

44:                                               ; preds = %30
  %45 = load ptr, ptr %7, align 8
  %46 = ptrtoint ptr %45 to i64
  %47 = sub i64 %46, ptrtoint (ptr @fproc to i64)
  %48 = sdiv exact i64 %47, 224
  %49 = trunc i64 %48 to i32
  call void @revive(i32 noundef %49, i32 noundef 0)
  %50 = load i32, ptr @susp_count, align 4
  %51 = add nsw i32 %50, -1
  store i32 %51, ptr @susp_count, align 4
  %52 = load i32, ptr %6, align 4
  %53 = add nsw i32 %52, -1
  store i32 %53, ptr %6, align 4
  %54 = icmp eq i32 %53, 0
  br i1 %54, label %55, label %56

55:                                               ; preds = %44
  br label %61

56:                                               ; preds = %44
  br label %57

57:                                               ; preds = %56, %30, %23, %17, %11
  br label %58

58:                                               ; preds = %57
  %59 = load ptr, ptr %7, align 8
  %60 = getelementptr inbounds %struct.fproc, ptr %59, i32 1
  store ptr %60, ptr %7, align 8
  br label %8

61:                                               ; preds = %55, %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @revive(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %12, label %9

9:                                                ; preds = %2
  %10 = load i32, ptr %3, align 4
  %11 = icmp sge i32 %10, 32
  br i1 %11, label %12, label %14

12:                                               ; preds = %9, %2
  %13 = load i32, ptr %3, align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef %13)
  br label %14

14:                                               ; preds = %12, %9
  %15 = load i32, ptr %3, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %16
  store ptr %17, ptr %5, align 8
  %18 = load ptr, ptr %5, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 12
  %20 = load i8, ptr %19, align 4
  %21 = sext i8 %20 to i32
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %29, label %23

23:                                               ; preds = %14
  %24 = load ptr, ptr %5, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 13
  %26 = load i8, ptr %25, align 1
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 1
  br i1 %28, label %29, label %30

29:                                               ; preds = %23, %14
  br label %61

30:                                               ; preds = %23
  %31 = load ptr, ptr %5, align 8
  %32 = getelementptr inbounds %struct.fproc, ptr %31, i32 0, i32 14
  %33 = load i8, ptr %32, align 2
  %34 = sext i8 %33 to i32
  %35 = sub nsw i32 0, %34
  store i32 %35, ptr %6, align 4
  %36 = load i32, ptr %6, align 4
  %37 = icmp eq i32 %36, -10
  br i1 %37, label %38, label %43

38:                                               ; preds = %30
  %39 = load ptr, ptr %5, align 8
  %40 = getelementptr inbounds %struct.fproc, ptr %39, i32 0, i32 13
  store i8 1, ptr %40, align 1
  %41 = load i32, ptr @reviving, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, ptr @reviving, align 4
  br label %61

43:                                               ; preds = %30
  %44 = load ptr, ptr %5, align 8
  %45 = getelementptr inbounds %struct.fproc, ptr %44, i32 0, i32 12
  store i8 0, ptr %45, align 4
  %46 = load i32, ptr %6, align 4
  %47 = icmp eq i32 %46, -11
  br i1 %47, label %48, label %54

48:                                               ; preds = %43
  %49 = load i32, ptr %3, align 4
  %50 = load ptr, ptr %5, align 8
  %51 = getelementptr inbounds %struct.fproc, ptr %50, i32 0, i32 9
  %52 = load i32, ptr %51, align 8
  %53 = ashr i32 %52, 8
  call void (i32, i32, ...) @reply(i32 noundef %49, i32 noundef %53)
  br label %60

54:                                               ; preds = %43
  %55 = load i32, ptr %4, align 4
  %56 = load ptr, ptr %5, align 8
  %57 = getelementptr inbounds %struct.fproc, ptr %56, i32 0, i32 11
  store i32 %55, ptr %57, align 8
  %58 = load i32, ptr %3, align 4
  %59 = load i32, ptr %4, align 4
  call void (i32, i32, ...) @reply(i32 noundef %58, i32 noundef %59)
  br label %60

60:                                               ; preds = %54, %48
  br label %61

61:                                               ; preds = %29, %60, %38
  ret void
}

declare void @panic(...) #1

declare void @reply(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_unpause() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = load i32, ptr @who, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %92

11:                                               ; preds = %0
  %12 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  store i32 %12, ptr %3, align 4
  %13 = load i32, ptr %3, align 4
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %18, label %15

15:                                               ; preds = %11
  %16 = load i32, ptr %3, align 4
  %17 = icmp sge i32 %16, 32
  br i1 %17, label %18, label %20

18:                                               ; preds = %15, %11
  %19 = load i32, ptr %3, align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str.1, i32 noundef %19)
  br label %20

20:                                               ; preds = %18, %15
  %21 = load i32, ptr %3, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %22
  store ptr %23, ptr %2, align 8
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 12
  %26 = load i8, ptr %25, align 4
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %20
  store i32 0, ptr %1, align 4
  br label %92

30:                                               ; preds = %20
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.fproc, ptr %31, i32 0, i32 14
  %33 = load i8, ptr %32, align 2
  %34 = sext i8 %33 to i32
  %35 = sub nsw i32 0, %34
  store i32 %35, ptr %4, align 4
  %36 = load i32, ptr %4, align 4
  %37 = icmp ne i32 %36, -10
  br i1 %37, label %38, label %91

38:                                               ; preds = %30
  %39 = load i32, ptr %4, align 4
  %40 = icmp ne i32 %39, -11
  br i1 %40, label %41, label %87

41:                                               ; preds = %38
  %42 = load ptr, ptr %2, align 8
  %43 = getelementptr inbounds %struct.fproc, ptr %42, i32 0, i32 9
  %44 = load i32, ptr %43, align 8
  %45 = ashr i32 %44, 8
  %46 = and i32 %45, 255
  store i32 %46, ptr %5, align 4
  %47 = load i32, ptr %5, align 4
  %48 = icmp slt i32 %47, 0
  br i1 %48, label %52, label %49

49:                                               ; preds = %41
  %50 = load i32, ptr %5, align 4
  %51 = icmp sge i32 %50, 20
  br i1 %51, label %52, label %53

52:                                               ; preds = %49, %41
  call void (ptr, i32, ...) @panic(ptr noundef @.str.2, i32 noundef 32768)
  br label %53

53:                                               ; preds = %52, %49
  %54 = load ptr, ptr %2, align 8
  %55 = getelementptr inbounds %struct.fproc, ptr %54, i32 0, i32 3
  %56 = load i32, ptr %5, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [20 x ptr], ptr %55, i64 0, i64 %57
  %59 = load ptr, ptr %58, align 8
  store ptr %59, ptr %6, align 8
  %60 = load ptr, ptr %6, align 8
  %61 = getelementptr inbounds %struct.filp, ptr %60, i32 0, i32 3
  %62 = load ptr, ptr %61, align 8
  %63 = getelementptr inbounds %struct.inode, ptr %62, i32 0, i32 6
  %64 = getelementptr inbounds [9 x i16], ptr %63, i64 0, i64 0
  %65 = load i16, ptr %64, align 2
  store i16 %65, ptr %7, align 2
  %66 = load i16, ptr %7, align 2
  %67 = zext i16 %66 to i32
  %68 = ashr i32 %67, 0
  %69 = and i32 %68, 255
  store i32 %69, ptr getelementptr inbounds (%struct.message, ptr @mess, i32 0, i32 2), align 8
  %70 = load i32, ptr %3, align 4
  store i32 %70, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mess, i32 0, i32 2), i32 0, i32 1), align 4
  %71 = load ptr, ptr %2, align 8
  %72 = getelementptr inbounds %struct.fproc, ptr %71, i32 0, i32 9
  %73 = load i32, ptr %72, align 8
  %74 = and i32 %73, 255
  %75 = icmp eq i32 %74, 3
  %76 = zext i1 %75 to i64
  %77 = select i1 %75, i32 4, i32 2
  store i32 %77, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mess, i32 0, i32 2), i32 0, i32 2), align 8
  store i32 0, ptr getelementptr inbounds (%struct.message, ptr @mess, i32 0, i32 1), align 4
  %78 = load i16, ptr %7, align 2
  %79 = zext i16 %78 to i32
  %80 = ashr i32 %79, 8
  %81 = and i32 %80, 255
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %82
  %84 = getelementptr inbounds %struct.dmap, ptr %83, i32 0, i32 1
  %85 = load ptr, ptr %84, align 8
  %86 = load i32, ptr %4, align 4
  call void (i32, ptr, ...) %85(i32 noundef %86, ptr noundef @mess)
  br label %87

87:                                               ; preds = %53, %38
  %88 = load ptr, ptr %2, align 8
  %89 = getelementptr inbounds %struct.fproc, ptr %88, i32 0, i32 12
  store i8 0, ptr %89, align 4
  %90 = load i32, ptr %3, align 4
  call void (i32, i32, ...) @reply(i32 noundef %90, i32 noundef -4)
  br label %91

91:                                               ; preds = %87, %30
  store i32 0, ptr %1, align 4
  br label %92

92:                                               ; preds = %91, %29, %10
  %93 = load i32, ptr %1, align 4
  ret i32 %93
}

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
