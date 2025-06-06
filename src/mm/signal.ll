; NOTE: Generated from src/mm/signal.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/signal.c'
source_filename = "src/mm/signal.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.mess_6 = type { i32, i32, i32, i64, ptr }
%struct.stat = type { i16, i16, i16, i16, i16, i16, i16, i64, i64, i64, i64 }

@mp = external global ptr, align 8
@mm_in = external global %struct.message, align 8
@who = external global i32, align 4
@dont_reply = external global i32, align 4
@mproc = external global [32 x %struct.mproc], align 16
@core_bits = external global i16, align 2
@m_sig = internal global %struct.message zeroinitializer, align 8
@.str = private unnamed_addr constant [9 x i8] c"alarm er\00", align 1
@core_name = external global [0 x i8], align 1
@.str.1 = private unnamed_addr constant [2 x i8] c".\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_signal() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = load ptr, ptr @mp, align 8
  %5 = getelementptr inbounds %struct.mproc, ptr %4, i32 0, i32 10
  %6 = load i16, ptr %5, align 2
  %7 = zext i16 %6 to i32
  store i32 %7, ptr %3, align 4
  %8 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %9 = icmp slt i32 %8, 1
  br i1 %9, label %13, label %10

10:                                               ; preds = %0
  %11 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %12 = icmp sgt i32 %11, 16
  br i1 %12, label %13, label %14

13:                                               ; preds = %10, %0
  store i32 -22, ptr %1, align 4
  br label %87

14:                                               ; preds = %10
  %15 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %16 = icmp eq i32 %15, 9
  br i1 %16, label %17, label %18

17:                                               ; preds = %14
  store i32 0, ptr %1, align 4
  br label %87

18:                                               ; preds = %14
  %19 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %20 = sub nsw i32 %19, 1
  %21 = shl i32 1, %20
  store i32 %21, ptr %2, align 4
  %22 = load ptr, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %23 = icmp eq ptr %22, inttoptr (i64 1 to ptr)
  br i1 %23, label %24, label %40

24:                                               ; preds = %18
  %25 = load i32, ptr %2, align 4
  %26 = load ptr, ptr @mp, align 8
  %27 = getelementptr inbounds %struct.mproc, ptr %26, i32 0, i32 10
  %28 = load i16, ptr %27, align 2
  %29 = zext i16 %28 to i32
  %30 = or i32 %29, %25
  %31 = trunc i32 %30 to i16
  store i16 %31, ptr %27, align 2
  %32 = load i32, ptr %2, align 4
  %33 = xor i32 %32, -1
  %34 = load ptr, ptr @mp, align 8
  %35 = getelementptr inbounds %struct.mproc, ptr %34, i32 0, i32 11
  %36 = load i16, ptr %35, align 4
  %37 = zext i16 %36 to i32
  %38 = and i32 %37, %33
  %39 = trunc i32 %38 to i16
  store i16 %39, ptr %35, align 4
  br label %80

40:                                               ; preds = %18
  %41 = load ptr, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %42 = icmp eq ptr %41, null
  br i1 %42, label %43, label %60

43:                                               ; preds = %40
  %44 = load i32, ptr %2, align 4
  %45 = xor i32 %44, -1
  %46 = load ptr, ptr @mp, align 8
  %47 = getelementptr inbounds %struct.mproc, ptr %46, i32 0, i32 10
  %48 = load i16, ptr %47, align 2
  %49 = zext i16 %48 to i32
  %50 = and i32 %49, %45
  %51 = trunc i32 %50 to i16
  store i16 %51, ptr %47, align 2
  %52 = load i32, ptr %2, align 4
  %53 = xor i32 %52, -1
  %54 = load ptr, ptr @mp, align 8
  %55 = getelementptr inbounds %struct.mproc, ptr %54, i32 0, i32 11
  %56 = load i16, ptr %55, align 4
  %57 = zext i16 %56 to i32
  %58 = and i32 %57, %53
  %59 = trunc i32 %58 to i16
  store i16 %59, ptr %55, align 4
  br label %79

60:                                               ; preds = %40
  %61 = load i32, ptr %2, align 4
  %62 = xor i32 %61, -1
  %63 = load ptr, ptr @mp, align 8
  %64 = getelementptr inbounds %struct.mproc, ptr %63, i32 0, i32 10
  %65 = load i16, ptr %64, align 2
  %66 = zext i16 %65 to i32
  %67 = and i32 %66, %62
  %68 = trunc i32 %67 to i16
  store i16 %68, ptr %64, align 2
  %69 = load i32, ptr %2, align 4
  %70 = load ptr, ptr @mp, align 8
  %71 = getelementptr inbounds %struct.mproc, ptr %70, i32 0, i32 11
  %72 = load i16, ptr %71, align 4
  %73 = zext i16 %72 to i32
  %74 = or i32 %73, %69
  %75 = trunc i32 %74 to i16
  store i16 %75, ptr %71, align 4
  %76 = load ptr, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %77 = load ptr, ptr @mp, align 8
  %78 = getelementptr inbounds %struct.mproc, ptr %77, i32 0, i32 12
  store ptr %76, ptr %78, align 8
  br label %79

79:                                               ; preds = %60, %43
  br label %80

80:                                               ; preds = %79, %24
  %81 = load i32, ptr %3, align 4
  %82 = load i32, ptr %2, align 4
  %83 = and i32 %81, %82
  %84 = icmp ne i32 %83, 0
  br i1 %84, label %85, label %86

85:                                               ; preds = %80
  store i32 1, ptr %1, align 4
  br label %87

86:                                               ; preds = %80
  store i32 0, ptr %1, align 4
  br label %87

87:                                               ; preds = %86, %85, %17, %13
  %88 = load i32, ptr %1, align 4
  ret i32 %88
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_kill() #0 {
  %1 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %2 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %3 = load ptr, ptr @mp, align 8
  %4 = getelementptr inbounds %struct.mproc, ptr %3, i32 0, i32 7
  %5 = load i16, ptr %4, align 2
  %6 = zext i16 %5 to i32
  %7 = call i32 @check_sig(i32 noundef %1, i32 noundef %2, i32 noundef %6)
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_ksig() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i16, align 2
  %9 = load i32, ptr @who, align 4
  %10 = icmp ne i32 %9, -1
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %82

12:                                               ; preds = %0
  store i32 1, ptr @dont_reply, align 4
  %13 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  store i32 %13, ptr %6, align 4
  %14 = load i32, ptr %6, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %15
  store ptr %16, ptr %2, align 8
  %17 = load ptr, ptr %2, align 8
  %18 = getelementptr inbounds %struct.mproc, ptr %17, i32 0, i32 13
  %19 = load i32, ptr %18, align 8
  %20 = and i32 %19, 1
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %28, label %22

22:                                               ; preds = %12
  %23 = load ptr, ptr %2, align 8
  %24 = getelementptr inbounds %struct.mproc, ptr %23, i32 0, i32 13
  %25 = load i32, ptr %24, align 8
  %26 = and i32 %25, 4
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %29

28:                                               ; preds = %22, %12
  store i32 0, ptr %1, align 4
  br label %82

29:                                               ; preds = %22
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 3
  %32 = load i32, ptr %31, align 8
  store i32 %32, ptr %5, align 4
  %33 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %34 = trunc i32 %33 to i16
  store i16 %34, ptr %8, align 2
  store ptr @mproc, ptr @mp, align 8
  %35 = load ptr, ptr %2, align 8
  %36 = getelementptr inbounds %struct.mproc, ptr %35, i32 0, i32 5
  %37 = load i32, ptr %36, align 8
  %38 = load ptr, ptr @mp, align 8
  %39 = getelementptr inbounds %struct.mproc, ptr %38, i32 0, i32 5
  store i32 %37, ptr %39, align 8
  %40 = load i16, ptr %8, align 2
  %41 = zext i16 %40 to i32
  %42 = icmp eq i32 %41, 32768
  br i1 %42, label %43, label %45

43:                                               ; preds = %29
  %44 = load i32, ptr %6, align 4
  call void (i32, ...) @stack_fault(i32 noundef %44)
  br label %45

45:                                               ; preds = %43, %29
  store i32 0, ptr %3, align 4
  store i32 1, ptr %4, align 4
  br label %46

46:                                               ; preds = %76, %45
  %47 = load i32, ptr %3, align 4
  %48 = icmp slt i32 %47, 15
  br i1 %48, label %49, label %81

49:                                               ; preds = %46
  %50 = load i32, ptr %4, align 4
  %51 = icmp eq i32 %50, 2
  br i1 %51, label %55, label %52

52:                                               ; preds = %49
  %53 = load i32, ptr %4, align 4
  %54 = icmp eq i32 %53, 3
  br i1 %54, label %55, label %56

55:                                               ; preds = %52, %49
  br label %58

56:                                               ; preds = %52
  %57 = load i32, ptr %5, align 4
  br label %58

58:                                               ; preds = %56, %55
  %59 = phi i32 [ 0, %55 ], [ %57, %56 ]
  store i32 %59, ptr %7, align 4
  %60 = load i32, ptr %4, align 4
  %61 = icmp eq i32 %60, 9
  br i1 %61, label %62, label %63

62:                                               ; preds = %58
  store i32 -1, ptr %7, align 4
  br label %63

63:                                               ; preds = %62, %58
  %64 = load i16, ptr %8, align 2
  %65 = zext i16 %64 to i32
  %66 = load i32, ptr %3, align 4
  %67 = ashr i32 %65, %66
  %68 = and i32 %67, 1
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %75

70:                                               ; preds = %63
  %71 = load i32, ptr %7, align 4
  %72 = load i32, ptr %4, align 4
  %73 = call i32 @check_sig(i32 noundef %71, i32 noundef %72, i32 noundef 0)
  %74 = load i32, ptr %6, align 4
  call void (i32, i32, ptr, ...) @sys_sig(i32 noundef %74, i32 noundef -1, ptr noundef null)
  br label %75

75:                                               ; preds = %70, %63
  br label %76

76:                                               ; preds = %75
  %77 = load i32, ptr %3, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, ptr %3, align 4
  %79 = load i32, ptr %4, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, ptr %4, align 4
  br label %46, !llvm.loop !6

81:                                               ; preds = %46
  store i32 0, ptr %1, align 4
  br label %82

82:                                               ; preds = %81, %28, %11
  %83 = load i32, ptr %1, align 4
  ret i32 %83
}

declare void @stack_fault(...) #1

declare void @sys_sig(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sig_proc(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i16, align 2
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.mproc, ptr %8, i32 0, i32 13
  %10 = load i32, ptr %9, align 8
  %11 = and i32 %10, 1
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %2
  br label %93

14:                                               ; preds = %2
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.mproc, ptr %15, i32 0, i32 13
  %17 = load i32, ptr %16, align 8
  %18 = and i32 %17, 64
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %26

20:                                               ; preds = %14
  %21 = load i32, ptr %4, align 4
  %22 = icmp ne i32 %21, 9
  br i1 %22, label %23, label %26

23:                                               ; preds = %20
  %24 = load ptr, ptr %3, align 8
  %25 = load i32, ptr %4, align 4
  call void (ptr, i32, ...) @stop_proc(ptr noundef %24, i32 noundef %25)
  br label %93

26:                                               ; preds = %20, %14
  %27 = load i32, ptr %4, align 4
  %28 = sub nsw i32 %27, 1
  %29 = shl i32 1, %28
  %30 = trunc i32 %29 to i16
  store i16 %30, ptr %5, align 2
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds %struct.mproc, ptr %31, i32 0, i32 11
  %33 = load i16, ptr %32, align 4
  %34 = zext i16 %33 to i32
  %35 = load i16, ptr %5, align 2
  %36 = zext i16 %35 to i32
  %37 = and i32 %34, %36
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %76

39:                                               ; preds = %26
  %40 = load i16, ptr %5, align 2
  %41 = zext i16 %40 to i32
  %42 = xor i32 %41, -1
  %43 = load ptr, ptr %3, align 8
  %44 = getelementptr inbounds %struct.mproc, ptr %43, i32 0, i32 11
  %45 = load i16, ptr %44, align 4
  %46 = zext i16 %45 to i32
  %47 = and i32 %46, %42
  %48 = trunc i32 %47 to i16
  store i16 %48, ptr %44, align 4
  %49 = load ptr, ptr %3, align 8
  %50 = ptrtoint ptr %49 to i64
  %51 = sub i64 %50, ptrtoint (ptr @mproc to i64)
  %52 = sdiv exact i64 %51, 80
  %53 = trunc i64 %52 to i32
  call void (i32, ptr, ...) @sys_getsp(i32 noundef %53, ptr noundef %7)
  %54 = load i64, ptr %7, align 8
  %55 = sub i64 %54, 16
  store i64 %55, ptr %7, align 8
  %56 = load ptr, ptr %3, align 8
  %57 = load ptr, ptr %3, align 8
  %58 = getelementptr inbounds %struct.mproc, ptr %57, i32 0, i32 0
  %59 = getelementptr inbounds [3 x %struct.mem_map], ptr %58, i64 0, i64 1
  %60 = getelementptr inbounds %struct.mem_map, ptr %59, i32 0, i32 2
  %61 = load i32, ptr %60, align 4
  %62 = load i64, ptr %7, align 8
  %63 = call i32 (ptr, i32, i64, ...) @adjust(ptr noundef %56, i32 noundef %61, i64 noundef %62)
  %64 = icmp eq i32 %63, 0
  br i1 %64, label %65, label %75

65:                                               ; preds = %39
  %66 = load ptr, ptr %3, align 8
  %67 = ptrtoint ptr %66 to i64
  %68 = sub i64 %67, ptrtoint (ptr @mproc to i64)
  %69 = sdiv exact i64 %68, 80
  %70 = trunc i64 %69 to i32
  %71 = load i32, ptr %4, align 4
  %72 = load ptr, ptr %3, align 8
  %73 = getelementptr inbounds %struct.mproc, ptr %72, i32 0, i32 12
  %74 = load ptr, ptr %73, align 8
  call void (i32, i32, ptr, ...) @sys_sig(i32 noundef %70, i32 noundef %71, ptr noundef %74)
  br label %93

75:                                               ; preds = %39
  br label %76

76:                                               ; preds = %75, %26
  %77 = load i16, ptr @core_bits, align 2
  %78 = zext i16 %77 to i32
  %79 = load i32, ptr %4, align 4
  %80 = sub nsw i32 %79, 1
  %81 = ashr i32 %78, %80
  %82 = and i32 %81, 1
  store i32 %82, ptr %6, align 4
  %83 = load i32, ptr %4, align 4
  %84 = trunc i32 %83 to i8
  %85 = load ptr, ptr %3, align 8
  %86 = getelementptr inbounds %struct.mproc, ptr %85, i32 0, i32 2
  store i8 %84, ptr %86, align 1
  %87 = load i32, ptr %6, align 4
  %88 = icmp ne i32 %87, 0
  br i1 %88, label %89, label %91

89:                                               ; preds = %76
  %90 = load ptr, ptr %3, align 8
  call void @dump_core(ptr noundef %90)
  br label %91

91:                                               ; preds = %89, %76
  %92 = load ptr, ptr %3, align 8
  call void (ptr, i32, ...) @mm_exit(ptr noundef %92, i32 noundef 0)
  br label %93

93:                                               ; preds = %91, %65, %23, %13
  ret void
}

declare void @stop_proc(...) #1

declare void @sys_getsp(...) #1

declare i32 @adjust(...) #1

declare void @mm_exit(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_alarm() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  store i32 %3, ptr %2, align 4
  %4 = load i32, ptr @who, align 4
  %5 = load i32, ptr %2, align 4
  %6 = call i32 @set_alarm(i32 noundef %4, i32 noundef %5)
  store i32 %6, ptr %1, align 4
  %7 = load i32, ptr %1, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @set_alarm(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 1, ptr getelementptr inbounds (%struct.message, ptr @m_sig, i32 0, i32 1), align 4
  %6 = load i32, ptr %3, align 4
  store i32 %6, ptr getelementptr inbounds (%struct.message, ptr @m_sig, i32 0, i32 2), align 8
  %7 = load i32, ptr %4, align 4
  %8 = mul i32 60, %7
  %9 = zext i32 %8 to i64
  store i64 %9, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @m_sig, i32 0, i32 2), i32 0, i32 3), align 8
  %10 = load i32, ptr %4, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %19

12:                                               ; preds = %2
  %13 = load i32, ptr %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %14
  %16 = getelementptr inbounds %struct.mproc, ptr %15, i32 0, i32 13
  %17 = load i32, ptr %16, align 8
  %18 = or i32 %17, 16
  store i32 %18, ptr %16, align 8
  br label %26

19:                                               ; preds = %2
  %20 = load i32, ptr %3, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %21
  %23 = getelementptr inbounds %struct.mproc, ptr %22, i32 0, i32 13
  %24 = load i32, ptr %23, align 8
  %25 = and i32 %24, -17
  store i32 %25, ptr %23, align 8
  br label %26

26:                                               ; preds = %19, %12
  %27 = call i32 @sendrec(i32 noundef -3, ptr noundef @m_sig)
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %26
  call void @panic(ptr noundef @.str, i32 noundef 32768)
  br label %30

30:                                               ; preds = %29, %26
  %31 = load i64, ptr getelementptr inbounds (%struct.mess_6, ptr getelementptr inbounds (%struct.message, ptr @m_sig, i32 0, i32 2), i32 0, i32 3), align 8
  %32 = trunc i64 %31 to i32
  store i32 %32, ptr %5, align 4
  %33 = load i32, ptr %5, align 4
  ret i32 %33
}

declare i32 @sendrec(i32 noundef, ptr noundef) #1

declare void @panic(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_pause() #0 {
  %1 = load ptr, ptr @mp, align 8
  %2 = getelementptr inbounds %struct.mproc, ptr %1, i32 0, i32 13
  %3 = load i32, ptr %2, align 8
  %4 = or i32 %3, 8
  store i32 %4, ptr %2, align 8
  store i32 1, ptr @dont_reply, align 4
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @check_sig(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i16, align 2
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i16, align 2
  %12 = trunc i32 %2 to i16
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i16 %12, ptr %7, align 2
  %13 = load i32, ptr %6, align 4
  %14 = icmp slt i32 %13, 1
  br i1 %14, label %18, label %15

15:                                               ; preds = %3
  %16 = load i32, ptr %6, align 4
  %17 = icmp sgt i32 %16, 16
  br i1 %17, label %18, label %19

18:                                               ; preds = %15, %3
  store i32 -22, ptr %4, align 4
  br label %170

19:                                               ; preds = %15
  store i32 0, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = sub nsw i32 %20, 1
  %22 = shl i32 1, %21
  %23 = trunc i32 %22 to i16
  store i16 %23, ptr %11, align 2
  store ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), ptr %8, align 8
  br label %24

24:                                               ; preds = %149, %19
  %25 = load ptr, ptr %8, align 8
  %26 = icmp ult ptr %25, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %26, label %27, label %152

27:                                               ; preds = %24
  %28 = load ptr, ptr %8, align 8
  %29 = getelementptr inbounds %struct.mproc, ptr %28, i32 0, i32 13
  %30 = load i32, ptr %29, align 8
  %31 = and i32 %30, 1
  %32 = icmp eq i32 %31, 0
  br i1 %32, label %33, label %34

33:                                               ; preds = %27
  br label %149

34:                                               ; preds = %27
  store i32 1, ptr %10, align 4
  %35 = load i16, ptr %7, align 2
  %36 = zext i16 %35 to i32
  %37 = load ptr, ptr %8, align 8
  %38 = getelementptr inbounds %struct.mproc, ptr %37, i32 0, i32 7
  %39 = load i16, ptr %38, align 2
  %40 = zext i16 %39 to i32
  %41 = icmp ne i32 %36, %40
  br i1 %41, label %42, label %47

42:                                               ; preds = %34
  %43 = load i16, ptr %7, align 2
  %44 = zext i16 %43 to i32
  %45 = icmp ne i32 %44, 0
  br i1 %45, label %46, label %47

46:                                               ; preds = %42
  store i32 0, ptr %10, align 4
  br label %47

47:                                               ; preds = %46, %42, %34
  %48 = load i32, ptr %5, align 4
  %49 = icmp sgt i32 %48, 0
  br i1 %49, label %50, label %57

50:                                               ; preds = %47
  %51 = load i32, ptr %5, align 4
  %52 = load ptr, ptr %8, align 8
  %53 = getelementptr inbounds %struct.mproc, ptr %52, i32 0, i32 3
  %54 = load i32, ptr %53, align 8
  %55 = icmp ne i32 %51, %54
  br i1 %55, label %56, label %57

56:                                               ; preds = %50
  store i32 0, ptr %10, align 4
  br label %57

57:                                               ; preds = %56, %50, %47
  %58 = load ptr, ptr %8, align 8
  %59 = getelementptr inbounds %struct.mproc, ptr %58, i32 0, i32 13
  %60 = load i32, ptr %59, align 8
  %61 = and i32 %60, 4
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %64

63:                                               ; preds = %57
  store i32 0, ptr %10, align 4
  br label %64

64:                                               ; preds = %63, %57
  %65 = load i32, ptr %5, align 4
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %67, label %76

67:                                               ; preds = %64
  %68 = load ptr, ptr @mp, align 8
  %69 = getelementptr inbounds %struct.mproc, ptr %68, i32 0, i32 5
  %70 = load i32, ptr %69, align 8
  %71 = load ptr, ptr %8, align 8
  %72 = getelementptr inbounds %struct.mproc, ptr %71, i32 0, i32 5
  %73 = load i32, ptr %72, align 8
  %74 = icmp ne i32 %70, %73
  br i1 %74, label %75, label %76

75:                                               ; preds = %67
  store i32 0, ptr %10, align 4
  br label %76

76:                                               ; preds = %75, %67, %64
  %77 = load i16, ptr %7, align 2
  %78 = zext i16 %77 to i32
  %79 = icmp eq i32 %78, 0
  br i1 %79, label %80, label %84

80:                                               ; preds = %76
  %81 = load i32, ptr %5, align 4
  %82 = icmp eq i32 %81, -1
  br i1 %82, label %83, label %84

83:                                               ; preds = %80
  store i32 1, ptr %10, align 4
  br label %84

84:                                               ; preds = %83, %80, %76
  %85 = load ptr, ptr %8, align 8
  %86 = getelementptr inbounds %struct.mproc, ptr %85, i32 0, i32 3
  %87 = load i32, ptr %86, align 8
  %88 = icmp eq i32 %87, 1
  br i1 %88, label %89, label %93

89:                                               ; preds = %84
  %90 = load i32, ptr %5, align 4
  %91 = icmp eq i32 %90, -1
  br i1 %91, label %92, label %93

92:                                               ; preds = %89
  store i32 0, ptr %10, align 4
  br label %93

93:                                               ; preds = %92, %89, %84
  %94 = load ptr, ptr %8, align 8
  %95 = getelementptr inbounds %struct.mproc, ptr %94, i32 0, i32 3
  %96 = load i32, ptr %95, align 8
  %97 = icmp eq i32 %96, 1
  br i1 %97, label %98, label %102

98:                                               ; preds = %93
  %99 = load i32, ptr %6, align 4
  %100 = icmp eq i32 %99, 9
  br i1 %100, label %101, label %102

101:                                              ; preds = %98
  store i32 0, ptr %10, align 4
  br label %102

102:                                              ; preds = %101, %98, %93
  %103 = load i32, ptr %6, align 4
  %104 = icmp eq i32 %103, 14
  br i1 %104, label %105, label %121

105:                                              ; preds = %102
  %106 = load ptr, ptr %8, align 8
  %107 = getelementptr inbounds %struct.mproc, ptr %106, i32 0, i32 13
  %108 = load i32, ptr %107, align 8
  %109 = and i32 %108, 16
  %110 = icmp eq i32 %109, 0
  br i1 %110, label %111, label %112

111:                                              ; preds = %105
  br label %149

112:                                              ; preds = %105
  %113 = load i32, ptr %10, align 4
  %114 = icmp ne i32 %113, 0
  br i1 %114, label %115, label %120

115:                                              ; preds = %112
  %116 = load ptr, ptr %8, align 8
  %117 = getelementptr inbounds %struct.mproc, ptr %116, i32 0, i32 13
  %118 = load i32, ptr %117, align 8
  %119 = and i32 %118, -17
  store i32 %119, ptr %117, align 8
  br label %120

120:                                              ; preds = %115, %112
  br label %121

121:                                              ; preds = %120, %102
  %122 = load i32, ptr %10, align 4
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %124, label %125

124:                                              ; preds = %121
  br label %149

125:                                              ; preds = %121
  %126 = load i32, ptr %9, align 4
  %127 = add nsw i32 %126, 1
  store i32 %127, ptr %9, align 4
  %128 = load ptr, ptr %8, align 8
  %129 = getelementptr inbounds %struct.mproc, ptr %128, i32 0, i32 10
  %130 = load i16, ptr %129, align 2
  %131 = zext i16 %130 to i32
  %132 = load i16, ptr %11, align 2
  %133 = zext i16 %132 to i32
  %134 = and i32 %131, %133
  %135 = icmp ne i32 %134, 0
  br i1 %135, label %136, label %137

136:                                              ; preds = %125
  br label %149

137:                                              ; preds = %125
  %138 = load ptr, ptr %8, align 8
  %139 = load i32, ptr %6, align 4
  call void @sig_proc(ptr noundef %138, i32 noundef %139)
  %140 = load ptr, ptr %8, align 8
  %141 = ptrtoint ptr %140 to i64
  %142 = sub i64 %141, ptrtoint (ptr @mproc to i64)
  %143 = sdiv exact i64 %142, 80
  %144 = trunc i64 %143 to i32
  call void @unpause(i32 noundef %144)
  %145 = load i32, ptr %5, align 4
  %146 = icmp sgt i32 %145, 0
  br i1 %146, label %147, label %148

147:                                              ; preds = %137
  br label %152

148:                                              ; preds = %137
  br label %149

149:                                              ; preds = %148, %136, %124, %111, %33
  %150 = load ptr, ptr %8, align 8
  %151 = getelementptr inbounds %struct.mproc, ptr %150, i32 1
  store ptr %151, ptr %8, align 8
  br label %24, !llvm.loop !8

152:                                              ; preds = %147, %24
  %153 = load ptr, ptr @mp, align 8
  %154 = getelementptr inbounds %struct.mproc, ptr %153, i32 0, i32 13
  %155 = load i32, ptr %154, align 8
  %156 = and i32 %155, 1
  %157 = icmp eq i32 %156, 0
  br i1 %157, label %164, label %158

158:                                              ; preds = %152
  %159 = load ptr, ptr @mp, align 8
  %160 = getelementptr inbounds %struct.mproc, ptr %159, i32 0, i32 13
  %161 = load i32, ptr %160, align 8
  %162 = and i32 %161, 4
  %163 = icmp ne i32 %162, 0
  br i1 %163, label %164, label %165

164:                                              ; preds = %158, %152
  store i32 1, ptr @dont_reply, align 4
  br label %165

165:                                              ; preds = %164, %158
  %166 = load i32, ptr %9, align 4
  %167 = icmp sgt i32 %166, 0
  %168 = zext i1 %167 to i64
  %169 = select i1 %167, i32 0, i32 -3
  store i32 %169, ptr %4, align 4
  br label %170

170:                                              ; preds = %165, %18
  %171 = load i32, ptr %4, align 4
  ret i32 %171
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @unpause(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %5
  store ptr %6, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %struct.mproc, ptr %7, i32 0, i32 13
  %9 = load i32, ptr %8, align 8
  %10 = and i32 %9, 8
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %24

12:                                               ; preds = %1
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.mproc, ptr %13, i32 0, i32 13
  %15 = load i32, ptr %14, align 8
  %16 = and i32 %15, 4
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %24

18:                                               ; preds = %12
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.mproc, ptr %19, i32 0, i32 13
  %21 = load i32, ptr %20, align 8
  %22 = and i32 %21, -9
  store i32 %22, ptr %20, align 8
  %23 = load i32, ptr %2, align 4
  call void @reply(i32 noundef %23, i32 noundef -4, i32 noundef 0, ptr noundef null)
  br label %44

24:                                               ; preds = %12, %1
  %25 = load ptr, ptr %3, align 8
  %26 = getelementptr inbounds %struct.mproc, ptr %25, i32 0, i32 13
  %27 = load i32, ptr %26, align 8
  %28 = and i32 %27, 2
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %42

30:                                               ; preds = %24
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds %struct.mproc, ptr %31, i32 0, i32 13
  %33 = load i32, ptr %32, align 8
  %34 = and i32 %33, 4
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %42

36:                                               ; preds = %30
  %37 = load ptr, ptr %3, align 8
  %38 = getelementptr inbounds %struct.mproc, ptr %37, i32 0, i32 13
  %39 = load i32, ptr %38, align 8
  %40 = and i32 %39, -3
  store i32 %40, ptr %38, align 8
  %41 = load i32, ptr %2, align 4
  call void @reply(i32 noundef %41, i32 noundef -4, i32 noundef 0, ptr noundef null)
  br label %44

42:                                               ; preds = %30, %24
  %43 = load i32, ptr %2, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 65, i32 noundef %43, i32 noundef 0, i32 noundef 0)
  br label %44

44:                                               ; preds = %42, %36, %18
  ret void
}

declare void @reply(i32 noundef, i32 noundef, i32 noundef, ptr noundef) #1

declare void @tell_fs(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @dump_core(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca %struct.stat, align 8
  %4 = alloca %struct.stat, align 8
  %5 = alloca [256 x i8], align 16
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca ptr, align 8
  %18 = alloca i64, align 8
  %19 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %20 = load ptr, ptr %2, align 8
  %21 = ptrtoint ptr %20 to i64
  %22 = sub i64 %21, ptrtoint (ptr @mproc to i64)
  %23 = sdiv exact i64 %22, 80
  %24 = trunc i64 %23 to i32
  store i32 %24, ptr %11, align 4
  %25 = load i32, ptr %11, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef %25, i32 noundef 0, i32 noundef 0)
  %26 = load ptr, ptr %2, align 8
  %27 = getelementptr inbounds %struct.mproc, ptr %26, i32 0, i32 6
  %28 = load i16, ptr %27, align 4
  %29 = zext i16 %28 to i32
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 7
  %32 = load i16, ptr %31, align 2
  %33 = zext i16 %32 to i32
  %34 = icmp ne i32 %29, %33
  br i1 %34, label %35, label %36

35:                                               ; preds = %1
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef 0, i32 noundef 1, i32 noundef 0)
  br label %179

36:                                               ; preds = %1
  %37 = load ptr, ptr @mp, align 8
  store ptr %37, ptr %17, align 8
  %38 = load ptr, ptr %2, align 8
  store ptr %38, ptr @mp, align 8
  %39 = call i32 (ptr, ptr, i32, ...) @allowed(ptr noundef @core_name, ptr noundef %3, i32 noundef 2)
  store i32 %39, ptr %7, align 4
  %40 = call i32 (ptr, ptr, i32, ...) @allowed(ptr noundef @.str.1, ptr noundef %4, i32 noundef 2)
  store i32 %40, ptr %8, align 4
  %41 = load ptr, ptr %17, align 8
  store ptr %41, ptr @mp, align 8
  %42 = load i32, ptr %7, align 4
  %43 = icmp sge i32 %42, 0
  br i1 %43, label %44, label %47

44:                                               ; preds = %36
  %45 = load i32, ptr %7, align 4
  %46 = call i32 (i32, ...) @close(i32 noundef %45)
  br label %47

47:                                               ; preds = %44, %36
  %48 = load i32, ptr %8, align 4
  %49 = icmp sge i32 %48, 0
  br i1 %49, label %50, label %53

50:                                               ; preds = %47
  %51 = load i32, ptr %8, align 4
  %52 = call i32 (i32, ...) @close(i32 noundef %51)
  br label %53

53:                                               ; preds = %50, %47
  %54 = load ptr, ptr %2, align 8
  %55 = getelementptr inbounds %struct.mproc, ptr %54, i32 0, i32 7
  %56 = load i16, ptr %55, align 2
  %57 = zext i16 %56 to i32
  %58 = icmp eq i32 %57, 0
  br i1 %58, label %59, label %60

59:                                               ; preds = %53
  store i32 0, ptr %7, align 4
  br label %60

60:                                               ; preds = %59, %53
  %61 = load i32, ptr %8, align 4
  %62 = icmp sge i32 %61, 0
  br i1 %62, label %63, label %173

63:                                               ; preds = %60
  %64 = load i32, ptr %7, align 4
  %65 = icmp sge i32 %64, 0
  br i1 %65, label %69, label %66

66:                                               ; preds = %63
  %67 = load i32, ptr %7, align 4
  %68 = icmp eq i32 %67, -2
  br i1 %68, label %69, label %173

69:                                               ; preds = %66, %63
  %70 = call i32 (ptr, i32, ...) @creat(ptr noundef @core_name, i32 noundef 511)
  store i32 %70, ptr %7, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef 0, i32 noundef 1, i32 noundef 0)
  %71 = load i32, ptr %7, align 4
  %72 = icmp slt i32 %71, 0
  br i1 %72, label %73, label %74

73:                                               ; preds = %69
  br label %179

74:                                               ; preds = %69
  %75 = load ptr, ptr %2, align 8
  %76 = getelementptr inbounds %struct.mproc, ptr %75, i32 0, i32 2
  %77 = load i8, ptr %76, align 1
  %78 = sext i8 %77 to i32
  %79 = or i32 %78, 128
  %80 = trunc i32 %79 to i8
  store i8 %80, ptr %76, align 1
  %81 = load i32, ptr %7, align 4
  %82 = load ptr, ptr %2, align 8
  %83 = getelementptr inbounds %struct.mproc, ptr %82, i32 0, i32 0
  %84 = getelementptr inbounds [3 x %struct.mem_map], ptr %83, i64 0, i64 0
  %85 = call i32 (i32, ptr, i32, ...) @write(i32 noundef %81, ptr noundef %84, i32 noundef 36)
  %86 = icmp slt i32 %85, 0
  br i1 %86, label %87, label %90

87:                                               ; preds = %74
  %88 = load i32, ptr %7, align 4
  %89 = call i32 (i32, ...) @close(i32 noundef %88)
  br label %179

90:                                               ; preds = %74
  store i32 0, ptr %19, align 4
  br label %91

91:                                               ; preds = %98, %90
  %92 = load i32, ptr %11, align 4
  %93 = load i32, ptr %19, align 4
  %94 = sext i32 %93 to i64
  %95 = ptrtoint ptr %18 to i64
  %96 = call i32 (i32, i32, i64, i64, ...) @sys_trace(i32 noundef 3, i32 noundef %92, i64 noundef %94, i64 noundef %95)
  %97 = icmp eq i32 %96, 0
  br i1 %97, label %98, label %105

98:                                               ; preds = %91
  %99 = load i32, ptr %7, align 4
  %100 = call i32 (i32, ptr, i32, ...) @write(i32 noundef %99, ptr noundef %18, i32 noundef 8)
  %101 = load i32, ptr %19, align 4
  %102 = sext i32 %101 to i64
  %103 = add i64 %102, 8
  %104 = trunc i64 %103 to i32
  store i32 %104, ptr %19, align 4
  br label %91, !llvm.loop !9

105:                                              ; preds = %91
  %106 = getelementptr inbounds [256 x i8], ptr %5, i64 0, i64 0
  %107 = ptrtoint ptr %106 to i64
  store i64 %107, ptr %12, align 8
  %108 = load i64, ptr %12, align 8
  store i64 %108, ptr %16, align 8
  store i32 0, ptr %6, align 4
  br label %109

109:                                              ; preds = %169, %105
  %110 = load i32, ptr %6, align 4
  %111 = icmp slt i32 %110, 3
  br i1 %111, label %112, label %172

112:                                              ; preds = %109
  %113 = load ptr, ptr %2, align 8
  %114 = getelementptr inbounds %struct.mproc, ptr %113, i32 0, i32 0
  %115 = load i32, ptr %6, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds [3 x %struct.mem_map], ptr %114, i64 0, i64 %116
  %118 = getelementptr inbounds %struct.mem_map, ptr %117, i32 0, i32 0
  %119 = load i32, ptr %118, align 4
  %120 = zext i32 %119 to i64
  %121 = shl i64 %120, 8
  store i64 %121, ptr %13, align 8
  %122 = load ptr, ptr %2, align 8
  %123 = getelementptr inbounds %struct.mproc, ptr %122, i32 0, i32 0
  %124 = load i32, ptr %6, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [3 x %struct.mem_map], ptr %123, i64 0, i64 %125
  %127 = getelementptr inbounds %struct.mem_map, ptr %126, i32 0, i32 2
  %128 = load i32, ptr %127, align 4
  %129 = zext i32 %128 to i64
  %130 = shl i64 %129, 8
  store i64 %130, ptr %14, align 8
  br label %131

131:                                              ; preds = %161, %112
  %132 = load i64, ptr %14, align 8
  %133 = icmp sgt i64 %132, 0
  br i1 %133, label %134, label %168

134:                                              ; preds = %131
  %135 = load i64, ptr %14, align 8
  %136 = icmp slt i64 %135, 256
  br i1 %136, label %137, label %139

137:                                              ; preds = %134
  %138 = load i64, ptr %14, align 8
  br label %140

139:                                              ; preds = %134
  br label %140

140:                                              ; preds = %139, %137
  %141 = phi i64 [ %138, %137 ], [ 256, %139 ]
  store i64 %141, ptr %15, align 8
  %142 = load i32, ptr %11, align 4
  %143 = load i32, ptr %6, align 4
  %144 = load i64, ptr %13, align 8
  %145 = load i64, ptr %16, align 8
  %146 = load i64, ptr %15, align 8
  %147 = call i32 (i32, i32, i64, i32, i32, i64, i64, ...) @mem_copy(i32 noundef %142, i32 noundef %143, i64 noundef %144, i32 noundef 0, i32 noundef 1, i64 noundef %145, i64 noundef %146)
  store i32 %147, ptr %9, align 4
  %148 = load i32, ptr %7, align 4
  %149 = getelementptr inbounds [256 x i8], ptr %5, i64 0, i64 0
  %150 = load i64, ptr %15, align 8
  %151 = trunc i64 %150 to i32
  %152 = call i32 (i32, ptr, i32, ...) @write(i32 noundef %148, ptr noundef %149, i32 noundef %151)
  store i32 %152, ptr %10, align 4
  %153 = load i32, ptr %9, align 4
  %154 = icmp slt i32 %153, 0
  br i1 %154, label %158, label %155

155:                                              ; preds = %140
  %156 = load i32, ptr %10, align 4
  %157 = icmp slt i32 %156, 0
  br i1 %157, label %158, label %161

158:                                              ; preds = %155, %140
  %159 = load i32, ptr %7, align 4
  %160 = call i32 (i32, ...) @close(i32 noundef %159)
  br label %179

161:                                              ; preds = %155
  %162 = load i64, ptr %15, align 8
  %163 = load i64, ptr %13, align 8
  %164 = add nsw i64 %163, %162
  store i64 %164, ptr %13, align 8
  %165 = load i64, ptr %15, align 8
  %166 = load i64, ptr %14, align 8
  %167 = sub nsw i64 %166, %165
  store i64 %167, ptr %14, align 8
  br label %131, !llvm.loop !10

168:                                              ; preds = %131
  br label %169

169:                                              ; preds = %168
  %170 = load i32, ptr %6, align 4
  %171 = add nsw i32 %170, 1
  store i32 %171, ptr %6, align 4
  br label %109, !llvm.loop !11

172:                                              ; preds = %109
  br label %176

173:                                              ; preds = %66, %60
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef 0, i32 noundef 1, i32 noundef 0)
  %174 = load i32, ptr %7, align 4
  %175 = call i32 (i32, ...) @close(i32 noundef %174)
  br label %179

176:                                              ; preds = %172
  %177 = load i32, ptr %7, align 4
  %178 = call i32 (i32, ...) @close(i32 noundef %177)
  br label %179

179:                                              ; preds = %176, %173, %158, %87, %73, %35
  ret void
}

declare i32 @allowed(...) #1

declare i32 @close(...) #1

declare i32 @creat(...) #1

declare i32 @write(...) #1

declare i32 @sys_trace(...) #1

declare i32 @mem_copy(...) #1

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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
