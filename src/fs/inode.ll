; NOTE: Generated from src/fs/inode.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/inode.c'
source_filename = "src/fs/inode.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.buf = type { %union.anon, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }

@inode = external global [32 x %struct.inode], align 16
@err_code = external global i32, align 4
@.str = private unnamed_addr constant [34 x i8] c"Out of i-nodes on %sdevice %d/%d\0A\00", align 1
@boot_parameters = external global %struct.bparam_s, align 2
@.str.1 = private unnamed_addr constant [6 x i8] c"root \00", align 1
@.str.2 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@fp = external global ptr, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @get_inode(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = trunc i32 %0 to i16
  %9 = trunc i32 %1 to i16
  store i16 %8, ptr %4, align 2
  store i16 %9, ptr %5, align 2
  store ptr null, ptr %7, align 8
  store ptr @inode, ptr %6, align 8
  br label %10

10:                                               ; preds = %45, %2
  %11 = load ptr, ptr %6, align 8
  %12 = icmp ult ptr %11, getelementptr inbounds ([32 x %struct.inode], ptr @inode, i64 0, i64 32)
  br i1 %12, label %13, label %48

13:                                               ; preds = %10
  %14 = load ptr, ptr %6, align 8
  %15 = getelementptr inbounds %struct.inode, ptr %14, i32 0, i32 11
  %16 = load i16, ptr %15, align 4
  %17 = sext i16 %16 to i32
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %19, label %42

19:                                               ; preds = %13
  %20 = load ptr, ptr %6, align 8
  %21 = getelementptr inbounds %struct.inode, ptr %20, i32 0, i32 9
  %22 = load i16, ptr %21, align 8
  %23 = zext i16 %22 to i32
  %24 = load i16, ptr %4, align 2
  %25 = zext i16 %24 to i32
  %26 = icmp eq i32 %23, %25
  br i1 %26, label %27, label %41

27:                                               ; preds = %19
  %28 = load ptr, ptr %6, align 8
  %29 = getelementptr inbounds %struct.inode, ptr %28, i32 0, i32 10
  %30 = load i16, ptr %29, align 2
  %31 = zext i16 %30 to i32
  %32 = load i16, ptr %5, align 2
  %33 = zext i16 %32 to i32
  %34 = icmp eq i32 %31, %33
  br i1 %34, label %35, label %41

35:                                               ; preds = %27
  %36 = load ptr, ptr %6, align 8
  %37 = getelementptr inbounds %struct.inode, ptr %36, i32 0, i32 11
  %38 = load i16, ptr %37, align 4
  %39 = add i16 %38, 1
  store i16 %39, ptr %37, align 4
  %40 = load ptr, ptr %6, align 8
  store ptr %40, ptr %3, align 8
  br label %70

41:                                               ; preds = %27, %19
  br label %44

42:                                               ; preds = %13
  %43 = load ptr, ptr %6, align 8
  store ptr %43, ptr %7, align 8
  br label %44

44:                                               ; preds = %42, %41
  br label %45

45:                                               ; preds = %44
  %46 = load ptr, ptr %6, align 8
  %47 = getelementptr inbounds %struct.inode, ptr %46, i32 1
  store ptr %47, ptr %6, align 8
  br label %10

48:                                               ; preds = %10
  %49 = load ptr, ptr %7, align 8
  %50 = icmp eq ptr %49, null
  br i1 %50, label %51, label %52

51:                                               ; preds = %48
  store i32 -23, ptr @err_code, align 4
  store ptr null, ptr %3, align 8
  br label %70

52:                                               ; preds = %48
  %53 = load i16, ptr %4, align 2
  %54 = load ptr, ptr %7, align 8
  %55 = getelementptr inbounds %struct.inode, ptr %54, i32 0, i32 9
  store i16 %53, ptr %55, align 8
  %56 = load i16, ptr %5, align 2
  %57 = load ptr, ptr %7, align 8
  %58 = getelementptr inbounds %struct.inode, ptr %57, i32 0, i32 10
  store i16 %56, ptr %58, align 2
  %59 = load ptr, ptr %7, align 8
  %60 = getelementptr inbounds %struct.inode, ptr %59, i32 0, i32 11
  store i16 1, ptr %60, align 4
  %61 = load i16, ptr %4, align 2
  %62 = zext i16 %61 to i32
  %63 = icmp ne i32 %62, 65535
  br i1 %63, label %64, label %66

64:                                               ; preds = %52
  %65 = load ptr, ptr %7, align 8
  call void @rw_inode(ptr noundef %65, i32 noundef 0)
  br label %66

66:                                               ; preds = %64, %52
  %67 = load ptr, ptr %7, align 8
  %68 = getelementptr inbounds %struct.inode, ptr %67, i32 0, i32 16
  store i8 0, ptr %68, align 2
  %69 = load ptr, ptr %7, align 8
  store ptr %69, ptr %3, align 8
  br label %70

70:                                               ; preds = %66, %51, %35
  %71 = load ptr, ptr %3, align 8
  ret ptr %71
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @put_inode(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = icmp eq ptr %3, null
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %52

6:                                                ; preds = %1
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.inode, ptr %7, i32 0, i32 11
  %9 = load i16, ptr %8, align 4
  %10 = add i16 %9, -1
  store i16 %10, ptr %8, align 4
  %11 = sext i16 %10 to i32
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %52

13:                                               ; preds = %6
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds %struct.inode, ptr %14, i32 0, i32 5
  %16 = load i8, ptr %15, align 1
  %17 = zext i8 %16 to i32
  %18 = and i32 %17, 255
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %32

20:                                               ; preds = %13
  %21 = load ptr, ptr %2, align 8
  call void (ptr, ...) @truncate(ptr noundef %21)
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.inode, ptr %22, i32 0, i32 0
  store i16 0, ptr %23, align 8
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.inode, ptr %24, i32 0, i32 9
  %26 = load i16, ptr %25, align 8
  %27 = zext i16 %26 to i32
  %28 = load ptr, ptr %2, align 8
  %29 = getelementptr inbounds %struct.inode, ptr %28, i32 0, i32 10
  %30 = load i16, ptr %29, align 2
  %31 = zext i16 %30 to i32
  call void @free_inode(i32 noundef %27, i32 noundef %31)
  br label %41

32:                                               ; preds = %13
  %33 = load ptr, ptr %2, align 8
  %34 = getelementptr inbounds %struct.inode, ptr %33, i32 0, i32 13
  %35 = load i8, ptr %34, align 1
  %36 = sext i8 %35 to i32
  %37 = icmp eq i32 %36, 1
  br i1 %37, label %38, label %40

38:                                               ; preds = %32
  %39 = load ptr, ptr %2, align 8
  call void (ptr, ...) @truncate(ptr noundef %39)
  br label %40

40:                                               ; preds = %38, %32
  br label %41

41:                                               ; preds = %40, %20
  %42 = load ptr, ptr %2, align 8
  %43 = getelementptr inbounds %struct.inode, ptr %42, i32 0, i32 13
  store i8 0, ptr %43, align 1
  %44 = load ptr, ptr %2, align 8
  %45 = getelementptr inbounds %struct.inode, ptr %44, i32 0, i32 12
  %46 = load i8, ptr %45, align 2
  %47 = sext i8 %46 to i32
  %48 = icmp eq i32 %47, 1
  br i1 %48, label %49, label %51

49:                                               ; preds = %41
  %50 = load ptr, ptr %2, align 8
  call void @rw_inode(ptr noundef %50, i32 noundef 1)
  br label %51

51:                                               ; preds = %49, %41
  br label %52

52:                                               ; preds = %5, %51, %6
  ret void
}

declare void @truncate(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @alloc_inode(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i16, align 2
  %11 = alloca i16, align 2
  %12 = trunc i32 %0 to i16
  %13 = trunc i32 %1 to i16
  store i16 %12, ptr %4, align 2
  store i16 %13, ptr %5, align 2
  %14 = load i16, ptr %4, align 2
  %15 = zext i16 %14 to i32
  %16 = call ptr (i32, ...) @get_super(i32 noundef %15)
  store ptr %16, ptr %7, align 8
  %17 = load ptr, ptr %7, align 8
  %18 = getelementptr inbounds %struct.super_block, ptr %17, i32 0, i32 8
  %19 = getelementptr inbounds [8 x ptr], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %7, align 8
  %21 = getelementptr inbounds %struct.super_block, ptr %20, i32 0, i32 0
  %22 = load i16, ptr %21, align 8
  %23 = zext i16 %22 to i32
  %24 = add nsw i32 %23, 1
  %25 = load ptr, ptr %7, align 8
  %26 = getelementptr inbounds %struct.super_block, ptr %25, i32 0, i32 2
  %27 = load i16, ptr %26, align 4
  %28 = zext i16 %27 to i32
  %29 = call zeroext i16 (ptr, i32, i32, i32, ...) @alloc_bit(ptr noundef %19, i32 noundef %24, i32 noundef %28, i32 noundef 0)
  store i16 %29, ptr %11, align 2
  %30 = load i16, ptr %11, align 2
  %31 = zext i16 %30 to i32
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %57

33:                                               ; preds = %2
  store i32 -23, ptr @err_code, align 4
  %34 = load ptr, ptr %7, align 8
  %35 = getelementptr inbounds %struct.super_block, ptr %34, i32 0, i32 10
  %36 = load i16, ptr %35, align 8
  %37 = zext i16 %36 to i32
  %38 = ashr i32 %37, 8
  %39 = and i32 %38, 255
  store i32 %39, ptr %8, align 4
  %40 = load ptr, ptr %7, align 8
  %41 = getelementptr inbounds %struct.super_block, ptr %40, i32 0, i32 10
  %42 = load i16, ptr %41, align 8
  %43 = zext i16 %42 to i32
  %44 = ashr i32 %43, 0
  %45 = and i32 %44, 255
  store i32 %45, ptr %9, align 4
  %46 = load ptr, ptr %7, align 8
  %47 = getelementptr inbounds %struct.super_block, ptr %46, i32 0, i32 10
  %48 = load i16, ptr %47, align 8
  %49 = zext i16 %48 to i32
  %50 = load i16, ptr @boot_parameters, align 2
  %51 = zext i16 %50 to i32
  %52 = icmp eq i32 %49, %51
  %53 = zext i1 %52 to i64
  %54 = select i1 %52, ptr @.str.1, ptr @.str.2
  %55 = load i32, ptr %8, align 4
  %56 = load i32, ptr %9, align 4
  call void (ptr, ptr, i32, i32, ...) @printk(ptr noundef @.str, ptr noundef %54, i32 noundef %55, i32 noundef %56)
  store ptr null, ptr %3, align 8
  br label %91

57:                                               ; preds = %2
  %58 = load i16, ptr %11, align 2
  store i16 %58, ptr %10, align 2
  %59 = load i16, ptr %10, align 2
  %60 = zext i16 %59 to i32
  %61 = call ptr @get_inode(i32 noundef 65535, i32 noundef %60)
  store ptr %61, ptr %6, align 8
  %62 = icmp eq ptr %61, null
  br i1 %62, label %63, label %69

63:                                               ; preds = %57
  %64 = load ptr, ptr %7, align 8
  %65 = getelementptr inbounds %struct.super_block, ptr %64, i32 0, i32 8
  %66 = getelementptr inbounds [8 x ptr], ptr %65, i64 0, i64 0
  %67 = load i16, ptr %11, align 2
  %68 = zext i16 %67 to i32
  call void (ptr, i32, ...) @free_bit(ptr noundef %66, i32 noundef %68)
  br label %89

69:                                               ; preds = %57
  %70 = load i16, ptr %5, align 2
  %71 = load ptr, ptr %6, align 8
  %72 = getelementptr inbounds %struct.inode, ptr %71, i32 0, i32 0
  store i16 %70, ptr %72, align 8
  %73 = load ptr, ptr %6, align 8
  %74 = getelementptr inbounds %struct.inode, ptr %73, i32 0, i32 5
  store i8 0, ptr %74, align 1
  %75 = load ptr, ptr @fp, align 8
  %76 = getelementptr inbounds %struct.fproc, ptr %75, i32 0, i32 5
  %77 = load i16, ptr %76, align 2
  %78 = load ptr, ptr %6, align 8
  %79 = getelementptr inbounds %struct.inode, ptr %78, i32 0, i32 1
  store i16 %77, ptr %79, align 2
  %80 = load ptr, ptr @fp, align 8
  %81 = getelementptr inbounds %struct.fproc, ptr %80, i32 0, i32 7
  %82 = load i8, ptr %81, align 1
  %83 = load ptr, ptr %6, align 8
  %84 = getelementptr inbounds %struct.inode, ptr %83, i32 0, i32 4
  store i8 %82, ptr %84, align 8
  %85 = load i16, ptr %4, align 2
  %86 = load ptr, ptr %6, align 8
  %87 = getelementptr inbounds %struct.inode, ptr %86, i32 0, i32 9
  store i16 %85, ptr %87, align 8
  %88 = load ptr, ptr %6, align 8
  call void @wipe_inode(ptr noundef %88)
  br label %89

89:                                               ; preds = %69, %63
  %90 = load ptr, ptr %6, align 8
  store ptr %90, ptr %3, align 8
  br label %91

91:                                               ; preds = %89, %33
  %92 = load ptr, ptr %3, align 8
  ret ptr %92
}

declare ptr @get_super(...) #1

declare zeroext i16 @alloc_bit(...) #1

declare void @printk(...) #1

declare void @free_bit(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @wipe_inode(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.inode, ptr %4, i32 0, i32 2
  store i64 0, ptr %5, align 8
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.inode, ptr %6, i32 0, i32 16
  store i8 8, ptr %7, align 2
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.inode, ptr %8, i32 0, i32 12
  store i8 1, ptr %9, align 2
  store i32 0, ptr %3, align 4
  br label %10

10:                                               ; preds = %19, %1
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 9
  br i1 %12, label %13, label %22

13:                                               ; preds = %10
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds %struct.inode, ptr %14, i32 0, i32 6
  %16 = load i32, ptr %3, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [9 x i16], ptr %15, i64 0, i64 %17
  store i16 0, ptr %18, align 2
  br label %19

19:                                               ; preds = %13
  %20 = load i32, ptr %3, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %3, align 4
  br label %10

22:                                               ; preds = %10
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_inode(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca ptr, align 8
  %6 = trunc i32 %0 to i16
  %7 = trunc i32 %1 to i16
  store i16 %6, ptr %3, align 2
  store i16 %7, ptr %4, align 2
  %8 = load i16, ptr %3, align 2
  %9 = zext i16 %8 to i32
  %10 = call ptr (i32, ...) @get_super(i32 noundef %9)
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = getelementptr inbounds %struct.super_block, ptr %11, i32 0, i32 8
  %13 = getelementptr inbounds [8 x ptr], ptr %12, i64 0, i64 0
  %14 = load i16, ptr %4, align 2
  %15 = zext i16 %14 to i32
  call void (ptr, i32, ...) @free_bit(ptr noundef %13, i32 noundef %15)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @update_times(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  %4 = call i64 (...) @clock_time()
  store i64 %4, ptr %3, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.inode, ptr %5, i32 0, i32 16
  %7 = load i8, ptr %6, align 2
  %8 = sext i8 %7 to i32
  %9 = and i32 %8, 2
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %15

11:                                               ; preds = %1
  %12 = load i64, ptr %3, align 8
  %13 = load ptr, ptr %2, align 8
  %14 = getelementptr inbounds %struct.inode, ptr %13, i32 0, i32 7
  store i64 %12, ptr %14, align 8
  br label %15

15:                                               ; preds = %11, %1
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.inode, ptr %16, i32 0, i32 16
  %18 = load i8, ptr %17, align 2
  %19 = sext i8 %18 to i32
  %20 = and i32 %19, 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %26

22:                                               ; preds = %15
  %23 = load i64, ptr %3, align 8
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.inode, ptr %24, i32 0, i32 8
  store i64 %23, ptr %25, align 8
  br label %26

26:                                               ; preds = %22, %15
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.inode, ptr %27, i32 0, i32 16
  %29 = load i8, ptr %28, align 2
  %30 = sext i8 %29 to i32
  %31 = and i32 %30, 8
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %37

33:                                               ; preds = %26
  %34 = load i64, ptr %3, align 8
  %35 = load ptr, ptr %2, align 8
  %36 = getelementptr inbounds %struct.inode, ptr %35, i32 0, i32 3
  store i64 %34, ptr %36, align 8
  br label %37

37:                                               ; preds = %33, %26
  %38 = load ptr, ptr %2, align 8
  %39 = getelementptr inbounds %struct.inode, ptr %38, i32 0, i32 16
  store i8 0, ptr %39, align 2
  ret void
}

declare i64 @clock_time(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_inode(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.inode, ptr %9, i32 0, i32 9
  %11 = load i16, ptr %10, align 8
  %12 = zext i16 %11 to i32
  %13 = call ptr (i32, ...) @get_super(i32 noundef %12)
  store ptr %13, ptr %7, align 8
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.inode, ptr %14, i32 0, i32 10
  %16 = load i16, ptr %15, align 2
  %17 = zext i16 %16 to i32
  %18 = sub nsw i32 %17, 1
  %19 = trunc i32 %18 to i16
  %20 = zext i16 %19 to i64
  %21 = udiv i64 %20, 21
  %22 = load ptr, ptr %7, align 8
  %23 = getelementptr inbounds %struct.super_block, ptr %22, i32 0, i32 2
  %24 = load i16, ptr %23, align 4
  %25 = zext i16 %24 to i64
  %26 = add i64 %21, %25
  %27 = load ptr, ptr %7, align 8
  %28 = getelementptr inbounds %struct.super_block, ptr %27, i32 0, i32 3
  %29 = load i16, ptr %28, align 2
  %30 = zext i16 %29 to i64
  %31 = add i64 %26, %30
  %32 = add i64 %31, 2
  %33 = trunc i64 %32 to i16
  store i16 %33, ptr %8, align 2
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %struct.inode, ptr %34, i32 0, i32 9
  %36 = load i16, ptr %35, align 8
  %37 = zext i16 %36 to i32
  %38 = load i16, ptr %8, align 2
  %39 = zext i16 %38 to i32
  %40 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %37, i32 noundef %39, i32 noundef 0)
  store ptr %40, ptr %5, align 8
  %41 = load ptr, ptr %5, align 8
  %42 = getelementptr inbounds %struct.buf, ptr %41, i32 0, i32 0
  %43 = getelementptr inbounds [21 x %struct.d_inode], ptr %42, i64 0, i64 0
  %44 = load ptr, ptr %3, align 8
  %45 = getelementptr inbounds %struct.inode, ptr %44, i32 0, i32 10
  %46 = load i16, ptr %45, align 2
  %47 = zext i16 %46 to i32
  %48 = sub nsw i32 %47, 1
  %49 = sext i32 %48 to i64
  %50 = urem i64 %49, 21
  %51 = getelementptr inbounds %struct.d_inode, ptr %43, i64 %50
  store ptr %51, ptr %6, align 8
  %52 = load i32, ptr %4, align 4
  %53 = icmp eq i32 %52, 0
  br i1 %53, label %54, label %57

54:                                               ; preds = %2
  %55 = load ptr, ptr %3, align 8
  %56 = load ptr, ptr %6, align 8
  call void (ptr, ptr, i64, ...) @copy(ptr noundef %55, ptr noundef %56, i64 noundef 48)
  br label %69

57:                                               ; preds = %2
  %58 = load ptr, ptr %3, align 8
  %59 = getelementptr inbounds %struct.inode, ptr %58, i32 0, i32 16
  %60 = load i8, ptr %59, align 2
  %61 = icmp ne i8 %60, 0
  br i1 %61, label %62, label %64

62:                                               ; preds = %57
  %63 = load ptr, ptr %3, align 8
  call void @update_times(ptr noundef %63)
  br label %64

64:                                               ; preds = %62, %57
  %65 = load ptr, ptr %6, align 8
  %66 = load ptr, ptr %3, align 8
  call void (ptr, ptr, i64, ...) @copy(ptr noundef %65, ptr noundef %66, i64 noundef 48)
  %67 = load ptr, ptr %5, align 8
  %68 = getelementptr inbounds %struct.buf, ptr %67, i32 0, i32 6
  store i8 1, ptr %68, align 4
  br label %69

69:                                               ; preds = %64, %54
  %70 = load ptr, ptr %5, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %70, i32 noundef 0)
  %71 = load ptr, ptr %3, align 8
  %72 = getelementptr inbounds %struct.inode, ptr %71, i32 0, i32 12
  store i8 0, ptr %72, align 2
  ret void
}

declare ptr @get_block(...) #1

declare void @copy(...) #1

declare void @put_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @dup_inode(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.inode, ptr %3, i32 0, i32 11
  %5 = load i16, ptr %4, align 4
  %6 = add i16 %5, 1
  store i16 %6, ptr %4, align 4
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
