; NOTE: Generated from src/mm/trace.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/trace.c'
source_filename = "src/mm/trace.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@mm_in = external global %struct.message, align 8
@mp = external global ptr, align 8
@mm_out = external global %struct.message, align 8
@mproc = external global [32 x %struct.mproc], align 16
@errno = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_trace() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %10

5:                                                ; preds = %0
  %6 = load ptr, ptr @mp, align 8
  %7 = getelementptr inbounds %struct.mproc, ptr %6, i32 0, i32 13
  %8 = load i32, ptr %7, align 8
  %9 = or i32 %8, 64
  store i32 %9, ptr %7, align 8
  store i64 0, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 4), align 8
  store i32 0, ptr %1, align 4
  br label %69

10:                                               ; preds = %0
  %11 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %12 = call ptr @findproc(i32 noundef %11)
  store ptr %12, ptr %2, align 8
  %13 = icmp eq ptr %12, null
  br i1 %13, label %20, label %14

14:                                               ; preds = %10
  %15 = load ptr, ptr %2, align 8
  %16 = getelementptr inbounds %struct.mproc, ptr %15, i32 0, i32 13
  %17 = load i32, ptr %16, align 8
  %18 = and i32 %17, 128
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %14, %10
  store i32 -3, ptr %1, align 4
  br label %69

21:                                               ; preds = %14
  %22 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %23 = icmp eq i32 %22, 8
  br i1 %23, label %24, label %27

24:                                               ; preds = %21
  %25 = load ptr, ptr %2, align 8
  %26 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  call void (ptr, i64, ...) @mm_exit(ptr noundef %25, i64 noundef %26)
  store i64 0, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 4), align 8
  store i32 0, ptr %1, align 4
  br label %69

27:                                               ; preds = %21
  %28 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %29 = icmp eq i32 %28, 7
  br i1 %29, label %30, label %54

30:                                               ; preds = %27
  %31 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %32 = icmp sgt i64 %31, 16
  br i1 %32, label %33, label %34

33:                                               ; preds = %30
  store i32 -5, ptr %1, align 4
  br label %69

34:                                               ; preds = %30
  %35 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %36 = icmp sgt i64 %35, 0
  br i1 %36, label %37, label %49

37:                                               ; preds = %34
  %38 = load ptr, ptr %2, align 8
  %39 = getelementptr inbounds %struct.mproc, ptr %38, i32 0, i32 13
  %40 = load i32, ptr %39, align 8
  %41 = and i32 %40, -65
  store i32 %41, ptr %39, align 8
  %42 = load ptr, ptr %2, align 8
  %43 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %44 = trunc i64 %43 to i32
  call void (ptr, i32, ...) @sig_proc(ptr noundef %42, i32 noundef %44)
  %45 = load ptr, ptr %2, align 8
  %46 = getelementptr inbounds %struct.mproc, ptr %45, i32 0, i32 13
  %47 = load i32, ptr %46, align 8
  %48 = or i32 %47, 64
  store i32 %48, ptr %46, align 8
  br label %49

49:                                               ; preds = %37, %34
  %50 = load ptr, ptr %2, align 8
  %51 = getelementptr inbounds %struct.mproc, ptr %50, i32 0, i32 13
  %52 = load i32, ptr %51, align 8
  %53 = and i32 %52, -129
  store i32 %53, ptr %51, align 8
  br label %54

54:                                               ; preds = %49, %27
  %55 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %56 = load ptr, ptr %2, align 8
  %57 = ptrtoint ptr %56 to i64
  %58 = sub i64 %57, ptrtoint (ptr @mproc to i64)
  %59 = sdiv exact i64 %58, 80
  %60 = trunc i64 %59 to i32
  %61 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 3), align 8
  %62 = call i32 (i32, i32, i64, ptr, ...) @sys_trace(i32 noundef %55, i32 noundef %60, i64 noundef %61, ptr noundef getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4))
  %63 = icmp ne i32 %62, 0
  br i1 %63, label %64, label %67

64:                                               ; preds = %54
  %65 = load i32, ptr @errno, align 4
  %66 = sub nsw i32 0, %65
  store i32 %66, ptr %1, align 4
  br label %69

67:                                               ; preds = %54
  %68 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  store i64 %68, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 4), align 8
  store i32 0, ptr %1, align 4
  br label %69

69:                                               ; preds = %67, %64, %33, %24, %20, %5
  %70 = load i32, ptr %1, align 4
  ret i32 %70
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @findproc(i32 noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  store ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 3), ptr %4, align 8
  br label %5

5:                                                ; preds = %23, %1
  %6 = load ptr, ptr %4, align 8
  %7 = icmp ult ptr %6, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %7, label %8, label %26

8:                                                ; preds = %5
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds %struct.mproc, ptr %9, i32 0, i32 13
  %11 = load i32, ptr %10, align 8
  %12 = and i32 %11, 1
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %22

14:                                               ; preds = %8
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.mproc, ptr %15, i32 0, i32 3
  %17 = load i32, ptr %16, align 8
  %18 = load i32, ptr %3, align 4
  %19 = icmp eq i32 %17, %18
  br i1 %19, label %20, label %22

20:                                               ; preds = %14
  %21 = load ptr, ptr %4, align 8
  store ptr %21, ptr %2, align 8
  br label %27

22:                                               ; preds = %14, %8
  br label %23

23:                                               ; preds = %22
  %24 = load ptr, ptr %4, align 8
  %25 = getelementptr inbounds %struct.mproc, ptr %24, i32 1
  store ptr %25, ptr %4, align 8
  br label %5, !llvm.loop !6

26:                                               ; preds = %5
  store ptr null, ptr %2, align 8
  br label %27

27:                                               ; preds = %26, %20
  %28 = load ptr, ptr %2, align 8
  ret ptr %28
}

declare void @mm_exit(...) #1

declare void @sig_proc(...) #1

declare i32 @sys_trace(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @stop_proc(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.mproc, ptr %6, i32 0, i32 4
  %8 = load i32, ptr %7, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds %struct.mproc, ptr @mproc, i64 %9
  store ptr %10, ptr %5, align 8
  %11 = load ptr, ptr %3, align 8
  %12 = ptrtoint ptr %11 to i64
  %13 = sub i64 %12, ptrtoint (ptr @mproc to i64)
  %14 = sdiv exact i64 %13, 80
  %15 = trunc i64 %14 to i32
  %16 = call i32 (i32, i32, i64, ptr, ...) @sys_trace(i32 noundef -1, i32 noundef %15, i64 noundef 0, ptr noundef null)
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %2
  br label %49

19:                                               ; preds = %2
  %20 = load ptr, ptr %3, align 8
  %21 = getelementptr inbounds %struct.mproc, ptr %20, i32 0, i32 13
  %22 = load i32, ptr %21, align 8
  %23 = or i32 %22, 128
  store i32 %23, ptr %21, align 8
  %24 = load ptr, ptr %5, align 8
  %25 = getelementptr inbounds %struct.mproc, ptr %24, i32 0, i32 13
  %26 = load i32, ptr %25, align 8
  %27 = and i32 %26, 2
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %43

29:                                               ; preds = %19
  %30 = load ptr, ptr %5, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 13
  %32 = load i32, ptr %31, align 8
  %33 = and i32 %32, -3
  store i32 %33, ptr %31, align 8
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %struct.mproc, ptr %34, i32 0, i32 4
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %3, align 8
  %38 = getelementptr inbounds %struct.mproc, ptr %37, i32 0, i32 3
  %39 = load i32, ptr %38, align 8
  %40 = load i32, ptr %4, align 4
  %41 = shl i32 %40, 8
  %42 = or i32 127, %41
  call void @reply(i32 noundef %36, i32 noundef %39, i32 noundef %42, ptr noundef null)
  br label %48

43:                                               ; preds = %19
  %44 = load i32, ptr %4, align 4
  %45 = trunc i32 %44 to i8
  %46 = load ptr, ptr %3, align 8
  %47 = getelementptr inbounds %struct.mproc, ptr %46, i32 0, i32 2
  store i8 %45, ptr %47, align 1
  br label %48

48:                                               ; preds = %43, %29
  br label %49

49:                                               ; preds = %48, %18
  ret void
}

declare void @reply(i32 noundef, i32 noundef, i32 noundef, ptr noundef) #1

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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
