; NOTE: Generated from src/fs/stadir.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/stadir.c'
source_filename = "src/fs/stadir.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.stat = type { i16, i16, i16, i16, i16, i16, i16, i64, i64, i64, i64 }

@who = external global i32, align 4
@fproc = external global [32 x %struct.fproc], align 16
@m = external global %struct.message, align 8
@fp = external global ptr, align 8
@super_user = external global i32, align 4
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_chdir() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = load i32, ptr @who, align 4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %42

5:                                                ; preds = %0
  %6 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [32 x %struct.fproc], ptr @fproc, i64 0, i64 %7
  store ptr %8, ptr %2, align 8
  %9 = load ptr, ptr @fp, align 8
  %10 = getelementptr inbounds %struct.fproc, ptr %9, i32 0, i32 1
  %11 = load ptr, ptr %10, align 8
  call void (ptr, ...) @put_inode(ptr noundef %11)
  %12 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %18

14:                                               ; preds = %5
  %15 = load ptr, ptr @fp, align 8
  %16 = getelementptr inbounds %struct.fproc, ptr %15, i32 0, i32 2
  %17 = load ptr, ptr %16, align 8
  br label %22

18:                                               ; preds = %5
  %19 = load ptr, ptr %2, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  br label %22

22:                                               ; preds = %18, %14
  %23 = phi ptr [ %17, %14 ], [ %21, %18 ]
  %24 = load ptr, ptr @fp, align 8
  %25 = getelementptr inbounds %struct.fproc, ptr %24, i32 0, i32 1
  store ptr %23, ptr %25, align 8
  %26 = load ptr, ptr @fp, align 8
  %27 = getelementptr inbounds %struct.fproc, ptr %26, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %28)
  %29 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %32

31:                                               ; preds = %22
  br label %37

32:                                               ; preds = %22
  %33 = load ptr, ptr %2, align 8
  %34 = getelementptr inbounds %struct.fproc, ptr %33, i32 0, i32 5
  %35 = load i16, ptr %34, align 2
  %36 = zext i16 %35 to i32
  br label %37

37:                                               ; preds = %32, %31
  %38 = phi i32 [ 0, %31 ], [ %36, %32 ]
  %39 = trunc i32 %38 to i16
  %40 = load ptr, ptr @fp, align 8
  %41 = getelementptr inbounds %struct.fproc, ptr %40, i32 0, i32 5
  store i16 %39, ptr %41, align 2
  store i32 0, ptr %1, align 4
  br label %48

42:                                               ; preds = %0
  %43 = load ptr, ptr @fp, align 8
  %44 = getelementptr inbounds %struct.fproc, ptr %43, i32 0, i32 1
  %45 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %46 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %47 = call i32 @change(ptr noundef %44, ptr noundef %45, i32 noundef %46)
  store i32 %47, ptr %1, align 4
  br label %48

48:                                               ; preds = %42, %37
  %49 = load i32, ptr %1, align 4
  ret i32 %49
}

declare void @put_inode(...) #1

declare void @dup_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_chroot() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = load i32, ptr @super_user, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %6, label %5

5:                                                ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %13

6:                                                ; preds = %0
  %7 = load ptr, ptr @fp, align 8
  %8 = getelementptr inbounds %struct.fproc, ptr %7, i32 0, i32 2
  %9 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %10 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %11 = call i32 @change(ptr noundef %8, ptr noundef %9, i32 noundef %10)
  store i32 %11, ptr %2, align 4
  %12 = load i32, ptr %2, align 4
  store i32 %12, ptr %1, align 4
  br label %13

13:                                               ; preds = %6, %5
  %14 = load i32, ptr %1, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_stat() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %5 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %6 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %4, i32 noundef %5, i32 noundef 1)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = load i32, ptr @err_code, align 4
  store i32 %9, ptr %1, align 4
  br label %21

10:                                               ; preds = %0
  %11 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %11, ptr %2, align 8
  %12 = icmp eq ptr %11, null
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, ptr @err_code, align 4
  store i32 %14, ptr %1, align 4
  br label %21

15:                                               ; preds = %10
  %16 = load ptr, ptr %2, align 8
  %17 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %18 = call i32 @stat_inode(ptr noundef %16, ptr noundef null, ptr noundef %17)
  store i32 %18, ptr %3, align 4
  %19 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %19)
  %20 = load i32, ptr %3, align 4
  store i32 %20, ptr %1, align 4
  br label %21

21:                                               ; preds = %15, %13, %8
  %22 = load i32, ptr %1, align 4
  ret i32 %22
}

declare i32 @fetch_name(...) #1

declare ptr @eat_path(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_fstat() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %4 = call ptr (i32, ...) @get_filp(i32 noundef %3)
  store ptr %4, ptr %2, align 8
  %5 = icmp eq ptr %4, null
  br i1 %5, label %6, label %8

6:                                                ; preds = %0
  %7 = load i32, ptr @err_code, align 4
  store i32 %7, ptr %1, align 4
  br label %15

8:                                                ; preds = %0
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds %struct.filp, ptr %9, i32 0, i32 3
  %11 = load ptr, ptr %10, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %14 = call i32 @stat_inode(ptr noundef %11, ptr noundef %12, ptr noundef %13)
  store i32 %14, ptr %1, align 4
  br label %15

15:                                               ; preds = %8, %6
  %16 = load i32, ptr %1, align 4
  ret i32 %16
}

declare ptr @get_filp(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @change(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  %10 = load ptr, ptr %6, align 8
  %11 = load i32, ptr %7, align 4
  %12 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %10, i32 noundef %11, i32 noundef 3)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %3
  %15 = load i32, ptr @err_code, align 4
  store i32 %15, ptr %4, align 4
  br label %43

16:                                               ; preds = %3
  %17 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %17, ptr %8, align 8
  %18 = icmp eq ptr %17, null
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = load i32, ptr @err_code, align 4
  store i32 %20, ptr %4, align 4
  br label %43

21:                                               ; preds = %16
  %22 = load ptr, ptr %8, align 8
  %23 = getelementptr inbounds %struct.inode, ptr %22, i32 0, i32 0
  %24 = load i16, ptr %23, align 8
  %25 = zext i16 %24 to i32
  %26 = and i32 %25, 61440
  %27 = icmp ne i32 %26, 16384
  br i1 %27, label %28, label %29

28:                                               ; preds = %21
  store i32 -20, ptr %9, align 4
  br label %32

29:                                               ; preds = %21
  %30 = load ptr, ptr %8, align 8
  %31 = call i32 (ptr, i32, i32, ...) @forbidden(ptr noundef %30, i32 noundef 1, i32 noundef 0)
  store i32 %31, ptr %9, align 4
  br label %32

32:                                               ; preds = %29, %28
  %33 = load i32, ptr %9, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %38

35:                                               ; preds = %32
  %36 = load ptr, ptr %8, align 8
  call void (ptr, ...) @put_inode(ptr noundef %36)
  %37 = load i32, ptr %9, align 4
  store i32 %37, ptr %4, align 4
  br label %43

38:                                               ; preds = %32
  %39 = load ptr, ptr %5, align 8
  %40 = load ptr, ptr %39, align 8
  call void (ptr, ...) @put_inode(ptr noundef %40)
  %41 = load ptr, ptr %8, align 8
  %42 = load ptr, ptr %5, align 8
  store ptr %41, ptr %42, align 8
  store i32 0, ptr %4, align 4
  br label %43

43:                                               ; preds = %38, %35, %19, %14
  %44 = load i32, ptr %4, align 4
  ret i32 %44
}

declare i32 @forbidden(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @stat_inode(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca %struct.stat, align 8
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.inode, ptr %11, i32 0, i32 16
  %13 = load i8, ptr %12, align 2
  %14 = icmp ne i8 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %3
  %16 = load ptr, ptr %4, align 8
  call void (ptr, ...) @update_times(ptr noundef %16)
  br label %17

17:                                               ; preds = %15, %3
  store ptr %8, ptr %7, align 8
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.inode, ptr %18, i32 0, i32 9
  %20 = load i16, ptr %19, align 8
  %21 = zext i16 %20 to i32
  %22 = trunc i32 %21 to i16
  %23 = load ptr, ptr %7, align 8
  %24 = getelementptr inbounds %struct.stat, ptr %23, i32 0, i32 0
  store i16 %22, ptr %24, align 8
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds %struct.inode, ptr %25, i32 0, i32 10
  %27 = load i16, ptr %26, align 2
  %28 = load ptr, ptr %7, align 8
  %29 = getelementptr inbounds %struct.stat, ptr %28, i32 0, i32 1
  store i16 %27, ptr %29, align 2
  %30 = load ptr, ptr %4, align 8
  %31 = getelementptr inbounds %struct.inode, ptr %30, i32 0, i32 0
  %32 = load i16, ptr %31, align 8
  %33 = load ptr, ptr %7, align 8
  %34 = getelementptr inbounds %struct.stat, ptr %33, i32 0, i32 2
  store i16 %32, ptr %34, align 4
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.inode, ptr %35, i32 0, i32 5
  %37 = load i8, ptr %36, align 1
  %38 = zext i8 %37 to i32
  %39 = and i32 %38, 255
  %40 = trunc i32 %39 to i16
  %41 = load ptr, ptr %7, align 8
  %42 = getelementptr inbounds %struct.stat, ptr %41, i32 0, i32 3
  store i16 %40, ptr %42, align 2
  %43 = load ptr, ptr %4, align 8
  %44 = getelementptr inbounds %struct.inode, ptr %43, i32 0, i32 1
  %45 = load i16, ptr %44, align 2
  %46 = load ptr, ptr %7, align 8
  %47 = getelementptr inbounds %struct.stat, ptr %46, i32 0, i32 4
  store i16 %45, ptr %47, align 8
  %48 = load ptr, ptr %4, align 8
  %49 = getelementptr inbounds %struct.inode, ptr %48, i32 0, i32 4
  %50 = load i8, ptr %49, align 8
  %51 = zext i8 %50 to i32
  %52 = and i32 %51, 255
  %53 = trunc i32 %52 to i16
  %54 = load ptr, ptr %7, align 8
  %55 = getelementptr inbounds %struct.stat, ptr %54, i32 0, i32 5
  store i16 %53, ptr %55, align 2
  %56 = load ptr, ptr %4, align 8
  %57 = getelementptr inbounds %struct.inode, ptr %56, i32 0, i32 6
  %58 = getelementptr inbounds [9 x i16], ptr %57, i64 0, i64 0
  %59 = load i16, ptr %58, align 2
  %60 = load ptr, ptr %7, align 8
  %61 = getelementptr inbounds %struct.stat, ptr %60, i32 0, i32 6
  store i16 %59, ptr %61, align 4
  %62 = load ptr, ptr %4, align 8
  %63 = getelementptr inbounds %struct.inode, ptr %62, i32 0, i32 2
  %64 = load i64, ptr %63, align 8
  %65 = load ptr, ptr %7, align 8
  %66 = getelementptr inbounds %struct.stat, ptr %65, i32 0, i32 7
  store i64 %64, ptr %66, align 8
  %67 = load ptr, ptr %4, align 8
  %68 = getelementptr inbounds %struct.inode, ptr %67, i32 0, i32 13
  %69 = load i8, ptr %68, align 1
  %70 = sext i8 %69 to i32
  %71 = icmp eq i32 %70, 1
  br i1 %71, label %72, label %89

72:                                               ; preds = %17
  %73 = load ptr, ptr %5, align 8
  %74 = icmp ne ptr %73, null
  br i1 %74, label %75, label %89

75:                                               ; preds = %72
  %76 = load ptr, ptr %5, align 8
  %77 = getelementptr inbounds %struct.filp, ptr %76, i32 0, i32 0
  %78 = load i16, ptr %77, align 8
  %79 = zext i16 %78 to i32
  %80 = icmp eq i32 %79, 4
  br i1 %80, label %81, label %89

81:                                               ; preds = %75
  %82 = load ptr, ptr %5, align 8
  %83 = getelementptr inbounds %struct.filp, ptr %82, i32 0, i32 4
  %84 = load i64, ptr %83, align 8
  %85 = load ptr, ptr %7, align 8
  %86 = getelementptr inbounds %struct.stat, ptr %85, i32 0, i32 7
  %87 = load i64, ptr %86, align 8
  %88 = sub nsw i64 %87, %84
  store i64 %88, ptr %86, align 8
  br label %89

89:                                               ; preds = %81, %75, %72, %17
  %90 = load ptr, ptr %4, align 8
  %91 = getelementptr inbounds %struct.inode, ptr %90, i32 0, i32 7
  %92 = load i64, ptr %91, align 8
  %93 = load ptr, ptr %7, align 8
  %94 = getelementptr inbounds %struct.stat, ptr %93, i32 0, i32 8
  store i64 %92, ptr %94, align 8
  %95 = load ptr, ptr %4, align 8
  %96 = getelementptr inbounds %struct.inode, ptr %95, i32 0, i32 3
  %97 = load i64, ptr %96, align 8
  %98 = load ptr, ptr %7, align 8
  %99 = getelementptr inbounds %struct.stat, ptr %98, i32 0, i32 9
  store i64 %97, ptr %99, align 8
  %100 = load ptr, ptr %4, align 8
  %101 = getelementptr inbounds %struct.inode, ptr %100, i32 0, i32 8
  %102 = load i64, ptr %101, align 8
  %103 = load ptr, ptr %7, align 8
  %104 = getelementptr inbounds %struct.stat, ptr %103, i32 0, i32 10
  store i64 %102, ptr %104, align 8
  %105 = load ptr, ptr %6, align 8
  %106 = ptrtoint ptr %105 to i64
  store i64 %106, ptr %10, align 8
  %107 = load i32, ptr @who, align 4
  %108 = load i64, ptr %10, align 8
  %109 = load ptr, ptr %7, align 8
  %110 = call i32 (i32, i32, i64, i64, ptr, i32, ...) @rw_user(i32 noundef 1, i32 noundef %107, i64 noundef %108, i64 noundef 48, ptr noundef %109, i32 noundef 0)
  store i32 %110, ptr %9, align 4
  %111 = load i32, ptr %9, align 4
  ret i32 %111
}

declare void @update_times(...) #1

declare i32 @rw_user(...) #1

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
