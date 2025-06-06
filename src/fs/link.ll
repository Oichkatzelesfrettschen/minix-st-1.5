; NOTE: Generated from src/fs/link.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/link.c'
source_filename = "src/fs/link.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.fproc = type { i16, ptr, ptr, [20 x ptr], i16, i16, i8, i8, i16, i32, ptr, i32, i8, i8, i8, i32, i32 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }
%struct.buf = type { %union.anon.0, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon.0 = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }

@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16
@super_user = external global i32, align 4
@fs_call = external global i32, align 4
@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"..\00", align 1
@fproc = external global [32 x %struct.fproc], align 16
@fp = external global ptr, align 8
@dot2 = internal global [14 x i8] c"..\00\00\00\00\00\00\00\00\00\00\00\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_link() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca [14 x i8], align 1
  %6 = alloca ptr, align 8
  %7 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %8 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %9 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %7, i32 noundef %8, i32 noundef 1)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %0
  %12 = load i32, ptr @err_code, align 4
  store i32 %12, ptr %1, align 4
  br label %116

13:                                               ; preds = %0
  %14 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %14, ptr %3, align 8
  %15 = icmp eq ptr %14, null
  br i1 %15, label %16, label %18

16:                                               ; preds = %13
  %17 = load i32, ptr @err_code, align 4
  store i32 %17, ptr %1, align 4
  br label %116

18:                                               ; preds = %13
  store i32 0, ptr %4, align 4
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.inode, ptr %19, i32 0, i32 5
  %21 = load i8, ptr %20, align 1
  %22 = zext i8 %21 to i32
  %23 = and i32 %22, 255
  %24 = icmp eq i32 %23, 127
  br i1 %24, label %25, label %26

25:                                               ; preds = %18
  store i32 -31, ptr %4, align 4
  br label %26

26:                                               ; preds = %25, %18
  %27 = load i32, ptr %4, align 4
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %41

29:                                               ; preds = %26
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.inode, ptr %30, i32 0, i32 0
  %32 = load i16, ptr %31, align 8
  %33 = zext i16 %32 to i32
  %34 = and i32 %33, 61440
  %35 = icmp eq i32 %34, 16384
  br i1 %35, label %36, label %40

36:                                               ; preds = %29
  %37 = load i32, ptr @super_user, align 4
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %40, label %39

39:                                               ; preds = %36
  store i32 -1, ptr %4, align 4
  br label %40

40:                                               ; preds = %39, %36, %29
  br label %41

41:                                               ; preds = %40, %26
  %42 = load i32, ptr %4, align 4
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %44, label %47

44:                                               ; preds = %41
  %45 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %45)
  %46 = load i32, ptr %4, align 4
  store i32 %46, ptr %1, align 4
  br label %116

47:                                               ; preds = %41
  %48 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %49 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %50 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %48, i32 noundef %49, i32 noundef 1)
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %55

52:                                               ; preds = %47
  %53 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %53)
  %54 = load i32, ptr @err_code, align 4
  store i32 %54, ptr %1, align 4
  br label %116

55:                                               ; preds = %47
  %56 = getelementptr inbounds [14 x i8], ptr %5, i64 0, i64 0
  %57 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef @user_path, ptr noundef %56)
  store ptr %57, ptr %2, align 8
  %58 = icmp eq ptr %57, null
  br i1 %58, label %59, label %61

59:                                               ; preds = %55
  %60 = load i32, ptr @err_code, align 4
  store i32 %60, ptr %4, align 4
  br label %61

61:                                               ; preds = %59, %55
  %62 = load i32, ptr %4, align 4
  %63 = icmp eq i32 %62, 0
  br i1 %63, label %64, label %78

64:                                               ; preds = %61
  %65 = load ptr, ptr %2, align 8
  %66 = getelementptr inbounds [14 x i8], ptr %5, i64 0, i64 0
  %67 = call ptr (ptr, ptr, ...) @advance(ptr noundef %65, ptr noundef %66)
  store ptr %67, ptr %6, align 8
  %68 = icmp eq ptr %67, null
  br i1 %68, label %69, label %75

69:                                               ; preds = %64
  %70 = load i32, ptr @err_code, align 4
  store i32 %70, ptr %4, align 4
  %71 = load i32, ptr %4, align 4
  %72 = icmp eq i32 %71, -2
  br i1 %72, label %73, label %74

73:                                               ; preds = %69
  store i32 0, ptr %4, align 4
  br label %74

74:                                               ; preds = %73, %69
  br label %77

75:                                               ; preds = %64
  %76 = load ptr, ptr %6, align 8
  call void (ptr, ...) @put_inode(ptr noundef %76)
  store i32 -17, ptr %4, align 4
  br label %77

77:                                               ; preds = %75, %74
  br label %78

78:                                               ; preds = %77, %61
  %79 = load i32, ptr %4, align 4
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %81, label %93

81:                                               ; preds = %78
  %82 = load ptr, ptr %3, align 8
  %83 = getelementptr inbounds %struct.inode, ptr %82, i32 0, i32 9
  %84 = load i16, ptr %83, align 8
  %85 = zext i16 %84 to i32
  %86 = load ptr, ptr %2, align 8
  %87 = getelementptr inbounds %struct.inode, ptr %86, i32 0, i32 9
  %88 = load i16, ptr %87, align 8
  %89 = zext i16 %88 to i32
  %90 = icmp ne i32 %85, %89
  br i1 %90, label %91, label %92

91:                                               ; preds = %81
  store i32 -18, ptr %4, align 4
  br label %92

92:                                               ; preds = %91, %81
  br label %93

93:                                               ; preds = %92, %78
  %94 = load i32, ptr %4, align 4
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %96, label %102

96:                                               ; preds = %93
  %97 = load ptr, ptr %2, align 8
  %98 = getelementptr inbounds [14 x i8], ptr %5, i64 0, i64 0
  %99 = load ptr, ptr %3, align 8
  %100 = getelementptr inbounds %struct.inode, ptr %99, i32 0, i32 10
  %101 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %97, ptr noundef %98, ptr noundef %100, i32 noundef 1)
  store i32 %101, ptr %4, align 4
  br label %102

102:                                              ; preds = %96, %93
  %103 = load i32, ptr %4, align 4
  %104 = icmp eq i32 %103, 0
  br i1 %104, label %105, label %112

105:                                              ; preds = %102
  %106 = load ptr, ptr %3, align 8
  %107 = getelementptr inbounds %struct.inode, ptr %106, i32 0, i32 5
  %108 = load i8, ptr %107, align 1
  %109 = add i8 %108, 1
  store i8 %109, ptr %107, align 1
  %110 = load ptr, ptr %3, align 8
  %111 = getelementptr inbounds %struct.inode, ptr %110, i32 0, i32 12
  store i8 1, ptr %111, align 2
  br label %112

112:                                              ; preds = %105, %102
  %113 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %113)
  %114 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %114)
  %115 = load i32, ptr %4, align 4
  store i32 %115, ptr %1, align 4
  br label %116

116:                                              ; preds = %112, %52, %44, %16, %11
  %117 = load i32, ptr %1, align 4
  ret i32 %117
}

declare i32 @fetch_name(...) #1

declare ptr @eat_path(...) #1

declare void @put_inode(...) #1

declare ptr @last_dir(...) #1

declare ptr @advance(...) #1

declare i32 @search_dir(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_unlink() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i16, align 2
  %10 = alloca [14 x i8], align 1
  %11 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %12 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %13 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %11, i32 noundef %12, i32 noundef 3)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %0
  %16 = load i32, ptr @err_code, align 4
  store i32 %16, ptr %1, align 4
  br label %184

17:                                               ; preds = %0
  %18 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %19 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef @user_path, ptr noundef %18)
  store ptr %19, ptr %3, align 8
  %20 = icmp eq ptr %19, null
  br i1 %20, label %21, label %23

21:                                               ; preds = %17
  %22 = load i32, ptr @err_code, align 4
  store i32 %22, ptr %1, align 4
  br label %184

23:                                               ; preds = %17
  store i32 0, ptr %5, align 4
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %26 = call ptr (ptr, ptr, ...) @advance(ptr noundef %24, ptr noundef %25)
  store ptr %26, ptr %2, align 8
  %27 = icmp eq ptr %26, null
  br i1 %27, label %28, label %30

28:                                               ; preds = %23
  %29 = load i32, ptr @err_code, align 4
  store i32 %29, ptr %5, align 4
  br label %30

30:                                               ; preds = %28, %23
  %31 = load i32, ptr %5, align 4
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %36

33:                                               ; preds = %30
  %34 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %34)
  %35 = load i32, ptr %5, align 4
  store i32 %35, ptr %1, align 4
  br label %184

36:                                               ; preds = %30
  %37 = load ptr, ptr %2, align 8
  %38 = getelementptr inbounds %struct.inode, ptr %37, i32 0, i32 0
  %39 = load i16, ptr %38, align 8
  store i16 %39, ptr %8, align 2
  %40 = load ptr, ptr %2, align 8
  %41 = getelementptr inbounds %struct.inode, ptr %40, i32 0, i32 1
  %42 = load i16, ptr %41, align 2
  store i16 %42, ptr %9, align 2
  %43 = load i32, ptr @fs_call, align 4
  %44 = icmp eq i32 %43, 10
  br i1 %44, label %45, label %64

45:                                               ; preds = %36
  %46 = load ptr, ptr %2, align 8
  %47 = getelementptr inbounds %struct.inode, ptr %46, i32 0, i32 0
  %48 = load i16, ptr %47, align 8
  %49 = zext i16 %48 to i32
  %50 = and i32 %49, 61440
  %51 = icmp eq i32 %50, 16384
  br i1 %51, label %52, label %56

52:                                               ; preds = %45
  %53 = load i32, ptr @super_user, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %56, label %55

55:                                               ; preds = %52
  store i32 -1, ptr %5, align 4
  br label %56

56:                                               ; preds = %55, %52, %45
  %57 = load i32, ptr %5, align 4
  %58 = icmp eq i32 %57, 0
  br i1 %58, label %59, label %63

59:                                               ; preds = %56
  %60 = load ptr, ptr %3, align 8
  %61 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %62 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %60, ptr noundef %61, ptr noundef null, i32 noundef 2)
  store i32 %62, ptr %5, align 4
  br label %63

63:                                               ; preds = %59, %56
  br label %167

64:                                               ; preds = %36
  %65 = load ptr, ptr %2, align 8
  %66 = getelementptr inbounds %struct.inode, ptr %65, i32 0, i32 0
  %67 = load i16, ptr %66, align 8
  %68 = zext i16 %67 to i32
  %69 = and i32 %68, 61440
  %70 = icmp ne i32 %69, 16384
  br i1 %70, label %71, label %72

71:                                               ; preds = %64
  store i32 -20, ptr %5, align 4
  br label %72

72:                                               ; preds = %71, %64
  %73 = load ptr, ptr %2, align 8
  %74 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %73, ptr noundef @.str, ptr noundef %7, i32 noundef 0)
  %75 = icmp eq i32 %74, 0
  br i1 %75, label %76, label %77

76:                                               ; preds = %72
  store i32 -39, ptr %5, align 4
  br label %77

77:                                               ; preds = %76, %72
  %78 = call i32 @strcmp(ptr noundef @user_path, ptr noundef @.str.1) #3
  %79 = icmp eq i32 %78, 0
  br i1 %79, label %80, label %81

80:                                               ; preds = %77
  store i32 -1, ptr %5, align 4
  br label %81

81:                                               ; preds = %80, %77
  %82 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %83 = call i32 @strcmp(ptr noundef %82, ptr noundef @.str.2) #3
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %89, label %85

85:                                               ; preds = %81
  %86 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %87 = call i32 @strcmp(ptr noundef %86, ptr noundef @.str.3) #3
  %88 = icmp eq i32 %87, 0
  br i1 %88, label %89, label %90

89:                                               ; preds = %85, %81
  store i32 -1, ptr %5, align 4
  br label %90

90:                                               ; preds = %89, %85
  store ptr getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 3), ptr %4, align 8
  br label %91

91:                                               ; preds = %108, %90
  %92 = load ptr, ptr %4, align 8
  %93 = icmp ult ptr %92, getelementptr inbounds ([32 x %struct.fproc], ptr @fproc, i64 0, i64 32)
  br i1 %93, label %94, label %111

94:                                               ; preds = %91
  %95 = load ptr, ptr %4, align 8
  %96 = getelementptr inbounds %struct.fproc, ptr %95, i32 0, i32 1
  %97 = load ptr, ptr %96, align 8
  %98 = load ptr, ptr %2, align 8
  %99 = icmp eq ptr %97, %98
  br i1 %99, label %106, label %100

100:                                              ; preds = %94
  %101 = load ptr, ptr %4, align 8
  %102 = getelementptr inbounds %struct.fproc, ptr %101, i32 0, i32 2
  %103 = load ptr, ptr %102, align 8
  %104 = load ptr, ptr %2, align 8
  %105 = icmp eq ptr %103, %104
  br i1 %105, label %106, label %107

106:                                              ; preds = %100, %94
  store i32 -16, ptr %5, align 4
  br label %111

107:                                              ; preds = %100
  br label %108

108:                                              ; preds = %107
  %109 = load ptr, ptr %4, align 8
  %110 = getelementptr inbounds %struct.fproc, ptr %109, i32 1
  store ptr %110, ptr %4, align 8
  br label %91

111:                                              ; preds = %106, %91
  %112 = load i32, ptr %5, align 4
  %113 = icmp eq i32 %112, 0
  br i1 %113, label %114, label %118

114:                                              ; preds = %111
  %115 = load ptr, ptr %3, align 8
  %116 = getelementptr inbounds [14 x i8], ptr %10, i64 0, i64 0
  %117 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %115, ptr noundef %116, ptr noundef null, i32 noundef 2)
  store i32 %117, ptr %5, align 4
  br label %118

118:                                              ; preds = %114, %111
  %119 = load i32, ptr %5, align 4
  %120 = icmp eq i32 %119, 0
  br i1 %120, label %121, label %166

121:                                              ; preds = %118
  %122 = load ptr, ptr %2, align 8
  %123 = getelementptr inbounds %struct.inode, ptr %122, i32 0, i32 0
  %124 = load i16, ptr %123, align 8
  %125 = zext i16 %124 to i32
  %126 = or i32 %125, 448
  %127 = trunc i32 %126 to i16
  store i16 %127, ptr %123, align 8
  %128 = load ptr, ptr @fp, align 8
  %129 = getelementptr inbounds %struct.fproc, ptr %128, i32 0, i32 5
  %130 = load i16, ptr %129, align 2
  %131 = load ptr, ptr %2, align 8
  %132 = getelementptr inbounds %struct.inode, ptr %131, i32 0, i32 1
  store i16 %130, ptr %132, align 2
  %133 = load ptr, ptr %2, align 8
  %134 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %133, ptr noundef @.str.2, ptr noundef null, i32 noundef 2)
  store i32 %134, ptr %5, align 4
  %135 = icmp eq i32 %134, 0
  br i1 %135, label %136, label %141

136:                                              ; preds = %121
  %137 = load ptr, ptr %2, align 8
  %138 = getelementptr inbounds %struct.inode, ptr %137, i32 0, i32 5
  %139 = load i8, ptr %138, align 1
  %140 = add i8 %139, -1
  store i8 %140, ptr %138, align 1
  br label %141

141:                                              ; preds = %136, %121
  %142 = load ptr, ptr %2, align 8
  %143 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %142, ptr noundef @.str.3, ptr noundef null, i32 noundef 2)
  store i32 %143, ptr %6, align 4
  %144 = icmp eq i32 %143, 0
  br i1 %144, label %145, label %150

145:                                              ; preds = %141
  %146 = load ptr, ptr %3, align 8
  %147 = getelementptr inbounds %struct.inode, ptr %146, i32 0, i32 5
  %148 = load i8, ptr %147, align 1
  %149 = add i8 %148, -1
  store i8 %149, ptr %147, align 1
  br label %150

150:                                              ; preds = %145, %141
  %151 = load ptr, ptr %2, align 8
  %152 = getelementptr inbounds %struct.inode, ptr %151, i32 0, i32 12
  store i8 1, ptr %152, align 2
  %153 = load ptr, ptr %3, align 8
  %154 = getelementptr inbounds %struct.inode, ptr %153, i32 0, i32 12
  store i8 1, ptr %154, align 2
  %155 = load i32, ptr %6, align 4
  %156 = icmp ne i32 %155, 0
  br i1 %156, label %157, label %159

157:                                              ; preds = %150
  %158 = load i32, ptr %6, align 4
  store i32 %158, ptr %5, align 4
  br label %159

159:                                              ; preds = %157, %150
  %160 = load i16, ptr %8, align 2
  %161 = load ptr, ptr %2, align 8
  %162 = getelementptr inbounds %struct.inode, ptr %161, i32 0, i32 0
  store i16 %160, ptr %162, align 8
  %163 = load i16, ptr %9, align 2
  %164 = load ptr, ptr %2, align 8
  %165 = getelementptr inbounds %struct.inode, ptr %164, i32 0, i32 1
  store i16 %163, ptr %165, align 2
  br label %166

166:                                              ; preds = %159, %118
  br label %167

167:                                              ; preds = %166, %63
  %168 = load i32, ptr %5, align 4
  %169 = icmp eq i32 %168, 0
  br i1 %169, label %170, label %177

170:                                              ; preds = %167
  %171 = load ptr, ptr %2, align 8
  %172 = getelementptr inbounds %struct.inode, ptr %171, i32 0, i32 5
  %173 = load i8, ptr %172, align 1
  %174 = add i8 %173, -1
  store i8 %174, ptr %172, align 1
  %175 = load ptr, ptr %2, align 8
  %176 = getelementptr inbounds %struct.inode, ptr %175, i32 0, i32 12
  store i8 1, ptr %176, align 2
  br label %177

177:                                              ; preds = %170, %167
  %178 = load i16, ptr %8, align 2
  %179 = load ptr, ptr %2, align 8
  %180 = getelementptr inbounds %struct.inode, ptr %179, i32 0, i32 0
  store i16 %178, ptr %180, align 8
  %181 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %181)
  %182 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %182)
  %183 = load i32, ptr %5, align 4
  store i32 %183, ptr %1, align 4
  br label %184

184:                                              ; preds = %177, %33, %21, %15
  %185 = load i32, ptr %1, align 4
  ret i32 %185
}

; Function Attrs: nounwind
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_rename() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca [15 x i8], align 1
  %10 = alloca [15 x i8], align 1
  %11 = alloca [256 x i8], align 16
  %12 = alloca i16, align 2
  store i32 0, ptr %6, align 4
  %13 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %14 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %15 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %13, i32 noundef %14, i32 noundef 1)
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %0
  %18 = load i32, ptr @err_code, align 4
  store i32 %18, ptr %1, align 4
  br label %234

19:                                               ; preds = %0
  %20 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %21 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef @user_path, ptr noundef %20)
  store ptr %21, ptr %2, align 8
  %22 = icmp eq ptr %21, null
  br i1 %22, label %23, label %25

23:                                               ; preds = %19
  %24 = load i32, ptr @err_code, align 4
  store i32 %24, ptr %1, align 4
  br label %234

25:                                               ; preds = %19
  %26 = load ptr, ptr %2, align 8
  %27 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %28 = call ptr (ptr, ptr, ...) @advance(ptr noundef %26, ptr noundef %27)
  store ptr %28, ptr %3, align 8
  %29 = icmp eq ptr %28, null
  br i1 %29, label %30, label %32

30:                                               ; preds = %25
  %31 = load i32, ptr @err_code, align 4
  store i32 %31, ptr %6, align 4
  br label %32

32:                                               ; preds = %30, %25
  %33 = getelementptr inbounds [256 x i8], ptr %11, i64 0, i64 0
  %34 = call ptr @strcpy(ptr noundef %33, ptr noundef @user_path) #3
  %35 = getelementptr inbounds [15 x i8], ptr %10, i64 0, i64 0
  %36 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %37 = call ptr @strcpy(ptr noundef %35, ptr noundef %36) #3
  %38 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %39 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %40 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %38, i32 noundef %39, i32 noundef 1)
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %44

42:                                               ; preds = %32
  %43 = load i32, ptr @err_code, align 4
  store i32 %43, ptr %6, align 4
  br label %44

44:                                               ; preds = %42, %32
  %45 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %46 = call ptr (ptr, ptr, ...) @last_dir(ptr noundef @user_path, ptr noundef %45)
  store ptr %46, ptr %4, align 8
  %47 = icmp eq ptr %46, null
  br i1 %47, label %48, label %50

48:                                               ; preds = %44
  %49 = load i32, ptr @err_code, align 4
  store i32 %49, ptr %6, align 4
  br label %50

50:                                               ; preds = %48, %44
  %51 = load ptr, ptr %4, align 8
  %52 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %53 = call ptr (ptr, ptr, ...) @advance(ptr noundef %51, ptr noundef %52)
  store ptr %53, ptr %5, align 8
  %54 = load i32, ptr %6, align 4
  %55 = icmp eq i32 %54, 0
  br i1 %55, label %56, label %146

56:                                               ; preds = %50
  %57 = getelementptr inbounds [256 x i8], ptr %11, i64 0, i64 0
  %58 = getelementptr inbounds [256 x i8], ptr %11, i64 0, i64 0
  %59 = call i32 @strlen(ptr noundef %58)
  %60 = call i32 @strncmp(ptr noundef %57, ptr noundef @user_path, i32 noundef %59)
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %63

62:                                               ; preds = %56
  store i32 -22, ptr %6, align 4
  br label %63

63:                                               ; preds = %62, %56
  %64 = getelementptr inbounds [256 x i8], ptr %11, i64 0, i64 0
  %65 = call i32 @strcmp(ptr noundef %64, ptr noundef @.str.2) #3
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %71, label %67

67:                                               ; preds = %63
  %68 = getelementptr inbounds [256 x i8], ptr %11, i64 0, i64 0
  %69 = call i32 @strcmp(ptr noundef %68, ptr noundef @.str.3) #3
  %70 = icmp eq i32 %69, 0
  br i1 %70, label %71, label %72

71:                                               ; preds = %67, %63
  store i32 -22, ptr %6, align 4
  br label %72

72:                                               ; preds = %71, %67
  %73 = load ptr, ptr %2, align 8
  %74 = getelementptr inbounds %struct.inode, ptr %73, i32 0, i32 9
  %75 = load i16, ptr %74, align 8
  %76 = zext i16 %75 to i32
  %77 = load ptr, ptr %4, align 8
  %78 = getelementptr inbounds %struct.inode, ptr %77, i32 0, i32 9
  %79 = load i16, ptr %78, align 8
  %80 = zext i16 %79 to i32
  %81 = icmp ne i32 %76, %80
  br i1 %81, label %82, label %83

82:                                               ; preds = %72
  store i32 -18, ptr %6, align 4
  br label %83

83:                                               ; preds = %82, %72
  %84 = load ptr, ptr %2, align 8
  %85 = call i32 (ptr, i32, i32, ...) @forbidden(ptr noundef %84, i32 noundef 3, i32 noundef 0)
  %86 = icmp ne i32 %85, 0
  br i1 %86, label %87, label %88

87:                                               ; preds = %83
  store i32 -13, ptr %6, align 4
  br label %88

88:                                               ; preds = %87, %83
  %89 = load ptr, ptr %4, align 8
  %90 = call i32 (ptr, i32, i32, ...) @forbidden(ptr noundef %89, i32 noundef 3, i32 noundef 0)
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %92, label %93

92:                                               ; preds = %88
  store i32 -13, ptr %6, align 4
  br label %93

93:                                               ; preds = %92, %88
  %94 = load ptr, ptr %3, align 8
  %95 = getelementptr inbounds %struct.inode, ptr %94, i32 0, i32 0
  %96 = load i16, ptr %95, align 8
  %97 = zext i16 %96 to i32
  %98 = and i32 %97, 61440
  %99 = icmp eq i32 %98, 16384
  %100 = zext i1 %99 to i32
  store i32 %100, ptr %7, align 4
  %101 = load ptr, ptr %5, align 8
  %102 = icmp ne ptr %101, null
  br i1 %102, label %103, label %145

103:                                              ; preds = %93
  %104 = load ptr, ptr %5, align 8
  %105 = getelementptr inbounds %struct.inode, ptr %104, i32 0, i32 0
  %106 = load i16, ptr %105, align 8
  %107 = zext i16 %106 to i32
  %108 = and i32 %107, 61440
  %109 = icmp eq i32 %108, 16384
  %110 = zext i1 %109 to i32
  store i32 %110, ptr %8, align 4
  %111 = load i32, ptr %7, align 4
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %117

113:                                              ; preds = %103
  %114 = load i32, ptr %8, align 4
  %115 = icmp eq i32 %114, 0
  br i1 %115, label %116, label %117

116:                                              ; preds = %113
  store i32 -20, ptr %6, align 4
  br label %117

117:                                              ; preds = %116, %113, %103
  %118 = load i32, ptr %7, align 4
  %119 = icmp eq i32 %118, 0
  br i1 %119, label %120, label %124

120:                                              ; preds = %117
  %121 = load i32, ptr %8, align 4
  %122 = icmp eq i32 %121, 1
  br i1 %122, label %123, label %124

123:                                              ; preds = %120
  store i32 -21, ptr %6, align 4
  br label %124

124:                                              ; preds = %123, %120, %117
  %125 = load ptr, ptr %3, align 8
  %126 = getelementptr inbounds %struct.inode, ptr %125, i32 0, i32 10
  %127 = load i16, ptr %126, align 2
  %128 = zext i16 %127 to i32
  %129 = load ptr, ptr %5, align 8
  %130 = getelementptr inbounds %struct.inode, ptr %129, i32 0, i32 10
  %131 = load i16, ptr %130, align 2
  %132 = zext i16 %131 to i32
  %133 = icmp eq i32 %128, %132
  br i1 %133, label %134, label %135

134:                                              ; preds = %124
  store i32 1000, ptr %6, align 4
  br label %135

135:                                              ; preds = %134, %124
  %136 = load i32, ptr %8, align 4
  %137 = icmp eq i32 %136, 1
  br i1 %137, label %138, label %144

138:                                              ; preds = %135
  %139 = load ptr, ptr %5, align 8
  %140 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %139, ptr noundef @.str, ptr noundef %12, i32 noundef 0)
  %141 = icmp eq i32 %140, 0
  br i1 %141, label %142, label %143

142:                                              ; preds = %138
  store i32 -39, ptr %6, align 4
  br label %143

143:                                              ; preds = %142, %138
  br label %144

144:                                              ; preds = %143, %135
  br label %145

145:                                              ; preds = %144, %93
  br label %146

146:                                              ; preds = %145, %50
  %147 = load i32, ptr %6, align 4
  %148 = icmp eq i32 %147, 0
  br i1 %148, label %149, label %222

149:                                              ; preds = %146
  %150 = load ptr, ptr %3, align 8
  %151 = getelementptr inbounds %struct.inode, ptr %150, i32 0, i32 10
  %152 = load i16, ptr %151, align 2
  store i16 %152, ptr %12, align 2
  %153 = load ptr, ptr %5, align 8
  %154 = icmp eq ptr %153, null
  br i1 %154, label %155, label %172

155:                                              ; preds = %149
  %156 = load ptr, ptr %4, align 8
  %157 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %158 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %156, ptr noundef %157, ptr noundef %12, i32 noundef 1)
  store i32 %158, ptr %6, align 4
  %159 = load i32, ptr %6, align 4
  %160 = icmp eq i32 %159, 0
  br i1 %160, label %161, label %171

161:                                              ; preds = %155
  %162 = load i32, ptr %7, align 4
  %163 = icmp ne i32 %162, 0
  br i1 %163, label %164, label %171

164:                                              ; preds = %161
  %165 = load ptr, ptr %4, align 8
  %166 = getelementptr inbounds %struct.inode, ptr %165, i32 0, i32 5
  %167 = load i8, ptr %166, align 1
  %168 = add i8 %167, 1
  store i8 %168, ptr %166, align 1
  %169 = load ptr, ptr %4, align 8
  %170 = getelementptr inbounds %struct.inode, ptr %169, i32 0, i32 12
  store i8 1, ptr %170, align 2
  br label %171

171:                                              ; preds = %164, %161, %155
  br label %193

172:                                              ; preds = %149
  %173 = load ptr, ptr %4, align 8
  %174 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %175 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %173, ptr noundef %174, ptr noundef null, i32 noundef 2)
  %176 = load ptr, ptr %4, align 8
  %177 = getelementptr inbounds [15 x i8], ptr %9, i64 0, i64 0
  %178 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %176, ptr noundef %177, ptr noundef %12, i32 noundef 1)
  %179 = load ptr, ptr %5, align 8
  %180 = getelementptr inbounds %struct.inode, ptr %179, i32 0, i32 5
  %181 = load i8, ptr %180, align 1
  %182 = add i8 %181, -1
  store i8 %182, ptr %180, align 1
  %183 = load ptr, ptr %5, align 8
  %184 = getelementptr inbounds %struct.inode, ptr %183, i32 0, i32 12
  store i8 1, ptr %184, align 2
  %185 = load i32, ptr %7, align 4
  %186 = icmp ne i32 %185, 0
  br i1 %186, label %187, label %192

187:                                              ; preds = %172
  %188 = load ptr, ptr %5, align 8
  %189 = getelementptr inbounds %struct.inode, ptr %188, i32 0, i32 5
  %190 = load i8, ptr %189, align 1
  %191 = add i8 %190, -1
  store i8 %191, ptr %189, align 1
  br label %192

192:                                              ; preds = %187, %172
  br label %193

193:                                              ; preds = %192, %171
  %194 = load i32, ptr %6, align 4
  %195 = icmp eq i32 %194, 0
  br i1 %195, label %196, label %221

196:                                              ; preds = %193
  %197 = load i32, ptr %7, align 4
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %199, label %213

199:                                              ; preds = %196
  %200 = load ptr, ptr %2, align 8
  %201 = getelementptr inbounds %struct.inode, ptr %200, i32 0, i32 5
  %202 = load i8, ptr %201, align 1
  %203 = add i8 %202, -1
  store i8 %203, ptr %201, align 1
  %204 = load ptr, ptr %2, align 8
  %205 = getelementptr inbounds %struct.inode, ptr %204, i32 0, i32 12
  store i8 1, ptr %205, align 2
  %206 = load ptr, ptr %4, align 8
  %207 = getelementptr inbounds %struct.inode, ptr %206, i32 0, i32 10
  %208 = load i16, ptr %207, align 2
  store i16 %208, ptr %12, align 2
  %209 = load ptr, ptr %3, align 8
  %210 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %209, ptr noundef @.str.3, ptr noundef null, i32 noundef 2)
  %211 = load ptr, ptr %3, align 8
  %212 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %211, ptr noundef @dot2, ptr noundef %12, i32 noundef 1)
  br label %213

213:                                              ; preds = %199, %196
  %214 = load ptr, ptr %2, align 8
  %215 = getelementptr inbounds [15 x i8], ptr %10, i64 0, i64 0
  %216 = call i32 (ptr, ptr, ptr, i32, ...) @search_dir(ptr noundef %214, ptr noundef %215, ptr noundef null, i32 noundef 2)
  %217 = load ptr, ptr %2, align 8
  %218 = getelementptr inbounds %struct.inode, ptr %217, i32 0, i32 16
  store i8 12, ptr %218, align 2
  %219 = load ptr, ptr %4, align 8
  %220 = getelementptr inbounds %struct.inode, ptr %219, i32 0, i32 16
  store i8 12, ptr %220, align 2
  br label %221

221:                                              ; preds = %213, %193
  br label %222

222:                                              ; preds = %221, %146
  %223 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %223)
  %224 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %224)
  %225 = load ptr, ptr %4, align 8
  call void (ptr, ...) @put_inode(ptr noundef %225)
  %226 = load ptr, ptr %5, align 8
  call void (ptr, ...) @put_inode(ptr noundef %226)
  %227 = load i32, ptr %6, align 4
  %228 = icmp eq i32 %227, 1000
  br i1 %228, label %229, label %230

229:                                              ; preds = %222
  br label %232

230:                                              ; preds = %222
  %231 = load i32, ptr %6, align 4
  br label %232

232:                                              ; preds = %230, %229
  %233 = phi i32 [ 0, %229 ], [ %231, %230 ]
  store i32 %233, ptr %1, align 4
  br label %234

234:                                              ; preds = %232, %23, %17
  %235 = load i32, ptr %1, align 4
  ret i32 %235
}

; Function Attrs: nounwind
declare ptr @strcpy(ptr noundef, ptr noundef) #2

declare i32 @strncmp(ptr noundef, ptr noundef, i32 noundef) #1

declare i32 @strlen(ptr noundef) #1

declare i32 @forbidden(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @truncate(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i16, align 2
  store ptr %0, ptr %2, align 8
  %13 = load ptr, ptr %2, align 8
  %14 = getelementptr inbounds %struct.inode, ptr %13, i32 0, i32 0
  %15 = load i16, ptr %14, align 8
  %16 = zext i16 %15 to i32
  %17 = and i32 %16, 61440
  store i32 %17, ptr %9, align 4
  %18 = load i32, ptr %9, align 4
  %19 = icmp eq i32 %18, 8192
  br i1 %19, label %23, label %20

20:                                               ; preds = %1
  %21 = load i32, ptr %9, align 4
  %22 = icmp eq i32 %21, 24576
  br i1 %22, label %23, label %24

23:                                               ; preds = %20, %1
  br label %127

24:                                               ; preds = %20
  %25 = load ptr, ptr %2, align 8
  %26 = getelementptr inbounds %struct.inode, ptr %25, i32 0, i32 9
  %27 = load i16, ptr %26, align 8
  store i16 %27, ptr %12, align 2
  %28 = load ptr, ptr %2, align 8
  %29 = call i32 (ptr, ...) @scale_factor(ptr noundef %28)
  store i32 %29, ptr %8, align 4
  %30 = load i32, ptr %8, align 4
  %31 = zext i32 %30 to i64
  %32 = shl i64 1024, %31
  store i64 %32, ptr %7, align 8
  %33 = load ptr, ptr %2, align 8
  %34 = getelementptr inbounds %struct.inode, ptr %33, i32 0, i32 13
  %35 = load i8, ptr %34, align 1
  %36 = sext i8 %35 to i32
  %37 = icmp eq i32 %36, 1
  %38 = zext i1 %37 to i32
  store i32 %38, ptr %10, align 4
  br i1 %37, label %39, label %42

39:                                               ; preds = %24
  %40 = load ptr, ptr %2, align 8
  %41 = getelementptr inbounds %struct.inode, ptr %40, i32 0, i32 2
  store i64 7168, ptr %41, align 8
  br label %42

42:                                               ; preds = %39, %24
  store i64 0, ptr %6, align 8
  br label %43

43:                                               ; preds = %66, %42
  %44 = load i64, ptr %6, align 8
  %45 = load ptr, ptr %2, align 8
  %46 = getelementptr inbounds %struct.inode, ptr %45, i32 0, i32 2
  %47 = load i64, ptr %46, align 8
  %48 = icmp slt i64 %44, %47
  br i1 %48, label %49, label %70

49:                                               ; preds = %43
  %50 = load ptr, ptr %2, align 8
  %51 = load i64, ptr %6, align 8
  %52 = call zeroext i16 (ptr, i64, ...) @read_map(ptr noundef %50, i64 noundef %51)
  store i16 %52, ptr %3, align 2
  %53 = zext i16 %52 to i32
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %65

55:                                               ; preds = %49
  %56 = load i16, ptr %3, align 2
  %57 = zext i16 %56 to i32
  %58 = load i32, ptr %8, align 4
  %59 = ashr i32 %57, %58
  %60 = trunc i32 %59 to i16
  store i16 %60, ptr %4, align 2
  %61 = load i16, ptr %12, align 2
  %62 = zext i16 %61 to i32
  %63 = load i16, ptr %4, align 2
  %64 = zext i16 %63 to i32
  call void (i32, i32, ...) @free_zone(i32 noundef %62, i32 noundef %64)
  br label %65

65:                                               ; preds = %55, %49
  br label %66

66:                                               ; preds = %65
  %67 = load i64, ptr %7, align 8
  %68 = load i64, ptr %6, align 8
  %69 = add nsw i64 %68, %67
  store i64 %69, ptr %6, align 8
  br label %43

70:                                               ; preds = %43
  %71 = load i16, ptr %12, align 2
  %72 = zext i16 %71 to i32
  %73 = load ptr, ptr %2, align 8
  %74 = getelementptr inbounds %struct.inode, ptr %73, i32 0, i32 6
  %75 = getelementptr inbounds [9 x i16], ptr %74, i64 0, i64 7
  %76 = load i16, ptr %75, align 2
  %77 = zext i16 %76 to i32
  call void (i32, i32, ...) @free_zone(i32 noundef %72, i32 noundef %77)
  %78 = load ptr, ptr %2, align 8
  %79 = getelementptr inbounds %struct.inode, ptr %78, i32 0, i32 6
  %80 = getelementptr inbounds [9 x i16], ptr %79, i64 0, i64 8
  %81 = load i16, ptr %80, align 2
  store i16 %81, ptr %4, align 2
  %82 = zext i16 %81 to i32
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %119

84:                                               ; preds = %70
  %85 = load i16, ptr %4, align 2
  %86 = zext i16 %85 to i32
  %87 = load i32, ptr %8, align 4
  %88 = shl i32 %86, %87
  %89 = trunc i32 %88 to i16
  store i16 %89, ptr %3, align 2
  %90 = load i16, ptr %12, align 2
  %91 = zext i16 %90 to i32
  %92 = load i16, ptr %3, align 2
  %93 = zext i16 %92 to i32
  %94 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %91, i32 noundef %93, i32 noundef 0)
  store ptr %94, ptr %11, align 8
  %95 = load ptr, ptr %11, align 8
  %96 = getelementptr inbounds %struct.buf, ptr %95, i32 0, i32 0
  %97 = getelementptr inbounds [512 x i16], ptr %96, i64 0, i64 0
  store ptr %97, ptr %5, align 8
  br label %98

98:                                               ; preds = %110, %84
  %99 = load ptr, ptr %5, align 8
  %100 = load ptr, ptr %11, align 8
  %101 = getelementptr inbounds %struct.buf, ptr %100, i32 0, i32 0
  %102 = getelementptr inbounds [512 x i16], ptr %101, i64 0, i64 512
  %103 = icmp ult ptr %99, %102
  br i1 %103, label %104, label %113

104:                                              ; preds = %98
  %105 = load i16, ptr %12, align 2
  %106 = zext i16 %105 to i32
  %107 = load ptr, ptr %5, align 8
  %108 = load i16, ptr %107, align 2
  %109 = zext i16 %108 to i32
  call void (i32, i32, ...) @free_zone(i32 noundef %106, i32 noundef %109)
  br label %110

110:                                              ; preds = %104
  %111 = load ptr, ptr %5, align 8
  %112 = getelementptr inbounds i16, ptr %111, i32 1
  store ptr %112, ptr %5, align 8
  br label %98

113:                                              ; preds = %98
  %114 = load ptr, ptr %11, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %114, i32 noundef 2)
  %115 = load i16, ptr %12, align 2
  %116 = zext i16 %115 to i32
  %117 = load i16, ptr %4, align 2
  %118 = zext i16 %117 to i32
  call void (i32, i32, ...) @free_zone(i32 noundef %116, i32 noundef %118)
  br label %119

119:                                              ; preds = %113, %70
  %120 = load i32, ptr %10, align 4
  %121 = icmp ne i32 %120, 0
  br i1 %121, label %122, label %124

122:                                              ; preds = %119
  %123 = load ptr, ptr %2, align 8
  call void (ptr, ...) @wipe_inode(ptr noundef %123)
  br label %124

124:                                              ; preds = %122, %119
  %125 = load ptr, ptr %2, align 8
  %126 = getelementptr inbounds %struct.inode, ptr %125, i32 0, i32 12
  store i8 1, ptr %126, align 2
  br label %127

127:                                              ; preds = %124, %23
  ret void
}

declare i32 @scale_factor(...) #1

declare zeroext i16 @read_map(...) #1

declare void @free_zone(...) #1

declare ptr @get_block(...) #1

declare void @put_block(...) #1

declare void @wipe_inode(...) #1

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
