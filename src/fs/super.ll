; NOTE: Generated from src/fs/super.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/super.c'
source_filename = "src/fs/super.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.buf = type { %union.anon, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }

@bufs_in_use = external global i32, align 4
@.str = private unnamed_addr constant [20 x i8] c"too many map blocks\00", align 1
@.str.1 = private unnamed_addr constant [45 x i8] c"FS freeing unused block of inode.  bit = %d\0A\00", align 1
@super_block = external global [5 x %struct.super_block], align 16
@.str.2 = private unnamed_addr constant [46 x i8] c"can't find superblock for device (in decimal)\00", align 1
@boot_parameters = external global %struct.bparam_s, align 2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @load_bit_maps(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i16, align 2
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = trunc i32 %0 to i16
  store i16 %7, ptr %3, align 2
  %8 = load i16, ptr %3, align 2
  %9 = zext i16 %8 to i32
  %10 = call ptr @get_super(i32 noundef %9)
  store ptr %10, ptr %5, align 8
  %11 = load i32, ptr @bufs_in_use, align 4
  %12 = load ptr, ptr %5, align 8
  %13 = getelementptr inbounds %struct.super_block, ptr %12, i32 0, i32 2
  %14 = load i16, ptr %13, align 4
  %15 = zext i16 %14 to i32
  %16 = add nsw i32 %11, %15
  %17 = load ptr, ptr %5, align 8
  %18 = getelementptr inbounds %struct.super_block, ptr %17, i32 0, i32 3
  %19 = load i16, ptr %18, align 2
  %20 = zext i16 %19 to i32
  %21 = add nsw i32 %16, %20
  %22 = icmp sge i32 %21, 27
  br i1 %22, label %23, label %24

23:                                               ; preds = %1
  store i32 -99, ptr %2, align 4
  br label %106

24:                                               ; preds = %1
  %25 = load ptr, ptr %5, align 8
  %26 = getelementptr inbounds %struct.super_block, ptr %25, i32 0, i32 2
  %27 = load i16, ptr %26, align 4
  %28 = zext i16 %27 to i32
  %29 = icmp sgt i32 %28, 8
  br i1 %29, label %36, label %30

30:                                               ; preds = %24
  %31 = load ptr, ptr %5, align 8
  %32 = getelementptr inbounds %struct.super_block, ptr %31, i32 0, i32 3
  %33 = load i16, ptr %32, align 2
  %34 = zext i16 %33 to i32
  %35 = icmp sgt i32 %34, 8
  br i1 %35, label %36, label %37

36:                                               ; preds = %30, %24
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef 32768)
  br label %37

37:                                               ; preds = %36, %30
  store i32 0, ptr %4, align 4
  br label %38

38:                                               ; preds = %56, %37
  %39 = load i32, ptr %4, align 4
  %40 = load ptr, ptr %5, align 8
  %41 = getelementptr inbounds %struct.super_block, ptr %40, i32 0, i32 2
  %42 = load i16, ptr %41, align 4
  %43 = zext i16 %42 to i32
  %44 = icmp slt i32 %39, %43
  br i1 %44, label %45, label %59

45:                                               ; preds = %38
  %46 = load i16, ptr %3, align 2
  %47 = zext i16 %46 to i32
  %48 = load i32, ptr %4, align 4
  %49 = add nsw i32 2, %48
  %50 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %47, i32 noundef %49, i32 noundef 0)
  %51 = load ptr, ptr %5, align 8
  %52 = getelementptr inbounds %struct.super_block, ptr %51, i32 0, i32 8
  %53 = load i32, ptr %4, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [8 x ptr], ptr %52, i64 0, i64 %54
  store ptr %50, ptr %55, align 8
  br label %56

56:                                               ; preds = %45
  %57 = load i32, ptr %4, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %4, align 4
  br label %38

59:                                               ; preds = %38
  %60 = load ptr, ptr %5, align 8
  %61 = getelementptr inbounds %struct.super_block, ptr %60, i32 0, i32 2
  %62 = load i16, ptr %61, align 4
  %63 = zext i16 %62 to i32
  %64 = add nsw i32 2, %63
  %65 = trunc i32 %64 to i16
  store i16 %65, ptr %6, align 2
  store i32 0, ptr %4, align 4
  br label %66

66:                                               ; preds = %86, %59
  %67 = load i32, ptr %4, align 4
  %68 = load ptr, ptr %5, align 8
  %69 = getelementptr inbounds %struct.super_block, ptr %68, i32 0, i32 3
  %70 = load i16, ptr %69, align 2
  %71 = zext i16 %70 to i32
  %72 = icmp slt i32 %67, %71
  br i1 %72, label %73, label %89

73:                                               ; preds = %66
  %74 = load i16, ptr %3, align 2
  %75 = zext i16 %74 to i32
  %76 = load i16, ptr %6, align 2
  %77 = zext i16 %76 to i32
  %78 = load i32, ptr %4, align 4
  %79 = add nsw i32 %77, %78
  %80 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %75, i32 noundef %79, i32 noundef 0)
  %81 = load ptr, ptr %5, align 8
  %82 = getelementptr inbounds %struct.super_block, ptr %81, i32 0, i32 9
  %83 = load i32, ptr %4, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds [8 x ptr], ptr %82, i64 0, i64 %84
  store ptr %80, ptr %85, align 8
  br label %86

86:                                               ; preds = %73
  %87 = load i32, ptr %4, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, ptr %4, align 4
  br label %66

89:                                               ; preds = %66
  %90 = load ptr, ptr %5, align 8
  %91 = getelementptr inbounds %struct.super_block, ptr %90, i32 0, i32 8
  %92 = getelementptr inbounds [8 x ptr], ptr %91, i64 0, i64 0
  %93 = load ptr, ptr %92, align 8
  %94 = getelementptr inbounds %struct.buf, ptr %93, i32 0, i32 0
  %95 = getelementptr inbounds [256 x i32], ptr %94, i64 0, i64 0
  %96 = load i32, ptr %95, align 8
  %97 = or i32 %96, 3
  store i32 %97, ptr %95, align 8
  %98 = load ptr, ptr %5, align 8
  %99 = getelementptr inbounds %struct.super_block, ptr %98, i32 0, i32 9
  %100 = getelementptr inbounds [8 x ptr], ptr %99, i64 0, i64 0
  %101 = load ptr, ptr %100, align 8
  %102 = getelementptr inbounds %struct.buf, ptr %101, i32 0, i32 0
  %103 = getelementptr inbounds [256 x i32], ptr %102, i64 0, i64 0
  %104 = load i32, ptr %103, align 8
  %105 = or i32 %104, 1
  store i32 %105, ptr %103, align 8
  store i32 0, ptr %2, align 4
  br label %106

106:                                              ; preds = %89, %23
  %107 = load i32, ptr %2, align 4
  ret i32 %107
}

declare void @panic(...) #1

declare ptr @get_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @unload_bit_maps(i32 noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = trunc i32 %0 to i16
  store i16 %5, ptr %2, align 2
  %6 = load i16, ptr %2, align 2
  %7 = zext i16 %6 to i32
  %8 = call ptr @get_super(i32 noundef %7)
  store ptr %8, ptr %4, align 8
  store i32 0, ptr %3, align 4
  br label %9

9:                                                ; preds = %23, %1
  %10 = load i32, ptr %3, align 4
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.super_block, ptr %11, i32 0, i32 2
  %13 = load i16, ptr %12, align 4
  %14 = zext i16 %13 to i32
  %15 = icmp slt i32 %10, %14
  br i1 %15, label %16, label %26

16:                                               ; preds = %9
  %17 = load ptr, ptr %4, align 8
  %18 = getelementptr inbounds %struct.super_block, ptr %17, i32 0, i32 8
  %19 = load i32, ptr %3, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [8 x ptr], ptr %18, i64 0, i64 %20
  %22 = load ptr, ptr %21, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %22, i32 noundef 195)
  br label %23

23:                                               ; preds = %16
  %24 = load i32, ptr %3, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, ptr %3, align 4
  br label %9

26:                                               ; preds = %9
  store i32 0, ptr %3, align 4
  br label %27

27:                                               ; preds = %41, %26
  %28 = load i32, ptr %3, align 4
  %29 = load ptr, ptr %4, align 8
  %30 = getelementptr inbounds %struct.super_block, ptr %29, i32 0, i32 3
  %31 = load i16, ptr %30, align 2
  %32 = zext i16 %31 to i32
  %33 = icmp slt i32 %28, %32
  br i1 %33, label %34, label %44

34:                                               ; preds = %27
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.super_block, ptr %35, i32 0, i32 9
  %37 = load i32, ptr %3, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [8 x ptr], ptr %36, i64 0, i64 %38
  %40 = load ptr, ptr %39, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %40, i32 noundef 196)
  br label %41

41:                                               ; preds = %34
  %42 = load i32, ptr %3, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %3, align 4
  br label %27

44:                                               ; preds = %27
  ret i32 0
}

declare void @put_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @alloc_bit(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca ptr, align 8
  %20 = trunc i32 %1 to i16
  %21 = trunc i32 %2 to i16
  %22 = trunc i32 %3 to i16
  store ptr %0, ptr %6, align 8
  store i16 %20, ptr %7, align 2
  store i16 %21, ptr %8, align 2
  store i16 %22, ptr %9, align 2
  %23 = load i16, ptr %9, align 2
  %24 = zext i16 %23 to i32
  %25 = load i16, ptr %7, align 2
  %26 = zext i16 %25 to i32
  %27 = icmp sge i32 %24, %26
  br i1 %27, label %28, label %29

28:                                               ; preds = %4
  store i16 0, ptr %9, align 2
  br label %29

29:                                               ; preds = %28, %4
  %30 = load i16, ptr %9, align 2
  %31 = zext i16 %30 to i32
  %32 = ashr i32 %31, 13
  store i32 %32, ptr %15, align 4
  %33 = load i16, ptr %9, align 2
  %34 = zext i16 %33 to i32
  %35 = load i32, ptr %15, align 4
  %36 = shl i32 %35, 13
  %37 = sub nsw i32 %34, %36
  store i32 %37, ptr %17, align 4
  %38 = load i32, ptr %17, align 4
  %39 = sext i32 %38 to i64
  %40 = udiv i64 %39, 32
  %41 = trunc i64 %40 to i32
  store i32 %41, ptr %16, align 4
  %42 = load i32, ptr %16, align 4
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %47

44:                                               ; preds = %29
  %45 = load i16, ptr %8, align 2
  %46 = zext i16 %45 to i32
  br label %51

47:                                               ; preds = %29
  %48 = load i16, ptr %8, align 2
  %49 = zext i16 %48 to i32
  %50 = add nsw i32 %49, 1
  br label %51

51:                                               ; preds = %47, %44
  %52 = phi i32 [ %46, %44 ], [ %50, %47 ]
  store i32 %52, ptr %18, align 4
  br label %53

53:                                               ; preds = %142, %51
  %54 = load i32, ptr %18, align 4
  %55 = add nsw i32 %54, -1
  store i32 %55, ptr %18, align 4
  %56 = icmp ne i32 %54, 0
  br i1 %56, label %57, label %143

57:                                               ; preds = %53
  %58 = load ptr, ptr %6, align 8
  %59 = load i32, ptr %15, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds ptr, ptr %58, i64 %60
  %62 = load ptr, ptr %61, align 8
  store ptr %62, ptr %19, align 8
  %63 = load ptr, ptr %19, align 8
  %64 = getelementptr inbounds %struct.buf, ptr %63, i32 0, i32 0
  %65 = load i32, ptr %16, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds [256 x i32], ptr %64, i64 0, i64 %66
  store ptr %67, ptr %11, align 8
  %68 = load ptr, ptr %19, align 8
  %69 = getelementptr inbounds %struct.buf, ptr %68, i32 0, i32 0
  %70 = getelementptr inbounds [256 x i32], ptr %69, i64 0, i64 256
  store ptr %70, ptr %12, align 8
  br label %71

71:                                               ; preds = %132, %57
  %72 = load ptr, ptr %11, align 8
  %73 = load ptr, ptr %12, align 8
  %74 = icmp ne ptr %72, %73
  br i1 %74, label %75, label %135

75:                                               ; preds = %71
  %76 = load ptr, ptr %11, align 8
  %77 = load i32, ptr %76, align 4
  store i32 %77, ptr %10, align 4
  %78 = icmp ne i32 %77, -1
  br i1 %78, label %79, label %132

79:                                               ; preds = %75
  store i32 0, ptr %13, align 4
  br label %80

80:                                               ; preds = %128, %79
  %81 = load i32, ptr %13, align 4
  %82 = sext i32 %81 to i64
  %83 = icmp ult i64 %82, 32
  br i1 %83, label %84, label %131

84:                                               ; preds = %80
  %85 = load i32, ptr %10, align 4
  %86 = load i32, ptr %13, align 4
  %87 = lshr i32 %85, %86
  %88 = and i32 %87, 1
  %89 = icmp eq i32 %88, 0
  br i1 %89, label %90, label %127

90:                                               ; preds = %84
  %91 = load i32, ptr %13, align 4
  %92 = sext i32 %91 to i64
  %93 = load ptr, ptr %11, align 8
  %94 = load ptr, ptr %19, align 8
  %95 = getelementptr inbounds %struct.buf, ptr %94, i32 0, i32 0
  %96 = getelementptr inbounds [256 x i32], ptr %95, i64 0, i64 0
  %97 = ptrtoint ptr %93 to i64
  %98 = ptrtoint ptr %96 to i64
  %99 = sub i64 %97, %98
  %100 = sdiv exact i64 %99, 4
  %101 = trunc i64 %100 to i32
  %102 = sext i32 %101 to i64
  %103 = mul i64 %102, 32
  %104 = add i64 %92, %103
  %105 = load i32, ptr %15, align 4
  %106 = shl i32 %105, 13
  %107 = sext i32 %106 to i64
  %108 = add i64 %104, %107
  %109 = trunc i64 %108 to i32
  store i32 %109, ptr %14, align 4
  %110 = load i32, ptr %14, align 4
  %111 = load i16, ptr %7, align 2
  %112 = zext i16 %111 to i32
  %113 = icmp sge i32 %110, %112
  br i1 %113, label %114, label %117

114:                                              ; preds = %90
  %115 = load ptr, ptr %12, align 8
  %116 = getelementptr inbounds i32, ptr %115, i64 -1
  store ptr %116, ptr %11, align 8
  br label %131

117:                                              ; preds = %90
  %118 = load i32, ptr %13, align 4
  %119 = shl i32 1, %118
  %120 = load ptr, ptr %11, align 8
  %121 = load i32, ptr %120, align 4
  %122 = or i32 %121, %119
  store i32 %122, ptr %120, align 4
  %123 = load ptr, ptr %19, align 8
  %124 = getelementptr inbounds %struct.buf, ptr %123, i32 0, i32 6
  store i8 1, ptr %124, align 4
  %125 = load i32, ptr %14, align 4
  %126 = trunc i32 %125 to i16
  store i16 %126, ptr %5, align 2
  br label %144

127:                                              ; preds = %84
  br label %128

128:                                              ; preds = %127
  %129 = load i32, ptr %13, align 4
  %130 = add nsw i32 %129, 1
  store i32 %130, ptr %13, align 4
  br label %80

131:                                              ; preds = %114, %80
  br label %132

132:                                              ; preds = %131, %75
  %133 = load ptr, ptr %11, align 8
  %134 = getelementptr inbounds i32, ptr %133, i32 1
  store ptr %134, ptr %11, align 8
  br label %71

135:                                              ; preds = %71
  %136 = load i32, ptr %15, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, ptr %15, align 4
  %138 = load i16, ptr %8, align 2
  %139 = zext i16 %138 to i32
  %140 = icmp eq i32 %137, %139
  br i1 %140, label %141, label %142

141:                                              ; preds = %135
  store i32 0, ptr %15, align 4
  br label %142

142:                                              ; preds = %141, %135
  store i32 0, ptr %16, align 4
  br label %53

143:                                              ; preds = %53
  store i16 0, ptr %5, align 2
  br label %144

144:                                              ; preds = %143, %117
  %145 = load i16, ptr %5, align 2
  ret i16 %145
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_bit(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i16, align 2
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = trunc i32 %1 to i16
  store ptr %0, ptr %3, align 8
  store i16 %10, ptr %4, align 2
  %11 = load i16, ptr %4, align 2
  %12 = zext i16 %11 to i32
  %13 = ashr i32 %12, 13
  store i32 %13, ptr %5, align 4
  %14 = load i16, ptr %4, align 2
  %15 = zext i16 %14 to i32
  %16 = load i32, ptr %5, align 4
  %17 = shl i32 %16, 13
  %18 = sub nsw i32 %15, %17
  store i32 %18, ptr %6, align 4
  %19 = load i32, ptr %6, align 4
  %20 = sext i32 %19 to i64
  %21 = udiv i64 %20, 32
  %22 = trunc i64 %21 to i32
  store i32 %22, ptr %7, align 4
  %23 = load i32, ptr %6, align 4
  %24 = sext i32 %23 to i64
  %25 = urem i64 %24, 32
  %26 = trunc i64 %25 to i32
  store i32 %26, ptr %8, align 4
  %27 = load ptr, ptr %3, align 8
  %28 = load i32, ptr %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds ptr, ptr %27, i64 %29
  %31 = load ptr, ptr %30, align 8
  store ptr %31, ptr %9, align 8
  %32 = load ptr, ptr %9, align 8
  %33 = icmp eq ptr %32, null
  br i1 %33, label %34, label %35

34:                                               ; preds = %2
  br label %62

35:                                               ; preds = %2
  %36 = load ptr, ptr %9, align 8
  %37 = getelementptr inbounds %struct.buf, ptr %36, i32 0, i32 0
  %38 = load i32, ptr %7, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds [256 x i32], ptr %37, i64 0, i64 %39
  %41 = load i32, ptr %40, align 4
  %42 = load i32, ptr %8, align 4
  %43 = ashr i32 %41, %42
  %44 = and i32 %43, 1
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %46, label %49

46:                                               ; preds = %35
  %47 = load i16, ptr %4, align 2
  %48 = zext i16 %47 to i32
  call void (ptr, i32, ...) @printk(ptr noundef @.str.1, i32 noundef %48)
  br label %49

49:                                               ; preds = %46, %35
  %50 = load i32, ptr %8, align 4
  %51 = shl i32 1, %50
  %52 = xor i32 %51, -1
  %53 = load ptr, ptr %9, align 8
  %54 = getelementptr inbounds %struct.buf, ptr %53, i32 0, i32 0
  %55 = load i32, ptr %7, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds [256 x i32], ptr %54, i64 0, i64 %56
  %58 = load i32, ptr %57, align 4
  %59 = and i32 %58, %52
  store i32 %59, ptr %57, align 4
  %60 = load ptr, ptr %9, align 8
  %61 = getelementptr inbounds %struct.buf, ptr %60, i32 0, i32 6
  store i8 1, ptr %61, align 4
  br label %62

62:                                               ; preds = %49, %34
  ret void
}

declare void @printk(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @get_super(i32 noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i16, align 2
  %4 = alloca ptr, align 8
  %5 = trunc i32 %0 to i16
  store i16 %5, ptr %3, align 2
  store ptr @super_block, ptr %4, align 8
  br label %6

6:                                                ; preds = %20, %1
  %7 = load ptr, ptr %4, align 8
  %8 = icmp ult ptr %7, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %8, label %9, label %23

9:                                                ; preds = %6
  %10 = load ptr, ptr %4, align 8
  %11 = getelementptr inbounds %struct.super_block, ptr %10, i32 0, i32 10
  %12 = load i16, ptr %11, align 8
  %13 = zext i16 %12 to i32
  %14 = load i16, ptr %3, align 2
  %15 = zext i16 %14 to i32
  %16 = icmp eq i32 %13, %15
  br i1 %16, label %17, label %19

17:                                               ; preds = %9
  %18 = load ptr, ptr %4, align 8
  store ptr %18, ptr %2, align 8
  br label %26

19:                                               ; preds = %9
  br label %20

20:                                               ; preds = %19
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.super_block, ptr %21, i32 1
  store ptr %22, ptr %4, align 8
  br label %6

23:                                               ; preds = %6
  %24 = load i16, ptr %3, align 2
  %25 = zext i16 %24 to i32
  call void (ptr, i32, ...) @panic(ptr noundef @.str.2, i32 noundef %25)
  br label %26

26:                                               ; preds = %23, %17
  %27 = load ptr, ptr %2, align 8
  ret ptr %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @mounted(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.inode, ptr %6, i32 0, i32 6
  %8 = getelementptr inbounds [9 x i16], ptr %7, i64 0, i64 0
  %9 = load i16, ptr %8, align 2
  store i16 %9, ptr %5, align 2
  %10 = load i16, ptr %5, align 2
  %11 = zext i16 %10 to i32
  %12 = load i16, ptr @boot_parameters, align 2
  %13 = zext i16 %12 to i32
  %14 = icmp eq i32 %11, %13
  br i1 %14, label %15, label %16

15:                                               ; preds = %1
  store i32 1, ptr %2, align 4
  br label %34

16:                                               ; preds = %1
  store ptr @super_block, ptr %4, align 8
  br label %17

17:                                               ; preds = %30, %16
  %18 = load ptr, ptr %4, align 8
  %19 = icmp ult ptr %18, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %19, label %20, label %33

20:                                               ; preds = %17
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.super_block, ptr %21, i32 0, i32 10
  %23 = load i16, ptr %22, align 8
  %24 = zext i16 %23 to i32
  %25 = load i16, ptr %5, align 2
  %26 = zext i16 %25 to i32
  %27 = icmp eq i32 %24, %26
  br i1 %27, label %28, label %29

28:                                               ; preds = %20
  store i32 1, ptr %2, align 4
  br label %34

29:                                               ; preds = %20
  br label %30

30:                                               ; preds = %29
  %31 = load ptr, ptr %4, align 8
  %32 = getelementptr inbounds %struct.super_block, ptr %31, i32 1
  store ptr %32, ptr %4, align 8
  br label %17

33:                                               ; preds = %17
  store i32 0, ptr %2, align 4
  br label %34

34:                                               ; preds = %33, %28, %15
  %35 = load i32, ptr %2, align 4
  ret i32 %35
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @scale_factor(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.inode, ptr %4, i32 0, i32 9
  %6 = load i16, ptr %5, align 8
  %7 = zext i16 %6 to i32
  %8 = call ptr @get_super(i32 noundef %7)
  store ptr %8, ptr %3, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.super_block, ptr %9, i32 0, i32 5
  %11 = load i16, ptr %10, align 2
  %12 = sext i16 %11 to i32
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_super(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %4, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %25

9:                                                ; preds = %2
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.super_block, ptr %10, i32 0, i32 10
  %12 = load i16, ptr %11, align 8
  store i16 %12, ptr %6, align 2
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.super_block, ptr %13, i32 0, i32 10
  %15 = load i16, ptr %14, align 8
  %16 = zext i16 %15 to i32
  %17 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %16, i32 noundef 1, i32 noundef 0)
  store ptr %17, ptr %5, align 8
  %18 = load ptr, ptr %3, align 8
  %19 = load ptr, ptr %5, align 8
  %20 = getelementptr inbounds %struct.buf, ptr %19, i32 0, i32 0
  %21 = getelementptr inbounds [1024 x i8], ptr %20, i64 0, i64 0
  call void (ptr, ptr, i64, ...) @copy(ptr noundef %18, ptr noundef %21, i64 noundef 200)
  %22 = load i16, ptr %6, align 2
  %23 = load ptr, ptr %3, align 8
  %24 = getelementptr inbounds %struct.super_block, ptr %23, i32 0, i32 10
  store i16 %22, ptr %24, align 8
  br label %37

25:                                               ; preds = %2
  %26 = load ptr, ptr %3, align 8
  %27 = getelementptr inbounds %struct.super_block, ptr %26, i32 0, i32 10
  %28 = load i16, ptr %27, align 8
  %29 = zext i16 %28 to i32
  %30 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %29, i32 noundef 1, i32 noundef 1)
  store ptr %30, ptr %5, align 8
  %31 = load ptr, ptr %5, align 8
  %32 = getelementptr inbounds %struct.buf, ptr %31, i32 0, i32 0
  %33 = getelementptr inbounds [1024 x i8], ptr %32, i64 0, i64 0
  %34 = load ptr, ptr %3, align 8
  call void (ptr, ptr, i64, ...) @copy(ptr noundef %33, ptr noundef %34, i64 noundef 200)
  %35 = load ptr, ptr %5, align 8
  %36 = getelementptr inbounds %struct.buf, ptr %35, i32 0, i32 6
  store i8 1, ptr %36, align 4
  br label %37

37:                                               ; preds = %25, %9
  %38 = load ptr, ptr %3, align 8
  %39 = getelementptr inbounds %struct.super_block, ptr %38, i32 0, i32 15
  store i8 0, ptr %39, align 1
  %40 = load ptr, ptr %5, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %40, i32 noundef 197)
  ret void
}

declare void @copy(...) #1

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
