; NOTE: Generated from src/mm/alloc.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/alloc.c'
source_filename = "src/mm/alloc.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.hole = type { i32, i32, ptr }

@hole_head = internal global ptr null, align 8
@free_slots = internal global ptr null, align 8
@.str = private unnamed_addr constant [16 x i8] c"Hole table full\00", align 1
@hole = internal global [128 x %struct.hole] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @alloc_mem(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %7 = load ptr, ptr @hole_head, align 8
  store ptr %7, ptr %4, align 8
  br label %8

8:                                                ; preds = %41, %1
  %9 = load ptr, ptr %4, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %11, label %46

11:                                               ; preds = %8
  %12 = load ptr, ptr %4, align 8
  %13 = getelementptr inbounds %struct.hole, ptr %12, i32 0, i32 1
  %14 = load i32, ptr %13, align 4
  %15 = load i32, ptr %3, align 4
  %16 = icmp uge i32 %14, %15
  br i1 %16, label %17, label %41

17:                                               ; preds = %11
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.hole, ptr %18, i32 0, i32 0
  %20 = load i32, ptr %19, align 8
  store i32 %20, ptr %6, align 4
  %21 = load i32, ptr %3, align 4
  %22 = load ptr, ptr %4, align 8
  %23 = getelementptr inbounds %struct.hole, ptr %22, i32 0, i32 0
  %24 = load i32, ptr %23, align 8
  %25 = add i32 %24, %21
  store i32 %25, ptr %23, align 8
  %26 = load i32, ptr %3, align 4
  %27 = load ptr, ptr %4, align 8
  %28 = getelementptr inbounds %struct.hole, ptr %27, i32 0, i32 1
  %29 = load i32, ptr %28, align 4
  %30 = sub i32 %29, %26
  store i32 %30, ptr %28, align 4
  %31 = load ptr, ptr %4, align 8
  %32 = getelementptr inbounds %struct.hole, ptr %31, i32 0, i32 1
  %33 = load i32, ptr %32, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %37

35:                                               ; preds = %17
  %36 = load i32, ptr %6, align 4
  store i32 %36, ptr %2, align 4
  br label %47

37:                                               ; preds = %17
  %38 = load ptr, ptr %5, align 8
  %39 = load ptr, ptr %4, align 8
  call void @del_slot(ptr noundef %38, ptr noundef %39)
  %40 = load i32, ptr %6, align 4
  store i32 %40, ptr %2, align 4
  br label %47

41:                                               ; preds = %11
  %42 = load ptr, ptr %4, align 8
  store ptr %42, ptr %5, align 8
  %43 = load ptr, ptr %4, align 8
  %44 = getelementptr inbounds %struct.hole, ptr %43, i32 0, i32 2
  %45 = load ptr, ptr %44, align 8
  store ptr %45, ptr %4, align 8
  br label %8, !llvm.loop !6

46:                                               ; preds = %8
  store i32 0, ptr %2, align 4
  br label %47

47:                                               ; preds = %46, %37, %35
  %48 = load i32, ptr %2, align 4
  ret i32 %48
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @del_slot(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %4, align 8
  %6 = load ptr, ptr @hole_head, align 8
  %7 = icmp eq ptr %5, %6
  br i1 %7, label %8, label %12

8:                                                ; preds = %2
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds %struct.hole, ptr %9, i32 0, i32 2
  %11 = load ptr, ptr %10, align 8
  store ptr %11, ptr @hole_head, align 8
  br label %18

12:                                               ; preds = %2
  %13 = load ptr, ptr %4, align 8
  %14 = getelementptr inbounds %struct.hole, ptr %13, i32 0, i32 2
  %15 = load ptr, ptr %14, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.hole, ptr %16, i32 0, i32 2
  store ptr %15, ptr %17, align 8
  br label %18

18:                                               ; preds = %12, %8
  %19 = load ptr, ptr @free_slots, align 8
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds %struct.hole, ptr %20, i32 0, i32 2
  store ptr %19, ptr %21, align 8
  %22 = load ptr, ptr %4, align 8
  store ptr %22, ptr @free_slots, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_mem(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %8 = load ptr, ptr @free_slots, align 8
  store ptr %8, ptr %6, align 8
  %9 = icmp eq ptr %8, null
  br i1 %9, label %10, label %11

10:                                               ; preds = %2
  call void @panic(ptr noundef @.str, i32 noundef 32768)
  br label %11

11:                                               ; preds = %10, %2
  %12 = load i32, ptr %3, align 4
  %13 = load ptr, ptr %6, align 8
  %14 = getelementptr inbounds %struct.hole, ptr %13, i32 0, i32 0
  store i32 %12, ptr %14, align 8
  %15 = load i32, ptr %4, align 4
  %16 = load ptr, ptr %6, align 8
  %17 = getelementptr inbounds %struct.hole, ptr %16, i32 0, i32 1
  store i32 %15, ptr %17, align 4
  %18 = load ptr, ptr %6, align 8
  %19 = getelementptr inbounds %struct.hole, ptr %18, i32 0, i32 2
  %20 = load ptr, ptr %19, align 8
  store ptr %20, ptr @free_slots, align 8
  %21 = load ptr, ptr @hole_head, align 8
  store ptr %21, ptr %5, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = icmp eq ptr %22, null
  br i1 %23, label %30, label %24

24:                                               ; preds = %11
  %25 = load i32, ptr %3, align 4
  %26 = load ptr, ptr %5, align 8
  %27 = getelementptr inbounds %struct.hole, ptr %26, i32 0, i32 0
  %28 = load i32, ptr %27, align 8
  %29 = icmp ule i32 %25, %28
  br i1 %29, label %30, label %36

30:                                               ; preds = %24, %11
  %31 = load ptr, ptr %5, align 8
  %32 = load ptr, ptr %6, align 8
  %33 = getelementptr inbounds %struct.hole, ptr %32, i32 0, i32 2
  store ptr %31, ptr %33, align 8
  %34 = load ptr, ptr %6, align 8
  store ptr %34, ptr @hole_head, align 8
  %35 = load ptr, ptr %6, align 8
  call void @merge(ptr noundef %35)
  br label %63

36:                                               ; preds = %24
  br label %37

37:                                               ; preds = %48, %36
  %38 = load ptr, ptr %5, align 8
  %39 = icmp ne ptr %38, null
  br i1 %39, label %40, label %46

40:                                               ; preds = %37
  %41 = load i32, ptr %3, align 4
  %42 = load ptr, ptr %5, align 8
  %43 = getelementptr inbounds %struct.hole, ptr %42, i32 0, i32 0
  %44 = load i32, ptr %43, align 8
  %45 = icmp ugt i32 %41, %44
  br label %46

46:                                               ; preds = %40, %37
  %47 = phi i1 [ false, %37 ], [ %45, %40 ]
  br i1 %47, label %48, label %53

48:                                               ; preds = %46
  %49 = load ptr, ptr %5, align 8
  store ptr %49, ptr %7, align 8
  %50 = load ptr, ptr %5, align 8
  %51 = getelementptr inbounds %struct.hole, ptr %50, i32 0, i32 2
  %52 = load ptr, ptr %51, align 8
  store ptr %52, ptr %5, align 8
  br label %37, !llvm.loop !8

53:                                               ; preds = %46
  %54 = load ptr, ptr %7, align 8
  %55 = getelementptr inbounds %struct.hole, ptr %54, i32 0, i32 2
  %56 = load ptr, ptr %55, align 8
  %57 = load ptr, ptr %6, align 8
  %58 = getelementptr inbounds %struct.hole, ptr %57, i32 0, i32 2
  store ptr %56, ptr %58, align 8
  %59 = load ptr, ptr %6, align 8
  %60 = load ptr, ptr %7, align 8
  %61 = getelementptr inbounds %struct.hole, ptr %60, i32 0, i32 2
  store ptr %59, ptr %61, align 8
  %62 = load ptr, ptr %7, align 8
  call void @merge(ptr noundef %62)
  br label %63

63:                                               ; preds = %53, %30
  ret void
}

declare void @panic(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @merge(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.hole, ptr %4, i32 0, i32 2
  %6 = load ptr, ptr %5, align 8
  store ptr %6, ptr %3, align 8
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  br label %61

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.hole, ptr %10, i32 0, i32 0
  %12 = load i32, ptr %11, align 8
  %13 = load ptr, ptr %2, align 8
  %14 = getelementptr inbounds %struct.hole, ptr %13, i32 0, i32 1
  %15 = load i32, ptr %14, align 4
  %16 = add i32 %12, %15
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.hole, ptr %17, i32 0, i32 0
  %19 = load i32, ptr %18, align 8
  %20 = icmp eq i32 %16, %19
  br i1 %20, label %21, label %31

21:                                               ; preds = %9
  %22 = load ptr, ptr %3, align 8
  %23 = getelementptr inbounds %struct.hole, ptr %22, i32 0, i32 1
  %24 = load i32, ptr %23, align 4
  %25 = load ptr, ptr %2, align 8
  %26 = getelementptr inbounds %struct.hole, ptr %25, i32 0, i32 1
  %27 = load i32, ptr %26, align 4
  %28 = add i32 %27, %24
  store i32 %28, ptr %26, align 4
  %29 = load ptr, ptr %2, align 8
  %30 = load ptr, ptr %3, align 8
  call void @del_slot(ptr noundef %29, ptr noundef %30)
  br label %33

31:                                               ; preds = %9
  %32 = load ptr, ptr %3, align 8
  store ptr %32, ptr %2, align 8
  br label %33

33:                                               ; preds = %31, %21
  %34 = load ptr, ptr %2, align 8
  %35 = getelementptr inbounds %struct.hole, ptr %34, i32 0, i32 2
  %36 = load ptr, ptr %35, align 8
  store ptr %36, ptr %3, align 8
  %37 = icmp eq ptr %36, null
  br i1 %37, label %38, label %39

38:                                               ; preds = %33
  br label %61

39:                                               ; preds = %33
  %40 = load ptr, ptr %2, align 8
  %41 = getelementptr inbounds %struct.hole, ptr %40, i32 0, i32 0
  %42 = load i32, ptr %41, align 8
  %43 = load ptr, ptr %2, align 8
  %44 = getelementptr inbounds %struct.hole, ptr %43, i32 0, i32 1
  %45 = load i32, ptr %44, align 4
  %46 = add i32 %42, %45
  %47 = load ptr, ptr %3, align 8
  %48 = getelementptr inbounds %struct.hole, ptr %47, i32 0, i32 0
  %49 = load i32, ptr %48, align 8
  %50 = icmp eq i32 %46, %49
  br i1 %50, label %51, label %61

51:                                               ; preds = %39
  %52 = load ptr, ptr %3, align 8
  %53 = getelementptr inbounds %struct.hole, ptr %52, i32 0, i32 1
  %54 = load i32, ptr %53, align 4
  %55 = load ptr, ptr %2, align 8
  %56 = getelementptr inbounds %struct.hole, ptr %55, i32 0, i32 1
  %57 = load i32, ptr %56, align 4
  %58 = add i32 %57, %54
  store i32 %58, ptr %56, align 4
  %59 = load ptr, ptr %2, align 8
  %60 = load ptr, ptr %3, align 8
  call void @del_slot(ptr noundef %59, ptr noundef %60)
  br label %61

61:                                               ; preds = %8, %38, %51, %39
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @max_hole() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = load ptr, ptr @hole_head, align 8
  store ptr %3, ptr %1, align 8
  store i32 0, ptr %2, align 4
  br label %4

4:                                                ; preds = %17, %0
  %5 = load ptr, ptr %1, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %21

7:                                                ; preds = %4
  %8 = load ptr, ptr %1, align 8
  %9 = getelementptr inbounds %struct.hole, ptr %8, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  %11 = load i32, ptr %2, align 4
  %12 = icmp ugt i32 %10, %11
  br i1 %12, label %13, label %17

13:                                               ; preds = %7
  %14 = load ptr, ptr %1, align 8
  %15 = getelementptr inbounds %struct.hole, ptr %14, i32 0, i32 1
  %16 = load i32, ptr %15, align 4
  store i32 %16, ptr %2, align 4
  br label %17

17:                                               ; preds = %13, %7
  %18 = load ptr, ptr %1, align 8
  %19 = getelementptr inbounds %struct.hole, ptr %18, i32 0, i32 2
  %20 = load ptr, ptr %19, align 8
  store ptr %20, ptr %1, align 8
  br label %4, !llvm.loop !9

21:                                               ; preds = %4
  %22 = load i32, ptr %2, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @mem_init() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store ptr @hole, ptr %1, align 8
  br label %4

4:                                                ; preds = %12, %0
  %5 = load ptr, ptr %1, align 8
  %6 = icmp ult ptr %5, getelementptr inbounds ([128 x %struct.hole], ptr @hole, i64 0, i64 128)
  br i1 %6, label %7, label %15

7:                                                ; preds = %4
  %8 = load ptr, ptr %1, align 8
  %9 = getelementptr inbounds %struct.hole, ptr %8, i64 1
  %10 = load ptr, ptr %1, align 8
  %11 = getelementptr inbounds %struct.hole, ptr %10, i32 0, i32 2
  store ptr %9, ptr %11, align 8
  br label %12

12:                                               ; preds = %7
  %13 = load ptr, ptr %1, align 8
  %14 = getelementptr inbounds %struct.hole, ptr %13, i32 1
  store ptr %14, ptr %1, align 8
  br label %4, !llvm.loop !10

15:                                               ; preds = %4
  store ptr null, ptr getelementptr inbounds (%struct.hole, ptr getelementptr inbounds ([128 x %struct.hole], ptr @hole, i64 0, i64 127), i32 0, i32 2), align 8
  store ptr null, ptr @hole_head, align 8
  store ptr @hole, ptr @free_slots, align 8
  br label %16

16:                                               ; preds = %19, %15
  %17 = call i32 @get_mem(ptr noundef %2, i32 noundef 0)
  store i32 %17, ptr %3, align 4
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %22

19:                                               ; preds = %16
  %20 = load i32, ptr %2, align 4
  %21 = load i32, ptr %3, align 4
  call void @free_mem(i32 noundef %20, i32 noundef %21)
  br label %16, !llvm.loop !11

22:                                               ; preds = %16
  ret void
}

declare i32 @get_mem(ptr noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @mem_left() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca i32, align 4
  %3 = load ptr, ptr @hole_head, align 8
  store ptr %3, ptr %1, align 8
  store i32 0, ptr %2, align 4
  br label %4

4:                                                ; preds = %13, %0
  %5 = load ptr, ptr %1, align 8
  %6 = icmp ne ptr %5, null
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  %8 = load ptr, ptr %1, align 8
  %9 = getelementptr inbounds %struct.hole, ptr %8, i32 0, i32 1
  %10 = load i32, ptr %9, align 4
  %11 = load i32, ptr %2, align 4
  %12 = add i32 %11, %10
  store i32 %12, ptr %2, align 4
  br label %13

13:                                               ; preds = %7
  %14 = load ptr, ptr %1, align 8
  %15 = getelementptr inbounds %struct.hole, ptr %14, i32 0, i32 2
  %16 = load ptr, ptr %15, align 8
  store ptr %16, ptr %1, align 8
  br label %4, !llvm.loop !12

17:                                               ; preds = %4
  %18 = load i32, ptr %2, align 4
  ret i32 %18
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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
