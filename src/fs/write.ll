; NOTE: Generated from src/fs/write.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/write.c'
source_filename = "src/fs/write.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.buf = type { %union.anon, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }

@err_code = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_write() #0 {
  %1 = call i32 (i32, ...) @read_write(i32 noundef 1)
  ret i32 %1
}

declare i32 @read_write(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @clear_zone(ptr noundef %0, i64 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i16, align 2
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i32 %2, ptr %6, align 4
  %14 = load ptr, ptr %4, align 8
  %15 = call i32 (ptr, ...) @scale_factor(ptr noundef %14)
  store i32 %15, ptr %12, align 4
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %3
  br label %79

18:                                               ; preds = %3
  %19 = load i32, ptr %12, align 4
  %20 = zext i32 %19 to i64
  %21 = shl i64 1024, %20
  store i64 %21, ptr %13, align 8
  %22 = load i32, ptr %6, align 4
  %23 = icmp eq i32 %22, 1
  br i1 %23, label %24, label %30

24:                                               ; preds = %18
  %25 = load i64, ptr %5, align 8
  %26 = load i64, ptr %13, align 8
  %27 = sdiv i64 %25, %26
  %28 = load i64, ptr %13, align 8
  %29 = mul nsw i64 %27, %28
  store i64 %29, ptr %5, align 8
  br label %30

30:                                               ; preds = %24, %18
  %31 = load i64, ptr %5, align 8
  %32 = add nsw i64 %31, 1024
  %33 = sub nsw i64 %32, 1
  store i64 %33, ptr %11, align 8
  %34 = load i64, ptr %11, align 8
  %35 = load i64, ptr %13, align 8
  %36 = sdiv i64 %34, %35
  %37 = load i64, ptr %5, align 8
  %38 = load i64, ptr %13, align 8
  %39 = sdiv i64 %37, %38
  %40 = icmp ne i64 %36, %39
  br i1 %40, label %41, label %42

41:                                               ; preds = %30
  br label %79

42:                                               ; preds = %30
  %43 = load ptr, ptr %4, align 8
  %44 = load i64, ptr %11, align 8
  %45 = call zeroext i16 (ptr, i64, ...) @read_map(ptr noundef %43, i64 noundef %44)
  store i16 %45, ptr %9, align 2
  %46 = zext i16 %45 to i32
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %42
  br label %79

49:                                               ; preds = %42
  %50 = load i16, ptr %9, align 2
  %51 = zext i16 %50 to i32
  %52 = load i32, ptr %12, align 4
  %53 = ashr i32 %51, %52
  %54 = add nsw i32 %53, 1
  %55 = load i32, ptr %12, align 4
  %56 = shl i32 %54, %55
  %57 = sub nsw i32 %56, 1
  %58 = trunc i32 %57 to i16
  store i16 %58, ptr %10, align 2
  %59 = load i16, ptr %9, align 2
  store i16 %59, ptr %8, align 2
  br label %60

60:                                               ; preds = %76, %49
  %61 = load i16, ptr %8, align 2
  %62 = zext i16 %61 to i32
  %63 = load i16, ptr %10, align 2
  %64 = zext i16 %63 to i32
  %65 = icmp sle i32 %62, %64
  br i1 %65, label %66, label %79

66:                                               ; preds = %60
  %67 = load ptr, ptr %4, align 8
  %68 = getelementptr inbounds %struct.inode, ptr %67, i32 0, i32 9
  %69 = load i16, ptr %68, align 8
  %70 = zext i16 %69 to i32
  %71 = load i16, ptr %8, align 2
  %72 = zext i16 %71 to i32
  %73 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %70, i32 noundef %72, i32 noundef 1)
  store ptr %73, ptr %7, align 8
  %74 = load ptr, ptr %7, align 8
  call void @zero_block(ptr noundef %74)
  %75 = load ptr, ptr %7, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %75, i32 noundef 6)
  br label %76

76:                                               ; preds = %66
  %77 = load i16, ptr %8, align 2
  %78 = add i16 %77, 1
  store i16 %78, ptr %8, align 2
  br label %60

79:                                               ; preds = %17, %41, %48, %60
  ret void
}

declare i32 @scale_factor(...) #1

declare zeroext i16 @read_map(...) #1

declare ptr @get_block(...) #1

declare void @put_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @new_block(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %14 = load ptr, ptr %4, align 8
  %15 = load i64, ptr %5, align 8
  %16 = call zeroext i16 (ptr, i64, ...) @read_map(ptr noundef %14, i64 noundef %15)
  store i16 %16, ptr %7, align 2
  %17 = zext i16 %16 to i32
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %19, label %94

19:                                               ; preds = %2
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds %struct.inode, ptr %20, i32 0, i32 2
  %22 = load i64, ptr %21, align 8
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %24, label %33

24:                                               ; preds = %19
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds %struct.inode, ptr %25, i32 0, i32 9
  %27 = load i16, ptr %26, align 8
  %28 = zext i16 %27 to i32
  %29 = call ptr (i32, ...) @get_super(i32 noundef %28)
  store ptr %29, ptr %13, align 8
  %30 = load ptr, ptr %13, align 8
  %31 = getelementptr inbounds %struct.super_block, ptr %30, i32 0, i32 4
  %32 = load i16, ptr %31, align 8
  store i16 %32, ptr %9, align 2
  br label %38

33:                                               ; preds = %19
  %34 = load ptr, ptr %4, align 8
  %35 = getelementptr inbounds %struct.inode, ptr %34, i32 0, i32 6
  %36 = getelementptr inbounds [9 x i16], ptr %35, i64 0, i64 0
  %37 = load i16, ptr %36, align 2
  store i16 %37, ptr %9, align 2
  br label %38

38:                                               ; preds = %33, %24
  %39 = load ptr, ptr %4, align 8
  %40 = getelementptr inbounds %struct.inode, ptr %39, i32 0, i32 9
  %41 = load i16, ptr %40, align 8
  %42 = zext i16 %41 to i32
  %43 = load i16, ptr %9, align 2
  %44 = zext i16 %43 to i32
  %45 = call zeroext i16 (i32, i32, ...) @alloc_zone(i32 noundef %42, i32 noundef %44)
  store i16 %45, ptr %9, align 2
  %46 = zext i16 %45 to i32
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %38
  store ptr null, ptr %3, align 8
  br label %104

49:                                               ; preds = %38
  %50 = load ptr, ptr %4, align 8
  %51 = load i64, ptr %5, align 8
  %52 = load i16, ptr %9, align 2
  %53 = zext i16 %52 to i32
  %54 = call i32 @write_map(ptr noundef %50, i64 noundef %51, i32 noundef %53)
  store i32 %54, ptr %12, align 4
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %64

56:                                               ; preds = %49
  %57 = load ptr, ptr %4, align 8
  %58 = getelementptr inbounds %struct.inode, ptr %57, i32 0, i32 9
  %59 = load i16, ptr %58, align 8
  %60 = zext i16 %59 to i32
  %61 = load i16, ptr %9, align 2
  %62 = zext i16 %61 to i32
  call void (i32, i32, ...) @free_zone(i32 noundef %60, i32 noundef %62)
  %63 = load i32, ptr %12, align 4
  store i32 %63, ptr @err_code, align 4
  store ptr null, ptr %3, align 8
  br label %104

64:                                               ; preds = %49
  %65 = load i64, ptr %5, align 8
  %66 = load ptr, ptr %4, align 8
  %67 = getelementptr inbounds %struct.inode, ptr %66, i32 0, i32 2
  %68 = load i64, ptr %67, align 8
  %69 = icmp ne i64 %65, %68
  br i1 %69, label %70, label %73

70:                                               ; preds = %64
  %71 = load ptr, ptr %4, align 8
  %72 = load i64, ptr %5, align 8
  call void @clear_zone(ptr noundef %71, i64 noundef %72, i32 noundef 1)
  br label %73

73:                                               ; preds = %70, %64
  %74 = load ptr, ptr %4, align 8
  %75 = call i32 (ptr, ...) @scale_factor(ptr noundef %74)
  store i32 %75, ptr %11, align 4
  %76 = load i16, ptr %9, align 2
  %77 = zext i16 %76 to i32
  %78 = load i32, ptr %11, align 4
  %79 = shl i32 %77, %78
  %80 = trunc i32 %79 to i16
  store i16 %80, ptr %8, align 2
  %81 = load i32, ptr %11, align 4
  %82 = zext i32 %81 to i64
  %83 = shl i64 1024, %82
  store i64 %83, ptr %10, align 8
  %84 = load i16, ptr %8, align 2
  %85 = zext i16 %84 to i32
  %86 = load i64, ptr %5, align 8
  %87 = load i64, ptr %10, align 8
  %88 = srem i64 %86, %87
  %89 = sdiv i64 %88, 1024
  %90 = trunc i64 %89 to i16
  %91 = zext i16 %90 to i32
  %92 = add nsw i32 %85, %91
  %93 = trunc i32 %92 to i16
  store i16 %93, ptr %7, align 2
  br label %94

94:                                               ; preds = %73, %2
  %95 = load ptr, ptr %4, align 8
  %96 = getelementptr inbounds %struct.inode, ptr %95, i32 0, i32 9
  %97 = load i16, ptr %96, align 8
  %98 = zext i16 %97 to i32
  %99 = load i16, ptr %7, align 2
  %100 = zext i16 %99 to i32
  %101 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %98, i32 noundef %100, i32 noundef 1)
  store ptr %101, ptr %6, align 8
  %102 = load ptr, ptr %6, align 8
  call void @zero_block(ptr noundef %102)
  %103 = load ptr, ptr %6, align 8
  store ptr %103, ptr %3, align 8
  br label %104

104:                                              ; preds = %94, %56, %48
  %105 = load ptr, ptr %3, align 8
  ret ptr %105
}

declare ptr @get_super(...) #1

declare zeroext i16 @alloc_zone(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @write_map(ptr noundef %0, i64 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i16, align 2
  %8 = alloca i32, align 4
  %9 = alloca i16, align 2
  %10 = alloca ptr, align 8
  %11 = alloca i16, align 2
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = trunc i32 %2 to i16
  store ptr %0, ptr %5, align 8
  store i64 %1, ptr %6, align 8
  store i16 %18, ptr %7, align 2
  %19 = load ptr, ptr %5, align 8
  %20 = getelementptr inbounds %struct.inode, ptr %19, i32 0, i32 12
  store i8 1, ptr %20, align 2
  store ptr null, ptr %15, align 8
  %21 = load ptr, ptr %5, align 8
  %22 = call i32 (ptr, ...) @scale_factor(ptr noundef %21)
  store i32 %22, ptr %8, align 4
  %23 = load i64, ptr %6, align 8
  %24 = sdiv i64 %23, 1024
  %25 = load i32, ptr %8, align 4
  %26 = zext i32 %25 to i64
  %27 = ashr i64 %24, %26
  store i64 %27, ptr %13, align 8
  %28 = load i64, ptr %13, align 8
  %29 = icmp slt i64 %28, 7
  br i1 %29, label %30, label %40

30:                                               ; preds = %3
  %31 = load i16, ptr %7, align 2
  %32 = load ptr, ptr %5, align 8
  %33 = getelementptr inbounds %struct.inode, ptr %32, i32 0, i32 6
  %34 = load i64, ptr %13, align 8
  %35 = trunc i64 %34 to i32
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [9 x i16], ptr %33, i64 0, i64 %36
  store i16 %31, ptr %37, align 2
  %38 = load ptr, ptr %5, align 8
  %39 = getelementptr inbounds %struct.inode, ptr %38, i32 0, i32 16
  store i8 8, ptr %39, align 2
  store i32 0, ptr %4, align 4
  br label %182

40:                                               ; preds = %3
  %41 = load i64, ptr %13, align 8
  %42 = sub nsw i64 %41, 7
  store i64 %42, ptr %12, align 8
  store i32 0, ptr %16, align 4
  store i32 0, ptr %17, align 4
  %43 = load i64, ptr %12, align 8
  %44 = icmp ult i64 %43, 512
  br i1 %44, label %45, label %49

45:                                               ; preds = %40
  %46 = load ptr, ptr %5, align 8
  %47 = getelementptr inbounds %struct.inode, ptr %46, i32 0, i32 6
  %48 = getelementptr inbounds [9 x i16], ptr %47, i64 0, i64 7
  store ptr %48, ptr %10, align 8
  br label %115

49:                                               ; preds = %40
  %50 = load ptr, ptr %5, align 8
  %51 = getelementptr inbounds %struct.inode, ptr %50, i32 0, i32 6
  %52 = getelementptr inbounds [9 x i16], ptr %51, i64 0, i64 8
  %53 = load i16, ptr %52, align 2
  store i16 %53, ptr %9, align 2
  %54 = zext i16 %53 to i32
  %55 = icmp eq i32 %54, 0
  br i1 %55, label %56, label %76

56:                                               ; preds = %49
  %57 = load ptr, ptr %5, align 8
  %58 = getelementptr inbounds %struct.inode, ptr %57, i32 0, i32 9
  %59 = load i16, ptr %58, align 8
  %60 = zext i16 %59 to i32
  %61 = load ptr, ptr %5, align 8
  %62 = getelementptr inbounds %struct.inode, ptr %61, i32 0, i32 6
  %63 = getelementptr inbounds [9 x i16], ptr %62, i64 0, i64 0
  %64 = load i16, ptr %63, align 2
  %65 = zext i16 %64 to i32
  %66 = call zeroext i16 (i32, i32, ...) @alloc_zone(i32 noundef %60, i32 noundef %65)
  store i16 %66, ptr %9, align 2
  %67 = zext i16 %66 to i32
  %68 = icmp eq i32 %67, 0
  br i1 %68, label %69, label %71

69:                                               ; preds = %56
  %70 = load i32, ptr @err_code, align 4
  store i32 %70, ptr %4, align 4
  br label %182

71:                                               ; preds = %56
  %72 = load i16, ptr %9, align 2
  %73 = load ptr, ptr %5, align 8
  %74 = getelementptr inbounds %struct.inode, ptr %73, i32 0, i32 6
  %75 = getelementptr inbounds [9 x i16], ptr %74, i64 0, i64 8
  store i16 %72, ptr %75, align 2
  store i32 1, ptr %17, align 4
  br label %76

76:                                               ; preds = %71, %49
  %77 = load i64, ptr %12, align 8
  %78 = sub i64 %77, 512
  store i64 %78, ptr %12, align 8
  %79 = load i64, ptr %12, align 8
  %80 = udiv i64 %79, 512
  %81 = trunc i64 %80 to i32
  store i32 %81, ptr %14, align 4
  %82 = load i64, ptr %12, align 8
  %83 = urem i64 %82, 512
  store i64 %83, ptr %12, align 8
  %84 = load i32, ptr %14, align 4
  %85 = sext i32 %84 to i64
  %86 = icmp uge i64 %85, 512
  br i1 %86, label %87, label %88

87:                                               ; preds = %76
  store i32 -27, ptr %4, align 4
  br label %182

88:                                               ; preds = %76
  %89 = load i16, ptr %9, align 2
  %90 = zext i16 %89 to i32
  %91 = load i32, ptr %8, align 4
  %92 = shl i32 %90, %91
  %93 = trunc i32 %92 to i16
  store i16 %93, ptr %11, align 2
  %94 = load ptr, ptr %5, align 8
  %95 = getelementptr inbounds %struct.inode, ptr %94, i32 0, i32 9
  %96 = load i16, ptr %95, align 8
  %97 = zext i16 %96 to i32
  %98 = load i16, ptr %11, align 2
  %99 = zext i16 %98 to i32
  %100 = load i32, ptr %17, align 4
  %101 = icmp ne i32 %100, 0
  %102 = zext i1 %101 to i64
  %103 = select i1 %101, i32 1, i32 0
  %104 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %97, i32 noundef %99, i32 noundef %103)
  store ptr %104, ptr %15, align 8
  %105 = load i32, ptr %17, align 4
  %106 = icmp ne i32 %105, 0
  br i1 %106, label %107, label %109

107:                                              ; preds = %88
  %108 = load ptr, ptr %15, align 8
  call void @zero_block(ptr noundef %108)
  br label %109

109:                                              ; preds = %107, %88
  %110 = load ptr, ptr %15, align 8
  %111 = getelementptr inbounds %struct.buf, ptr %110, i32 0, i32 0
  %112 = load i32, ptr %14, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [512 x i16], ptr %111, i64 0, i64 %113
  store ptr %114, ptr %10, align 8
  br label %115

115:                                              ; preds = %109, %45
  %116 = load ptr, ptr %10, align 8
  %117 = load i16, ptr %116, align 2
  %118 = zext i16 %117 to i32
  %119 = icmp eq i32 %118, 0
  br i1 %119, label %120, label %146

120:                                              ; preds = %115
  %121 = load ptr, ptr %5, align 8
  %122 = getelementptr inbounds %struct.inode, ptr %121, i32 0, i32 9
  %123 = load i16, ptr %122, align 8
  %124 = zext i16 %123 to i32
  %125 = load ptr, ptr %5, align 8
  %126 = getelementptr inbounds %struct.inode, ptr %125, i32 0, i32 6
  %127 = getelementptr inbounds [9 x i16], ptr %126, i64 0, i64 0
  %128 = load i16, ptr %127, align 2
  %129 = zext i16 %128 to i32
  %130 = call zeroext i16 (i32, i32, ...) @alloc_zone(i32 noundef %124, i32 noundef %129)
  %131 = load ptr, ptr %10, align 8
  store i16 %130, ptr %131, align 2
  store i32 1, ptr %16, align 4
  %132 = load ptr, ptr %15, align 8
  %133 = icmp ne ptr %132, null
  br i1 %133, label %134, label %137

134:                                              ; preds = %120
  %135 = load ptr, ptr %15, align 8
  %136 = getelementptr inbounds %struct.buf, ptr %135, i32 0, i32 6
  store i8 1, ptr %136, align 4
  br label %137

137:                                              ; preds = %134, %120
  %138 = load ptr, ptr %10, align 8
  %139 = load i16, ptr %138, align 2
  %140 = zext i16 %139 to i32
  %141 = icmp eq i32 %140, 0
  br i1 %141, label %142, label %145

142:                                              ; preds = %137
  %143 = load ptr, ptr %15, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %143, i32 noundef 2)
  %144 = load i32, ptr @err_code, align 4
  store i32 %144, ptr %4, align 4
  br label %182

145:                                              ; preds = %137
  br label %146

146:                                              ; preds = %145, %115
  %147 = load ptr, ptr %15, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %147, i32 noundef 2)
  %148 = load ptr, ptr %10, align 8
  %149 = load i16, ptr %148, align 2
  %150 = zext i16 %149 to i32
  %151 = load i32, ptr %8, align 4
  %152 = shl i32 %150, %151
  %153 = trunc i32 %152 to i16
  store i16 %153, ptr %11, align 2
  %154 = load ptr, ptr %5, align 8
  %155 = getelementptr inbounds %struct.inode, ptr %154, i32 0, i32 9
  %156 = load i16, ptr %155, align 8
  %157 = zext i16 %156 to i32
  %158 = load i16, ptr %11, align 2
  %159 = zext i16 %158 to i32
  %160 = load i32, ptr %16, align 4
  %161 = icmp ne i32 %160, 0
  %162 = zext i1 %161 to i64
  %163 = select i1 %161, i32 1, i32 0
  %164 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %157, i32 noundef %159, i32 noundef %163)
  store ptr %164, ptr %15, align 8
  %165 = load i32, ptr %16, align 4
  %166 = icmp ne i32 %165, 0
  br i1 %166, label %167, label %169

167:                                              ; preds = %146
  %168 = load ptr, ptr %15, align 8
  call void @zero_block(ptr noundef %168)
  br label %169

169:                                              ; preds = %167, %146
  %170 = load i16, ptr %7, align 2
  %171 = load ptr, ptr %15, align 8
  %172 = getelementptr inbounds %struct.buf, ptr %171, i32 0, i32 0
  %173 = load i64, ptr %12, align 8
  %174 = trunc i64 %173 to i32
  %175 = sext i32 %174 to i64
  %176 = getelementptr inbounds [512 x i16], ptr %172, i64 0, i64 %175
  store i16 %170, ptr %176, align 2
  %177 = load ptr, ptr %5, align 8
  %178 = getelementptr inbounds %struct.inode, ptr %177, i32 0, i32 16
  store i8 8, ptr %178, align 2
  %179 = load ptr, ptr %15, align 8
  %180 = getelementptr inbounds %struct.buf, ptr %179, i32 0, i32 6
  store i8 1, ptr %180, align 4
  %181 = load ptr, ptr %15, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %181, i32 noundef 2)
  store i32 0, ptr %4, align 4
  br label %182

182:                                              ; preds = %169, %142, %87, %69, %30
  %183 = load i32, ptr %4, align 4
  ret i32 %183
}

declare void @free_zone(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @zero_block(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  store i32 256, ptr %3, align 4
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.buf, ptr %5, i32 0, i32 0
  %7 = getelementptr inbounds [256 x i32], ptr %6, i64 0, i64 0
  store ptr %7, ptr %4, align 8
  br label %8

8:                                                ; preds = %11, %1
  %9 = load ptr, ptr %4, align 8
  %10 = getelementptr inbounds i32, ptr %9, i32 1
  store ptr %10, ptr %4, align 8
  store i32 0, ptr %9, align 4
  br label %11

11:                                               ; preds = %8
  %12 = load i32, ptr %3, align 4
  %13 = add nsw i32 %12, -1
  store i32 %13, ptr %3, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %8, label %15

15:                                               ; preds = %11
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.buf, ptr %16, i32 0, i32 6
  store i8 1, ptr %17, align 4
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
