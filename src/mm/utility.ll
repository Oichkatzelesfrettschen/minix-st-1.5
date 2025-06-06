; NOTE: Generated from src/mm/utility.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/utility.c'
source_filename = "src/mm/utility.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.stat = type { i16, i16, i16, i16, i16, i16, i16, i64, i64, i64, i64 }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.mess_5 = type { i8, i8, i32, i32, i64, i64, i64 }

@errno = external global i32, align 4
@.str = private unnamed_addr constant [22 x i8] c"allowed: fstat failed\00", align 1
@mp = external global ptr, align 8
@copy_mess = internal global %struct.message zeroinitializer, align 8
@.str.1 = private unnamed_addr constant [26 x i8] c"Memory manager panic: %s \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @allowed(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  %11 = load ptr, ptr %5, align 8
  %12 = call i32 (ptr, i32, ...) @open(ptr noundef %11, i32 noundef 0)
  store i32 %12, ptr %8, align 4
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %17

14:                                               ; preds = %3
  %15 = load i32, ptr @errno, align 4
  %16 = sub nsw i32 0, %15
  store i32 %16, ptr %4, align 4
  br label %105

17:                                               ; preds = %3
  %18 = load i32, ptr %8, align 4
  %19 = load ptr, ptr %6, align 8
  %20 = call i32 @fstat(i32 noundef %18, ptr noundef %19)
  %21 = icmp slt i32 %20, 0
  br i1 %21, label %22, label %23

22:                                               ; preds = %17
  call void @panic(ptr noundef @.str, i32 noundef 32768)
  br label %23

23:                                               ; preds = %22, %17
  %24 = load ptr, ptr %6, align 8
  %25 = getelementptr inbounds %struct.stat, ptr %24, i32 0, i32 2
  %26 = load i16, ptr %25, align 4
  %27 = zext i16 %26 to i32
  %28 = and i32 %27, 61440
  store i32 %28, ptr %10, align 4
  %29 = load i32, ptr %7, align 4
  %30 = icmp eq i32 %29, 1
  br i1 %30, label %31, label %37

31:                                               ; preds = %23
  %32 = load i32, ptr %10, align 4
  %33 = icmp ne i32 %32, 32768
  br i1 %33, label %34, label %37

34:                                               ; preds = %31
  %35 = load i32, ptr %8, align 4
  %36 = call i32 (i32, ...) @close(i32 noundef %35)
  store i32 -13, ptr %4, align 4
  br label %105

37:                                               ; preds = %31, %23
  %38 = load ptr, ptr @mp, align 8
  %39 = getelementptr inbounds %struct.mproc, ptr %38, i32 0, i32 7
  %40 = load i16, ptr %39, align 2
  %41 = zext i16 %40 to i32
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %43, label %55

43:                                               ; preds = %37
  %44 = load i32, ptr %7, align 4
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %55

46:                                               ; preds = %43
  %47 = load ptr, ptr %6, align 8
  %48 = getelementptr inbounds %struct.stat, ptr %47, i32 0, i32 2
  %49 = load i16, ptr %48, align 4
  %50 = zext i16 %49 to i32
  %51 = and i32 %50, 73
  %52 = icmp ne i32 %51, 0
  br i1 %52, label %53, label %55

53:                                               ; preds = %46
  %54 = load i32, ptr %8, align 4
  store i32 %54, ptr %4, align 4
  br label %105

55:                                               ; preds = %46, %43, %37
  %56 = load ptr, ptr @mp, align 8
  %57 = getelementptr inbounds %struct.mproc, ptr %56, i32 0, i32 7
  %58 = load i16, ptr %57, align 2
  %59 = zext i16 %58 to i32
  %60 = load ptr, ptr %6, align 8
  %61 = getelementptr inbounds %struct.stat, ptr %60, i32 0, i32 4
  %62 = load i16, ptr %61, align 8
  %63 = zext i16 %62 to i32
  %64 = icmp eq i32 %59, %63
  br i1 %64, label %65, label %66

65:                                               ; preds = %55
  store i32 6, ptr %9, align 4
  br label %79

66:                                               ; preds = %55
  %67 = load ptr, ptr @mp, align 8
  %68 = getelementptr inbounds %struct.mproc, ptr %67, i32 0, i32 9
  %69 = load i8, ptr %68, align 1
  %70 = zext i8 %69 to i32
  %71 = load ptr, ptr %6, align 8
  %72 = getelementptr inbounds %struct.stat, ptr %71, i32 0, i32 5
  %73 = load i16, ptr %72, align 2
  %74 = sext i16 %73 to i32
  %75 = icmp eq i32 %70, %74
  br i1 %75, label %76, label %77

76:                                               ; preds = %66
  store i32 3, ptr %9, align 4
  br label %78

77:                                               ; preds = %66
  store i32 0, ptr %9, align 4
  br label %78

78:                                               ; preds = %77, %76
  br label %79

79:                                               ; preds = %78, %65
  %80 = load ptr, ptr @mp, align 8
  %81 = getelementptr inbounds %struct.mproc, ptr %80, i32 0, i32 7
  %82 = load i16, ptr %81, align 2
  %83 = zext i16 %82 to i32
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %85, label %90

85:                                               ; preds = %79
  %86 = load i32, ptr %7, align 4
  %87 = icmp ne i32 %86, 1
  br i1 %87, label %88, label %90

88:                                               ; preds = %85
  %89 = load i32, ptr %8, align 4
  store i32 %89, ptr %4, align 4
  br label %105

90:                                               ; preds = %85, %79
  %91 = load ptr, ptr %6, align 8
  %92 = getelementptr inbounds %struct.stat, ptr %91, i32 0, i32 2
  %93 = load i16, ptr %92, align 4
  %94 = zext i16 %93 to i32
  %95 = load i32, ptr %9, align 4
  %96 = ashr i32 %94, %95
  %97 = load i32, ptr %7, align 4
  %98 = and i32 %96, %97
  %99 = icmp ne i32 %98, 0
  br i1 %99, label %100, label %102

100:                                              ; preds = %90
  %101 = load i32, ptr %8, align 4
  store i32 %101, ptr %4, align 4
  br label %105

102:                                              ; preds = %90
  %103 = load i32, ptr %8, align 4
  %104 = call i32 (i32, ...) @close(i32 noundef %103)
  store i32 -13, ptr %4, align 4
  br label %105

105:                                              ; preds = %102, %100, %88, %53, %34, %14
  %106 = load i32, ptr %4, align 4
  ret i32 %106
}

declare i32 @open(...) #1

declare i32 @fstat(i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @panic(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  call void (ptr, ...) @printk(ptr noundef @.str.1, ptr noundef %5)
  %6 = load i32, ptr %4, align 4
  %7 = icmp ne i32 %6, 32768
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %4, align 4
  call void (ptr, ...) @printk(ptr noundef @.str.2, i32 noundef %9)
  br label %10

10:                                               ; preds = %8, %2
  call void (ptr, ...) @printk(ptr noundef @.str.3)
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 36, i32 noundef 0, i32 noundef 0, i32 noundef 0)
  call void (...) @sys_abort()
  ret void
}

declare i32 @close(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @mem_copy(i32 noundef %0, i32 noundef %1, i64 noundef %2, i32 noundef %3, i32 noundef %4, i64 noundef %5, i64 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  store i32 %0, ptr %9, align 4
  store i32 %1, ptr %10, align 4
  store i64 %2, ptr %11, align 8
  store i32 %3, ptr %12, align 4
  store i32 %4, ptr %13, align 4
  store i64 %5, ptr %14, align 8
  store i64 %6, ptr %15, align 8
  %16 = load i64, ptr %15, align 8
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %7
  store i32 0, ptr %8, align 4
  br label %30

19:                                               ; preds = %7
  %20 = load i32, ptr %10, align 4
  %21 = trunc i32 %20 to i8
  store i8 %21, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), align 8
  %22 = load i32, ptr %9, align 4
  store i32 %22, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 2), align 4
  %23 = load i64, ptr %11, align 8
  store i64 %23, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 4), align 8
  %24 = load i32, ptr %13, align 4
  %25 = trunc i32 %24 to i8
  store i8 %25, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 1), align 1
  %26 = load i32, ptr %12, align 4
  store i32 %26, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 3), align 8
  %27 = load i64, ptr %14, align 8
  store i64 %27, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 5), align 8
  %28 = load i64, ptr %15, align 8
  store i64 %28, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 2), i32 0, i32 6), align 8
  call void (ptr, ...) @sys_copy(ptr noundef @copy_mess)
  %29 = load i32, ptr getelementptr inbounds (%struct.message, ptr @copy_mess, i32 0, i32 1), align 4
  store i32 %29, ptr %8, align 4
  br label %30

30:                                               ; preds = %19, %18
  %31 = load i32, ptr %8, align 4
  ret i32 %31
}

declare void @sys_copy(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @no_sys() #0 {
  ret i32 -22
}

declare void @printk(ptr noundef, ...) #1

declare void @tell_fs(...) #1

declare void @sys_abort(...) #1

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
