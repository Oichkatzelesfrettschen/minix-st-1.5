; NOTE: Generated from src/fs/filedes.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/filedes.c'
source_filename = "src/fs/filedes.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }

@fp = external global ptr, align 8
@filp = external global [64 x %struct.filp], align 16
@err_code = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @get_fd(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i16, align 2
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = trunc i32 %1 to i16
  store i32 %0, ptr %6, align 4
  store i16 %12, ptr %7, align 2
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  %13 = load ptr, ptr %8, align 8
  store i32 -1, ptr %13, align 4
  %14 = load i32, ptr %6, align 4
  store i32 %14, ptr %11, align 4
  br label %15

15:                                               ; preds = %30, %4
  %16 = load i32, ptr %11, align 4
  %17 = icmp slt i32 %16, 20
  br i1 %17, label %18, label %33

18:                                               ; preds = %15
  %19 = load ptr, ptr @fp, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 3
  %21 = load i32, ptr %11, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds [20 x ptr], ptr %20, i64 0, i64 %22
  %24 = load ptr, ptr %23, align 8
  %25 = icmp eq ptr %24, null
  br i1 %25, label %26, label %29

26:                                               ; preds = %18
  %27 = load i32, ptr %11, align 4
  %28 = load ptr, ptr %8, align 8
  store i32 %27, ptr %28, align 4
  br label %33

29:                                               ; preds = %18
  br label %30

30:                                               ; preds = %29
  %31 = load i32, ptr %11, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %11, align 4
  br label %15

33:                                               ; preds = %26, %15
  %34 = load ptr, ptr %8, align 8
  %35 = load i32, ptr %34, align 4
  %36 = icmp slt i32 %35, 0
  br i1 %36, label %37, label %38

37:                                               ; preds = %33
  store i32 -24, ptr %5, align 4
  br label %62

38:                                               ; preds = %33
  store ptr @filp, ptr %10, align 8
  br label %39

39:                                               ; preds = %58, %38
  %40 = load ptr, ptr %10, align 8
  %41 = icmp ult ptr %40, getelementptr inbounds ([64 x %struct.filp], ptr @filp, i64 0, i64 64)
  br i1 %41, label %42, label %61

42:                                               ; preds = %39
  %43 = load ptr, ptr %10, align 8
  %44 = getelementptr inbounds %struct.filp, ptr %43, i32 0, i32 2
  %45 = load i32, ptr %44, align 8
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %57

47:                                               ; preds = %42
  %48 = load i16, ptr %7, align 2
  %49 = load ptr, ptr %10, align 8
  %50 = getelementptr inbounds %struct.filp, ptr %49, i32 0, i32 0
  store i16 %48, ptr %50, align 8
  %51 = load ptr, ptr %10, align 8
  %52 = getelementptr inbounds %struct.filp, ptr %51, i32 0, i32 4
  store i64 0, ptr %52, align 8
  %53 = load ptr, ptr %10, align 8
  %54 = getelementptr inbounds %struct.filp, ptr %53, i32 0, i32 1
  store i32 0, ptr %54, align 4
  %55 = load ptr, ptr %10, align 8
  %56 = load ptr, ptr %9, align 8
  store ptr %55, ptr %56, align 8
  store i32 0, ptr %5, align 4
  br label %62

57:                                               ; preds = %42
  br label %58

58:                                               ; preds = %57
  %59 = load ptr, ptr %10, align 8
  %60 = getelementptr inbounds %struct.filp, ptr %59, i32 1
  store ptr %60, ptr %10, align 8
  br label %39

61:                                               ; preds = %39
  store i32 -23, ptr %5, align 4
  br label %62

62:                                               ; preds = %61, %47, %37
  %63 = load i32, ptr %5, align 4
  ret i32 %63
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @get_filp(i32 noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 -9, ptr @err_code, align 4
  %4 = load i32, ptr %3, align 4
  %5 = icmp slt i32 %4, 0
  br i1 %5, label %9, label %6

6:                                                ; preds = %1
  %7 = load i32, ptr %3, align 4
  %8 = icmp sge i32 %7, 20
  br i1 %8, label %9, label %10

9:                                                ; preds = %6, %1
  store ptr null, ptr %2, align 8
  br label %17

10:                                               ; preds = %6
  %11 = load ptr, ptr @fp, align 8
  %12 = getelementptr inbounds %struct.fproc, ptr %11, i32 0, i32 3
  %13 = load i32, ptr %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [20 x ptr], ptr %12, i64 0, i64 %14
  %16 = load ptr, ptr %15, align 8
  store ptr %16, ptr %2, align 8
  br label %17

17:                                               ; preds = %10, %9
  %18 = load ptr, ptr %2, align 8
  ret ptr %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @find_filp(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store ptr @filp, ptr %6, align 8
  br label %7

7:                                                ; preds = %32, %2
  %8 = load ptr, ptr %6, align 8
  %9 = icmp ult ptr %8, getelementptr inbounds ([64 x %struct.filp], ptr @filp, i64 0, i64 64)
  br i1 %9, label %10, label %35

10:                                               ; preds = %7
  %11 = load ptr, ptr %6, align 8
  %12 = getelementptr inbounds %struct.filp, ptr %11, i32 0, i32 2
  %13 = load i32, ptr %12, align 8
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %31

15:                                               ; preds = %10
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds %struct.filp, ptr %16, i32 0, i32 3
  %18 = load ptr, ptr %17, align 8
  %19 = load ptr, ptr %4, align 8
  %20 = icmp eq ptr %18, %19
  br i1 %20, label %21, label %31

21:                                               ; preds = %15
  %22 = load ptr, ptr %6, align 8
  %23 = getelementptr inbounds %struct.filp, ptr %22, i32 0, i32 0
  %24 = load i16, ptr %23, align 8
  %25 = zext i16 %24 to i32
  %26 = load i32, ptr %5, align 4
  %27 = and i32 %25, %26
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %31

29:                                               ; preds = %21
  %30 = load ptr, ptr %6, align 8
  store ptr %30, ptr %3, align 8
  br label %36

31:                                               ; preds = %21, %15, %10
  br label %32

32:                                               ; preds = %31
  %33 = load ptr, ptr %6, align 8
  %34 = getelementptr inbounds %struct.filp, ptr %33, i32 1
  store ptr %34, ptr %6, align 8
  br label %7

35:                                               ; preds = %7
  store ptr null, ptr %3, align 8
  br label %36

36:                                               ; preds = %35, %29
  %37 = load ptr, ptr %3, align 8
  ret ptr %37
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
