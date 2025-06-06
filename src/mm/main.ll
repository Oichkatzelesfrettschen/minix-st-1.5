; NOTE: Generated from src/mm/main.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/main.c'
source_filename = "src/mm/main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }
%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mess_2 = type { i32, i32, i32, i64, i64, ptr }

@mproc = external global [32 x %struct.mproc], align 16
@who = external global i32, align 4
@mp = external global ptr, align 8
@dont_reply = external global i32, align 4
@err_code = external global i32, align 4
@mm_call = external global i32, align 4
@call_vec = external global [0 x ptr], align 8
@result2 = external global i32, align 4
@res_ptr = external global ptr, align 8
@mm_out = external global %struct.message, align 8
@.str = private unnamed_addr constant [15 x i8] c"MM can't reply\00", align 1
@mm_in = external global %struct.message, align 8
@.str.1 = private unnamed_addr constant [32 x i8] c"inconsistent system memory base\00", align 1
@.str.2 = private unnamed_addr constant [31 x i8] c"not enough memory for RAM disk\00", align 1
@.str.3 = private unnamed_addr constant [24 x i8] c"Memory size = %4dK     \00", align 1
@.str.4 = private unnamed_addr constant [18 x i8] c"MINIX = %3dK     \00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"RAM disk = %4dK     \00", align 1
@.str.6 = private unnamed_addr constant [18 x i8] c"Available = %dK\0A\0A\00", align 1
@.str.7 = private unnamed_addr constant [34 x i8] c"\0ANot enough memory to run MINIX\0A\0A\00", align 1
@.str.8 = private unnamed_addr constant [33 x i8] c"Kernel didn't respond to get_mem\00", align 1
@.str.9 = private unnamed_addr constant [17 x i8] c"MM receive error\00", align 1
@procs_in_use = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @mm_init()
  br label %3

3:                                                ; preds = %0, %22, %29, %30
  call void @get_work()
  %4 = load i32, ptr @who, align 4
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %5
  store ptr %6, ptr @mp, align 8
  store i32 0, ptr %2, align 4
  store i32 0, ptr @dont_reply, align 4
  store i32 -999, ptr @err_code, align 4
  %7 = load i32, ptr @mm_call, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %12, label %9

9:                                                ; preds = %3
  %10 = load i32, ptr @mm_call, align 4
  %11 = icmp sge i32 %10, 70
  br i1 %11, label %12, label %13

12:                                               ; preds = %9, %3
  store i32 -102, ptr %2, align 4
  br label %19

13:                                               ; preds = %9
  %14 = load i32, ptr @mm_call, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [0 x ptr], ptr @call_vec, i64 0, i64 %15
  %17 = load ptr, ptr %16, align 8
  %18 = call i32 (...) %17()
  store i32 %18, ptr %2, align 4
  br label %19

19:                                               ; preds = %13, %12
  %20 = load i32, ptr @dont_reply, align 4
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %23

22:                                               ; preds = %19
  br label %3

23:                                               ; preds = %19
  %24 = load i32, ptr @mm_call, align 4
  %25 = icmp eq i32 %24, 59
  br i1 %25, label %26, label %30

26:                                               ; preds = %23
  %27 = load i32, ptr %2, align 4
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %26
  br label %3

30:                                               ; preds = %26, %23
  %31 = load i32, ptr @who, align 4
  %32 = load i32, ptr %2, align 4
  %33 = load i32, ptr @result2, align 4
  %34 = load ptr, ptr @res_ptr, align 8
  call void @reply(i32 noundef %31, i32 noundef %32, i32 noundef %33, ptr noundef %34)
  br label %3
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @mm_init() #0 {
  call void (...) @mem_init()
  %1 = load i32, ptr getelementptr inbounds (%struct.mproc, ptr @mproc, i32 0, i32 13), align 8
  %2 = or i32 %1, 1
  store i32 %2, ptr getelementptr inbounds (%struct.mproc, ptr @mproc, i32 0, i32 13), align 8
  %3 = load i32, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 1), i32 0, i32 13), align 8
  %4 = or i32 %3, 1
  store i32 %4, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 1), i32 0, i32 13), align 8
  %5 = load i32, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), i32 0, i32 13), align 8
  %6 = or i32 %5, 1
  store i32 %6, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), i32 0, i32 13), align 8
  store i32 1, ptr getelementptr inbounds (%struct.mproc, ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), i32 0, i32 3), align 8
  store i32 3, ptr @procs_in_use, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @get_work() #0 {
  %1 = call i32 @receive(i32 noundef 132, ptr noundef @mm_in)
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %0
  call void @panic(ptr noundef @.str.9, i32 noundef 32768)
  br label %4

4:                                                ; preds = %3, %0
  %5 = load i32, ptr @mm_in, align 8
  store i32 %5, ptr @who, align 4
  %6 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 1), align 4
  store i32 %6, ptr @mm_call, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reply(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %10 = load i32, ptr %5, align 4
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %11
  store ptr %12, ptr %9, align 8
  %13 = load ptr, ptr %9, align 8
  %14 = getelementptr inbounds %struct.mproc, ptr %13, i32 0, i32 13
  %15 = load i32, ptr %14, align 8
  %16 = and i32 %15, 1
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %24, label %18

18:                                               ; preds = %4
  %19 = load ptr, ptr %9, align 8
  %20 = getelementptr inbounds %struct.mproc, ptr %19, i32 0, i32 13
  %21 = load i32, ptr %20, align 8
  %22 = and i32 %21, 4
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %25

24:                                               ; preds = %18, %4
  br label %33

25:                                               ; preds = %18
  %26 = load i32, ptr %6, align 4
  store i32 %26, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 1), align 4
  %27 = load i32, ptr %7, align 4
  store i32 %27, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), align 8
  %28 = load ptr, ptr %8, align 8
  store ptr %28, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 5), align 8
  %29 = load i32, ptr %5, align 4
  %30 = call i32 @send(i32 noundef %29, ptr noundef @mm_out)
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %32, label %33

32:                                               ; preds = %25
  call void @panic(ptr noundef @.str, i32 noundef 32768)
  br label %33

33:                                               ; preds = %24, %32, %25
  ret void
}

declare i32 @send(i32 noundef, ptr noundef) #1

declare void @panic(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_brk2() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = load i32, ptr @who, align 4
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

16:                                               ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %151

17:                                               ; preds = %0
  %18 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  store i32 %18, ptr %11, align 4
  %19 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  store i32 %19, ptr %12, align 4
  %20 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 3), align 8
  %21 = ptrtoint ptr %20 to i64
  %22 = trunc i64 %21 to i32
  store i32 %22, ptr %6, align 4
  %23 = load i32, ptr %11, align 4
  %24 = load i32, ptr %12, align 4
  %25 = add i32 %23, %24
  store i32 %25, ptr %7, align 4
  %26 = load i32, ptr %6, align 4
  %27 = load i32, ptr %7, align 4
  %28 = add i32 %26, %27
  store i32 %28, ptr %13, align 4
  %29 = load i32, ptr %13, align 4
  %30 = call i32 @alloc_mem(i32 noundef %29)
  store i32 %30, ptr %8, align 4
  %31 = load i32, ptr %8, align 4
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %35

33:                                               ; preds = %17
  %34 = load i32, ptr %8, align 4
  call void @panic(ptr noundef @.str.1, i32 noundef %34)
  br label %35

35:                                               ; preds = %33, %17
  %36 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 2), align 8
  store i32 %36, ptr %10, align 4
  %37 = load i32, ptr %10, align 4
  %38 = load i32, ptr %13, align 4
  %39 = sub i32 %37, %38
  store i32 %39, ptr %9, align 4
  %40 = load i32, ptr %9, align 4
  %41 = call i32 @alloc_mem(i32 noundef %40)
  store i32 %41, ptr %8, align 4
  %42 = load i32, ptr %8, align 4
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %45

44:                                               ; preds = %35
  call void @panic(ptr noundef @.str.2, i32 noundef 32768)
  br label %45

45:                                               ; preds = %44, %35
  %46 = load i32, ptr %8, align 4
  %47 = zext i32 %46 to i64
  %48 = mul nsw i64 %47, 256
  store i64 %48, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 3), align 8
  %49 = load i32, ptr %13, align 4
  %50 = load i32, ptr %9, align 4
  %51 = add i32 %49, %50
  %52 = call i32 (...) @mem_left()
  %53 = add i32 %51, %52
  %54 = zext i32 %53 to i64
  %55 = shl i64 %54, 8
  %56 = add i64 %55, 512
  %57 = udiv i64 %56, 1024
  %58 = trunc i64 %57 to i32
  store i32 %58, ptr %2, align 4
  %59 = load i32, ptr %13, align 4
  %60 = zext i32 %59 to i64
  %61 = shl i64 %60, 8
  %62 = add i64 %61, 512
  %63 = udiv i64 %62, 1024
  %64 = trunc i64 %63 to i32
  store i32 %64, ptr %3, align 4
  %65 = load i32, ptr %9, align 4
  %66 = zext i32 %65 to i64
  %67 = shl i64 %66, 8
  %68 = add i64 %67, 512
  %69 = udiv i64 %68, 1024
  %70 = trunc i64 %69 to i32
  store i32 %70, ptr %4, align 4
  %71 = load i32, ptr %2, align 4
  call void (ptr, ...) @printk(ptr noundef @.str.3, i32 noundef %71)
  %72 = load i32, ptr %3, align 4
  call void (ptr, ...) @printk(ptr noundef @.str.4, i32 noundef %72)
  %73 = load i32, ptr %4, align 4
  call void (ptr, ...) @printk(ptr noundef @.str.5, i32 noundef %73)
  %74 = load i32, ptr %2, align 4
  %75 = load i32, ptr %3, align 4
  %76 = sub nsw i32 %74, %75
  %77 = load i32, ptr %4, align 4
  %78 = sub nsw i32 %76, %77
  call void (ptr, ...) @printk(ptr noundef @.str.6, i32 noundef %78)
  %79 = load i32, ptr %2, align 4
  %80 = load i32, ptr %3, align 4
  %81 = sub nsw i32 %79, %80
  %82 = load i32, ptr %4, align 4
  %83 = sub nsw i32 %81, %82
  %84 = icmp slt i32 %83, 32
  br i1 %84, label %85, label %86

85:                                               ; preds = %45
  call void (ptr, ...) @printk(ptr noundef @.str.7, i32 noundef 32768)
  call void (...) @sys_abort()
  br label %86

86:                                               ; preds = %85, %45
  store ptr getelementptr inbounds ([32 x %struct.mproc], ptr @mproc, i64 0, i64 2), ptr %5, align 8
  %87 = load i32, ptr %6, align 4
  %88 = load ptr, ptr %5, align 8
  %89 = getelementptr inbounds %struct.mproc, ptr %88, i32 0, i32 0
  %90 = getelementptr inbounds [3 x %struct.mem_map], ptr %89, i64 0, i64 0
  %91 = getelementptr inbounds %struct.mem_map, ptr %90, i32 0, i32 1
  store i32 %87, ptr %91, align 4
  %92 = load i32, ptr %11, align 4
  %93 = load ptr, ptr %5, align 8
  %94 = getelementptr inbounds %struct.mproc, ptr %93, i32 0, i32 0
  %95 = getelementptr inbounds [3 x %struct.mem_map], ptr %94, i64 0, i64 0
  %96 = getelementptr inbounds %struct.mem_map, ptr %95, i32 0, i32 2
  store i32 %92, ptr %96, align 8
  %97 = load i32, ptr %6, align 4
  %98 = load i32, ptr %11, align 4
  %99 = add i32 %97, %98
  %100 = load ptr, ptr %5, align 8
  %101 = getelementptr inbounds %struct.mproc, ptr %100, i32 0, i32 0
  %102 = getelementptr inbounds [3 x %struct.mem_map], ptr %101, i64 0, i64 1
  %103 = getelementptr inbounds %struct.mem_map, ptr %102, i32 0, i32 1
  store i32 %99, ptr %103, align 4
  %104 = load i32, ptr %12, align 4
  %105 = load ptr, ptr %5, align 8
  %106 = getelementptr inbounds %struct.mproc, ptr %105, i32 0, i32 0
  %107 = getelementptr inbounds [3 x %struct.mem_map], ptr %106, i64 0, i64 1
  %108 = getelementptr inbounds %struct.mem_map, ptr %107, i32 0, i32 2
  store i32 %104, ptr %108, align 4
  %109 = load i32, ptr %6, align 4
  %110 = load i32, ptr %7, align 4
  %111 = add i32 %109, %110
  %112 = load ptr, ptr %5, align 8
  %113 = getelementptr inbounds %struct.mproc, ptr %112, i32 0, i32 0
  %114 = getelementptr inbounds [3 x %struct.mem_map], ptr %113, i64 0, i64 2
  %115 = getelementptr inbounds %struct.mem_map, ptr %114, i32 0, i32 1
  store i32 %111, ptr %115, align 4
  %116 = load ptr, ptr %5, align 8
  %117 = getelementptr inbounds %struct.mproc, ptr %116, i32 0, i32 0
  %118 = getelementptr inbounds [3 x %struct.mem_map], ptr %117, i64 0, i64 0
  %119 = getelementptr inbounds %struct.mem_map, ptr %118, i32 0, i32 1
  %120 = load i32, ptr %119, align 4
  %121 = load ptr, ptr %5, align 8
  %122 = getelementptr inbounds %struct.mproc, ptr %121, i32 0, i32 0
  %123 = getelementptr inbounds [3 x %struct.mem_map], ptr %122, i64 0, i64 0
  %124 = getelementptr inbounds %struct.mem_map, ptr %123, i32 0, i32 0
  store i32 %120, ptr %124, align 8
  %125 = load ptr, ptr %5, align 8
  %126 = getelementptr inbounds %struct.mproc, ptr %125, i32 0, i32 0
  %127 = getelementptr inbounds [3 x %struct.mem_map], ptr %126, i64 0, i64 1
  %128 = getelementptr inbounds %struct.mem_map, ptr %127, i32 0, i32 1
  %129 = load i32, ptr %128, align 4
  %130 = load ptr, ptr %5, align 8
  %131 = getelementptr inbounds %struct.mproc, ptr %130, i32 0, i32 0
  %132 = getelementptr inbounds [3 x %struct.mem_map], ptr %131, i64 0, i64 1
  %133 = getelementptr inbounds %struct.mem_map, ptr %132, i32 0, i32 0
  store i32 %129, ptr %133, align 4
  %134 = load ptr, ptr %5, align 8
  %135 = getelementptr inbounds %struct.mproc, ptr %134, i32 0, i32 0
  %136 = getelementptr inbounds [3 x %struct.mem_map], ptr %135, i64 0, i64 2
  %137 = getelementptr inbounds %struct.mem_map, ptr %136, i32 0, i32 1
  %138 = load i32, ptr %137, align 4
  %139 = load ptr, ptr %5, align 8
  %140 = getelementptr inbounds %struct.mproc, ptr %139, i32 0, i32 0
  %141 = getelementptr inbounds [3 x %struct.mem_map], ptr %140, i64 0, i64 2
  %142 = getelementptr inbounds %struct.mem_map, ptr %141, i32 0, i32 0
  store i32 %138, ptr %142, align 8
  %143 = load i32, ptr %11, align 4
  %144 = icmp ne i32 %143, 0
  br i1 %144, label %145, label %150

145:                                              ; preds = %86
  %146 = load ptr, ptr %5, align 8
  %147 = getelementptr inbounds %struct.mproc, ptr %146, i32 0, i32 13
  %148 = load i32, ptr %147, align 8
  %149 = or i32 %148, 32
  store i32 %149, ptr %147, align 8
  br label %150

150:                                              ; preds = %145, %86
  store i32 0, ptr %1, align 4
  br label %151

151:                                              ; preds = %150, %16
  %152 = load i32, ptr %1, align 4
  ret i32 %152
}

declare i32 @alloc_mem(i32 noundef) #1

declare i32 @mem_left(...) #1

declare void @printk(ptr noundef, ...) #1

declare void @sys_abort(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @get_mem(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 14, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 1), align 4
  %5 = load i32, ptr %4, align 4
  store i32 %5, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), align 8
  %6 = call i32 @sendrec(i32 noundef -2, ptr noundef @mm_out)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %11, label %8

8:                                                ; preds = %2
  %9 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 1), align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %8, %2
  call void @panic(ptr noundef @.str.8, i32 noundef 32768)
  br label %12

12:                                               ; preds = %11, %8
  %13 = load i64, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 3), align 8
  %14 = trunc i64 %13 to i32
  %15 = load ptr, ptr %3, align 8
  store i32 %14, ptr %15, align 4
  %16 = load i32, ptr getelementptr inbounds (%struct.mess_2, ptr getelementptr inbounds (%struct.message, ptr @mm_out, i32 0, i32 2), i32 0, i32 2), align 8
  ret i32 %16
}

declare i32 @sendrec(i32 noundef, ptr noundef) #1

declare i32 @receive(i32 noundef, ptr noundef) #1

declare void @mem_init(...) #1

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
