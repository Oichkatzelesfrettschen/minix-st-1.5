; NOTE: Generated from src/fs/protect.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/protect.c'
source_filename = "src/fs/protect.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }

@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16
@fp = external global ptr, align 8
@super_user = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_chmod() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %5 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %6 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %4, i32 noundef %5, i32 noundef 3)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = load i32, ptr @err_code, align 4
  store i32 %9, ptr %1, align 4
  br label %53

10:                                               ; preds = %0
  %11 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %11, ptr %2, align 8
  %12 = icmp eq ptr %11, null
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, ptr @err_code, align 4
  store i32 %14, ptr %1, align 4
  br label %53

15:                                               ; preds = %10
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
  br label %32

29:                                               ; preds = %25, %15
  %30 = load ptr, ptr %2, align 8
  %31 = call i32 @read_only(ptr noundef %30)
  store i32 %31, ptr %3, align 4
  br label %32

32:                                               ; preds = %29, %28
  %33 = load i32, ptr %3, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %38

35:                                               ; preds = %32
  %36 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %36)
  %37 = load i32, ptr %3, align 4
  store i32 %37, ptr %1, align 4
  br label %53

38:                                               ; preds = %32
  %39 = load ptr, ptr %2, align 8
  %40 = getelementptr inbounds %struct.inode, ptr %39, i32 0, i32 0
  %41 = load i16, ptr %40, align 8
  %42 = zext i16 %41 to i32
  %43 = and i32 %42, -3584
  %44 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %45 = and i32 %44, 3583
  %46 = or i32 %43, %45
  %47 = trunc i32 %46 to i16
  %48 = load ptr, ptr %2, align 8
  %49 = getelementptr inbounds %struct.inode, ptr %48, i32 0, i32 0
  store i16 %47, ptr %49, align 8
  %50 = load ptr, ptr %2, align 8
  %51 = getelementptr inbounds %struct.inode, ptr %50, i32 0, i32 12
  store i8 1, ptr %51, align 2
  %52 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %52)
  store i32 0, ptr %1, align 4
  br label %53

53:                                               ; preds = %38, %35, %13, %8
  %54 = load i32, ptr %1, align 4
  ret i32 %54
}

declare i32 @fetch_name(...) #1

declare ptr @eat_path(...) #1

declare void @put_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_chown() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load i32, ptr @super_user, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %38

7:                                                ; preds = %0
  %8 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %9 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %10 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %8, i32 noundef %9, i32 noundef 1)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %7
  %13 = load i32, ptr @err_code, align 4
  store i32 %13, ptr %1, align 4
  br label %38

14:                                               ; preds = %7
  %15 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %15, ptr %2, align 8
  %16 = icmp eq ptr %15, null
  br i1 %16, label %17, label %19

17:                                               ; preds = %14
  %18 = load i32, ptr @err_code, align 4
  store i32 %18, ptr %1, align 4
  br label %38

19:                                               ; preds = %14
  %20 = load ptr, ptr %2, align 8
  %21 = call i32 @read_only(ptr noundef %20)
  store i32 %21, ptr %3, align 4
  %22 = load i32, ptr %3, align 4
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %35

24:                                               ; preds = %19
  %25 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %26 = trunc i32 %25 to i16
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.inode, ptr %27, i32 0, i32 1
  store i16 %26, ptr %28, align 2
  %29 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %30 = trunc i32 %29 to i8
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.inode, ptr %31, i32 0, i32 4
  store i8 %30, ptr %32, align 8
  %33 = load ptr, ptr %2, align 8
  %34 = getelementptr inbounds %struct.inode, ptr %33, i32 0, i32 12
  store i8 1, ptr %34, align 2
  br label %35

35:                                               ; preds = %24, %19
  %36 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %36)
  %37 = load i32, ptr %3, align 4
  store i32 %37, ptr %1, align 4
  br label %38

38:                                               ; preds = %35, %17, %12, %6
  %39 = load i32, ptr %1, align 4
  ret i32 %39
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_umask() #0 {
  %1 = alloca i16, align 2
  %2 = load ptr, ptr @fp, align 8
  %3 = getelementptr inbounds %struct.fproc, ptr %2, i32 0, i32 0
  %4 = load i16, ptr %3, align 8
  %5 = zext i16 %4 to i32
  %6 = xor i32 %5, -1
  %7 = trunc i32 %6 to i16
  store i16 %7, ptr %1, align 2
  %8 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %9 = and i32 %8, 511
  %10 = xor i32 %9, -1
  %11 = trunc i32 %10 to i16
  %12 = load ptr, ptr @fp, align 8
  %13 = getelementptr inbounds %struct.fproc, ptr %12, i32 0, i32 0
  store i16 %11, ptr %13, align 8
  %14 = load i16, ptr %1, align 2
  %15 = zext i16 %14 to i32
  ret i32 %15
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_access() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %5 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %6 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %4, i32 noundef %5, i32 noundef 3)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  %9 = load i32, ptr @err_code, align 4
  store i32 %9, ptr %1, align 4
  br label %23

10:                                               ; preds = %0
  %11 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %11, ptr %2, align 8
  %12 = icmp eq ptr %11, null
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = load i32, ptr @err_code, align 4
  store i32 %14, ptr %1, align 4
  br label %23

15:                                               ; preds = %10
  %16 = load ptr, ptr %2, align 8
  %17 = load i32, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %18 = trunc i32 %17 to i16
  %19 = zext i16 %18 to i32
  %20 = call i32 @forbidden(ptr noundef %16, i32 noundef %19, i32 noundef 1)
  store i32 %20, ptr %3, align 4
  %21 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %21)
  %22 = load i32, ptr %3, align 4
  store i32 %22, ptr %1, align 4
  br label %23

23:                                               ; preds = %15, %13, %8
  %24 = load i32, ptr %1, align 4
  ret i32 %24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @forbidden(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  %6 = alloca i32, align 4
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = trunc i32 %1 to i16
  store ptr %0, ptr %4, align 8
  store i16 %14, ptr %5, align 2
  store i32 %2, ptr %6, align 4
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.inode, ptr %15, i32 0, i32 0
  %17 = load i16, ptr %16, align 8
  store i16 %17, ptr %7, align 2
  %18 = load i32, ptr %6, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %25

20:                                               ; preds = %3
  %21 = load ptr, ptr @fp, align 8
  %22 = getelementptr inbounds %struct.fproc, ptr %21, i32 0, i32 4
  %23 = load i16, ptr %22, align 8
  %24 = zext i16 %23 to i32
  br label %30

25:                                               ; preds = %3
  %26 = load ptr, ptr @fp, align 8
  %27 = getelementptr inbounds %struct.fproc, ptr %26, i32 0, i32 5
  %28 = load i16, ptr %27, align 2
  %29 = zext i16 %28 to i32
  br label %30

30:                                               ; preds = %25, %20
  %31 = phi i32 [ %24, %20 ], [ %29, %25 ]
  store i32 %31, ptr %12, align 4
  %32 = load i32, ptr %6, align 4
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %34, label %39

34:                                               ; preds = %30
  %35 = load ptr, ptr @fp, align 8
  %36 = getelementptr inbounds %struct.fproc, ptr %35, i32 0, i32 6
  %37 = load i8, ptr %36, align 4
  %38 = zext i8 %37 to i32
  br label %44

39:                                               ; preds = %30
  %40 = load ptr, ptr @fp, align 8
  %41 = getelementptr inbounds %struct.fproc, ptr %40, i32 0, i32 7
  %42 = load i8, ptr %41, align 1
  %43 = zext i8 %42 to i32
  br label %44

44:                                               ; preds = %39, %34
  %45 = phi i32 [ %38, %34 ], [ %43, %39 ]
  store i32 %45, ptr %13, align 4
  %46 = load i32, ptr %12, align 4
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %44
  store i16 7, ptr %8, align 2
  br label %74

49:                                               ; preds = %44
  %50 = load i32, ptr %12, align 4
  %51 = load ptr, ptr %4, align 8
  %52 = getelementptr inbounds %struct.inode, ptr %51, i32 0, i32 1
  %53 = load i16, ptr %52, align 2
  %54 = zext i16 %53 to i32
  %55 = icmp eq i32 %50, %54
  br i1 %55, label %56, label %57

56:                                               ; preds = %49
  store i32 6, ptr %11, align 4
  br label %67

57:                                               ; preds = %49
  %58 = load i32, ptr %13, align 4
  %59 = load ptr, ptr %4, align 8
  %60 = getelementptr inbounds %struct.inode, ptr %59, i32 0, i32 4
  %61 = load i8, ptr %60, align 8
  %62 = zext i8 %61 to i32
  %63 = icmp eq i32 %58, %62
  br i1 %63, label %64, label %65

64:                                               ; preds = %57
  store i32 3, ptr %11, align 4
  br label %66

65:                                               ; preds = %57
  store i32 0, ptr %11, align 4
  br label %66

66:                                               ; preds = %65, %64
  br label %67

67:                                               ; preds = %66, %56
  %68 = load i16, ptr %7, align 2
  %69 = zext i16 %68 to i32
  %70 = load i32, ptr %11, align 4
  %71 = ashr i32 %69, %70
  %72 = and i32 %71, 7
  %73 = trunc i32 %72 to i16
  store i16 %73, ptr %8, align 2
  br label %74

74:                                               ; preds = %67, %48
  store i32 0, ptr %10, align 4
  %75 = load i16, ptr %8, align 2
  %76 = zext i16 %75 to i32
  %77 = load i16, ptr %5, align 2
  %78 = zext i16 %77 to i32
  %79 = or i32 %76, %78
  %80 = load i16, ptr %8, align 2
  %81 = zext i16 %80 to i32
  %82 = icmp ne i32 %79, %81
  br i1 %82, label %83, label %84

83:                                               ; preds = %74
  store i32 -13, ptr %10, align 4
  br label %84

84:                                               ; preds = %83, %74
  store i16 73, ptr %9, align 2
  %85 = load i16, ptr %5, align 2
  %86 = zext i16 %85 to i32
  %87 = and i32 %86, 1
  %88 = icmp ne i32 %87, 0
  br i1 %88, label %89, label %97

89:                                               ; preds = %84
  %90 = load i16, ptr %7, align 2
  %91 = zext i16 %90 to i32
  %92 = load i16, ptr %9, align 2
  %93 = zext i16 %92 to i32
  %94 = and i32 %91, %93
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %96, label %97

96:                                               ; preds = %89
  store i32 -13, ptr %10, align 4
  br label %97

97:                                               ; preds = %96, %89, %84
  %98 = load i32, ptr %10, align 4
  %99 = icmp eq i32 %98, 0
  br i1 %99, label %100, label %109

100:                                              ; preds = %97
  %101 = load i16, ptr %5, align 2
  %102 = zext i16 %101 to i32
  %103 = and i32 %102, 2
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %108

105:                                              ; preds = %100
  %106 = load ptr, ptr %4, align 8
  %107 = call i32 @read_only(ptr noundef %106)
  store i32 %107, ptr %10, align 4
  br label %108

108:                                              ; preds = %105, %100
  br label %109

109:                                              ; preds = %108, %97
  %110 = load i32, ptr %10, align 4
  ret i32 %110
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @read_only(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.inode, ptr %4, i32 0, i32 9
  %6 = load i16, ptr %5, align 8
  %7 = zext i16 %6 to i32
  %8 = call ptr (i32, ...) @get_super(i32 noundef %7)
  store ptr %8, ptr %3, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.super_block, ptr %9, i32 0, i32 14
  %11 = load i8, ptr %10, align 8
  %12 = sext i8 %11 to i32
  %13 = icmp ne i32 %12, 0
  %14 = zext i1 %13 to i64
  %15 = select i1 %13, i32 -30, i32 0
  ret i32 %15
}

declare ptr @get_super(...) #1

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
