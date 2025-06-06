; NOTE: Generated from src/mm/getset.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/getset.c'
source_filename = "src/mm/getset.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }

@mp = external global ptr, align 8
@mm_call = external global i32, align 4
@result2 = external global i32, align 4
@mproc = external global [32 x %struct.mproc], align 16
@who = external global i32, align 4
@mm_in = external global %struct.message, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_getset() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = load ptr, ptr @mp, align 8
  store ptr %4, ptr %2, align 8
  %5 = load i32, ptr @mm_call, align 4
  switch i32 %5, label %101 [
    i32 24, label %6
    i32 47, label %15
    i32 20, label %24
    i32 23, label %37
    i32 46, label %69
  ]

6:                                                ; preds = %0
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.mproc, ptr %7, i32 0, i32 6
  %9 = load i16, ptr %8, align 4
  %10 = zext i16 %9 to i32
  store i32 %10, ptr %3, align 4
  %11 = load ptr, ptr %2, align 8
  %12 = getelementptr inbounds %struct.mproc, ptr %11, i32 0, i32 7
  %13 = load i16, ptr %12, align 2
  %14 = zext i16 %13 to i32
  store i32 %14, ptr @result2, align 4
  br label %101

15:                                               ; preds = %0
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.mproc, ptr %16, i32 0, i32 8
  %18 = load i8, ptr %17, align 8
  %19 = zext i8 %18 to i32
  store i32 %19, ptr %3, align 4
  %20 = load ptr, ptr %2, align 8
  %21 = getelementptr inbounds %struct.mproc, ptr %20, i32 0, i32 9
  %22 = load i8, ptr %21, align 1
  %23 = zext i8 %22 to i32
  store i32 %23, ptr @result2, align 4
  br label %101

24:                                               ; preds = %0
  %25 = load i32, ptr @who, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %26
  %28 = getelementptr inbounds %struct.mproc, ptr %27, i32 0, i32 3
  %29 = load i32, ptr %28, align 8
  store i32 %29, ptr %3, align 4
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 4
  %32 = load i32, ptr %31, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %33
  %35 = getelementptr inbounds %struct.mproc, ptr %34, i32 0, i32 3
  %36 = load i32, ptr %35, align 8
  store i32 %36, ptr @result2, align 4
  br label %101

37:                                               ; preds = %0
  %38 = load ptr, ptr %2, align 8
  %39 = getelementptr inbounds %struct.mproc, ptr %38, i32 0, i32 6
  %40 = load i16, ptr %39, align 4
  %41 = zext i16 %40 to i32
  %42 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %43 = trunc i32 %42 to i16
  %44 = zext i16 %43 to i32
  %45 = icmp ne i32 %41, %44
  br i1 %45, label %46, label %53

46:                                               ; preds = %37
  %47 = load ptr, ptr %2, align 8
  %48 = getelementptr inbounds %struct.mproc, ptr %47, i32 0, i32 7
  %49 = load i16, ptr %48, align 2
  %50 = zext i16 %49 to i32
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %53

52:                                               ; preds = %46
  store i32 -1, ptr %1, align 4
  br label %103

53:                                               ; preds = %46, %37
  %54 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %55 = trunc i32 %54 to i16
  %56 = load ptr, ptr %2, align 8
  %57 = getelementptr inbounds %struct.mproc, ptr %56, i32 0, i32 6
  store i16 %55, ptr %57, align 4
  %58 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %59 = trunc i32 %58 to i16
  %60 = load ptr, ptr %2, align 8
  %61 = getelementptr inbounds %struct.mproc, ptr %60, i32 0, i32 7
  store i16 %59, ptr %61, align 2
  %62 = load i32, ptr @who, align 4
  %63 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %64 = trunc i32 %63 to i16
  %65 = zext i16 %64 to i32
  %66 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %67 = trunc i32 %66 to i16
  %68 = zext i16 %67 to i32
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 23, i32 noundef %62, i32 noundef %65, i32 noundef %68)
  store i32 0, ptr %3, align 4
  br label %101

69:                                               ; preds = %0
  %70 = load ptr, ptr %2, align 8
  %71 = getelementptr inbounds %struct.mproc, ptr %70, i32 0, i32 8
  %72 = load i8, ptr %71, align 8
  %73 = zext i8 %72 to i32
  %74 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %75 = trunc i32 %74 to i8
  %76 = zext i8 %75 to i32
  %77 = icmp ne i32 %73, %76
  br i1 %77, label %78, label %85

78:                                               ; preds = %69
  %79 = load ptr, ptr %2, align 8
  %80 = getelementptr inbounds %struct.mproc, ptr %79, i32 0, i32 7
  %81 = load i16, ptr %80, align 2
  %82 = zext i16 %81 to i32
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %85

84:                                               ; preds = %78
  store i32 -1, ptr %1, align 4
  br label %103

85:                                               ; preds = %78, %69
  %86 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %87 = trunc i32 %86 to i8
  %88 = load ptr, ptr %2, align 8
  %89 = getelementptr inbounds %struct.mproc, ptr %88, i32 0, i32 8
  store i8 %87, ptr %89, align 8
  %90 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %91 = trunc i32 %90 to i8
  %92 = load ptr, ptr %2, align 8
  %93 = getelementptr inbounds %struct.mproc, ptr %92, i32 0, i32 9
  store i8 %91, ptr %93, align 1
  %94 = load i32, ptr @who, align 4
  %95 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %96 = trunc i32 %95 to i8
  %97 = zext i8 %96 to i32
  %98 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %99 = trunc i32 %98 to i8
  %100 = zext i8 %99 to i32
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 46, i32 noundef %94, i32 noundef %97, i32 noundef %100)
  store i32 0, ptr %3, align 4
  br label %101

101:                                              ; preds = %0, %85, %53, %24, %15, %6
  %102 = load i32, ptr %3, align 4
  store i32 %102, ptr %1, align 4
  br label %103

103:                                              ; preds = %101, %84, %52
  %104 = load i32, ptr %1, align 4
  ret i32 %104
}

declare void @tell_fs(...) #1

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
