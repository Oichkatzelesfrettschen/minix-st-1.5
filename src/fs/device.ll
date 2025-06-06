; NOTE: Generated from src/fs/device.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/device.c'
source_filename = "src/fs/device.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.dmap = type { ptr, ptr, ptr, i32 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }
%struct.filp = type { i16, i32, i32, ptr, i64 }

@dev_mess = internal global %struct.message zeroinitializer, align 8
@dmap = external global [0 x %struct.dmap], align 8
@major = internal global i32 0, align 4
@task = internal global i32 0, align 4
@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@who = external global i32, align 4
@minor = internal global i32 0, align 4
@m1 = external global %struct.message, align 8
@.str = private unnamed_addr constant [22 x i8] c"rw_dev: can't receive\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"rw_dev: can't send\00", align 1
@fp = external global ptr, align 8
@fproc = external global [32 x %struct.fproc], align 16
@max_major = external global i32, align 4
@.str.2 = private unnamed_addr constant [14 x i8] c"bad major dev\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @dev_open(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i16, align 2
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %9 = load ptr, ptr %5, align 8
  %10 = getelementptr inbounds %struct.inode, ptr %9, i32 0, i32 11
  %11 = load i16, ptr %10, align 4
  %12 = sext i16 %11 to i32
  %13 = icmp sgt i32 %12, 1
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  store i32 0, ptr %4, align 4
  br label %31

15:                                               ; preds = %3
  %16 = load ptr, ptr %5, align 8
  %17 = getelementptr inbounds %struct.inode, ptr %16, i32 0, i32 6
  %18 = getelementptr inbounds [9 x i16], ptr %17, i64 0, i64 0
  %19 = load i16, ptr %18, align 2
  store i16 %19, ptr %8, align 2
  %20 = load i16, ptr %8, align 2
  %21 = zext i16 %20 to i32
  call void @find_dev(i32 noundef %21)
  %22 = load i16, ptr %8, align 2
  %23 = zext i16 %22 to i32
  store i32 %23, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), align 8
  %24 = load i32, ptr @major, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %25
  %27 = getelementptr inbounds %struct.dmap, ptr %26, i32 0, i32 0
  %28 = load ptr, ptr %27, align 8
  %29 = load i32, ptr @task, align 4
  call void (i32, ptr, ...) %28(i32 noundef %29, ptr noundef @dev_mess)
  %30 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %30, ptr %4, align 4
  br label %31

31:                                               ; preds = %15, %14
  %32 = load i32, ptr %4, align 4
  ret i32 %32
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @dev_close(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i16, align 2
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.inode, ptr %4, i32 0, i32 11
  %6 = load i16, ptr %5, align 4
  %7 = sext i16 %6 to i32
  %8 = icmp sgt i32 %7, 1
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  br label %23

10:                                               ; preds = %1
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds %struct.inode, ptr %11, i32 0, i32 6
  %13 = getelementptr inbounds [9 x i16], ptr %12, i64 0, i64 0
  %14 = load i16, ptr %13, align 2
  store i16 %14, ptr %3, align 2
  %15 = load i16, ptr %3, align 2
  %16 = zext i16 %15 to i32
  call void @find_dev(i32 noundef %16)
  %17 = load i32, ptr @major, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %18
  %20 = getelementptr inbounds %struct.dmap, ptr %19, i32 0, i32 2
  %21 = load ptr, ptr %20, align 8
  %22 = load i32, ptr @task, align 4
  call void (i32, ptr, ...) %21(i32 noundef %22, ptr noundef @dev_mess)
  br label %23

23:                                               ; preds = %10, %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @dev_io(i32 noundef %0, i32 noundef %1, i32 noundef %2, i64 noundef %3, i32 noundef %4, i32 noundef %5, ptr noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i16, align 2
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = trunc i32 %2 to i16
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i16 %15, ptr %10, align 2
  store i64 %3, ptr %11, align 8
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  store ptr %6, ptr %14, align 8
  %16 = load i16, ptr %10, align 2
  %17 = zext i16 %16 to i32
  call void @find_dev(i32 noundef %17)
  %18 = load i32, ptr %8, align 4
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %7
  br label %29

21:                                               ; preds = %7
  %22 = load i32, ptr %8, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %25

24:                                               ; preds = %21
  br label %27

25:                                               ; preds = %21
  %26 = load i32, ptr %8, align 4
  br label %27

27:                                               ; preds = %25, %24
  %28 = phi i32 [ 4, %24 ], [ %26, %25 ]
  br label %29

29:                                               ; preds = %27, %20
  %30 = phi i32 [ 3, %20 ], [ %28, %27 ]
  store i32 %30, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 1), align 4
  %31 = load i16, ptr %10, align 2
  %32 = zext i16 %31 to i32
  %33 = ashr i32 %32, 0
  %34 = and i32 %33, 255
  store i32 %34, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), align 8
  %35 = load i64, ptr %11, align 8
  store i64 %35, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 3), align 8
  %36 = load i32, ptr %13, align 4
  store i32 %36, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  %37 = load ptr, ptr %14, align 8
  store ptr %37, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 5), align 8
  %38 = load i32, ptr %12, align 4
  store i32 %38, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 2), align 8
  %39 = load i32, ptr %9, align 4
  %40 = sext i32 %39 to i64
  store i64 %40, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 4), align 8
  %41 = load i32, ptr @major, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %42
  %44 = getelementptr inbounds %struct.dmap, ptr %43, i32 0, i32 1
  %45 = load ptr, ptr %44, align 8
  %46 = load i32, ptr @task, align 4
  call void (i32, ptr, ...) %45(i32 noundef %46, ptr noundef @dev_mess)
  %47 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  %48 = icmp eq i32 %47, -998
  br i1 %48, label %49, label %51

49:                                               ; preds = %29
  %50 = load i32, ptr @task, align 4
  call void (i32, ...) @suspend(i32 noundef %50)
  br label %51

51:                                               ; preds = %49, %29
  %52 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  ret i32 %52
}

declare void @suspend(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_ioctl() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %5 = call ptr (i32, ...) @get_filp(i32 noundef %4)
  store ptr %5, ptr %2, align 8
  %6 = icmp eq ptr %5, null
  br i1 %6, label %7, label %9

7:                                                ; preds = %0
  %8 = load i32, ptr @err_code, align 4
  store i32 %8, ptr %1, align 4
  br label %45

9:                                                ; preds = %0
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.filp, ptr %10, i32 0, i32 3
  %12 = load ptr, ptr %11, align 8
  store ptr %12, ptr %3, align 8
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.inode, ptr %13, i32 0, i32 0
  %15 = load i16, ptr %14, align 8
  %16 = zext i16 %15 to i32
  %17 = and i32 %16, 61440
  %18 = icmp ne i32 %17, 8192
  br i1 %18, label %19, label %20

19:                                               ; preds = %9
  store i32 -25, ptr %1, align 4
  br label %45

20:                                               ; preds = %9
  %21 = load ptr, ptr %3, align 8
  %22 = getelementptr inbounds %struct.inode, ptr %21, i32 0, i32 6
  %23 = getelementptr inbounds [9 x i16], ptr %22, i64 0, i64 0
  %24 = load i16, ptr %23, align 2
  %25 = zext i16 %24 to i32
  call void @find_dev(i32 noundef %25)
  store i32 5, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 1), align 4
  %26 = load i32, ptr @who, align 4
  store i32 %26, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  %27 = load i32, ptr @minor, align 4
  store i32 %27, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), align 8
  %28 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  store i32 %28, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 2), align 8
  %29 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  store i64 %29, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 3), align 8
  %30 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  store i64 %30, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 4), align 8
  %31 = load i32, ptr @major, align 4
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %32
  %34 = getelementptr inbounds %struct.dmap, ptr %33, i32 0, i32 1
  %35 = load ptr, ptr %34, align 8
  %36 = load i32, ptr @task, align 4
  call void (i32, ptr, ...) %35(i32 noundef %36, ptr noundef @dev_mess)
  %37 = load i32, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 1), align 4
  %38 = icmp eq i32 %37, -998
  br i1 %38, label %39, label %41

39:                                               ; preds = %20
  %40 = load i32, ptr @task, align 4
  call void (i32, ...) @suspend(i32 noundef %40)
  br label %41

41:                                               ; preds = %39, %20
  %42 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 3), align 8
  store i64 %42, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  %43 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 4), align 8
  store i64 %43, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 4), align 8
  %44 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %44, ptr %1, align 4
  br label %45

45:                                               ; preds = %41, %19, %7
  %46 = load i32, ptr %1, align 4
  ret i32 %46
}

declare ptr @get_filp(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_dev(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.message, align 8
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  br label %7

7:                                                ; preds = %32, %2
  %8 = load i32, ptr %3, align 4
  %9 = load ptr, ptr %4, align 8
  %10 = call i32 (i32, ptr, ...) @sendrec(i32 noundef %8, ptr noundef %9)
  store i32 %10, ptr %5, align 4
  %11 = icmp eq i32 %10, -101
  br i1 %11, label %12, label %39

12:                                               ; preds = %7
  %13 = load i32, ptr %3, align 4
  %14 = call i32 (i32, ptr, ...) @receive(i32 noundef %13, ptr noundef %6)
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef 32768)
  br label %17

17:                                               ; preds = %16, %12
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.message, ptr %18, i32 0, i32 1
  %20 = load i32, ptr %19, align 4
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %32

22:                                               ; preds = %17
  %23 = getelementptr inbounds %struct.message, ptr %6, i32 0, i32 2
  %24 = getelementptr inbounds %struct.mess_2, ptr %23, i32 0, i32 0
  %25 = load i32, ptr %24, align 8
  %26 = load ptr, ptr %4, align 8
  %27 = getelementptr inbounds %struct.message, ptr %26, i32 0, i32 2
  %28 = getelementptr inbounds %struct.mess_2, ptr %27, i32 0, i32 1
  %29 = load i32, ptr %28, align 4
  %30 = icmp eq i32 %25, %29
  br i1 %30, label %31, label %32

31:                                               ; preds = %22
  br label %43

32:                                               ; preds = %22, %17
  %33 = getelementptr inbounds %struct.message, ptr %6, i32 0, i32 2
  %34 = getelementptr inbounds %struct.mess_2, ptr %33, i32 0, i32 0
  %35 = load i32, ptr %34, align 8
  %36 = getelementptr inbounds %struct.message, ptr %6, i32 0, i32 2
  %37 = getelementptr inbounds %struct.mess_2, ptr %36, i32 0, i32 1
  %38 = load i32, ptr %37, align 4
  call void (i32, i32, ...) @revive(i32 noundef %35, i32 noundef %38)
  br label %7

39:                                               ; preds = %7
  %40 = load i32, ptr %5, align 4
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %43

42:                                               ; preds = %39
  call void (ptr, i32, ...) @panic(ptr noundef @.str.1, i32 noundef 32768)
  br label %43

43:                                               ; preds = %31, %42, %39
  ret void
}

declare i32 @sendrec(...) #1

declare i32 @receive(...) #1

declare void @panic(...) #1

declare void @revive(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_dev2(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr @fp, align 8
  %8 = getelementptr inbounds %struct.fproc, ptr %7, i32 0, i32 8
  %9 = load i16, ptr %8, align 2
  %10 = zext i16 %9 to i32
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %17

12:                                               ; preds = %2
  %13 = load ptr, ptr %4, align 8
  %14 = getelementptr inbounds %struct.message, ptr %13, i32 0, i32 2
  %15 = getelementptr inbounds %struct.mess_2, ptr %14, i32 0, i32 0
  store i32 3, ptr %15, align 8
  %16 = load ptr, ptr %4, align 8
  call void @rw_dev(i32 noundef -4, ptr noundef %16)
  br label %40

17:                                               ; preds = %2
  %18 = load ptr, ptr @fp, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 8
  %20 = load i16, ptr %19, align 2
  %21 = zext i16 %20 to i32
  %22 = ashr i32 %21, 8
  %23 = and i32 %22, 255
  store i32 %23, ptr %6, align 4
  %24 = load i32, ptr %6, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %25
  %27 = getelementptr inbounds %struct.dmap, ptr %26, i32 0, i32 3
  %28 = load i32, ptr %27, align 8
  store i32 %28, ptr %5, align 4
  %29 = load ptr, ptr @fp, align 8
  %30 = getelementptr inbounds %struct.fproc, ptr %29, i32 0, i32 8
  %31 = load i16, ptr %30, align 2
  %32 = zext i16 %31 to i32
  %33 = ashr i32 %32, 0
  %34 = and i32 %33, 255
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.message, ptr %35, i32 0, i32 2
  %37 = getelementptr inbounds %struct.mess_2, ptr %36, i32 0, i32 0
  store i32 %34, ptr %37, align 8
  %38 = load i32, ptr %5, align 4
  %39 = load ptr, ptr %4, align 8
  call void @rw_dev(i32 noundef %38, ptr noundef %39)
  br label %40

40:                                               ; preds = %17, %12
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @no_call(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %4, align 8
  %6 = getelementptr inbounds %struct.message, ptr %5, i32 0, i32 2
  %7 = getelementptr inbounds %struct.mess_2, ptr %6, i32 0, i32 1
  store i32 0, ptr %7, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @tty_open(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = getelementptr inbounds %struct.message, ptr %7, i32 0, i32 2
  %9 = getelementptr inbounds %struct.mess_2, ptr %8, i32 0, i32 1
  store i32 0, ptr %9, align 4
  %10 = load ptr, ptr @fp, align 8
  %11 = getelementptr inbounds %struct.fproc, ptr %10, i32 0, i32 15
  %12 = load i32, ptr %11, align 8
  %13 = load ptr, ptr @fp, align 8
  %14 = getelementptr inbounds %struct.fproc, ptr %13, i32 0, i32 16
  %15 = load i32, ptr %14, align 4
  %16 = icmp ne i32 %12, %15
  br i1 %16, label %17, label %18

17:                                               ; preds = %2
  br label %84

18:                                               ; preds = %2
  %19 = load ptr, ptr @fp, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 8
  %21 = load i16, ptr %20, align 2
  %22 = zext i16 %21 to i32
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %25

24:                                               ; preds = %18
  br label %84

25:                                               ; preds = %18
  store ptr getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 3), ptr %5, align 8
  br label %26

26:                                               ; preds = %41, %25
  %27 = load ptr, ptr %5, align 8
  %28 = icmp ult ptr %27, getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 32)
  br i1 %28, label %29, label %44

29:                                               ; preds = %26
  %30 = load ptr, ptr %5, align 8
  %31 = getelementptr inbounds %struct.fproc, ptr %30, i32 0, i32 8
  %32 = load i16, ptr %31, align 2
  %33 = zext i16 %32 to i32
  %34 = load ptr, ptr %4, align 8
  %35 = getelementptr inbounds %struct.message, ptr %34, i32 0, i32 2
  %36 = getelementptr inbounds %struct.mess_2, ptr %35, i32 0, i32 0
  %37 = load i32, ptr %36, align 8
  %38 = icmp eq i32 %33, %37
  br i1 %38, label %39, label %40

39:                                               ; preds = %29
  br label %84

40:                                               ; preds = %29
  br label %41

41:                                               ; preds = %40
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds %struct.fproc, ptr %42, i32 1
  store ptr %43, ptr %5, align 8
  br label %26

44:                                               ; preds = %26
  %45 = load ptr, ptr %4, align 8
  %46 = getelementptr inbounds %struct.message, ptr %45, i32 0, i32 2
  %47 = getelementptr inbounds %struct.mess_2, ptr %46, i32 0, i32 0
  %48 = load i32, ptr %47, align 8
  %49 = trunc i32 %48 to i16
  %50 = load ptr, ptr @fp, align 8
  %51 = getelementptr inbounds %struct.fproc, ptr %50, i32 0, i32 8
  store i16 %49, ptr %51, align 2
  %52 = load ptr, ptr %4, align 8
  %53 = getelementptr inbounds %struct.message, ptr %52, i32 0, i32 2
  %54 = getelementptr inbounds %struct.mess_2, ptr %53, i32 0, i32 0
  %55 = load i32, ptr %54, align 8
  %56 = ashr i32 %55, 8
  %57 = and i32 %56, 255
  store i32 %57, ptr %6, align 4
  %58 = load ptr, ptr %4, align 8
  %59 = getelementptr inbounds %struct.message, ptr %58, i32 0, i32 2
  %60 = getelementptr inbounds %struct.mess_2, ptr %59, i32 0, i32 0
  %61 = load i32, ptr %60, align 8
  %62 = ashr i32 %61, 0
  %63 = and i32 %62, 255
  %64 = load ptr, ptr %4, align 8
  %65 = getelementptr inbounds %struct.message, ptr %64, i32 0, i32 2
  %66 = getelementptr inbounds %struct.mess_2, ptr %65, i32 0, i32 0
  store i32 %63, ptr %66, align 8
  %67 = load ptr, ptr %4, align 8
  %68 = getelementptr inbounds %struct.message, ptr %67, i32 0, i32 1
  store i32 6, ptr %68, align 4
  %69 = load i32, ptr @who, align 4
  %70 = load ptr, ptr %4, align 8
  %71 = getelementptr inbounds %struct.message, ptr %70, i32 0, i32 2
  %72 = getelementptr inbounds %struct.mess_2, ptr %71, i32 0, i32 1
  store i32 %69, ptr %72, align 4
  %73 = load i32, ptr @who, align 4
  %74 = load ptr, ptr %4, align 8
  %75 = getelementptr inbounds %struct.message, ptr %74, i32 0, i32 2
  %76 = getelementptr inbounds %struct.mess_2, ptr %75, i32 0, i32 2
  store i32 %73, ptr %76, align 8
  %77 = load i32, ptr %6, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %78
  %80 = getelementptr inbounds %struct.dmap, ptr %79, i32 0, i32 1
  %81 = load ptr, ptr %80, align 8
  %82 = load i32, ptr %3, align 4
  %83 = load ptr, ptr %4, align 8
  call void (i32, ptr, ...) %81(i32 noundef %82, ptr noundef %83)
  br label %84

84:                                               ; preds = %44, %39, %24, %17
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @tty_exit() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i16, align 2
  %3 = load ptr, ptr @fp, align 8
  %4 = getelementptr inbounds %struct.fproc, ptr %3, i32 0, i32 8
  %5 = load i16, ptr %4, align 2
  store i16 %5, ptr %2, align 2
  store ptr getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 3), ptr %1, align 8
  br label %6

6:                                                ; preds = %21, %0
  %7 = load ptr, ptr %1, align 8
  %8 = icmp ult ptr %7, getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 32)
  br i1 %8, label %9, label %24

9:                                                ; preds = %6
  %10 = load ptr, ptr %1, align 8
  %11 = getelementptr inbounds %struct.fproc, ptr %10, i32 0, i32 8
  %12 = load i16, ptr %11, align 2
  %13 = zext i16 %12 to i32
  %14 = load i16, ptr %2, align 2
  %15 = zext i16 %14 to i32
  %16 = icmp eq i32 %13, %15
  br i1 %16, label %17, label %20

17:                                               ; preds = %9
  %18 = load ptr, ptr %1, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 8
  store i16 0, ptr %19, align 2
  br label %20

20:                                               ; preds = %17, %9
  br label %21

21:                                               ; preds = %20
  %22 = load ptr, ptr %1, align 8
  %23 = getelementptr inbounds %struct.fproc, ptr %22, i32 1
  store ptr %23, ptr %1, align 8
  br label %6

24:                                               ; preds = %6
  %25 = load i16, ptr %2, align 2
  %26 = zext i16 %25 to i32
  call void @find_dev(i32 noundef %26)
  store i32 6, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 1), align 4
  %27 = load i16, ptr %2, align 2
  %28 = zext i16 %27 to i32
  %29 = ashr i32 %28, 0
  %30 = and i32 %29, 255
  store i32 %30, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), align 8
  %31 = load i32, ptr @who, align 4
  store i32 %31, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @dev_mess, i32 0, i32 2), i32 0, i32 2), align 8
  %32 = load i32, ptr @major, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %33
  %35 = getelementptr inbounds %struct.dmap, ptr %34, i32 0, i32 1
  %36 = load ptr, ptr %35, align 8
  %37 = load i32, ptr @task, align 4
  call void (i32, ptr, ...) %36(i32 noundef %37, ptr noundef @dev_mess)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @find_dev(i32 noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = trunc i32 %0 to i16
  store i16 %3, ptr %2, align 2
  %4 = load i16, ptr %2, align 2
  %5 = zext i16 %4 to i32
  %6 = ashr i32 %5, 8
  %7 = and i32 %6, 255
  store i32 %7, ptr @major, align 4
  %8 = load i16, ptr %2, align 2
  %9 = zext i16 %8 to i32
  %10 = ashr i32 %9, 0
  %11 = and i32 %10, 255
  store i32 %11, ptr @minor, align 4
  %12 = load i32, ptr @major, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %18, label %14

14:                                               ; preds = %1
  %15 = load i32, ptr @major, align 4
  %16 = load i32, ptr @max_major, align 4
  %17 = icmp sge i32 %15, %16
  br i1 %17, label %18, label %20

18:                                               ; preds = %14, %1
  %19 = load i32, ptr @major, align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str.2, i32 noundef %19)
  br label %20

20:                                               ; preds = %18, %14
  %21 = load i32, ptr @major, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %22
  %24 = getelementptr inbounds %struct.dmap, ptr %23, i32 0, i32 3
  %25 = load i32, ptr %24, align 8
  store i32 %25, ptr @task, align 4
  ret void
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
