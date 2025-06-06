; NOTE: Generated from src/fs/main.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/main.c'
source_filename = "src/fs/main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.buf = type { %union.anon.0, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon.0 = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.dmap = type { ptr, ptr, ptr, i32 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }

@fproc = external global [32 x %struct.fproc], align 16
@who = external global i32, align 4
@fp = external global ptr, align 8
@super_user = external global i32, align 4
@dont_reply = external global i32, align 4
@fs_call = external global i32, align 4
@call_vector = external global [0 x ptr], align 8
@rdahed_inode = external global ptr, align 8
@m1 = external global %struct.message, align 8
@boot_parameters = dso_local global %struct.bparam_s { i16 256, i16 512, i16 0, i16 13, i16 0 }, align 2
@reviving = external global i32, align 4
@m = external global %struct.message, align 8
@.str = private unnamed_addr constant [32 x i8] c"get_work couldn't revive anyone\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"fs receive error\00", align 1
@.str.2 = private unnamed_addr constant [29 x i8] c"BLOCK_SIZE % INODE_SIZE != 0\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"inode size != 32\00", align 1
@bufs_in_use = external global i32, align 4
@buf = external global [30 x %struct.buf], align 16
@front = external global ptr, align 8
@rear = external global ptr, align 8
@buf_hash = external global [32 x ptr], align 16
@data_org = external global [4 x i16], align 2
@.str.4 = private unnamed_addr constant [56 x i8] c"Booting MINIX 1.5.  Copyright 1991 Prentice-Hall, Inc.\0A\00", align 1
@super_block = external global [5 x %struct.super_block], align 16
@.str.5 = private unnamed_addr constant [25 x i8] c"Invalid root file system\00", align 1
@.str.6 = private unnamed_addr constant [33 x i8] c"RAM disk is too big. # blocks = \00", align 1
@.str.7 = private unnamed_addr constant [22 x i8] c"FS Can't report to MM\00", align 1
@.str.8 = private unnamed_addr constant [25 x i8] c"Can't report size to MEM\00", align 1
@.str.9 = private unnamed_addr constant [63 x i8] c"\0DRAM disk loaded.    Please remove root diskette.           \0A\0A\00", align 1
@.str.10 = private unnamed_addr constant [63 x i8] c"\0DRAM disk loaded.                                           \0A\0A\00", align 1
@.str.11 = private unnamed_addr constant [60 x i8] c"Insert ROOT diskette and hit RETURN (or specify bootdev) %c\00", align 1
@.str.12 = private unnamed_addr constant [58 x i8] c"Loading RAM disk. To load: %4DK           Loaded:   0K %c\00", align 1
@dmap = external global [0 x %struct.dmap], align 8
@.str.13 = private unnamed_addr constant [29 x i8] c"Disk error loading BOOT disk\00", align 1
@.str.14 = private unnamed_addr constant [14 x i8] c"\08\08\08\08\08\08%4DK %c\00", align 1
@.str.15 = private unnamed_addr constant [9 x i8] c"lastused\00", align 1
@.str.16 = private unnamed_addr constant [54 x i8] c"Root file system corrupted.  Possibly wrong diskette.\00", align 1
@.str.17 = private unnamed_addr constant [31 x i8] c"init: can't load root bit maps\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @main() #0 {
  %1 = alloca i32, align 4
  call void @fs_init()
  br label %2

2:                                                ; preds = %0, %28, %35
  call void @get_work()
  %3 = load i32, ptr @who, align 4
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %4
  store ptr %5, ptr @fp, align 8
  %6 = load ptr, ptr @fp, align 8
  %7 = getelementptr inbounds %struct.fproc, ptr %6, i32 0, i32 5
  %8 = load i16, ptr %7, align 2
  %9 = zext i16 %8 to i32
  %10 = icmp eq i32 %9, 0
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, i32 1, i32 0
  store i32 %12, ptr @super_user, align 4
  store i32 0, ptr @dont_reply, align 4
  %13 = load i32, ptr @fs_call, align 4
  %14 = icmp slt i32 %13, 0
  br i1 %14, label %18, label %15

15:                                               ; preds = %2
  %16 = load i32, ptr @fs_call, align 4
  %17 = icmp sge i32 %16, 70
  br i1 %17, label %18, label %19

18:                                               ; preds = %15, %2
  store i32 -102, ptr %1, align 4
  br label %25

19:                                               ; preds = %15
  %20 = load i32, ptr @fs_call, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [0 x ptr], ptr @call_vector, i64 0, i64 %21
  %23 = load ptr, ptr %22, align 8
  %24 = call i32 (...) %23()
  store i32 %24, ptr %1, align 4
  br label %25

25:                                               ; preds = %19, %18
  %26 = load i32, ptr @dont_reply, align 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %25
  br label %2

29:                                               ; preds = %25
  %30 = load i32, ptr @who, align 4
  %31 = load i32, ptr %1, align 4
  call void @reply(i32 noundef %30, i32 noundef %31)
  %32 = load ptr, ptr @rdahed_inode, align 8
  %33 = icmp ne ptr %32, null
  br i1 %33, label %34, label %35

34:                                               ; preds = %29
  call void (...) @read_ahead()
  br label %35

35:                                               ; preds = %34, %29
  br label %2
}

declare void @read_ahead(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reply(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  store i32 %5, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  %6 = load i32, ptr %3, align 4
  %7 = call i32 (i32, ptr, ...) @send(i32 noundef %6, ptr noundef @m1)
  ret void
}

declare i32 @send(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @get_work() #0 {
  %1 = alloca ptr, align 8
  %2 = load i32, ptr @reviving, align 4
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %46

4:                                                ; preds = %0
  store ptr @fproc, ptr %1, align 8
  br label %5

5:                                                ; preds = %42, %4
  %6 = load ptr, ptr %1, align 8
  %7 = icmp ult ptr %6, getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 32)
  br i1 %7, label %8, label %45

8:                                                ; preds = %5
  %9 = load ptr, ptr %1, align 8
  %10 = getelementptr inbounds %struct.fproc, ptr %9, i32 0, i32 13
  %11 = load i8, ptr %10, align 1
  %12 = sext i8 %11 to i32
  %13 = icmp eq i32 %12, 1
  br i1 %13, label %14, label %41

14:                                               ; preds = %8
  %15 = load ptr, ptr %1, align 8
  %16 = ptrtoint ptr %15 to i64
  %17 = sub i64 %16, ptrtoint (ptr @fproc to i64)
  %18 = sdiv exact i64 %17, 224
  %19 = trunc i64 %18 to i32
  store i32 %19, ptr @who, align 4
  %20 = load ptr, ptr %1, align 8
  %21 = getelementptr inbounds %struct.fproc, ptr %20, i32 0, i32 9
  %22 = load i32, ptr %21, align 8
  %23 = and i32 %22, 255
  store i32 %23, ptr @fs_call, align 4
  %24 = load ptr, ptr %1, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 9
  %26 = load i32, ptr %25, align 8
  %27 = ashr i32 %26, 8
  %28 = and i32 %27, 255
  store i32 %28, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %29 = load ptr, ptr %1, align 8
  %30 = getelementptr inbounds %struct.fproc, ptr %29, i32 0, i32 10
  %31 = load ptr, ptr %30, align 8
  store ptr %31, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %32 = load ptr, ptr %1, align 8
  %33 = getelementptr inbounds %struct.fproc, ptr %32, i32 0, i32 11
  %34 = load i32, ptr %33, align 8
  store i32 %34, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %35 = load ptr, ptr %1, align 8
  %36 = getelementptr inbounds %struct.fproc, ptr %35, i32 0, i32 12
  store i8 0, ptr %36, align 4
  %37 = load ptr, ptr %1, align 8
  %38 = getelementptr inbounds %struct.fproc, ptr %37, i32 0, i32 13
  store i8 0, ptr %38, align 1
  %39 = load i32, ptr @reviving, align 4
  %40 = add nsw i32 %39, -1
  store i32 %40, ptr @reviving, align 4
  br label %53

41:                                               ; preds = %8
  br label %42

42:                                               ; preds = %41
  %43 = load ptr, ptr %1, align 8
  %44 = getelementptr inbounds %struct.fproc, ptr %43, i32 1
  store ptr %44, ptr %1, align 8
  br label %5

45:                                               ; preds = %5
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef 32768)
  br label %46

46:                                               ; preds = %45, %0
  %47 = call i32 (i32, ptr, ...) @receive(i32 noundef 132, ptr noundef @m)
  %48 = icmp ne i32 %47, 0
  br i1 %48, label %49, label %50

49:                                               ; preds = %46
  call void (ptr, i32, ...) @panic(ptr noundef @.str.1, i32 noundef 32768)
  br label %50

50:                                               ; preds = %49, %46
  %51 = load i32, ptr @m, align 8
  store i32 %51, ptr @who, align 4
  %52 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 1), align 4
  store i32 %52, ptr @fs_call, align 4
  br label %53

53:                                               ; preds = %50, %14
  ret void
}

declare void @panic(...) #1

declare i32 @receive(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @fs_init() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = alloca i16, align 2
  call void @buf_pool()
  call void @get_boot_parameters()
  %4 = call zeroext i16 @load_ram()
  store i16 %4, ptr %3, align 2
  %5 = load i16, ptr %3, align 2
  %6 = zext i16 %5 to i32
  call void @load_super(i32 noundef %6)
  store i32 0, ptr %2, align 4
  br label %7

7:                                                ; preds = %34, %0
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %8, 3
  br i1 %9, label %10, label %37

10:                                               ; preds = %7
  %11 = load i32, ptr %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %12
  store ptr %13, ptr @fp, align 8
  %14 = load i16, ptr @boot_parameters, align 2
  %15 = zext i16 %14 to i32
  %16 = call ptr (i32, i32, ...) @get_inode(i32 noundef %15, i32 noundef 1)
  store ptr %16, ptr %1, align 8
  %17 = load ptr, ptr %1, align 8
  %18 = load ptr, ptr @fp, align 8
  %19 = getelementptr inbounds %struct.fproc, ptr %18, i32 0, i32 2
  store ptr %17, ptr %19, align 8
  %20 = load ptr, ptr %1, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %20)
  %21 = load ptr, ptr %1, align 8
  %22 = load ptr, ptr @fp, align 8
  %23 = getelementptr inbounds %struct.fproc, ptr %22, i32 0, i32 1
  store ptr %21, ptr %23, align 8
  %24 = load ptr, ptr @fp, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 4
  store i16 0, ptr %25, align 8
  %26 = load ptr, ptr @fp, align 8
  %27 = getelementptr inbounds %struct.fproc, ptr %26, i32 0, i32 5
  store i16 0, ptr %27, align 2
  %28 = load ptr, ptr @fp, align 8
  %29 = getelementptr inbounds %struct.fproc, ptr %28, i32 0, i32 6
  store i8 0, ptr %29, align 4
  %30 = load ptr, ptr @fp, align 8
  %31 = getelementptr inbounds %struct.fproc, ptr %30, i32 0, i32 7
  store i8 0, ptr %31, align 1
  %32 = load ptr, ptr @fp, align 8
  %33 = getelementptr inbounds %struct.fproc, ptr %32, i32 0, i32 0
  store i16 -1, ptr %33, align 8
  br label %34

34:                                               ; preds = %10
  %35 = load i32, ptr %2, align 4
  %36 = add nsw i32 %35, 2
  store i32 %36, ptr %2, align 4
  br label %7

37:                                               ; preds = %7
  call void (ptr, i32, ...) @panic(ptr noundef @.str.2, i32 noundef 32768)
  call void (ptr, i32, ...) @panic(ptr noundef @.str.3, i32 noundef 32768)
  ret void
}

declare ptr @get_inode(...) #1

declare void @dup_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @buf_pool() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i32 0, ptr @bufs_in_use, align 4
  store ptr @buf, ptr @front, align 8
  store ptr getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 29), ptr @rear, align 8
  store ptr @buf, ptr %1, align 8
  br label %5

5:                                                ; preds = %21, %0
  %6 = load ptr, ptr %1, align 8
  %7 = icmp ult ptr %6, getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 30)
  br i1 %7, label %8, label %24

8:                                                ; preds = %5
  %9 = load ptr, ptr %1, align 8
  %10 = getelementptr inbounds %struct.buf, ptr %9, i32 0, i32 4
  store i16 0, ptr %10, align 8
  %11 = load ptr, ptr %1, align 8
  %12 = getelementptr inbounds %struct.buf, ptr %11, i32 0, i32 5
  store i16 -1, ptr %12, align 2
  %13 = load ptr, ptr %1, align 8
  %14 = getelementptr inbounds %struct.buf, ptr %13, i64 1
  %15 = load ptr, ptr %1, align 8
  %16 = getelementptr inbounds %struct.buf, ptr %15, i32 0, i32 1
  store ptr %14, ptr %16, align 8
  %17 = load ptr, ptr %1, align 8
  %18 = getelementptr inbounds %struct.buf, ptr %17, i64 -1
  %19 = load ptr, ptr %1, align 8
  %20 = getelementptr inbounds %struct.buf, ptr %19, i32 0, i32 2
  store ptr %18, ptr %20, align 8
  br label %21

21:                                               ; preds = %8
  %22 = load ptr, ptr %1, align 8
  %23 = getelementptr inbounds %struct.buf, ptr %22, i32 1
  store ptr %23, ptr %1, align 8
  br label %5

24:                                               ; preds = %5
  store ptr null, ptr getelementptr inbounds (%struct.buf, ptr @buf, i32 0, i32 2), align 8
  store ptr null, ptr getelementptr inbounds (%struct.buf, ptr getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 29), i32 0, i32 1), align 16
  store ptr @buf, ptr %1, align 8
  br label %25

25:                                               ; preds = %34, %24
  %26 = load ptr, ptr %1, align 8
  %27 = icmp ult ptr %26, getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 30)
  br i1 %27, label %28, label %37

28:                                               ; preds = %25
  %29 = load ptr, ptr %1, align 8
  %30 = getelementptr inbounds %struct.buf, ptr %29, i32 0, i32 1
  %31 = load ptr, ptr %30, align 8
  %32 = load ptr, ptr %1, align 8
  %33 = getelementptr inbounds %struct.buf, ptr %32, i32 0, i32 3
  store ptr %31, ptr %33, align 8
  br label %34

34:                                               ; preds = %28
  %35 = load ptr, ptr %1, align 8
  %36 = getelementptr inbounds %struct.buf, ptr %35, i32 1
  store ptr %36, ptr %1, align 8
  br label %25

37:                                               ; preds = %25
  %38 = load ptr, ptr @front, align 8
  store ptr %38, ptr @buf_hash, align 16
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @get_boot_parameters() #0 {
  %1 = alloca %struct.bparam_s, align 2
  store i32 12, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  store i32 1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  store ptr %1, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  %2 = call i32 (i32, ptr, ...) @sendrec(i32 noundef -2, ptr noundef @m1)
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %4
  call void @llvm.memcpy.p0.p0.i64(ptr align 2 @boot_parameters, ptr align 2 %1, i64 10, i1 false)
  br label %8

8:                                                ; preds = %7, %4, %0
  ret void
}

declare i32 @sendrec(...) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i16 @load_ram() #0 {
  %1 = alloca i16, align 2
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i16, align 2
  %11 = alloca i16, align 2
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store i16 0, ptr %7, align 2
  %16 = load i16, ptr getelementptr inbounds ([4 x i16], ptr @data_org, i64 0, i64 2), align 2
  %17 = zext i16 %16 to i32
  store i32 %17, ptr %13, align 4
  %18 = load i16, ptr getelementptr inbounds ([4 x i16], ptr @data_org, i64 0, i64 3), align 2
  %19 = zext i16 %18 to i32
  store i32 %19, ptr %14, align 4
  %20 = load i16, ptr getelementptr inbounds ([4 x i16], ptr @data_org, i64 0, i64 4), align 2
  %21 = zext i16 %20 to i32
  store i32 %21, ptr %15, align 4
  call void (ptr, ...) @printk(ptr noundef @.str.4)
  %22 = load i16, ptr @boot_parameters, align 2
  %23 = zext i16 %22 to i32
  %24 = icmp ne i32 %23, 256
  br i1 %24, label %25, label %29

25:                                               ; preds = %0
  %26 = load i16, ptr getelementptr inbounds (%struct.bparam_s, ptr @boot_parameters, i32 0, i32 2), align 2
  %27 = zext i16 %26 to i32
  store i32 %27, ptr %4, align 4
  %28 = load i16, ptr @boot_parameters, align 2
  store i16 %28, ptr %11, align 2
  br label %79

29:                                               ; preds = %0
  store i16 256, ptr %11, align 2
  br label %30

30:                                               ; preds = %29
  %31 = call i32 @askdev()
  %32 = trunc i32 %31 to i16
  store i16 %32, ptr %10, align 2
  %33 = load i16, ptr %10, align 2
  %34 = zext i16 %33 to i32
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %30
  %37 = load i16, ptr getelementptr inbounds (%struct.bparam_s, ptr @boot_parameters, i32 0, i32 1), align 2
  store i16 %37, ptr %10, align 2
  br label %38

38:                                               ; preds = %36, %30
  %39 = load i16, ptr %10, align 2
  %40 = zext i16 %39 to i32
  %41 = load i16, ptr %7, align 2
  %42 = zext i16 %41 to i32
  %43 = add nsw i32 1, %42
  %44 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %40, i32 noundef %43, i32 noundef 0)
  store ptr %44, ptr %2, align 8
  %45 = load ptr, ptr %2, align 8
  %46 = getelementptr inbounds %struct.buf, ptr %45, i32 0, i32 0
  %47 = getelementptr inbounds [1024 x i8], ptr %46, i64 0, i64 0
  call void (ptr, ptr, i64, ...) @copy(ptr noundef @super_block, ptr noundef %47, i64 noundef 200)
  store ptr @super_block, ptr %6, align 8
  %48 = load ptr, ptr %6, align 8
  %49 = getelementptr inbounds %struct.super_block, ptr %48, i32 0, i32 7
  %50 = load i16, ptr %49, align 8
  %51 = sext i16 %50 to i32
  %52 = icmp ne i32 %51, 4991
  br i1 %52, label %53, label %68

53:                                               ; preds = %38
  %54 = load ptr, ptr %2, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %54, i32 noundef 6)
  store i16 771, ptr %10, align 2
  %55 = load i16, ptr %10, align 2
  %56 = zext i16 %55 to i32
  %57 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %56, i32 noundef 1, i32 noundef 0)
  store ptr %57, ptr %2, align 8
  %58 = load ptr, ptr %2, align 8
  %59 = getelementptr inbounds %struct.buf, ptr %58, i32 0, i32 0
  %60 = getelementptr inbounds [1024 x i8], ptr %59, i64 0, i64 0
  call void (ptr, ptr, i64, ...) @copy(ptr noundef @super_block, ptr noundef %60, i64 noundef 200)
  store ptr @super_block, ptr %6, align 8
  %61 = load ptr, ptr %6, align 8
  %62 = getelementptr inbounds %struct.super_block, ptr %61, i32 0, i32 7
  %63 = load i16, ptr %62, align 8
  %64 = sext i16 %63 to i32
  %65 = icmp ne i32 %64, 4991
  br i1 %65, label %66, label %67

66:                                               ; preds = %53
  call void (ptr, i32, ...) @panic(ptr noundef @.str.5, i32 noundef 32768)
  br label %67

67:                                               ; preds = %66, %53
  br label %68

68:                                               ; preds = %67, %38
  %69 = load ptr, ptr %6, align 8
  %70 = getelementptr inbounds %struct.super_block, ptr %69, i32 0, i32 1
  %71 = load i16, ptr %70, align 2
  %72 = zext i16 %71 to i32
  %73 = load ptr, ptr %6, align 8
  %74 = getelementptr inbounds %struct.super_block, ptr %73, i32 0, i32 5
  %75 = load i16, ptr %74, align 2
  %76 = sext i16 %75 to i32
  %77 = shl i32 %72, %76
  store i32 %77, ptr %4, align 4
  %78 = load ptr, ptr %2, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %78, i32 noundef 6)
  br label %79

79:                                               ; preds = %68, %25
  %80 = load i32, ptr %4, align 4
  %81 = icmp sgt i32 %80, 16384
  br i1 %81, label %82, label %84

82:                                               ; preds = %79
  %83 = load i32, ptr %4, align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str.6, i32 noundef %83)
  br label %84

84:                                               ; preds = %82, %79
  %85 = load i32, ptr %4, align 4
  %86 = mul nsw i32 %85, 4
  store i32 %86, ptr %12, align 4
  store i32 66, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  %87 = load i32, ptr %14, align 4
  store i32 %87, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  %88 = load i32, ptr %15, align 4
  store i32 %88, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 4
  %89 = load i32, ptr %13, align 4
  %90 = load i32, ptr %14, align 4
  %91 = add i32 %89, %90
  %92 = load i32, ptr %15, align 4
  %93 = add i32 %91, %92
  %94 = load i32, ptr %12, align 4
  %95 = add i32 %93, %94
  store i32 %95, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 2), align 8
  %96 = load i32, ptr %13, align 4
  %97 = sext i32 %96 to i64
  %98 = inttoptr i64 %97 to ptr
  store ptr %98, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  %99 = call i32 (i32, ptr, ...) @sendrec(i32 noundef 0, ptr noundef @m1)
  %100 = icmp ne i32 %99, 0
  br i1 %100, label %101, label %102

101:                                              ; preds = %84
  call void (ptr, i32, ...) @panic(ptr noundef @.str.7, i32 noundef 32768)
  br label %102

102:                                              ; preds = %101, %84
  store i32 5, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  %103 = load i32, ptr %4, align 4
  store i32 %103, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 2), align 8
  %104 = call i32 (i32, ptr, ...) @sendrec(i32 noundef -4, ptr noundef @m1)
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %106, label %107

106:                                              ; preds = %102
  call void (ptr, i32, ...) @panic(ptr noundef @.str.8, i32 noundef 32768)
  br label %107

107:                                              ; preds = %106, %102
  %108 = load i16, ptr @boot_parameters, align 2
  %109 = zext i16 %108 to i32
  %110 = icmp ne i32 %109, 256
  br i1 %110, label %111, label %113

111:                                              ; preds = %107
  %112 = load i16, ptr %11, align 2
  store i16 %112, ptr %1, align 2
  br label %127

113:                                              ; preds = %107
  %114 = load i16, ptr %10, align 2
  %115 = zext i16 %114 to i32
  %116 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  %117 = inttoptr i64 %116 to ptr
  call void @fastload(i32 noundef %115, ptr noundef %117)
  %118 = load i16, ptr %10, align 2
  %119 = zext i16 %118 to i32
  %120 = xor i32 %119, 512
  %121 = and i32 %120, -256
  %122 = icmp eq i32 %121, 0
  br i1 %122, label %123, label %124

123:                                              ; preds = %113
  call void (ptr, ...) @printk(ptr noundef @.str.9)
  br label %125

124:                                              ; preds = %113
  call void (ptr, ...) @printk(ptr noundef @.str.10)
  br label %125

125:                                              ; preds = %124, %123
  %126 = load i16, ptr %11, align 2
  store i16 %126, ptr %1, align 2
  br label %127

127:                                              ; preds = %125, %111
  %128 = load i16, ptr %1, align 2
  ret i16 %128
}

declare void @printk(...) #1

declare ptr @get_block(...) #1

declare void @copy(...) #1

declare void @put_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @askdev() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [80 x i8], align 16
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  call void (ptr, i32, ...) @printk(ptr noundef @.str.11, i32 noundef 0)
  store i32 3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 1), align 4
  store i32 0, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  store i32 1, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %8 = getelementptr inbounds [80 x i8], ptr %2, i64 0, i64 0
  store ptr %8, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 5), align 8
  store i32 80, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %9 = call i32 (i32, ptr, ...) @sendrec(i32 noundef -9, ptr noundef @m)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  store i32 0, ptr %1, align 4
  br label %91

12:                                               ; preds = %0
  br label %13

13:                                               ; preds = %21, %12
  %14 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  store i32 -1, ptr %1, align 4
  br label %91

17:                                               ; preds = %13
  %18 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %19 = icmp ne i32 %18, -998
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  br label %23

21:                                               ; preds = %17
  %22 = call i32 (i32, ptr, ...) @receive(i32 noundef -9, ptr noundef @m)
  br label %13

23:                                               ; preds = %20
  %24 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %24, ptr %7, align 4
  %25 = icmp sle i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %23
  store i32 0, ptr %1, align 4
  br label %91

27:                                               ; preds = %23
  %28 = getelementptr inbounds [80 x i8], ptr %2, i64 0, i64 0
  store ptr %28, ptr %3, align 8
  store i32 0, ptr %5, align 4
  br label %29

29:                                               ; preds = %49, %27
  %30 = load i32, ptr %7, align 4
  %31 = add nsw i32 %30, -1
  store i32 %31, ptr %7, align 4
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %33, label %34

33:                                               ; preds = %29
  store i32 0, ptr %1, align 4
  br label %91

34:                                               ; preds = %29
  %35 = load ptr, ptr %3, align 8
  %36 = getelementptr inbounds i8, ptr %35, i32 1
  store ptr %36, ptr %3, align 8
  %37 = load i8, ptr %35, align 1
  %38 = sext i8 %37 to i32
  store i32 %38, ptr %6, align 4
  %39 = load i32, ptr %6, align 4
  %40 = icmp eq i32 %39, 44
  br i1 %40, label %41, label %42

41:                                               ; preds = %34
  br label %55

42:                                               ; preds = %34
  %43 = load i32, ptr %6, align 4
  %44 = icmp slt i32 %43, 48
  br i1 %44, label %48, label %45

45:                                               ; preds = %42
  %46 = load i32, ptr %6, align 4
  %47 = icmp sgt i32 %46, 57
  br i1 %47, label %48, label %49

48:                                               ; preds = %45, %42
  store i32 0, ptr %1, align 4
  br label %91

49:                                               ; preds = %45
  %50 = load i32, ptr %5, align 4
  %51 = mul nsw i32 %50, 10
  %52 = load i32, ptr %6, align 4
  %53 = add nsw i32 %51, %52
  %54 = sub nsw i32 %53, 48
  store i32 %54, ptr %5, align 4
  br label %29

55:                                               ; preds = %41
  store i32 0, ptr %4, align 4
  br label %56

56:                                               ; preds = %76, %55
  %57 = load i32, ptr %7, align 4
  %58 = add nsw i32 %57, -1
  store i32 %58, ptr %7, align 4
  %59 = icmp slt i32 %58, 0
  br i1 %59, label %60, label %61

60:                                               ; preds = %56
  store i32 0, ptr %1, align 4
  br label %91

61:                                               ; preds = %56
  %62 = load ptr, ptr %3, align 8
  %63 = getelementptr inbounds i8, ptr %62, i32 1
  store ptr %63, ptr %3, align 8
  %64 = load i8, ptr %62, align 1
  %65 = sext i8 %64 to i32
  store i32 %65, ptr %6, align 4
  %66 = load i32, ptr %6, align 4
  %67 = icmp eq i32 %66, 10
  br i1 %67, label %68, label %69

68:                                               ; preds = %61
  br label %82

69:                                               ; preds = %61
  %70 = load i32, ptr %6, align 4
  %71 = icmp slt i32 %70, 48
  br i1 %71, label %75, label %72

72:                                               ; preds = %69
  %73 = load i32, ptr %6, align 4
  %74 = icmp sgt i32 %73, 57
  br i1 %74, label %75, label %76

75:                                               ; preds = %72, %69
  store i32 0, ptr %1, align 4
  br label %91

76:                                               ; preds = %72
  %77 = load i32, ptr %4, align 4
  %78 = mul nsw i32 %77, 10
  %79 = load i32, ptr %6, align 4
  %80 = add nsw i32 %78, %79
  %81 = sub nsw i32 %80, 48
  store i32 %81, ptr %4, align 4
  br label %56

82:                                               ; preds = %68
  %83 = load i32, ptr %7, align 4
  %84 = icmp ne i32 %83, 0
  br i1 %84, label %85, label %86

85:                                               ; preds = %82
  store i32 0, ptr %1, align 4
  br label %91

86:                                               ; preds = %82
  %87 = load i32, ptr %5, align 4
  %88 = shl i32 %87, 8
  %89 = load i32, ptr %4, align 4
  %90 = or i32 %88, %89
  store i32 %90, ptr %1, align 4
  br label %91

91:                                               ; preds = %86, %85, %75, %60, %48, %33, %26, %16, %11
  %92 = load i32, ptr %1, align 4
  ret i32 %92
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @fastload(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = trunc i32 %0 to i16
  store i16 %8, ptr %3, align 2
  store ptr %1, ptr %4, align 8
  %9 = load i16, ptr %3, align 2
  %10 = zext i16 %9 to i32
  %11 = call i32 @lastused(i32 noundef %10)
  store i32 %11, ptr %6, align 4
  %12 = load i32, ptr %6, align 4
  %13 = sext i32 %12 to i64
  %14 = mul nsw i64 %13, 1024
  %15 = sdiv i64 %14, 1024
  call void (ptr, i64, i32, ...) @printk(ptr noundef @.str.12, i64 noundef %15, i32 noundef 0)
  store i64 0, ptr %7, align 8
  br label %16

16:                                               ; preds = %57, %2
  %17 = load i32, ptr %6, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %68

19:                                               ; preds = %16
  %20 = load i32, ptr %6, align 4
  store i32 %20, ptr %5, align 4
  %21 = load i32, ptr %5, align 4
  %22 = icmp sgt i32 %21, 18
  br i1 %22, label %23, label %24

23:                                               ; preds = %19
  store i32 18, ptr %5, align 4
  br label %24

24:                                               ; preds = %23, %19
  %25 = load i32, ptr %5, align 4
  %26 = load i32, ptr %6, align 4
  %27 = sub nsw i32 %26, %25
  store i32 %27, ptr %6, align 4
  %28 = load i32, ptr %5, align 4
  %29 = mul nsw i32 %28, 1024
  store i32 %29, ptr %5, align 4
  store i32 3, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 1), align 4
  %30 = load i16, ptr %3, align 2
  %31 = zext i16 %30 to i32
  %32 = ashr i32 %31, 0
  %33 = and i32 %32, 255
  store i32 %33, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), align 8
  %34 = load i64, ptr %7, align 8
  store i64 %34, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 3), align 8
  store i32 -1, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 4
  %35 = load ptr, ptr %4, align 8
  store ptr %35, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 5), align 8
  %36 = load i32, ptr %5, align 4
  store i32 %36, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 2), align 8
  %37 = load i16, ptr %3, align 2
  %38 = zext i16 %37 to i32
  %39 = ashr i32 %38, 8
  %40 = and i32 %39, 255
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %41
  %43 = getelementptr inbounds %struct.dmap, ptr %42, i32 0, i32 1
  %44 = load ptr, ptr %43, align 8
  %45 = load i16, ptr %3, align 2
  %46 = zext i16 %45 to i32
  %47 = ashr i32 %46, 8
  %48 = and i32 %47, 255
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [0 x %struct.dmap], ptr @dmap, i64 0, i64 %49
  %51 = getelementptr inbounds %struct.dmap, ptr %50, i32 0, i32 3
  %52 = load i32, ptr %51, align 8
  call void (i32, ptr, ...) %44(i32 noundef %52, ptr noundef @m1)
  %53 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 4
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %55, label %57

55:                                               ; preds = %24
  %56 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @m1, i32 0, i32 2), i32 0, i32 1), align 4
  call void (ptr, i32, ...) @panic(ptr noundef @.str.13, i32 noundef %56)
  br label %57

57:                                               ; preds = %55, %24
  %58 = load i32, ptr %5, align 4
  %59 = sext i32 %58 to i64
  %60 = load i64, ptr %7, align 8
  %61 = add nsw i64 %60, %59
  store i64 %61, ptr %7, align 8
  %62 = load i32, ptr %5, align 4
  %63 = load ptr, ptr %4, align 8
  %64 = sext i32 %62 to i64
  %65 = getelementptr inbounds i8, ptr %63, i64 %64
  store ptr %65, ptr %4, align 8
  %66 = load i64, ptr %7, align 8
  %67 = sdiv i64 %66, 1024
  call void (ptr, i64, i32, ...) @printk(ptr noundef @.str.14, i64 noundef %67, i32 noundef 0)
  br label %16

68:                                               ; preds = %16
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @lastused(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i16, align 2
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = trunc i32 %0 to i16
  store i16 %14, ptr %3, align 2
  store ptr @super_block, ptr %10, align 8
  %15 = load ptr, ptr %10, align 8
  %16 = getelementptr inbounds %struct.super_block, ptr %15, i32 0, i32 2
  %17 = load i16, ptr %16, align 4
  %18 = zext i16 %17 to i32
  %19 = add nsw i32 2, %18
  store i32 %19, ptr %9, align 4
  %20 = load ptr, ptr %10, align 8
  %21 = getelementptr inbounds %struct.super_block, ptr %20, i32 0, i32 4
  %22 = load i16, ptr %21, align 8
  %23 = zext i16 %22 to i32
  store i32 %23, ptr %8, align 4
  %24 = load i32, ptr %8, align 4
  %25 = sub nsw i32 %24, 1
  store i32 %25, ptr %7, align 4
  store i32 0, ptr %4, align 4
  br label %26

26:                                               ; preds = %93, %1
  %27 = load i32, ptr %4, align 4
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds %struct.super_block, ptr %28, i32 0, i32 3
  %30 = load i16, ptr %29, align 2
  %31 = zext i16 %30 to i32
  %32 = icmp slt i32 %27, %31
  br i1 %32, label %33, label %96

33:                                               ; preds = %26
  %34 = load i16, ptr %3, align 2
  %35 = zext i16 %34 to i32
  %36 = load i32, ptr %9, align 4
  %37 = trunc i32 %36 to i16
  %38 = zext i16 %37 to i32
  %39 = load i32, ptr %4, align 4
  %40 = add nsw i32 %38, %39
  %41 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %35, i32 noundef %40, i32 noundef 0)
  store ptr %41, ptr %11, align 8
  %42 = load ptr, ptr %11, align 8
  %43 = getelementptr inbounds %struct.buf, ptr %42, i32 0, i32 0
  %44 = getelementptr inbounds [1024 x i8], ptr %43, i64 0, i64 0
  store ptr %44, ptr %12, align 8
  %45 = load ptr, ptr %11, align 8
  %46 = getelementptr inbounds %struct.buf, ptr %45, i32 0, i32 0
  %47 = getelementptr inbounds [1024 x i8], ptr %46, i64 0, i64 1024
  store ptr %47, ptr %13, align 8
  br label %48

48:                                               ; preds = %90, %33
  %49 = load ptr, ptr %12, align 8
  %50 = load ptr, ptr %13, align 8
  %51 = icmp ne ptr %49, %50
  br i1 %51, label %52, label %91

52:                                               ; preds = %48
  %53 = load ptr, ptr %12, align 8
  %54 = getelementptr inbounds i16, ptr %53, i32 1
  store ptr %54, ptr %12, align 8
  %55 = load i16, ptr %53, align 2
  %56 = sext i16 %55 to i32
  store i32 %56, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %57

57:                                               ; preds = %87, %52
  %58 = load i32, ptr %6, align 4
  %59 = sext i32 %58 to i64
  %60 = icmp ult i64 %59, 16
  br i1 %60, label %61, label %90

61:                                               ; preds = %57
  %62 = load i32, ptr %8, align 4
  %63 = load ptr, ptr %10, align 8
  %64 = getelementptr inbounds %struct.super_block, ptr %63, i32 0, i32 1
  %65 = load i16, ptr %64, align 2
  %66 = zext i16 %65 to i32
  %67 = icmp eq i32 %62, %66
  br i1 %67, label %68, label %76

68:                                               ; preds = %61
  %69 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %69, i32 noundef 196)
  %70 = load i32, ptr %7, align 4
  %71 = load ptr, ptr %10, align 8
  %72 = getelementptr inbounds %struct.super_block, ptr %71, i32 0, i32 5
  %73 = load i16, ptr %72, align 2
  %74 = sext i16 %73 to i32
  %75 = shl i32 %70, %74
  store i32 %75, ptr %2, align 4
  br label %97

76:                                               ; preds = %61
  %77 = load i32, ptr %5, align 4
  %78 = load i32, ptr %6, align 4
  %79 = ashr i32 %77, %78
  %80 = and i32 %79, 1
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %82, label %84

82:                                               ; preds = %76
  %83 = load i32, ptr %8, align 4
  store i32 %83, ptr %7, align 4
  br label %84

84:                                               ; preds = %82, %76
  %85 = load i32, ptr %8, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, ptr %8, align 4
  br label %87

87:                                               ; preds = %84
  %88 = load i32, ptr %6, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %6, align 4
  br label %57

90:                                               ; preds = %57
  br label %48

91:                                               ; preds = %48
  %92 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %92, i32 noundef 196)
  br label %93

93:                                               ; preds = %91
  %94 = load i32, ptr %4, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %4, align 4
  br label %26

96:                                               ; preds = %26
  call void (ptr, i32, ...) @panic(ptr noundef @.str.15, i32 noundef 32768)
  br label %97

97:                                               ; preds = %96, %68
  %98 = load i32, ptr %2, align 4
  ret i32 %98
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @load_super(i32 noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = trunc i32 %0 to i16
  store i16 %5, ptr %2, align 2
  store ptr @super_block, ptr %3, align 8
  br label %6

6:                                                ; preds = %12, %1
  %7 = load ptr, ptr %3, align 8
  %8 = icmp ult ptr %7, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %8, label %9, label %15

9:                                                ; preds = %6
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.super_block, ptr %10, i32 0, i32 10
  store i16 -1, ptr %11, align 8
  br label %12

12:                                               ; preds = %9
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.super_block, ptr %13, i32 1
  store ptr %14, ptr %3, align 8
  br label %6

15:                                               ; preds = %6
  store ptr @super_block, ptr %3, align 8
  %16 = load i16, ptr %2, align 2
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.super_block, ptr %17, i32 0, i32 10
  store i16 %16, ptr %18, align 8
  %19 = load ptr, ptr %3, align 8
  call void (ptr, i32, ...) @rw_super(ptr noundef %19, i32 noundef 0)
  %20 = load i16, ptr %2, align 2
  %21 = zext i16 %20 to i32
  %22 = call ptr (i32, i32, ...) @get_inode(i32 noundef %21, i32 noundef 1)
  store ptr %22, ptr %4, align 8
  %23 = load ptr, ptr %4, align 8
  %24 = getelementptr inbounds %struct.inode, ptr %23, i32 0, i32 0
  %25 = load i16, ptr %24, align 8
  %26 = zext i16 %25 to i32
  %27 = and i32 %26, 61440
  %28 = icmp ne i32 %27, 16384
  br i1 %28, label %41, label %29

29:                                               ; preds = %15
  %30 = load ptr, ptr %4, align 8
  %31 = getelementptr inbounds %struct.inode, ptr %30, i32 0, i32 5
  %32 = load i8, ptr %31, align 1
  %33 = zext i8 %32 to i32
  %34 = icmp slt i32 %33, 3
  br i1 %34, label %41, label %35

35:                                               ; preds = %29
  %36 = load ptr, ptr %3, align 8
  %37 = getelementptr inbounds %struct.super_block, ptr %36, i32 0, i32 7
  %38 = load i16, ptr %37, align 8
  %39 = sext i16 %38 to i32
  %40 = icmp ne i32 %39, 4991
  br i1 %40, label %41, label %42

41:                                               ; preds = %35, %29, %15
  call void (ptr, i32, ...) @panic(ptr noundef @.str.16, i32 noundef 32768)
  br label %42

42:                                               ; preds = %41, %35
  %43 = load ptr, ptr %4, align 8
  %44 = load ptr, ptr %3, align 8
  %45 = getelementptr inbounds %struct.super_block, ptr %44, i32 0, i32 12
  store ptr %43, ptr %45, align 8
  %46 = load ptr, ptr %4, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %46)
  %47 = load ptr, ptr %4, align 8
  %48 = load ptr, ptr %3, align 8
  %49 = getelementptr inbounds %struct.super_block, ptr %48, i32 0, i32 11
  store ptr %47, ptr %49, align 8
  %50 = load ptr, ptr %3, align 8
  %51 = getelementptr inbounds %struct.super_block, ptr %50, i32 0, i32 14
  store i8 0, ptr %51, align 8
  %52 = load i16, ptr %2, align 2
  %53 = zext i16 %52 to i32
  %54 = call i32 (i32, ...) @load_bit_maps(i32 noundef %53)
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %57

56:                                               ; preds = %42
  call void (ptr, i32, ...) @panic(ptr noundef @.str.17, i32 noundef 32768)
  br label %57

57:                                               ; preds = %56, %42
  ret void
}

declare void @rw_super(...) #1

declare i32 @load_bit_maps(...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
