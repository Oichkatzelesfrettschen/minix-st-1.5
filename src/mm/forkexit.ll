; NOTE: Generated from src/mm/forkexit.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/forkexit.c'
source_filename = "src/mm/forkexit.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }

@mp = external global ptr, align 8
@procs_in_use = external global i32, align 4
@mproc = external global [32 x %struct.mproc], align 16
@who = external global i32, align 4
@next_pid = internal global i32 2, align 4
@mm_in = external global %struct.message, align 8
@dont_reply = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_fork() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = load ptr, ptr @mp, align 8
  store ptr %11, ptr %2, align 8
  %12 = load i32, ptr @procs_in_use, align 4
  %13 = icmp eq i32 %12, 32
  br i1 %13, label %14, label %15

14:                                               ; preds = %0
  store i32 -11, ptr %1, align 4
  br label %154

15:                                               ; preds = %0
  %16 = load i32, ptr @procs_in_use, align 4
  %17 = icmp sge i32 %16, 30
  br i1 %17, label %18, label %25

18:                                               ; preds = %15
  %19 = load ptr, ptr %2, align 8
  %20 = getelementptr inbounds %struct.mproc, ptr %19, i32 0, i32 7
  %21 = load i16, ptr %20, align 2
  %22 = zext i16 %21 to i32
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %25

24:                                               ; preds = %18
  store i32 -11, ptr %1, align 4
  br label %154

25:                                               ; preds = %18, %15
  %26 = load ptr, ptr %2, align 8
  %27 = getelementptr inbounds %struct.mproc, ptr %26, i32 0, i32 0
  %28 = getelementptr inbounds [3 x %struct.mem_map], ptr %27, i64 0, i64 2
  %29 = getelementptr inbounds %struct.mem_map, ptr %28, i32 0, i32 2
  %30 = load i32, ptr %29, align 8
  store i32 %30, ptr %9, align 4
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.mproc, ptr %31, i32 0, i32 0
  %33 = getelementptr inbounds [3 x %struct.mem_map], ptr %32, i64 0, i64 2
  %34 = getelementptr inbounds %struct.mem_map, ptr %33, i32 0, i32 0
  %35 = load i32, ptr %34, align 8
  %36 = load ptr, ptr %2, align 8
  %37 = getelementptr inbounds %struct.mproc, ptr %36, i32 0, i32 0
  %38 = getelementptr inbounds [3 x %struct.mem_map], ptr %37, i64 0, i64 1
  %39 = getelementptr inbounds %struct.mem_map, ptr %38, i32 0, i32 0
  %40 = load i32, ptr %39, align 4
  %41 = sub i32 %35, %40
  %42 = load i32, ptr %9, align 4
  %43 = add i32 %42, %41
  store i32 %43, ptr %9, align 4
  %44 = load i32, ptr %9, align 4
  %45 = call i32 @alloc_mem(i32 noundef %44)
  store i32 %45, ptr %10, align 4
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %48

47:                                               ; preds = %25
  store i32 -11, ptr %1, align 4
  br label %154

48:                                               ; preds = %25
  store ptr @mproc, ptr %3, align 8
  br label %49

49:                                               ; preds = %60, %48
  %50 = load ptr, ptr %3, align 8
  %51 = icmp ult ptr %50, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %51, label %52, label %63

52:                                               ; preds = %49
  %53 = load ptr, ptr %3, align 8
  %54 = getelementptr inbounds %struct.mproc, ptr %53, i32 0, i32 13
  %55 = load i32, ptr %54, align 8
  %56 = and i32 %55, 1
  %57 = icmp eq i32 %56, 0
  br i1 %57, label %58, label %59

58:                                               ; preds = %52
  br label %63

59:                                               ; preds = %52
  br label %60

60:                                               ; preds = %59
  %61 = load ptr, ptr %3, align 8
  %62 = getelementptr inbounds %struct.mproc, ptr %61, i32 1
  store ptr %62, ptr %3, align 8
  br label %49

63:                                               ; preds = %58, %49
  %64 = load ptr, ptr %3, align 8
  %65 = ptrtoint ptr %64 to i64
  %66 = sub i64 %65, ptrtoint (ptr @mproc to i64)
  %67 = sdiv exact i64 %66, 80
  %68 = trunc i64 %67 to i32
  store i32 %68, ptr %5, align 4
  %69 = load i32, ptr @procs_in_use, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, ptr @procs_in_use, align 4
  %71 = load ptr, ptr %2, align 8
  store ptr %71, ptr %7, align 8
  %72 = load ptr, ptr %3, align 8
  store ptr %72, ptr %8, align 8
  store i32 80, ptr %4, align 4
  br label %73

73:                                               ; preds = %77, %63
  %74 = load i32, ptr %4, align 4
  %75 = add nsw i32 %74, -1
  store i32 %75, ptr %4, align 4
  %76 = icmp ne i32 %74, 0
  br i1 %76, label %77, label %83

77:                                               ; preds = %73
  %78 = load ptr, ptr %7, align 8
  %79 = getelementptr inbounds i8, ptr %78, i32 1
  store ptr %79, ptr %7, align 8
  %80 = load i8, ptr %78, align 1
  %81 = load ptr, ptr %8, align 8
  %82 = getelementptr inbounds i8, ptr %81, i32 1
  store ptr %82, ptr %8, align 8
  store i8 %80, ptr %81, align 1
  br label %73

83:                                               ; preds = %73
  %84 = load i32, ptr @who, align 4
  %85 = load ptr, ptr %3, align 8
  %86 = getelementptr inbounds %struct.mproc, ptr %85, i32 0, i32 4
  store i32 %84, ptr %86, align 4
  %87 = load ptr, ptr %3, align 8
  %88 = getelementptr inbounds %struct.mproc, ptr %87, i32 0, i32 13
  %89 = load i32, ptr %88, align 8
  %90 = and i32 %89, -65
  store i32 %90, ptr %88, align 8
  %91 = load ptr, ptr %3, align 8
  %92 = getelementptr inbounds %struct.mproc, ptr %91, i32 0, i32 1
  store i8 0, ptr %92, align 4
  %93 = load ptr, ptr %3, align 8
  %94 = getelementptr inbounds %struct.mproc, ptr %93, i32 0, i32 2
  store i8 0, ptr %94, align 1
  br label %95

95:                                               ; preds = %128, %83
  store i32 0, ptr %6, align 4
  %96 = load i32, ptr @next_pid, align 4
  %97 = icmp slt i32 %96, 30000
  br i1 %97, label %98, label %101

98:                                               ; preds = %95
  %99 = load i32, ptr @next_pid, align 4
  %100 = add nsw i32 %99, 1
  br label %102

101:                                              ; preds = %95
  br label %102

102:                                              ; preds = %101, %98
  %103 = phi i32 [ %100, %98 ], [ 2, %101 ]
  store i32 %103, ptr @next_pid, align 4
  store ptr @mproc, ptr %2, align 8
  br label %104

104:                                              ; preds = %121, %102
  %105 = load ptr, ptr %2, align 8
  %106 = icmp ult ptr %105, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %106, label %107, label %124

107:                                              ; preds = %104
  %108 = load ptr, ptr %2, align 8
  %109 = getelementptr inbounds %struct.mproc, ptr %108, i32 0, i32 3
  %110 = load i32, ptr %109, align 8
  %111 = load i32, ptr @next_pid, align 4
  %112 = icmp eq i32 %110, %111
  br i1 %112, label %119, label %113

113:                                              ; preds = %107
  %114 = load ptr, ptr %2, align 8
  %115 = getelementptr inbounds %struct.mproc, ptr %114, i32 0, i32 5
  %116 = load i32, ptr %115, align 8
  %117 = load i32, ptr @next_pid, align 4
  %118 = icmp eq i32 %116, %117
  br i1 %118, label %119, label %120

119:                                              ; preds = %113, %107
  store i32 1, ptr %6, align 4
  br label %124

120:                                              ; preds = %113
  br label %121

121:                                              ; preds = %120
  %122 = load ptr, ptr %2, align 8
  %123 = getelementptr inbounds %struct.mproc, ptr %122, i32 1
  store ptr %123, ptr %2, align 8
  br label %104

124:                                              ; preds = %119, %104
  %125 = load i32, ptr @next_pid, align 4
  %126 = load ptr, ptr %3, align 8
  %127 = getelementptr inbounds %struct.mproc, ptr %126, i32 0, i32 3
  store i32 %125, ptr %127, align 8
  br label %128

128:                                              ; preds = %124
  %129 = load i32, ptr %6, align 4
  %130 = icmp ne i32 %129, 0
  br i1 %130, label %95, label %131

131:                                              ; preds = %128
  %132 = load i32, ptr @who, align 4
  %133 = icmp eq i32 %132, 2
  br i1 %133, label %134, label %140

134:                                              ; preds = %131
  %135 = load ptr, ptr %3, align 8
  %136 = getelementptr inbounds %struct.mproc, ptr %135, i32 0, i32 3
  %137 = load i32, ptr %136, align 8
  %138 = load ptr, ptr %3, align 8
  %139 = getelementptr inbounds %struct.mproc, ptr %138, i32 0, i32 5
  store i32 %137, ptr %139, align 8
  br label %140

140:                                              ; preds = %134, %131
  %141 = load i32, ptr @who, align 4
  %142 = load i32, ptr %5, align 4
  %143 = load ptr, ptr %3, align 8
  %144 = getelementptr inbounds %struct.mproc, ptr %143, i32 0, i32 3
  %145 = load i32, ptr %144, align 8
  %146 = load i32, ptr %10, align 4
  call void (i32, i32, i32, i32, ...) @sys_fork(i32 noundef %141, i32 noundef %142, i32 noundef %145, i32 noundef %146)
  %147 = load i32, ptr @who, align 4
  %148 = load i32, ptr %5, align 4
  %149 = load ptr, ptr %3, align 8
  %150 = getelementptr inbounds %struct.mproc, ptr %149, i32 0, i32 3
  %151 = load i32, ptr %150, align 8
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 2, i32 noundef %147, i32 noundef %148, i32 noundef %151)
  %152 = load i32, ptr %5, align 4
  call void @reply(i32 noundef %152, i32 noundef 0, i32 noundef 0, ptr noundef null)
  %153 = load i32, ptr @next_pid, align 4
  store i32 %153, ptr %1, align 4
  br label %154

154:                                              ; preds = %140, %47, %24, %14
  %155 = load i32, ptr %1, align 4
  ret i32 %155
}

declare i32 @alloc_mem(i32 noundef) #1

declare void @sys_fork(...) #1

declare void @tell_fs(...) #1

declare void @reply(i32 noundef, i32 noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_mm_exit() #0 {
  %1 = load ptr, ptr @mp, align 8
  %2 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  call void @mm_exit(ptr noundef %1, i32 noundef %2)
  store i32 1, ptr @dont_reply, align 4
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @mm_exit(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %8 = load ptr, ptr %3, align 8
  %9 = ptrtoint ptr %8 to i64
  %10 = sub i64 %9, ptrtoint (ptr @mproc to i64)
  %11 = sdiv exact i64 %10, 80
  %12 = trunc i64 %11 to i32
  store i32 %12, ptr %7, align 4
  %13 = load i32, ptr %4, align 4
  %14 = trunc i32 %13 to i8
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.mproc, ptr %15, i32 0, i32 1
  store i8 %14, ptr %16, align 4
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.mproc, ptr %17, i32 0, i32 4
  %19 = load i32, ptr %18, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %20
  %22 = getelementptr inbounds %struct.mproc, ptr %21, i32 0, i32 13
  %23 = load i32, ptr %22, align 8
  %24 = and i32 %23, 2
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %28

26:                                               ; preds = %2
  %27 = load ptr, ptr %3, align 8
  call void @cleanup(ptr noundef %27)
  br label %33

28:                                               ; preds = %2
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %struct.mproc, ptr %29, i32 0, i32 13
  %31 = load i32, ptr %30, align 8
  %32 = or i32 %31, 4
  store i32 %32, ptr %30, align 8
  br label %33

33:                                               ; preds = %28, %26
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %struct.mproc, ptr %34, i32 0, i32 13
  %36 = load i32, ptr %35, align 8
  %37 = and i32 %36, 16
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %42

39:                                               ; preds = %33
  %40 = load i32, ptr %7, align 4
  %41 = call i32 (i32, i32, ...) @set_alarm(i32 noundef %40, i32 noundef 0)
  br label %42

42:                                               ; preds = %39, %33
  %43 = load ptr, ptr %3, align 8
  %44 = getelementptr inbounds %struct.mproc, ptr %43, i32 0, i32 4
  %45 = load i32, ptr %44, align 4
  %46 = load i32, ptr %7, align 4
  call void (i32, i32, ptr, ptr, ...) @sys_xit(i32 noundef %45, i32 noundef %46, ptr noundef %5, ptr noundef %6)
  %47 = load i32, ptr %5, align 4
  %48 = load i32, ptr %6, align 4
  call void @free_mem(i32 noundef %47, i32 noundef %48)
  %49 = load i32, ptr %7, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 1, i32 noundef %49, i32 noundef 0, i32 noundef 0)
  ret void
}

declare i32 @set_alarm(...) #1

declare void @sys_xit(...) #1

declare void @free_mem(i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_wait() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store ptr @mproc, ptr %2, align 8
  br label %4

4:                                                ; preds = %56, %0
  %5 = load ptr, ptr %2, align 8
  %6 = icmp ult ptr %5, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %6, label %7, label %59

7:                                                ; preds = %4
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.mproc, ptr %8, i32 0, i32 13
  %10 = load i32, ptr %9, align 8
  %11 = and i32 %10, 1
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %55

13:                                               ; preds = %7
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds %struct.mproc, ptr %14, i32 0, i32 4
  %16 = load i32, ptr %15, align 4
  %17 = load i32, ptr @who, align 4
  %18 = icmp eq i32 %16, %17
  br i1 %18, label %19, label %55

19:                                               ; preds = %13
  %20 = load i32, ptr %3, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, ptr %3, align 4
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.mproc, ptr %22, i32 0, i32 13
  %24 = load i32, ptr %23, align 8
  %25 = and i32 %24, 4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %19
  %28 = load ptr, ptr %2, align 8
  call void @cleanup(ptr noundef %28)
  store i32 1, ptr @dont_reply, align 4
  store i32 0, ptr %1, align 4
  br label %68

29:                                               ; preds = %19
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 13
  %32 = load i32, ptr %31, align 8
  %33 = and i32 %32, 128
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %54

35:                                               ; preds = %29
  %36 = load ptr, ptr %2, align 8
  %37 = getelementptr inbounds %struct.mproc, ptr %36, i32 0, i32 2
  %38 = load i8, ptr %37, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %54

41:                                               ; preds = %35
  %42 = load i32, ptr @who, align 4
  %43 = load ptr, ptr %2, align 8
  %44 = getelementptr inbounds %struct.mproc, ptr %43, i32 0, i32 3
  %45 = load i32, ptr %44, align 8
  %46 = load ptr, ptr %2, align 8
  %47 = getelementptr inbounds %struct.mproc, ptr %46, i32 0, i32 2
  %48 = load i8, ptr %47, align 1
  %49 = sext i8 %48 to i32
  %50 = shl i32 %49, 8
  %51 = or i32 127, %50
  call void @reply(i32 noundef %42, i32 noundef %45, i32 noundef %51, ptr noundef null)
  store i32 1, ptr @dont_reply, align 4
  %52 = load ptr, ptr %2, align 8
  %53 = getelementptr inbounds %struct.mproc, ptr %52, i32 0, i32 2
  store i8 0, ptr %53, align 1
  store i32 0, ptr %1, align 4
  br label %68

54:                                               ; preds = %35, %29
  br label %55

55:                                               ; preds = %54, %13, %7
  br label %56

56:                                               ; preds = %55
  %57 = load ptr, ptr %2, align 8
  %58 = getelementptr inbounds %struct.mproc, ptr %57, i32 1
  store ptr %58, ptr %2, align 8
  br label %4

59:                                               ; preds = %4
  %60 = load i32, ptr %3, align 4
  %61 = icmp sgt i32 %60, 0
  br i1 %61, label %62, label %67

62:                                               ; preds = %59
  %63 = load ptr, ptr @mp, align 8
  %64 = getelementptr inbounds %struct.mproc, ptr %63, i32 0, i32 13
  %65 = load i32, ptr %64, align 8
  %66 = or i32 %65, 2
  store i32 %66, ptr %64, align 8
  store i32 1, ptr @dont_reply, align 4
  store i32 0, ptr %1, align 4
  br label %68

67:                                               ; preds = %59
  store i32 -10, ptr %1, align 4
  br label %68

68:                                               ; preds = %67, %62, %41, %27
  %69 = load i32, ptr %1, align 4
  ret i32 %69
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @cleanup(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %8 = load ptr, ptr %2, align 8
  %9 = ptrtoint ptr %8 to i64
  %10 = sub i64 %9, ptrtoint (ptr @mproc to i64)
  %11 = sdiv exact i64 %10, 80
  %12 = trunc i64 %11 to i32
  store i32 %12, ptr %6, align 4
  %13 = load ptr, ptr %2, align 8
  %14 = getelementptr inbounds %struct.mproc, ptr %13, i32 0, i32 4
  %15 = load i32, ptr %14, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %16
  store ptr %17, ptr %3, align 8
  %18 = load ptr, ptr %2, align 8
  %19 = getelementptr inbounds %struct.mproc, ptr %18, i32 0, i32 2
  %20 = load i8, ptr %19, align 1
  %21 = sext i8 %20 to i32
  %22 = and i32 %21, 255
  store i32 %22, ptr %7, align 4
  %23 = load i32, ptr %7, align 4
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.mproc, ptr %24, i32 0, i32 1
  %26 = load i8, ptr %25, align 4
  %27 = sext i8 %26 to i32
  %28 = shl i32 %27, 8
  %29 = or i32 %23, %28
  store i32 %29, ptr %7, align 4
  %30 = load ptr, ptr %2, align 8
  %31 = getelementptr inbounds %struct.mproc, ptr %30, i32 0, i32 4
  %32 = load i32, ptr %31, align 4
  %33 = load ptr, ptr %2, align 8
  %34 = getelementptr inbounds %struct.mproc, ptr %33, i32 0, i32 3
  %35 = load i32, ptr %34, align 8
  %36 = load i32, ptr %7, align 4
  call void @reply(i32 noundef %32, i32 noundef %35, i32 noundef %36, ptr noundef null)
  %37 = load ptr, ptr %2, align 8
  %38 = getelementptr inbounds %struct.mproc, ptr %37, i32 0, i32 13
  %39 = load i32, ptr %38, align 8
  %40 = and i32 %39, -65
  store i32 %40, ptr %38, align 8
  %41 = load ptr, ptr %2, align 8
  %42 = getelementptr inbounds %struct.mproc, ptr %41, i32 0, i32 13
  %43 = load i32, ptr %42, align 8
  %44 = and i32 %43, -5
  store i32 %44, ptr %42, align 8
  %45 = load ptr, ptr %2, align 8
  %46 = getelementptr inbounds %struct.mproc, ptr %45, i32 0, i32 13
  %47 = load i32, ptr %46, align 8
  %48 = and i32 %47, -9
  store i32 %48, ptr %46, align 8
  %49 = load ptr, ptr %3, align 8
  %50 = getelementptr inbounds %struct.mproc, ptr %49, i32 0, i32 13
  %51 = load i32, ptr %50, align 8
  %52 = and i32 %51, -3
  store i32 %52, ptr %50, align 8
  %53 = load ptr, ptr %2, align 8
  %54 = getelementptr inbounds %struct.mproc, ptr %53, i32 0, i32 13
  %55 = load i32, ptr %54, align 8
  %56 = and i32 %55, -2
  store i32 %56, ptr %54, align 8
  %57 = load i32, ptr @procs_in_use, align 4
  %58 = add nsw i32 %57, -1
  store i32 %58, ptr @procs_in_use, align 4
  %59 = load i32, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), i32 0, i32 13), align 8
  %60 = and i32 %59, 2
  %61 = icmp ne i32 %60, 0
  %62 = zext i1 %61 to i64
  %63 = select i1 %61, i32 1, i32 0
  store i32 %63, ptr %5, align 4
  store ptr @mproc, ptr %4, align 8
  br label %64

64:                                               ; preds = %88, %1
  %65 = load ptr, ptr %4, align 8
  %66 = icmp ult ptr %65, getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 32)
  br i1 %66, label %67, label %91

67:                                               ; preds = %64
  %68 = load ptr, ptr %4, align 8
  %69 = getelementptr inbounds %struct.mproc, ptr %68, i32 0, i32 4
  %70 = load i32, ptr %69, align 4
  %71 = load i32, ptr %6, align 4
  %72 = icmp eq i32 %70, %71
  br i1 %72, label %73, label %87

73:                                               ; preds = %67
  %74 = load ptr, ptr %4, align 8
  %75 = getelementptr inbounds %struct.mproc, ptr %74, i32 0, i32 4
  store i32 2, ptr %75, align 4
  %76 = load i32, ptr %5, align 4
  %77 = icmp ne i32 %76, 0
  br i1 %77, label %78, label %86

78:                                               ; preds = %73
  %79 = load ptr, ptr %4, align 8
  %80 = getelementptr inbounds %struct.mproc, ptr %79, i32 0, i32 13
  %81 = load i32, ptr %80, align 8
  %82 = and i32 %81, 4
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %86

84:                                               ; preds = %78
  %85 = load ptr, ptr %4, align 8
  call void @cleanup(ptr noundef %85)
  store i32 0, ptr %5, align 4
  br label %86

86:                                               ; preds = %84, %78, %73
  br label %87

87:                                               ; preds = %86, %67
  br label %88

88:                                               ; preds = %87
  %89 = load ptr, ptr %4, align 8
  %90 = getelementptr inbounds %struct.mproc, ptr %89, i32 1
  store ptr %90, ptr %4, align 8
  br label %64

91:                                               ; preds = %64
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
