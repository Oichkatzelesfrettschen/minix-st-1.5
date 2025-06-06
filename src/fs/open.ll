; NOTE: Generated from src/fs/open.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/open.c'
source_filename = "src/fs/open.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@super_user = external global i32, align 4
@fp = external global ptr, align 8
@user_path = external global [255 x i8], align 16
@m1 = external global %struct.message, align 8
@dot1 = internal global [14 x i8] c".\00\00\00\00\00\00\00\00\00\00\00\00\00", align 1
@dot2 = internal global [14 x i8] c"..\00\00\00\00\00\00\00\00\00\00\00\00", align 1
@.str = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"..\00", align 1
@mode_map = internal global [4 x i8] c"\04\02\06\00", align 1
@susp_count = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_creat() #0 {
  %1 = alloca i32, align 4
  %2 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %3 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %4 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %2, i32 noundef %3, i32 noundef 3)
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %0
  %7 = load i32, ptr @err_code, align 4
  store i32 %7, ptr %1, align 4
  br label %13

8:                                                ; preds = %0
  %9 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %10 = trunc i32 %9 to i16
  %11 = zext i16 %10 to i32
  %12 = call i32 @common_open(i32 noundef 577, i32 noundef %11)
  store i32 %12, ptr %1, align 4
  br label %13

13:                                               ; preds = %8, %6
  %14 = load i32, ptr %1, align 4
  ret i32 %14
}

declare i32 @fetch_name(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_mknod() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i16, align 2
  %3 = alloca i32, align 4
  %4 = load i32, ptr @super_user, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %11, label %6

6:                                                ; preds = %0
  %7 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %8 = and i32 %7, 61440
  %9 = icmp ne i32 %8, 4096
  br i1 %9, label %10, label %11

10:                                               ; preds = %6
  store i32 -1, ptr %1, align 4
  br label %42

11:                                               ; preds = %6, %0
  %12 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %13 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %14 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %12, i32 noundef %13, i32 noundef 1)
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %18

16:                                               ; preds = %11
  %17 = load i32, ptr @err_code, align 4
  store i32 %17, ptr %1, align 4
  br label %42

18:                                               ; preds = %11
  %19 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %20 = and i32 %19, 61440
  %21 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %22 = and i32 %21, 3583
  %23 = load ptr, ptr @fp, align 8
  %24 = getelementptr inbounds %struct.fproc, ptr %23, i32 0, i32 0
  %25 = load i16, ptr %24, align 8
  %26 = zext i16 %25 to i32
  %27 = and i32 %22, %26
  %28 = or i32 %20, %27
  %29 = trunc i32 %28 to i16
  store i16 %29, ptr %2, align 2
  %30 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %31 = ptrtoint ptr %30 to i32
  store i32 %31, ptr %3, align 4
  %32 = load i16, ptr %2, align 2
  %33 = zext i16 %32 to i32
  %34 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %35 = trunc i32 %34 to i16
  %36 = zext i16 %35 to i32
  %37 = call ptr (ptr, i32, i32, ...) @new_node(ptr noundef @user_path, i32 noundef %33, i32 noundef %36)
  %38 = load i32, ptr %3, align 4
  %39 = zext i32 %38 to i64
  %40 = mul nsw i64 %39, 1024
  call void (ptr, i64, ...) @put_inode(ptr noundef %37, i64 noundef %40)
  %41 = load i32, ptr @err_code, align 4
  store i32 %41, ptr %1, align 4
  br label %42

42:                                               ; preds = %18, %16, %10
  %43 = load i32, ptr %1, align 4
  ret i32 %43
}

declare void @put_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_open() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %2, align 4
  %4 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %5 = and i32 %4, 64
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %12

7:                                                ; preds = %0
  %8 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  store i32 %8, ptr %2, align 4
  %9 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %10 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %11 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %9, i32 noundef %10, i32 noundef 1)
  store i32 %11, ptr %3, align 4
  br label %16

12:                                               ; preds = %0
  %13 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %14 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %15 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %13, i32 noundef %14, i32 noundef 3)
  store i32 %15, ptr %3, align 4
  br label %16

16:                                               ; preds = %12, %7
  %17 = load i32, ptr %3, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = load i32, ptr @err_code, align 4
  store i32 %20, ptr %1, align 4
  br label %27

21:                                               ; preds = %16
  %22 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %23 = load i32, ptr %2, align 4
  %24 = trunc i32 %23 to i16
  %25 = zext i16 %24 to i32
  %26 = call i32 @common_open(i32 noundef %22, i32 noundef %25)
  store i32 %26, ptr %1, align 4
  br label %27

27:                                               ; preds = %21, %19
  %28 = load i32, ptr %1, align 4
  ret i32 %28
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_close() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %7 = call ptr (i32, ...) @get_filp(i32 noundef %6)
  store ptr %7, ptr %2, align 8
  %8 = icmp eq ptr %7, null
  br i1 %8, label %9, label %11

9:                                                ; preds = %0
  %10 = load i32, ptr @err_code, align 4
  store i32 %10, ptr %1, align 4
  br label %78

11:                                               ; preds = %0
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds %struct.filp, ptr %12, i32 0, i32 3
  %14 = load ptr, ptr %13, align 8
  store ptr %14, ptr %3, align 8
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.inode, ptr %15, i32 0, i32 0
  %17 = load i16, ptr %16, align 8
  %18 = zext i16 %17 to i32
  %19 = and i32 %18, 61440
  store i32 %19, ptr %5, align 4
  %20 = load i32, ptr %5, align 4
  %21 = icmp eq i32 %20, 8192
  br i1 %21, label %25, label %22

22:                                               ; preds = %11
  %23 = load i32, ptr %5, align 4
  %24 = icmp eq i32 %23, 24576
  br i1 %24, label %25, label %48

25:                                               ; preds = %22, %11
  %26 = load i32, ptr %5, align 4
  %27 = icmp eq i32 %26, 24576
  br i1 %27, label %28, label %40

28:                                               ; preds = %25
  %29 = call i32 (...) @do_sync()
  %30 = load ptr, ptr %3, align 8
  %31 = call i32 (ptr, ...) @mounted(ptr noundef %30)
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %39

33:                                               ; preds = %28
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %struct.inode, ptr %34, i32 0, i32 6
  %36 = getelementptr inbounds [9 x i16], ptr %35, i64 0, i64 0
  %37 = load i16, ptr %36, align 2
  %38 = zext i16 %37 to i32
  call void (i32, ...) @invalidate(i32 noundef %38)
  br label %39

39:                                               ; preds = %33, %28
  br label %40

40:                                               ; preds = %39, %25
  %41 = load ptr, ptr %2, align 8
  %42 = getelementptr inbounds %struct.filp, ptr %41, i32 0, i32 2
  %43 = load i32, ptr %42, align 8
  %44 = icmp eq i32 %43, 1
  br i1 %44, label %45, label %47

45:                                               ; preds = %40
  %46 = load ptr, ptr %3, align 8
  call void (ptr, ...) @dev_close(ptr noundef %46)
  br label %47

47:                                               ; preds = %45, %40
  br label %48

48:                                               ; preds = %47, %22
  %49 = load ptr, ptr %3, align 8
  %50 = getelementptr inbounds %struct.inode, ptr %49, i32 0, i32 13
  %51 = load i8, ptr %50, align 1
  %52 = icmp ne i8 %51, 0
  br i1 %52, label %53, label %64

53:                                               ; preds = %48
  %54 = load ptr, ptr %2, align 8
  %55 = getelementptr inbounds %struct.filp, ptr %54, i32 0, i32 0
  %56 = load i16, ptr %55, align 8
  %57 = zext i16 %56 to i32
  %58 = and i32 %57, 4
  %59 = icmp ne i32 %58, 0
  %60 = zext i1 %59 to i64
  %61 = select i1 %59, i32 4, i32 3
  store i32 %61, ptr %4, align 4
  %62 = load ptr, ptr %3, align 8
  %63 = load i32, ptr %4, align 4
  call void (ptr, i32, i32, ...) @release(ptr noundef %62, i32 noundef %63, i32 noundef 32)
  br label %64

64:                                               ; preds = %53, %48
  %65 = load ptr, ptr %2, align 8
  %66 = getelementptr inbounds %struct.filp, ptr %65, i32 0, i32 2
  %67 = load i32, ptr %66, align 8
  %68 = add nsw i32 %67, -1
  store i32 %68, ptr %66, align 8
  %69 = icmp eq i32 %68, 0
  br i1 %69, label %70, label %72

70:                                               ; preds = %64
  %71 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %71)
  br label %72

72:                                               ; preds = %70, %64
  %73 = load ptr, ptr @fp, align 8
  %74 = getelementptr inbounds %struct.fproc, ptr %73, i32 0, i32 3
  %75 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds [20 x ptr], ptr %74, i64 0, i64 %76
  store ptr null, ptr %77, align 8
  store i32 0, ptr %1, align 4
  br label %78

78:                                               ; preds = %72, %9
  %79 = load i32, ptr %1, align 4
  ret i32 %79
}

declare ptr @get_filp(...) #1

declare i32 @do_sync(...) #1

declare i32 @mounted(...) #1

declare void @invalidate(...) #1

declare void @dev_close(...) #1

declare void @release(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_lseek() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %5 = call ptr (i32, ...) @get_filp(i32 noundef %4)
  store ptr %5, ptr %2, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %9

7:                                                ; preds = %0
  %8 = load i32, ptr @err_code, align 4
  store i32 %8, ptr %1, align 4
  br label %60

9:                                                ; preds = %0
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.filp, ptr %10, i32 0, i32 3
  %12 = load ptr, ptr %11, align 8
  %13 = getelementptr inbounds %struct.inode, ptr %12, i32 0, i32 13
  %14 = load i8, ptr %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %18

17:                                               ; preds = %9
  store i32 -29, ptr %1, align 4
  br label %60

18:                                               ; preds = %9
  %19 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  switch i32 %19, label %36 [
    i32 0, label %20
    i32 1, label %22
    i32 2, label %28
  ]

20:                                               ; preds = %18
  %21 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  store i64 %21, ptr %3, align 8
  br label %37

22:                                               ; preds = %18
  %23 = load ptr, ptr %2, align 8
  %24 = getelementptr inbounds %struct.filp, ptr %23, i32 0, i32 4
  %25 = load i64, ptr %24, align 8
  %26 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %27 = add nsw i64 %25, %26
  store i64 %27, ptr %3, align 8
  br label %37

28:                                               ; preds = %18
  %29 = load ptr, ptr %2, align 8
  %30 = getelementptr inbounds %struct.filp, ptr %29, i32 0, i32 3
  %31 = load ptr, ptr %30, align 8
  %32 = getelementptr inbounds %struct.inode, ptr %31, i32 0, i32 2
  %33 = load i64, ptr %32, align 8
  %34 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %35 = add nsw i64 %33, %34
  store i64 %35, ptr %3, align 8
  br label %37

36:                                               ; preds = %18
  store i32 -22, ptr %1, align 4
  br label %60

37:                                               ; preds = %28, %22, %20
  %38 = load i64, ptr %3, align 8
  %39 = icmp slt i64 %38, 0
  br i1 %39, label %43, label %40

40:                                               ; preds = %37
  %41 = load i64, ptr %3, align 8
  %42 = icmp sgt i64 %41, 2147483647
  br i1 %42, label %43, label %44

43:                                               ; preds = %40, %37
  store i32 -22, ptr %1, align 4
  br label %60

44:                                               ; preds = %40
  %45 = load i64, ptr %3, align 8
  %46 = load ptr, ptr %2, align 8
  %47 = getelementptr inbounds %struct.filp, ptr %46, i32 0, i32 4
  %48 = load i64, ptr %47, align 8
  %49 = icmp ne i64 %45, %48
  br i1 %49, label %50, label %55

50:                                               ; preds = %44
  %51 = load ptr, ptr %2, align 8
  %52 = getelementptr inbounds %struct.filp, ptr %51, i32 0, i32 3
  %53 = load ptr, ptr %52, align 8
  %54 = getelementptr inbounds %struct.inode, ptr %53, i32 0, i32 15
  store i8 1, ptr %54, align 1
  br label %55

55:                                               ; preds = %50, %44
  %56 = load i64, ptr %3, align 8
  %57 = load ptr, ptr %2, align 8
  %58 = getelementptr inbounds %struct.filp, ptr %57, i32 0, i32 4
  store i64 %56, ptr %58, align 8
  %59 = load i64, ptr %3, align 8
  store i64 %59, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  store i32 0, ptr %1, align 4
  br label %60

60:                                               ; preds = %55, %43, %36, %17, %7
  %61 = load i32, ptr %1, align 4
  ret i32 %61
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_mkdir() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca i16, align 2
  %7 = alloca [14 x i8], align 1
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %11 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %12 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %10, i32 noundef %11, i32 noundef 1)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %0
  %15 = load i32, ptr @err_code, align 4
  store i32 %15, ptr %1, align 4
  br label %95

16:                                               ; preds = %0
  %17 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %18 = and i32 %17, 511
  %19 = load ptr, ptr @fp, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 0
  %21 = load i16, ptr %20, align 8
  %22 = zext i16 %21 to i32
  %23 = and i32 %18, %22
  %24 = or i32 16384, %23
  %25 = trunc i32 %24 to i16
  store i16 %25, ptr %6, align 2
  %26 = load i16, ptr %6, align 2
  %27 = zext i16 %26 to i32
  %28 = call ptr @new_node(ptr noundef @user_path, i32 noundef %27, i32 noundef 0, i64 noundef 0)
  store ptr %28, ptr %8, align 8
  %29 = load ptr, ptr %8, align 8
  %30 = icmp eq ptr %29, null
  br i1 %30, label %31, label %33

31:                                               ; preds = %16
  %32 = load i32, ptr @err_code, align 4
  store i32 %32, ptr %1, align 4
  br label %95

33:                                               ; preds = %16
  %34 = load i32, ptr @err_code, align 4
  %35 = icmp eq i32 %34, -17
  br i1 %35, label %36, label %39

36:                                               ; preds = %33
  %37 = load ptr, ptr %8, align 8
  call void (ptr, ...) @put_inode(ptr noundef %37)
  %38 = load i32, ptr @err_code, align 4
  store i32 %38, ptr %1, align 4
  br label %95

39:                                               ; preds = %33
  %40 = getelementptr inbounds [14 x i8], ptr %7, i64 0, i64 0
  %41 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef @user_path, ptr noundef %40)
  store ptr %41, ptr %9, align 8
  %42 = load ptr, ptr %9, align 8
  %43 = getelementptr inbounds %struct.inode, ptr %42, i32 0, i32 10
  %44 = load i16, ptr %43, align 2
  store i16 %44, ptr %5, align 2
  %45 = load ptr, ptr %8, align 8
  %46 = getelementptr inbounds %struct.inode, ptr %45, i32 0, i32 10
  %47 = load i16, ptr %46, align 2
  store i16 %47, ptr %4, align 2
  %48 = load ptr, ptr %8, align 8
  %49 = getelementptr inbounds %struct.inode, ptr %48, i32 0, i32 0
  %50 = load i16, ptr %49, align 8
  %51 = zext i16 %50 to i32
  %52 = or i32 %51, 448
  %53 = trunc i32 %52 to i16
  store i16 %53, ptr %49, align 8
  %54 = load ptr, ptr %8, align 8
  %55 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %54, ptr noundef @dot1, ptr noundef %4, i32 noundef 1)
  store i32 %55, ptr %2, align 4
  %56 = load ptr, ptr %8, align 8
  %57 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %56, ptr noundef @dot2, ptr noundef %5, i32 noundef 1)
  store i32 %57, ptr %3, align 4
  %58 = load i16, ptr %6, align 2
  %59 = load ptr, ptr %8, align 8
  %60 = getelementptr inbounds %struct.inode, ptr %59, i32 0, i32 0
  store i16 %58, ptr %60, align 8
  %61 = load i32, ptr %2, align 4
  %62 = icmp eq i32 %61, 0
  br i1 %62, label %63, label %77

63:                                               ; preds = %39
  %64 = load i32, ptr %3, align 4
  %65 = icmp eq i32 %64, 0
  br i1 %65, label %66, label %77

66:                                               ; preds = %63
  %67 = load ptr, ptr %8, align 8
  %68 = getelementptr inbounds %struct.inode, ptr %67, i32 0, i32 5
  %69 = load i8, ptr %68, align 1
  %70 = add i8 %69, 1
  store i8 %70, ptr %68, align 1
  %71 = load ptr, ptr %9, align 8
  %72 = getelementptr inbounds %struct.inode, ptr %71, i32 0, i32 5
  %73 = load i8, ptr %72, align 1
  %74 = add i8 %73, 1
  store i8 %74, ptr %72, align 1
  %75 = load ptr, ptr %9, align 8
  %76 = getelementptr inbounds %struct.inode, ptr %75, i32 0, i32 12
  store i8 1, ptr %76, align 2
  br label %89

77:                                               ; preds = %63, %39
  %78 = load ptr, ptr %8, align 8
  %79 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %78, ptr noundef @.str, ptr noundef null, i32 noundef 2)
  %80 = load ptr, ptr %8, align 8
  %81 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %80, ptr noundef @.str.1, ptr noundef null, i32 noundef 2)
  %82 = load ptr, ptr %9, align 8
  %83 = getelementptr inbounds [14 x i8], ptr %7, i64 0, i64 0
  %84 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %82, ptr noundef %83, ptr noundef null, i32 noundef 2)
  %85 = load ptr, ptr %8, align 8
  %86 = getelementptr inbounds %struct.inode, ptr %85, i32 0, i32 5
  %87 = load i8, ptr %86, align 1
  %88 = add i8 %87, -1
  store i8 %88, ptr %86, align 1
  br label %89

89:                                               ; preds = %77, %66
  %90 = load ptr, ptr %8, align 8
  %91 = getelementptr inbounds %struct.inode, ptr %90, i32 0, i32 12
  store i8 1, ptr %91, align 2
  %92 = load ptr, ptr %9, align 8
  call void (ptr, ...) @put_inode(ptr noundef %92)
  %93 = load ptr, ptr %8, align 8
  call void (ptr, ...) @put_inode(ptr noundef %93)
  %94 = load i32, ptr @err_code, align 4
  store i32 %94, ptr %1, align 4
  br label %95

95:                                               ; preds = %89, %36, %31, %14
  %96 = load i32, ptr %1, align 4
  ret i32 %96
}

declare ptr @last_dir(...) #1

declare i32 @search_dir(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @new_node(ptr noundef %0, i32 noundef %1, i32 noundef %2, i64 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i64, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca [14 x i8], align 1
  %14 = trunc i32 %1 to i16
  %15 = trunc i32 %2 to i16
  store ptr %0, ptr %6, align 8
  store i16 %14, ptr %7, align 2
  store i16 %15, ptr %8, align 2
  store i64 %3, ptr %9, align 8
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds [14 x i8], ptr %13, i64 0, i64 0
  %18 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef %16, ptr noundef %17)
  store ptr %18, ptr %10, align 8
  %19 = icmp eq ptr %18, null
  br i1 %19, label %20, label %21

20:                                               ; preds = %4
  store ptr null, ptr %5, align 8
  br label %82

21:                                               ; preds = %4
  %22 = load ptr, ptr %10, align 8
  %23 = getelementptr inbounds [14 x i8], ptr %13, i64 0, i64 0
  %24 = call ptr (ptr, ptr, ...) @advance(ptr noundef %22, ptr noundef %23)
  store ptr %24, ptr %11, align 8
  %25 = load ptr, ptr %11, align 8
  %26 = icmp eq ptr %25, null
  br i1 %26, label %27, label %71

27:                                               ; preds = %21
  %28 = load i32, ptr @err_code, align 4
  %29 = icmp eq i32 %28, -2
  br i1 %29, label %30, label %71

30:                                               ; preds = %27
  %31 = load ptr, ptr %10, align 8
  %32 = getelementptr inbounds %struct.inode, ptr %31, i32 0, i32 9
  %33 = load i16, ptr %32, align 8
  %34 = zext i16 %33 to i32
  %35 = load i16, ptr %7, align 2
  %36 = zext i16 %35 to i32
  %37 = call ptr (i32, i32, ...) @alloc_inode(i32 noundef %34, i32 noundef %36)
  store ptr %37, ptr %11, align 8
  %38 = icmp eq ptr %37, null
  br i1 %38, label %39, label %41

39:                                               ; preds = %30
  %40 = load ptr, ptr %10, align 8
  call void (ptr, ...) @put_inode(ptr noundef %40)
  store ptr null, ptr %5, align 8
  br label %82

41:                                               ; preds = %30
  %42 = load ptr, ptr %11, align 8
  %43 = getelementptr inbounds %struct.inode, ptr %42, i32 0, i32 5
  %44 = load i8, ptr %43, align 1
  %45 = add i8 %44, 1
  store i8 %45, ptr %43, align 1
  %46 = load i16, ptr %8, align 2
  %47 = load ptr, ptr %11, align 8
  %48 = getelementptr inbounds %struct.inode, ptr %47, i32 0, i32 6
  %49 = getelementptr inbounds [9 x i16], ptr %48, i64 0, i64 0
  store i16 %46, ptr %49, align 2
  %50 = load i64, ptr %9, align 8
  %51 = load ptr, ptr %11, align 8
  %52 = getelementptr inbounds %struct.inode, ptr %51, i32 0, i32 2
  store i64 %50, ptr %52, align 8
  %53 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @rw_inode(ptr noundef %53, i32 noundef 1)
  %54 = load ptr, ptr %10, align 8
  %55 = getelementptr inbounds [14 x i8], ptr %13, i64 0, i64 0
  %56 = load ptr, ptr %11, align 8
  %57 = getelementptr inbounds %struct.inode, ptr %56, i32 0, i32 10
  %58 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %54, ptr noundef %55, ptr noundef %57, i32 noundef 1)
  store i32 %58, ptr %12, align 4
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %70

60:                                               ; preds = %41
  %61 = load ptr, ptr %10, align 8
  call void (ptr, ...) @put_inode(ptr noundef %61)
  %62 = load ptr, ptr %11, align 8
  %63 = getelementptr inbounds %struct.inode, ptr %62, i32 0, i32 5
  %64 = load i8, ptr %63, align 1
  %65 = add i8 %64, -1
  store i8 %65, ptr %63, align 1
  %66 = load ptr, ptr %11, align 8
  %67 = getelementptr inbounds %struct.inode, ptr %66, i32 0, i32 12
  store i8 1, ptr %67, align 2
  %68 = load ptr, ptr %11, align 8
  call void (ptr, ...) @put_inode(ptr noundef %68)
  %69 = load i32, ptr %12, align 4
  store i32 %69, ptr @err_code, align 4
  store ptr null, ptr %5, align 8
  br label %82

70:                                               ; preds = %41
  br label %78

71:                                               ; preds = %27, %21
  %72 = load ptr, ptr %11, align 8
  %73 = icmp ne ptr %72, null
  br i1 %73, label %74, label %75

74:                                               ; preds = %71
  store i32 -17, ptr %12, align 4
  br label %77

75:                                               ; preds = %71
  %76 = load i32, ptr @err_code, align 4
  store i32 %76, ptr %12, align 4
  br label %77

77:                                               ; preds = %75, %74
  br label %78

78:                                               ; preds = %77, %70
  %79 = load ptr, ptr %10, align 8
  call void (ptr, ...) @put_inode(ptr noundef %79)
  %80 = load i32, ptr %12, align 4
  store i32 %80, ptr @err_code, align 4
  %81 = load ptr, ptr %11, align 8
  store ptr %81, ptr %5, align 8
  br label %82

82:                                               ; preds = %78, %60, %39, %20
  %83 = load ptr, ptr %5, align 8
  ret ptr %83
}

declare ptr @advance(...) #1

declare ptr @alloc_inode(...) #1

declare void @rw_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @common_open(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i16, align 2
  %9 = alloca ptr, align 8
  %10 = alloca i16, align 2
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = trunc i32 %1 to i16
  store i32 %0, ptr %4, align 4
  store i16 %13, ptr %5, align 2
  store i32 1, ptr %12, align 4
  %14 = load i32, ptr %4, align 4
  %15 = and i32 %14, 3
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [4 x i8], ptr @mode_map, i64 0, i64 %16
  %18 = load i8, ptr %17, align 1
  %19 = sext i8 %18 to i16
  store i16 %19, ptr %8, align 2
  %20 = load i16, ptr %8, align 2
  %21 = zext i16 %20 to i32
  %22 = call i32 (i32, i32, ptr, ptr, ...) @get_fd(i32 noundef 0, i32 noundef %21, ptr noundef getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), ptr noundef %9)
  store i32 %22, ptr %7, align 4
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %26

24:                                               ; preds = %2
  %25 = load i32, ptr %7, align 4
  store i32 %25, ptr %3, align 4
  br label %139

26:                                               ; preds = %2
  %27 = load i32, ptr %4, align 4
  %28 = and i32 %27, 64
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %61

30:                                               ; preds = %26
  %31 = load i16, ptr %5, align 2
  %32 = zext i16 %31 to i32
  %33 = and i32 %32, 3583
  %34 = load ptr, ptr @fp, align 8
  %35 = getelementptr inbounds %struct.fproc, ptr %34, i32 0, i32 0
  %36 = load i16, ptr %35, align 8
  %37 = zext i16 %36 to i32
  %38 = and i32 %33, %37
  %39 = or i32 32768, %38
  %40 = trunc i32 %39 to i16
  store i16 %40, ptr %5, align 2
  %41 = load i16, ptr %5, align 2
  %42 = zext i16 %41 to i32
  %43 = call ptr @new_node(ptr noundef @user_path, i32 noundef %42, i32 noundef 0, i64 noundef 0)
  store ptr %43, ptr %6, align 8
  %44 = load i32, ptr @err_code, align 4
  store i32 %44, ptr %7, align 4
  %45 = load i32, ptr %7, align 4
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %48

47:                                               ; preds = %30
  store i32 0, ptr %12, align 4
  br label %60

48:                                               ; preds = %30
  %49 = load i32, ptr %7, align 4
  %50 = icmp ne i32 %49, -17
  br i1 %50, label %51, label %53

51:                                               ; preds = %48
  %52 = load i32, ptr %7, align 4
  store i32 %52, ptr %3, align 4
  br label %139

53:                                               ; preds = %48
  %54 = load i32, ptr %4, align 4
  %55 = and i32 %54, 128
  %56 = icmp ne i32 %55, 0
  %57 = xor i1 %56, true
  %58 = zext i1 %57 to i32
  store i32 %58, ptr %12, align 4
  br label %59

59:                                               ; preds = %53
  br label %60

60:                                               ; preds = %59, %47
  br label %67

61:                                               ; preds = %26
  %62 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %62, ptr %6, align 8
  %63 = icmp eq ptr %62, null
  br i1 %63, label %64, label %66

64:                                               ; preds = %61
  %65 = load i32, ptr @err_code, align 4
  store i32 %65, ptr %3, align 4
  br label %139

66:                                               ; preds = %61
  br label %67

67:                                               ; preds = %66, %60
  %68 = load i32, ptr %12, align 4
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %117

70:                                               ; preds = %67
  %71 = load ptr, ptr %6, align 8
  %72 = load i16, ptr %8, align 2
  %73 = zext i16 %72 to i32
  %74 = call i32 (ptr, i32, i32, ...) @forbidden(ptr noundef %71, i32 noundef %73, i32 noundef 0)
  store i32 %74, ptr %7, align 4
  %75 = icmp eq i32 %74, 0
  br i1 %75, label %76, label %116

76:                                               ; preds = %70
  %77 = load ptr, ptr %6, align 8
  %78 = getelementptr inbounds %struct.inode, ptr %77, i32 0, i32 0
  %79 = load i16, ptr %78, align 8
  %80 = zext i16 %79 to i32
  %81 = and i32 %80, 61440
  switch i32 %81, label %115 [
    i32 32768, label %82
    i32 16384, label %90
    i32 8192, label %97
    i32 24576, label %97
    i32 4096, label %109
  ]

82:                                               ; preds = %76
  %83 = load i32, ptr %4, align 4
  %84 = and i32 %83, 512
  %85 = icmp ne i32 %84, 0
  br i1 %85, label %86, label %89

86:                                               ; preds = %82
  %87 = load ptr, ptr %6, align 8
  call void (ptr, ...) @truncate(ptr noundef %87)
  %88 = load ptr, ptr %6, align 8
  call void (ptr, ...) @wipe_inode(ptr noundef %88)
  br label %89

89:                                               ; preds = %86, %82
  br label %115

90:                                               ; preds = %76
  %91 = load i16, ptr %8, align 2
  %92 = zext i16 %91 to i32
  %93 = and i32 %92, 2
  %94 = icmp ne i32 %93, 0
  %95 = zext i1 %94 to i64
  %96 = select i1 %94, i32 -21, i32 0
  store i32 %96, ptr %7, align 4
  br label %115

97:                                               ; preds = %76, %76
  %98 = load ptr, ptr %6, align 8
  %99 = getelementptr inbounds %struct.inode, ptr %98, i32 0, i32 6
  %100 = getelementptr inbounds [9 x i16], ptr %99, i64 0, i64 0
  %101 = load i16, ptr %100, align 2
  store i16 %101, ptr %10, align 2
  %102 = load i32, ptr %4, align 4
  %103 = and i32 %102, 2048
  store i32 %103, ptr %11, align 4
  %104 = load ptr, ptr %6, align 8
  %105 = load i16, ptr %8, align 2
  %106 = zext i16 %105 to i32
  %107 = load i32, ptr %11, align 4
  %108 = call i32 (ptr, i32, i32, ...) @dev_open(ptr noundef %104, i32 noundef %106, i32 noundef %107)
  store i32 %108, ptr %7, align 4
  br label %115

109:                                              ; preds = %76
  %110 = load ptr, ptr %6, align 8
  %111 = load i16, ptr %8, align 2
  %112 = zext i16 %111 to i32
  %113 = load i32, ptr %4, align 4
  %114 = call i32 @pipe_open(ptr noundef %110, i32 noundef %112, i32 noundef %113)
  store i32 %114, ptr %7, align 4
  br label %115

115:                                              ; preds = %76, %109, %97, %90, %89
  br label %116

116:                                              ; preds = %115, %70
  br label %117

117:                                              ; preds = %116, %67
  %118 = load i32, ptr %7, align 4
  %119 = icmp ne i32 %118, 0
  br i1 %119, label %120, label %123

120:                                              ; preds = %117
  %121 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %121)
  %122 = load i32, ptr %7, align 4
  store i32 %122, ptr %3, align 4
  br label %139

123:                                              ; preds = %117
  %124 = load ptr, ptr %9, align 8
  %125 = load ptr, ptr @fp, align 8
  %126 = getelementptr inbounds %struct.fproc, ptr %125, i32 0, i32 3
  %127 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds [20 x ptr], ptr %126, i64 0, i64 %128
  store ptr %124, ptr %129, align 8
  %130 = load ptr, ptr %9, align 8
  %131 = getelementptr inbounds %struct.filp, ptr %130, i32 0, i32 2
  store i32 1, ptr %131, align 8
  %132 = load ptr, ptr %6, align 8
  %133 = load ptr, ptr %9, align 8
  %134 = getelementptr inbounds %struct.filp, ptr %133, i32 0, i32 3
  store ptr %132, ptr %134, align 8
  %135 = load i32, ptr %4, align 4
  %136 = load ptr, ptr %9, align 8
  %137 = getelementptr inbounds %struct.filp, ptr %136, i32 0, i32 1
  store i32 %135, ptr %137, align 4
  %138 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  store i32 %138, ptr %3, align 4
  br label %139

139:                                              ; preds = %123, %120, %64, %51, %24
  %140 = load i32, ptr %3, align 4
  ret i32 %140
}

declare i32 @get_fd(...) #1

declare ptr @eat_path(...) #1

declare i32 @forbidden(...) #1

declare void @truncate(...) #1

declare void @wipe_inode(...) #1

declare i32 @dev_open(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @pipe_open(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = alloca i32, align 4
  %8 = trunc i32 %1 to i16
  store ptr %0, ptr %5, align 8
  store i16 %8, ptr %6, align 2
  store i32 %2, ptr %7, align 4
  %9 = load ptr, ptr %5, align 8
  %10 = load i16, ptr %6, align 2
  %11 = zext i16 %10 to i32
  %12 = and i32 %11, 2
  %13 = icmp ne i32 %12, 0
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i32 4, i32 2
  %16 = call ptr (ptr, i32, ...) @find_filp(ptr noundef %9, i32 noundef %15)
  %17 = icmp eq ptr %16, null
  br i1 %17, label %18, label %30

18:                                               ; preds = %3
  %19 = load i32, ptr %7, align 4
  %20 = and i32 %19, 2048
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %29

22:                                               ; preds = %18
  %23 = load i16, ptr %6, align 2
  %24 = zext i16 %23 to i32
  %25 = and i32 %24, 2
  %26 = icmp ne i32 %25, 0
  %27 = zext i1 %26 to i64
  %28 = select i1 %26, i32 -6, i32 0
  store i32 %28, ptr %4, align 4
  br label %42

29:                                               ; preds = %18
  call void (i32, ...) @suspend(i32 noundef -11)
  br label %39

30:                                               ; preds = %3
  %31 = load i32, ptr @susp_count, align 4
  %32 = icmp sgt i32 %31, 0
  br i1 %32, label %33, label %38

33:                                               ; preds = %30
  %34 = load ptr, ptr %5, align 8
  %35 = load i32, ptr @susp_count, align 4
  call void (ptr, i32, i32, ...) @release(ptr noundef %34, i32 noundef 5, i32 noundef %35)
  %36 = load ptr, ptr %5, align 8
  %37 = load i32, ptr @susp_count, align 4
  call void (ptr, i32, i32, ...) @release(ptr noundef %36, i32 noundef 8, i32 noundef %37)
  br label %38

38:                                               ; preds = %33, %30
  br label %39

39:                                               ; preds = %38, %29
  %40 = load ptr, ptr %5, align 8
  %41 = getelementptr inbounds %struct.inode, ptr %40, i32 0, i32 13
  store i8 1, ptr %41, align 1
  store i32 0, ptr %4, align 4
  br label %42

42:                                               ; preds = %39, %22
  %43 = load i32, ptr %4, align 4
  ret i32 %43
}

declare ptr @find_filp(...) #1

declare void @suspend(...) #1

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
