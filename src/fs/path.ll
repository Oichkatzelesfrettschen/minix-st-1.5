; NOTE: Generated from src/fs/path.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/path.c'
source_filename = "src/fs/path.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.buf = type { %union.anon, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.dir_struct = type { i16, [14 x i8] }

@fp = external global ptr, align 8
@err_code = external global i32, align 4
@fs_call = external global i32, align 4
@super_block = external global [5 x %struct.super_block], align 16
@.str = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"..\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @eat_path(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca [14 x i8], align 1
  store ptr %0, ptr %3, align 8
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds [14 x i8], ptr %6, i64 0, i64 0
  %9 = call ptr @last_dir(ptr noundef %7, ptr noundef %8)
  store ptr %9, ptr %4, align 8
  %10 = icmp eq ptr %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store ptr null, ptr %2, align 8
  br label %25

12:                                               ; preds = %1
  %13 = getelementptr inbounds [14 x i8], ptr %6, i64 0, i64 0
  %14 = load i8, ptr %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %12
  %18 = load ptr, ptr %4, align 8
  store ptr %18, ptr %2, align 8
  br label %25

19:                                               ; preds = %12
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds [14 x i8], ptr %6, i64 0, i64 0
  %22 = call ptr @advance(ptr noundef %20, ptr noundef %21)
  store ptr %22, ptr %5, align 8
  %23 = load ptr, ptr %4, align 8
  call void (ptr, ...) @put_inode(ptr noundef %23)
  %24 = load ptr, ptr %5, align 8
  store ptr %24, ptr %2, align 8
  br label %25

25:                                               ; preds = %19, %17, %11
  %26 = load ptr, ptr %2, align 8
  ret ptr %26
}

declare void @put_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @last_dir(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %10 = load ptr, ptr %4, align 8
  %11 = load i8, ptr %10, align 1
  %12 = sext i8 %11 to i32
  %13 = icmp eq i32 %12, 47
  br i1 %13, label %14, label %18

14:                                               ; preds = %2
  %15 = load ptr, ptr @fp, align 8
  %16 = getelementptr inbounds %struct.fproc, ptr %15, i32 0, i32 2
  %17 = load ptr, ptr %16, align 8
  br label %22

18:                                               ; preds = %2
  %19 = load ptr, ptr @fp, align 8
  %20 = getelementptr inbounds %struct.fproc, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  br label %22

22:                                               ; preds = %18, %14
  %23 = phi ptr [ %17, %14 ], [ %21, %18 ]
  store ptr %23, ptr %6, align 8
  %24 = load ptr, ptr %6, align 8
  %25 = getelementptr inbounds %struct.inode, ptr %24, i32 0, i32 5
  %26 = load i8, ptr %25, align 1
  %27 = zext i8 %26 to i32
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %34, label %29

29:                                               ; preds = %22
  %30 = load ptr, ptr %4, align 8
  %31 = load i8, ptr %30, align 1
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %35

34:                                               ; preds = %29, %22
  store i32 -2, ptr @err_code, align 4
  store ptr null, ptr %3, align 8
  br label %95

35:                                               ; preds = %29
  %36 = load ptr, ptr %6, align 8
  call void (ptr, ...) @dup_inode(ptr noundef %36)
  %37 = load i32, ptr @fs_call, align 4
  %38 = icmp eq i32 %37, 10
  br i1 %38, label %42, label %39

39:                                               ; preds = %35
  %40 = load i32, ptr @fs_call, align 4
  %41 = icmp eq i32 %40, 40
  br i1 %41, label %42, label %69

42:                                               ; preds = %39, %35
  br label %43

43:                                               ; preds = %42, %67
  %44 = load ptr, ptr %4, align 8
  %45 = load ptr, ptr %4, align 8
  %46 = call i32 @strlen(ptr noundef %45)
  %47 = zext i32 %46 to i64
  %48 = getelementptr inbounds i8, ptr %44, i64 %47
  %49 = getelementptr inbounds i8, ptr %48, i64 -2
  store ptr %49, ptr %9, align 8
  %50 = load ptr, ptr %9, align 8
  %51 = load ptr, ptr %4, align 8
  %52 = icmp ugt ptr %50, %51
  br i1 %52, label %53, label %66

53:                                               ; preds = %43
  %54 = load ptr, ptr %9, align 8
  %55 = load i8, ptr %54, align 1
  %56 = sext i8 %55 to i32
  %57 = icmp eq i32 %56, 47
  br i1 %57, label %58, label %66

58:                                               ; preds = %53
  %59 = load ptr, ptr %9, align 8
  %60 = getelementptr inbounds i8, ptr %59, i64 1
  %61 = load i8, ptr %60, align 1
  %62 = sext i8 %61 to i32
  %63 = icmp eq i32 %62, 46
  br i1 %63, label %64, label %66

64:                                               ; preds = %58
  %65 = load ptr, ptr %9, align 8
  store i8 0, ptr %65, align 1
  br label %67

66:                                               ; preds = %58, %53, %43
  br label %68

67:                                               ; preds = %64
  br label %43

68:                                               ; preds = %66
  br label %69

69:                                               ; preds = %68, %39
  br label %70

70:                                               ; preds = %69, %92
  %71 = load ptr, ptr %4, align 8
  %72 = load ptr, ptr %5, align 8
  %73 = call ptr @get_name(ptr noundef %71, ptr noundef %72)
  store ptr %73, ptr %7, align 8
  %74 = icmp eq ptr %73, null
  br i1 %74, label %75, label %77

75:                                               ; preds = %70
  %76 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %76)
  store ptr null, ptr %3, align 8
  br label %95

77:                                               ; preds = %70
  %78 = load ptr, ptr %7, align 8
  %79 = load i8, ptr %78, align 1
  %80 = sext i8 %79 to i32
  %81 = icmp eq i32 %80, 0
  br i1 %81, label %82, label %84

82:                                               ; preds = %77
  %83 = load ptr, ptr %6, align 8
  store ptr %83, ptr %3, align 8
  br label %95

84:                                               ; preds = %77
  %85 = load ptr, ptr %6, align 8
  %86 = load ptr, ptr %5, align 8
  %87 = call ptr @advance(ptr noundef %85, ptr noundef %86)
  store ptr %87, ptr %8, align 8
  %88 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %88)
  %89 = load ptr, ptr %8, align 8
  %90 = icmp eq ptr %89, null
  br i1 %90, label %91, label %92

91:                                               ; preds = %84
  store ptr null, ptr %3, align 8
  br label %95

92:                                               ; preds = %84
  %93 = load ptr, ptr %7, align 8
  store ptr %93, ptr %4, align 8
  %94 = load ptr, ptr %8, align 8
  store ptr %94, ptr %6, align 8
  br label %70

95:                                               ; preds = %91, %82, %75, %34
  %96 = load ptr, ptr %3, align 8
  ret ptr %96
}

declare void @dup_inode(...) #1

declare i32 @strlen(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @advance(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i16, align 2
  %11 = alloca i16, align 2
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = getelementptr inbounds i8, ptr %12, i64 0
  %14 = load i8, ptr %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %27

17:                                               ; preds = %2
  %18 = load ptr, ptr %4, align 8
  %19 = getelementptr inbounds %struct.inode, ptr %18, i32 0, i32 9
  %20 = load i16, ptr %19, align 8
  %21 = zext i16 %20 to i32
  %22 = load ptr, ptr %4, align 8
  %23 = getelementptr inbounds %struct.inode, ptr %22, i32 0, i32 10
  %24 = load i16, ptr %23, align 2
  %25 = zext i16 %24 to i32
  %26 = call ptr (i32, i32, ...) @get_inode(i32 noundef %21, i32 noundef %25)
  store ptr %26, ptr %3, align 8
  br label %147

27:                                               ; preds = %2
  %28 = load ptr, ptr %4, align 8
  %29 = icmp eq ptr %28, null
  br i1 %29, label %30, label %31

30:                                               ; preds = %27
  store ptr null, ptr %3, align 8
  br label %147

31:                                               ; preds = %27
  %32 = load ptr, ptr %4, align 8
  %33 = load ptr, ptr %5, align 8
  %34 = call i32 @search_dir(ptr noundef %32, ptr noundef %33, ptr noundef %11, i32 noundef 0)
  store i32 %34, ptr %9, align 4
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %31
  %37 = load i32, ptr %9, align 4
  store i32 %37, ptr @err_code, align 4
  store ptr null, ptr %3, align 8
  br label %147

38:                                               ; preds = %31
  %39 = load ptr, ptr %4, align 8
  %40 = getelementptr inbounds %struct.inode, ptr %39, i32 0, i32 9
  %41 = load i16, ptr %40, align 8
  %42 = zext i16 %41 to i32
  %43 = load i16, ptr %11, align 2
  %44 = zext i16 %43 to i32
  %45 = call ptr (i32, i32, ...) @get_inode(i32 noundef %42, i32 noundef %44)
  store ptr %45, ptr %6, align 8
  %46 = icmp eq ptr %45, null
  br i1 %46, label %47, label %48

47:                                               ; preds = %38
  store ptr null, ptr %3, align 8
  br label %147

48:                                               ; preds = %38
  %49 = load ptr, ptr %6, align 8
  %50 = getelementptr inbounds %struct.inode, ptr %49, i32 0, i32 10
  %51 = load i16, ptr %50, align 2
  %52 = zext i16 %51 to i32
  %53 = icmp eq i32 %52, 1
  br i1 %53, label %54, label %107

54:                                               ; preds = %48
  %55 = load ptr, ptr %4, align 8
  %56 = getelementptr inbounds %struct.inode, ptr %55, i32 0, i32 10
  %57 = load i16, ptr %56, align 2
  %58 = zext i16 %57 to i32
  %59 = icmp eq i32 %58, 1
  br i1 %59, label %60, label %106

60:                                               ; preds = %54
  %61 = load ptr, ptr %5, align 8
  %62 = getelementptr inbounds i8, ptr %61, i64 1
  %63 = load i8, ptr %62, align 1
  %64 = sext i8 %63 to i32
  %65 = icmp eq i32 %64, 46
  br i1 %65, label %66, label %105

66:                                               ; preds = %60
  store ptr getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 1), ptr %8, align 8
  br label %67

67:                                               ; preds = %101, %66
  %68 = load ptr, ptr %8, align 8
  %69 = icmp ult ptr %68, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %69, label %70, label %104

70:                                               ; preds = %67
  %71 = load ptr, ptr %8, align 8
  %72 = getelementptr inbounds %struct.super_block, ptr %71, i32 0, i32 10
  %73 = load i16, ptr %72, align 8
  %74 = zext i16 %73 to i32
  %75 = load ptr, ptr %6, align 8
  %76 = getelementptr inbounds %struct.inode, ptr %75, i32 0, i32 9
  %77 = load i16, ptr %76, align 8
  %78 = zext i16 %77 to i32
  %79 = icmp eq i32 %74, %78
  br i1 %79, label %80, label %100

80:                                               ; preds = %70
  %81 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %81)
  %82 = load ptr, ptr %8, align 8
  %83 = getelementptr inbounds %struct.super_block, ptr %82, i32 0, i32 12
  %84 = load ptr, ptr %83, align 8
  %85 = getelementptr inbounds %struct.inode, ptr %84, i32 0, i32 9
  %86 = load i16, ptr %85, align 8
  store i16 %86, ptr %10, align 2
  %87 = load i16, ptr %10, align 2
  %88 = zext i16 %87 to i32
  %89 = load ptr, ptr %8, align 8
  %90 = getelementptr inbounds %struct.super_block, ptr %89, i32 0, i32 12
  %91 = load ptr, ptr %90, align 8
  %92 = getelementptr inbounds %struct.inode, ptr %91, i32 0, i32 10
  %93 = load i16, ptr %92, align 2
  %94 = zext i16 %93 to i32
  %95 = call ptr (i32, i32, ...) @get_inode(i32 noundef %88, i32 noundef %94)
  store ptr %95, ptr %7, align 8
  %96 = load ptr, ptr %7, align 8
  %97 = load ptr, ptr %5, align 8
  %98 = call ptr @advance(ptr noundef %96, ptr noundef %97)
  store ptr %98, ptr %6, align 8
  %99 = load ptr, ptr %7, align 8
  call void (ptr, ...) @put_inode(ptr noundef %99)
  br label %104

100:                                              ; preds = %70
  br label %101

101:                                              ; preds = %100
  %102 = load ptr, ptr %8, align 8
  %103 = getelementptr inbounds %struct.super_block, ptr %102, i32 1
  store ptr %103, ptr %8, align 8
  br label %67

104:                                              ; preds = %80, %67
  br label %105

105:                                              ; preds = %104, %60
  br label %106

106:                                              ; preds = %105, %54
  br label %107

107:                                              ; preds = %106, %48
  %108 = load ptr, ptr %6, align 8
  %109 = icmp eq ptr %108, null
  br i1 %109, label %110, label %111

110:                                              ; preds = %107
  store ptr null, ptr %3, align 8
  br label %147

111:                                              ; preds = %107
  br label %112

112:                                              ; preds = %144, %111
  %113 = load ptr, ptr %6, align 8
  %114 = icmp ne ptr %113, null
  br i1 %114, label %115, label %121

115:                                              ; preds = %112
  %116 = load ptr, ptr %6, align 8
  %117 = getelementptr inbounds %struct.inode, ptr %116, i32 0, i32 14
  %118 = load i8, ptr %117, align 8
  %119 = sext i8 %118 to i32
  %120 = icmp eq i32 %119, 1
  br label %121

121:                                              ; preds = %115, %112
  %122 = phi i1 [ false, %112 ], [ %120, %115 ]
  br i1 %122, label %123, label %145

123:                                              ; preds = %121
  store ptr @super_block, ptr %8, align 8
  br label %124

124:                                              ; preds = %141, %123
  %125 = load ptr, ptr %8, align 8
  %126 = icmp ult ptr %125, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %126, label %127, label %144

127:                                              ; preds = %124
  %128 = load ptr, ptr %8, align 8
  %129 = getelementptr inbounds %struct.super_block, ptr %128, i32 0, i32 12
  %130 = load ptr, ptr %129, align 8
  %131 = load ptr, ptr %6, align 8
  %132 = icmp eq ptr %130, %131
  br i1 %132, label %133, label %140

133:                                              ; preds = %127
  %134 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %134)
  %135 = load ptr, ptr %8, align 8
  %136 = getelementptr inbounds %struct.super_block, ptr %135, i32 0, i32 10
  %137 = load i16, ptr %136, align 8
  %138 = zext i16 %137 to i32
  %139 = call ptr (i32, i32, ...) @get_inode(i32 noundef %138, i32 noundef 1)
  store ptr %139, ptr %6, align 8
  br label %144

140:                                              ; preds = %127
  br label %141

141:                                              ; preds = %140
  %142 = load ptr, ptr %8, align 8
  %143 = getelementptr inbounds %struct.super_block, ptr %142, i32 1
  store ptr %143, ptr %8, align 8
  br label %124

144:                                              ; preds = %133, %124
  br label %112

145:                                              ; preds = %121
  %146 = load ptr, ptr %6, align 8
  store ptr %146, ptr %3, align 8
  br label %147

147:                                              ; preds = %145, %110, %47, %36, %30, %17
  %148 = load ptr, ptr %3, align 8
  ret ptr %148
}

declare ptr @get_inode(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @search_dir(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i16, align 2
  %19 = alloca i64, align 8
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i16, align 2
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  %23 = load ptr, ptr %6, align 8
  %24 = getelementptr inbounds %struct.inode, ptr %23, i32 0, i32 0
  %25 = load i16, ptr %24, align 8
  %26 = zext i16 %25 to i32
  %27 = and i32 %26, 61440
  %28 = icmp ne i32 %27, 16384
  br i1 %28, label %29, label %30

29:                                               ; preds = %4
  store i32 -20, ptr %5, align 4
  br label %241

30:                                               ; preds = %4
  %31 = load i32, ptr %9, align 4
  %32 = icmp eq i32 %31, 0
  %33 = zext i1 %32 to i64
  %34 = select i1 %32, i32 1, i32 3
  %35 = trunc i32 %34 to i16
  store i16 %35, ptr %18, align 2
  %36 = load ptr, ptr %6, align 8
  %37 = load i16, ptr %18, align 2
  %38 = zext i16 %37 to i32
  %39 = call i32 (ptr, i32, i32, ...) @forbidden(ptr noundef %36, i32 noundef %38, i32 noundef 0)
  store i32 %39, ptr %13, align 4
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %43

41:                                               ; preds = %30
  %42 = load i32, ptr %13, align 4
  store i32 %42, ptr %5, align 4
  br label %241

43:                                               ; preds = %30
  %44 = load ptr, ptr %6, align 8
  %45 = getelementptr inbounds %struct.inode, ptr %44, i32 0, i32 2
  %46 = load i64, ptr %45, align 8
  %47 = udiv i64 %46, 16
  %48 = trunc i64 %47 to i32
  store i32 %48, ptr %21, align 4
  store i32 0, ptr %20, align 4
  store i32 0, ptr %14, align 4
  store i32 0, ptr %16, align 4
  %49 = load ptr, ptr %7, align 8
  %50 = load i8, ptr %49, align 1
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 0
  %53 = zext i1 %52 to i64
  %54 = select i1 %52, i32 1, i32 0
  store i32 %54, ptr %17, align 4
  store i64 0, ptr %19, align 8
  br label %55

55:                                               ; preds = %186, %43
  %56 = load i64, ptr %19, align 8
  %57 = load ptr, ptr %6, align 8
  %58 = getelementptr inbounds %struct.inode, ptr %57, i32 0, i32 2
  %59 = load i64, ptr %58, align 8
  %60 = icmp slt i64 %56, %59
  br i1 %60, label %61, label %189

61:                                               ; preds = %55
  %62 = load ptr, ptr %6, align 8
  %63 = load i64, ptr %19, align 8
  %64 = call zeroext i16 (ptr, i64, ...) @read_map(ptr noundef %62, i64 noundef %63)
  store i16 %64, ptr %22, align 2
  %65 = load ptr, ptr %6, align 8
  %66 = getelementptr inbounds %struct.inode, ptr %65, i32 0, i32 9
  %67 = load i16, ptr %66, align 8
  %68 = zext i16 %67 to i32
  %69 = load i16, ptr %22, align 2
  %70 = zext i16 %69 to i32
  %71 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %68, i32 noundef %70, i32 noundef 0)
  store ptr %71, ptr %11, align 8
  %72 = load ptr, ptr %11, align 8
  %73 = getelementptr inbounds %struct.buf, ptr %72, i32 0, i32 0
  %74 = getelementptr inbounds [64 x %struct.dir_struct], ptr %73, i64 0, i64 0
  store ptr %74, ptr %10, align 8
  br label %75

75:                                               ; preds = %177, %61
  %76 = load ptr, ptr %10, align 8
  %77 = load ptr, ptr %11, align 8
  %78 = getelementptr inbounds %struct.buf, ptr %77, i32 0, i32 0
  %79 = getelementptr inbounds [64 x %struct.dir_struct], ptr %78, i64 0, i64 64
  %80 = icmp ult ptr %76, %79
  br i1 %80, label %81, label %180

81:                                               ; preds = %75
  %82 = load i32, ptr %20, align 4
  %83 = add i32 %82, 1
  store i32 %83, ptr %20, align 4
  %84 = load i32, ptr %21, align 4
  %85 = icmp ugt i32 %83, %84
  br i1 %85, label %86, label %91

86:                                               ; preds = %81
  %87 = load i32, ptr %9, align 4
  %88 = icmp eq i32 %87, 1
  br i1 %88, label %89, label %90

89:                                               ; preds = %86
  store i32 1, ptr %14, align 4
  br label %90

90:                                               ; preds = %89, %86
  br label %180

91:                                               ; preds = %81
  %92 = load i32, ptr %9, align 4
  %93 = icmp ne i32 %92, 1
  br i1 %93, label %94, label %127

94:                                               ; preds = %91
  %95 = load ptr, ptr %10, align 8
  %96 = getelementptr inbounds %struct.dir_struct, ptr %95, i32 0, i32 0
  %97 = load i16, ptr %96, align 2
  %98 = zext i16 %97 to i32
  %99 = icmp ne i32 %98, 0
  br i1 %99, label %100, label %127

100:                                              ; preds = %94
  %101 = load i32, ptr %17, align 4
  %102 = icmp ne i32 %101, 0
  br i1 %102, label %103, label %117

103:                                              ; preds = %100
  %104 = load ptr, ptr %10, align 8
  %105 = getelementptr inbounds %struct.dir_struct, ptr %104, i32 0, i32 1
  %106 = getelementptr inbounds [14 x i8], ptr %105, i64 0, i64 0
  %107 = call i32 @strcmp(ptr noundef %106, ptr noundef @.str) #3
  %108 = icmp ne i32 %107, 0
  br i1 %108, label %109, label %116

109:                                              ; preds = %103
  %110 = load ptr, ptr %10, align 8
  %111 = getelementptr inbounds %struct.dir_struct, ptr %110, i32 0, i32 1
  %112 = getelementptr inbounds [14 x i8], ptr %111, i64 0, i64 0
  %113 = call i32 @strcmp(ptr noundef %112, ptr noundef @.str.1) #3
  %114 = icmp ne i32 %113, 0
  br i1 %114, label %115, label %116

115:                                              ; preds = %109
  store i32 1, ptr %16, align 4
  br label %116

116:                                              ; preds = %115, %109, %103
  br label %126

117:                                              ; preds = %100
  %118 = load ptr, ptr %10, align 8
  %119 = getelementptr inbounds %struct.dir_struct, ptr %118, i32 0, i32 1
  %120 = getelementptr inbounds [14 x i8], ptr %119, i64 0, i64 0
  %121 = load ptr, ptr %7, align 8
  %122 = call i32 @strncmp(ptr noundef %120, ptr noundef %121, i32 noundef 14)
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %124, label %125

124:                                              ; preds = %117
  store i32 1, ptr %16, align 4
  br label %125

125:                                              ; preds = %124, %117
  br label %126

126:                                              ; preds = %125, %116
  br label %127

127:                                              ; preds = %126, %94, %91
  %128 = load i32, ptr %16, align 4
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %130, label %166

130:                                              ; preds = %127
  store i32 0, ptr %13, align 4
  %131 = load i32, ptr %9, align 4
  %132 = icmp eq i32 %131, 2
  br i1 %132, label %133, label %158

133:                                              ; preds = %130
  %134 = load ptr, ptr %6, align 8
  %135 = getelementptr inbounds %struct.inode, ptr %134, i32 0, i32 9
  %136 = load i16, ptr %135, align 8
  %137 = zext i16 %136 to i32
  %138 = load ptr, ptr %10, align 8
  %139 = getelementptr inbounds %struct.dir_struct, ptr %138, i32 0, i32 0
  %140 = load i16, ptr %139, align 2
  %141 = zext i16 %140 to i32
  %142 = call ptr (i32, i32, ...) @get_inode(i32 noundef %137, i32 noundef %141)
  store ptr %142, ptr %12, align 8
  store i32 12, ptr %15, align 4
  %143 = load ptr, ptr %10, align 8
  %144 = getelementptr inbounds %struct.dir_struct, ptr %143, i32 0, i32 0
  %145 = load i16, ptr %144, align 2
  %146 = load ptr, ptr %10, align 8
  %147 = getelementptr inbounds %struct.dir_struct, ptr %146, i32 0, i32 1
  %148 = load i32, ptr %15, align 4
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds [14 x i8], ptr %147, i64 0, i64 %149
  store i16 %145, ptr %150, align 1
  %151 = load ptr, ptr %10, align 8
  %152 = getelementptr inbounds %struct.dir_struct, ptr %151, i32 0, i32 0
  store i16 0, ptr %152, align 2
  %153 = load ptr, ptr %11, align 8
  %154 = getelementptr inbounds %struct.buf, ptr %153, i32 0, i32 6
  store i8 1, ptr %154, align 4
  %155 = load ptr, ptr %6, align 8
  %156 = getelementptr inbounds %struct.inode, ptr %155, i32 0, i32 16
  store i8 8, ptr %156, align 2
  %157 = load ptr, ptr %12, align 8
  call void (ptr, ...) @put_inode(ptr noundef %157)
  br label %163

158:                                              ; preds = %130
  %159 = load ptr, ptr %10, align 8
  %160 = getelementptr inbounds %struct.dir_struct, ptr %159, i32 0, i32 0
  %161 = load i16, ptr %160, align 2
  %162 = load ptr, ptr %8, align 8
  store i16 %161, ptr %162, align 2
  br label %163

163:                                              ; preds = %158, %133
  %164 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %164, i32 noundef 1)
  %165 = load i32, ptr %13, align 4
  store i32 %165, ptr %5, align 4
  br label %241

166:                                              ; preds = %127
  %167 = load i32, ptr %9, align 4
  %168 = icmp eq i32 %167, 1
  br i1 %168, label %169, label %176

169:                                              ; preds = %166
  %170 = load ptr, ptr %10, align 8
  %171 = getelementptr inbounds %struct.dir_struct, ptr %170, i32 0, i32 0
  %172 = load i16, ptr %171, align 2
  %173 = zext i16 %172 to i32
  %174 = icmp eq i32 %173, 0
  br i1 %174, label %175, label %176

175:                                              ; preds = %169
  store i32 1, ptr %14, align 4
  br label %180

176:                                              ; preds = %169, %166
  br label %177

177:                                              ; preds = %176
  %178 = load ptr, ptr %10, align 8
  %179 = getelementptr inbounds %struct.dir_struct, ptr %178, i32 1
  store ptr %179, ptr %10, align 8
  br label %75

180:                                              ; preds = %175, %90, %75
  %181 = load i32, ptr %14, align 4
  %182 = icmp ne i32 %181, 0
  br i1 %182, label %183, label %184

183:                                              ; preds = %180
  br label %189

184:                                              ; preds = %180
  %185 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %185, i32 noundef 1)
  br label %186

186:                                              ; preds = %184
  %187 = load i64, ptr %19, align 8
  %188 = add nsw i64 %187, 1024
  store i64 %188, ptr %19, align 8
  br label %55

189:                                              ; preds = %183, %55
  %190 = load i32, ptr %9, align 4
  %191 = icmp ne i32 %190, 1
  br i1 %191, label %192, label %193

192:                                              ; preds = %189
  store i32 -2, ptr %5, align 4
  br label %241

193:                                              ; preds = %189
  %194 = load i32, ptr %14, align 4
  %195 = icmp eq i32 %194, 0
  br i1 %195, label %196, label %215

196:                                              ; preds = %193
  %197 = load i32, ptr %20, align 4
  %198 = add i32 %197, 1
  store i32 %198, ptr %20, align 4
  %199 = load i32, ptr %20, align 4
  %200 = icmp eq i32 %199, 0
  br i1 %200, label %201, label %202

201:                                              ; preds = %196
  store i32 -27, ptr %5, align 4
  br label %241

202:                                              ; preds = %196
  %203 = load ptr, ptr %6, align 8
  %204 = load ptr, ptr %6, align 8
  %205 = getelementptr inbounds %struct.inode, ptr %204, i32 0, i32 2
  %206 = load i64, ptr %205, align 8
  %207 = call ptr (ptr, i64, ...) @new_block(ptr noundef %203, i64 noundef %206)
  store ptr %207, ptr %11, align 8
  %208 = icmp eq ptr %207, null
  br i1 %208, label %209, label %211

209:                                              ; preds = %202
  %210 = load i32, ptr @err_code, align 4
  store i32 %210, ptr %5, align 4
  br label %241

211:                                              ; preds = %202
  %212 = load ptr, ptr %11, align 8
  %213 = getelementptr inbounds %struct.buf, ptr %212, i32 0, i32 0
  %214 = getelementptr inbounds [64 x %struct.dir_struct], ptr %213, i64 0, i64 0
  store ptr %214, ptr %10, align 8
  br label %215

215:                                              ; preds = %211, %193
  %216 = load ptr, ptr %10, align 8
  %217 = getelementptr inbounds %struct.dir_struct, ptr %216, i32 0, i32 1
  %218 = getelementptr inbounds [14 x i8], ptr %217, i64 0, i64 0
  %219 = load ptr, ptr %7, align 8
  call void (ptr, ptr, i32, ...) @copy(ptr noundef %218, ptr noundef %219, i32 noundef 14)
  %220 = load ptr, ptr %8, align 8
  %221 = load i16, ptr %220, align 2
  %222 = load ptr, ptr %10, align 8
  %223 = getelementptr inbounds %struct.dir_struct, ptr %222, i32 0, i32 0
  store i16 %221, ptr %223, align 2
  %224 = load ptr, ptr %11, align 8
  %225 = getelementptr inbounds %struct.buf, ptr %224, i32 0, i32 6
  store i8 1, ptr %225, align 4
  %226 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %226, i32 noundef 1)
  %227 = load ptr, ptr %6, align 8
  %228 = getelementptr inbounds %struct.inode, ptr %227, i32 0, i32 16
  store i8 8, ptr %228, align 2
  %229 = load ptr, ptr %6, align 8
  %230 = getelementptr inbounds %struct.inode, ptr %229, i32 0, i32 12
  store i8 1, ptr %230, align 2
  %231 = load i32, ptr %20, align 4
  %232 = load i32, ptr %21, align 4
  %233 = icmp ugt i32 %231, %232
  br i1 %233, label %234, label %240

234:                                              ; preds = %215
  %235 = load i32, ptr %20, align 4
  %236 = zext i32 %235 to i64
  %237 = mul i64 %236, 16
  %238 = load ptr, ptr %6, align 8
  %239 = getelementptr inbounds %struct.inode, ptr %238, i32 0, i32 2
  store i64 %237, ptr %239, align 8
  br label %240

240:                                              ; preds = %234, %215
  store i32 0, ptr %5, align 4
  br label %241

241:                                              ; preds = %240, %209, %201, %192, %163, %41, %29
  %242 = load i32, ptr %5, align 4
  ret i32 %242
}

declare i32 @forbidden(...) #1

declare zeroext i16 @read_map(...) #1

declare ptr @get_block(...) #1

; Function Attrs: nounwind
declare i32 @strcmp(ptr noundef, ptr noundef) #2

declare i32 @strncmp(ptr noundef, ptr noundef, i32 noundef) #1

declare void @put_block(...) #1

declare ptr @new_block(...) #1

declare void @copy(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @get_name(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %9 = load ptr, ptr %5, align 8
  store ptr %9, ptr %7, align 8
  %10 = load ptr, ptr %4, align 8
  store ptr %10, ptr %8, align 8
  br label %11

11:                                               ; preds = %16, %2
  %12 = load ptr, ptr %8, align 8
  %13 = load i8, ptr %12, align 1
  %14 = sext i8 %13 to i32
  store i32 %14, ptr %6, align 4
  %15 = icmp eq i32 %14, 47
  br i1 %15, label %16, label %19

16:                                               ; preds = %11
  %17 = load ptr, ptr %8, align 8
  %18 = getelementptr inbounds i8, ptr %17, i32 1
  store ptr %18, ptr %8, align 8
  br label %11

19:                                               ; preds = %11
  br label %20

20:                                               ; preds = %43, %19
  %21 = load ptr, ptr %8, align 8
  %22 = load ptr, ptr %4, align 8
  %23 = getelementptr inbounds i8, ptr %22, i64 255
  %24 = icmp ult ptr %21, %23
  br i1 %24, label %25, label %31

25:                                               ; preds = %20
  %26 = load i32, ptr %6, align 4
  %27 = icmp ne i32 %26, 47
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load i32, ptr %6, align 4
  %30 = icmp ne i32 %29, 0
  br label %31

31:                                               ; preds = %28, %25, %20
  %32 = phi i1 [ false, %25 ], [ false, %20 ], [ %30, %28 ]
  br i1 %32, label %33, label %48

33:                                               ; preds = %31
  %34 = load ptr, ptr %7, align 8
  %35 = load ptr, ptr %5, align 8
  %36 = getelementptr inbounds i8, ptr %35, i64 14
  %37 = icmp ult ptr %34, %36
  br i1 %37, label %38, label %43

38:                                               ; preds = %33
  %39 = load i32, ptr %6, align 4
  %40 = trunc i32 %39 to i8
  %41 = load ptr, ptr %7, align 8
  %42 = getelementptr inbounds i8, ptr %41, i32 1
  store ptr %42, ptr %7, align 8
  store i8 %40, ptr %41, align 1
  br label %43

43:                                               ; preds = %38, %33
  %44 = load ptr, ptr %8, align 8
  %45 = getelementptr inbounds i8, ptr %44, i32 1
  store ptr %45, ptr %8, align 8
  %46 = load i8, ptr %45, align 1
  %47 = sext i8 %46 to i32
  store i32 %47, ptr %6, align 4
  br label %20

48:                                               ; preds = %31
  br label %49

49:                                               ; preds = %59, %48
  %50 = load i32, ptr %6, align 4
  %51 = icmp eq i32 %50, 47
  br i1 %51, label %52, label %57

52:                                               ; preds = %49
  %53 = load ptr, ptr %8, align 8
  %54 = load ptr, ptr %4, align 8
  %55 = getelementptr inbounds i8, ptr %54, i64 255
  %56 = icmp ult ptr %53, %55
  br label %57

57:                                               ; preds = %52, %49
  %58 = phi i1 [ false, %49 ], [ %56, %52 ]
  br i1 %58, label %59, label %64

59:                                               ; preds = %57
  %60 = load ptr, ptr %8, align 8
  %61 = getelementptr inbounds i8, ptr %60, i32 1
  store ptr %61, ptr %8, align 8
  %62 = load i8, ptr %61, align 1
  %63 = sext i8 %62 to i32
  store i32 %63, ptr %6, align 4
  br label %49

64:                                               ; preds = %57
  br label %65

65:                                               ; preds = %70, %64
  %66 = load ptr, ptr %7, align 8
  %67 = load ptr, ptr %5, align 8
  %68 = getelementptr inbounds i8, ptr %67, i64 14
  %69 = icmp ult ptr %66, %68
  br i1 %69, label %70, label %73

70:                                               ; preds = %65
  %71 = load ptr, ptr %7, align 8
  %72 = getelementptr inbounds i8, ptr %71, i32 1
  store ptr %72, ptr %7, align 8
  store i8 0, ptr %71, align 1
  br label %65

73:                                               ; preds = %65
  %74 = load ptr, ptr %8, align 8
  %75 = load ptr, ptr %4, align 8
  %76 = getelementptr inbounds i8, ptr %75, i64 255
  %77 = icmp uge ptr %74, %76
  br i1 %77, label %78, label %79

78:                                               ; preds = %73
  store i32 -36, ptr @err_code, align 4
  store ptr null, ptr %3, align 8
  br label %81

79:                                               ; preds = %73
  %80 = load ptr, ptr %8, align 8
  store ptr %80, ptr %3, align 8
  br label %81

81:                                               ; preds = %79, %78
  %82 = load ptr, ptr %3, align 8
  ret ptr %82
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (https://github.com/swiftlang/llvm-project.git 901f89886dcd5d1eaf07c8504d58c90f37b0cfdf)"}
