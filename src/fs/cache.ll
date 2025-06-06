; NOTE: Generated from src/fs/cache.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/cache.c'
source_filename = "src/fs/cache.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.bparam_s = type { i16, i16, i16, i16, i16 }
%struct.buf = type { %union.anon, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.iorequest_s = type { i64, ptr, i16, i16 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }

@buf_hash = external global [32 x ptr], align 16
@bufs_in_use = external global i32, align 4
@.str = private unnamed_addr constant [19 x i8] c"All buffers in use\00", align 1
@front = external global ptr, align 8
@.str.1 = private unnamed_addr constant [15 x i8] c"No free buffer\00", align 1
@rear = external global ptr, align 8
@err_code = external global i32, align 4
@.str.2 = private unnamed_addr constant [28 x i8] c"No space on %sdevice %d/%d\0A\00", align 1
@boot_parameters = external global %struct.bparam_s, align 2
@.str.3 = private unnamed_addr constant [6 x i8] c"root \00", align 1
@.str.4 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.5 = private unnamed_addr constant [52 x i8] c"Unrecoverable disk error on device %d/%d, block %u\0A\00", align 1
@rdwt_err = external global i32, align 4
@buf = external global [30 x %struct.buf], align 16
@flushall.dirty = internal global [30 x ptr] zeroinitializer, align 16
@rw_scattered.iovec = internal global [30 x %struct.iorequest_s] zeroinitializer, align 16
@.str.6 = private unnamed_addr constant [23 x i8] c"Too much scattered i/o\00", align 1
@.str.7 = private unnamed_addr constant [53 x i8] c"Unrecoverable write error on device %d/%d, block %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @get_block(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  %6 = alloca i16, align 2
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = trunc i32 %0 to i16
  %11 = trunc i32 %1 to i16
  store i16 %10, ptr %5, align 2
  store i16 %11, ptr %6, align 2
  store i32 %2, ptr %7, align 4
  %12 = load i16, ptr %5, align 2
  %13 = zext i16 %12 to i32
  %14 = icmp ne i32 %13, 65535
  br i1 %14, label %15, label %62

15:                                               ; preds = %3
  %16 = load i16, ptr %6, align 2
  %17 = zext i16 %16 to i32
  %18 = and i32 %17, 31
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [32 x ptr], ptr @buf_hash, i64 0, i64 %19
  %21 = load ptr, ptr %20, align 8
  store ptr %21, ptr %8, align 8
  br label %22

22:                                               ; preds = %60, %15
  %23 = load ptr, ptr %8, align 8
  %24 = icmp ne ptr %23, null
  br i1 %24, label %25, label %61

25:                                               ; preds = %22
  %26 = load ptr, ptr %8, align 8
  %27 = getelementptr inbounds %struct.buf, ptr %26, i32 0, i32 4
  %28 = load i16, ptr %27, align 8
  %29 = zext i16 %28 to i32
  %30 = load i16, ptr %6, align 2
  %31 = zext i16 %30 to i32
  %32 = icmp eq i32 %29, %31
  br i1 %32, label %33, label %56

33:                                               ; preds = %25
  %34 = load ptr, ptr %8, align 8
  %35 = getelementptr inbounds %struct.buf, ptr %34, i32 0, i32 5
  %36 = load i16, ptr %35, align 2
  %37 = zext i16 %36 to i32
  %38 = load i16, ptr %5, align 2
  %39 = zext i16 %38 to i32
  %40 = icmp eq i32 %37, %39
  br i1 %40, label %41, label %56

41:                                               ; preds = %33
  %42 = load ptr, ptr %8, align 8
  %43 = getelementptr inbounds %struct.buf, ptr %42, i32 0, i32 7
  %44 = load i8, ptr %43, align 1
  %45 = sext i8 %44 to i32
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %50

47:                                               ; preds = %41
  %48 = load i32, ptr @bufs_in_use, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr @bufs_in_use, align 4
  br label %50

50:                                               ; preds = %47, %41
  %51 = load ptr, ptr %8, align 8
  %52 = getelementptr inbounds %struct.buf, ptr %51, i32 0, i32 7
  %53 = load i8, ptr %52, align 1
  %54 = add i8 %53, 1
  store i8 %54, ptr %52, align 1
  %55 = load ptr, ptr %8, align 8
  store ptr %55, ptr %4, align 8
  br label %193

56:                                               ; preds = %33, %25
  %57 = load ptr, ptr %8, align 8
  %58 = getelementptr inbounds %struct.buf, ptr %57, i32 0, i32 3
  %59 = load ptr, ptr %58, align 8
  store ptr %59, ptr %8, align 8
  br label %60

60:                                               ; preds = %56
  br label %22

61:                                               ; preds = %22
  br label %62

62:                                               ; preds = %61, %3
  %63 = load i32, ptr @bufs_in_use, align 4
  %64 = icmp eq i32 %63, 30
  br i1 %64, label %65, label %66

65:                                               ; preds = %62
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef 30)
  br label %66

66:                                               ; preds = %65, %62
  %67 = load ptr, ptr @front, align 8
  store ptr %67, ptr %8, align 8
  br label %68

68:                                               ; preds = %81, %66
  %69 = load ptr, ptr %8, align 8
  %70 = getelementptr inbounds %struct.buf, ptr %69, i32 0, i32 7
  %71 = load i8, ptr %70, align 1
  %72 = sext i8 %71 to i32
  %73 = icmp ne i32 %72, 0
  br i1 %73, label %74, label %82

74:                                               ; preds = %68
  %75 = load ptr, ptr %8, align 8
  %76 = getelementptr inbounds %struct.buf, ptr %75, i32 0, i32 1
  %77 = load ptr, ptr %76, align 8
  store ptr %77, ptr %8, align 8
  %78 = load ptr, ptr %8, align 8
  %79 = icmp eq ptr %78, null
  br i1 %79, label %80, label %81

80:                                               ; preds = %74
  call void (ptr, i32, ...) @panic(ptr noundef @.str.1, i32 noundef 32768)
  br label %81

81:                                               ; preds = %80, %74
  br label %68

82:                                               ; preds = %68
  %83 = load i32, ptr @bufs_in_use, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr @bufs_in_use, align 4
  %85 = load ptr, ptr %8, align 8
  %86 = getelementptr inbounds %struct.buf, ptr %85, i32 0, i32 4
  %87 = load i16, ptr %86, align 8
  %88 = zext i16 %87 to i32
  %89 = and i32 %88, 31
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [32 x ptr], ptr @buf_hash, i64 0, i64 %90
  %92 = load ptr, ptr %91, align 8
  store ptr %92, ptr %9, align 8
  %93 = load ptr, ptr %9, align 8
  %94 = load ptr, ptr %8, align 8
  %95 = icmp eq ptr %93, %94
  br i1 %95, label %96, label %107

96:                                               ; preds = %82
  %97 = load ptr, ptr %8, align 8
  %98 = getelementptr inbounds %struct.buf, ptr %97, i32 0, i32 3
  %99 = load ptr, ptr %98, align 8
  %100 = load ptr, ptr %8, align 8
  %101 = getelementptr inbounds %struct.buf, ptr %100, i32 0, i32 4
  %102 = load i16, ptr %101, align 8
  %103 = zext i16 %102 to i32
  %104 = and i32 %103, 31
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [32 x ptr], ptr @buf_hash, i64 0, i64 %105
  store ptr %99, ptr %106, align 8
  br label %131

107:                                              ; preds = %82
  br label %108

108:                                              ; preds = %129, %107
  %109 = load ptr, ptr %9, align 8
  %110 = getelementptr inbounds %struct.buf, ptr %109, i32 0, i32 3
  %111 = load ptr, ptr %110, align 8
  %112 = icmp ne ptr %111, null
  br i1 %112, label %113, label %130

113:                                              ; preds = %108
  %114 = load ptr, ptr %9, align 8
  %115 = getelementptr inbounds %struct.buf, ptr %114, i32 0, i32 3
  %116 = load ptr, ptr %115, align 8
  %117 = load ptr, ptr %8, align 8
  %118 = icmp eq ptr %116, %117
  br i1 %118, label %119, label %125

119:                                              ; preds = %113
  %120 = load ptr, ptr %8, align 8
  %121 = getelementptr inbounds %struct.buf, ptr %120, i32 0, i32 3
  %122 = load ptr, ptr %121, align 8
  %123 = load ptr, ptr %9, align 8
  %124 = getelementptr inbounds %struct.buf, ptr %123, i32 0, i32 3
  store ptr %122, ptr %124, align 8
  br label %130

125:                                              ; preds = %113
  %126 = load ptr, ptr %9, align 8
  %127 = getelementptr inbounds %struct.buf, ptr %126, i32 0, i32 3
  %128 = load ptr, ptr %127, align 8
  store ptr %128, ptr %9, align 8
  br label %129

129:                                              ; preds = %125
  br label %108

130:                                              ; preds = %119, %108
  br label %131

131:                                              ; preds = %130, %96
  %132 = load ptr, ptr %8, align 8
  %133 = getelementptr inbounds %struct.buf, ptr %132, i32 0, i32 5
  %134 = load i16, ptr %133, align 2
  %135 = zext i16 %134 to i32
  %136 = icmp ne i32 %135, 65535
  br i1 %136, label %137, label %148

137:                                              ; preds = %131
  %138 = load ptr, ptr %8, align 8
  %139 = getelementptr inbounds %struct.buf, ptr %138, i32 0, i32 6
  %140 = load i8, ptr %139, align 4
  %141 = sext i8 %140 to i32
  %142 = icmp eq i32 %141, 1
  br i1 %142, label %143, label %148

143:                                              ; preds = %137
  %144 = load ptr, ptr %8, align 8
  %145 = getelementptr inbounds %struct.buf, ptr %144, i32 0, i32 5
  %146 = load i16, ptr %145, align 2
  %147 = zext i16 %146 to i32
  call void @flushall(i32 noundef %147)
  br label %148

148:                                              ; preds = %143, %137, %131
  %149 = load i16, ptr %5, align 2
  %150 = load ptr, ptr %8, align 8
  %151 = getelementptr inbounds %struct.buf, ptr %150, i32 0, i32 5
  store i16 %149, ptr %151, align 2
  %152 = load i32, ptr %7, align 4
  %153 = icmp eq i32 %152, 2
  br i1 %153, label %154, label %157

154:                                              ; preds = %148
  %155 = load ptr, ptr %8, align 8
  %156 = getelementptr inbounds %struct.buf, ptr %155, i32 0, i32 5
  store i16 -1, ptr %156, align 2
  br label %157

157:                                              ; preds = %154, %148
  %158 = load i16, ptr %6, align 2
  %159 = load ptr, ptr %8, align 8
  %160 = getelementptr inbounds %struct.buf, ptr %159, i32 0, i32 4
  store i16 %158, ptr %160, align 8
  %161 = load ptr, ptr %8, align 8
  %162 = getelementptr inbounds %struct.buf, ptr %161, i32 0, i32 7
  %163 = load i8, ptr %162, align 1
  %164 = add i8 %163, 1
  store i8 %164, ptr %162, align 1
  %165 = load ptr, ptr %8, align 8
  %166 = getelementptr inbounds %struct.buf, ptr %165, i32 0, i32 4
  %167 = load i16, ptr %166, align 8
  %168 = zext i16 %167 to i32
  %169 = and i32 %168, 31
  %170 = sext i32 %169 to i64
  %171 = getelementptr inbounds [32 x ptr], ptr @buf_hash, i64 0, i64 %170
  %172 = load ptr, ptr %171, align 8
  %173 = load ptr, ptr %8, align 8
  %174 = getelementptr inbounds %struct.buf, ptr %173, i32 0, i32 3
  store ptr %172, ptr %174, align 8
  %175 = load ptr, ptr %8, align 8
  %176 = load ptr, ptr %8, align 8
  %177 = getelementptr inbounds %struct.buf, ptr %176, i32 0, i32 4
  %178 = load i16, ptr %177, align 8
  %179 = zext i16 %178 to i32
  %180 = and i32 %179, 31
  %181 = sext i32 %180 to i64
  %182 = getelementptr inbounds [32 x ptr], ptr @buf_hash, i64 0, i64 %181
  store ptr %175, ptr %182, align 8
  %183 = load i16, ptr %5, align 2
  %184 = zext i16 %183 to i32
  %185 = icmp ne i32 %184, 65535
  br i1 %185, label %186, label %191

186:                                              ; preds = %157
  %187 = load i32, ptr %7, align 4
  %188 = icmp eq i32 %187, 0
  br i1 %188, label %189, label %191

189:                                              ; preds = %186
  %190 = load ptr, ptr %8, align 8
  call void @rw_block(ptr noundef %190, i32 noundef 0)
  br label %191

191:                                              ; preds = %189, %186, %157
  %192 = load ptr, ptr %8, align 8
  store ptr %192, ptr %4, align 8
  br label %193

193:                                              ; preds = %191, %50
  %194 = load ptr, ptr %4, align 8
  ret ptr %194
}

declare void @panic(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @put_block(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %7 = load ptr, ptr %3, align 8
  %8 = icmp eq ptr %7, null
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %107

10:                                               ; preds = %2
  %11 = load ptr, ptr %3, align 8
  %12 = getelementptr inbounds %struct.buf, ptr %11, i32 0, i32 7
  %13 = load i8, ptr %12, align 1
  %14 = add i8 %13, -1
  store i8 %14, ptr %12, align 1
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.buf, ptr %15, i32 0, i32 7
  %17 = load i8, ptr %16, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %10
  br label %107

21:                                               ; preds = %10
  %22 = load i32, ptr @bufs_in_use, align 4
  %23 = add nsw i32 %22, -1
  store i32 %23, ptr @bufs_in_use, align 4
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds %struct.buf, ptr %24, i32 0, i32 1
  %26 = load ptr, ptr %25, align 8
  store ptr %26, ptr %5, align 8
  %27 = load ptr, ptr %3, align 8
  %28 = getelementptr inbounds %struct.buf, ptr %27, i32 0, i32 2
  %29 = load ptr, ptr %28, align 8
  store ptr %29, ptr %6, align 8
  %30 = load ptr, ptr %6, align 8
  %31 = icmp ne ptr %30, null
  br i1 %31, label %32, label %36

32:                                               ; preds = %21
  %33 = load ptr, ptr %5, align 8
  %34 = load ptr, ptr %6, align 8
  %35 = getelementptr inbounds %struct.buf, ptr %34, i32 0, i32 1
  store ptr %33, ptr %35, align 8
  br label %38

36:                                               ; preds = %21
  %37 = load ptr, ptr %5, align 8
  store ptr %37, ptr @front, align 8
  br label %38

38:                                               ; preds = %36, %32
  %39 = load ptr, ptr %5, align 8
  %40 = icmp ne ptr %39, null
  br i1 %40, label %41, label %45

41:                                               ; preds = %38
  %42 = load ptr, ptr %6, align 8
  %43 = load ptr, ptr %5, align 8
  %44 = getelementptr inbounds %struct.buf, ptr %43, i32 0, i32 2
  store ptr %42, ptr %44, align 8
  br label %47

45:                                               ; preds = %38
  %46 = load ptr, ptr %6, align 8
  store ptr %46, ptr @rear, align 8
  br label %47

47:                                               ; preds = %45, %41
  %48 = load i32, ptr %4, align 4
  %49 = and i32 %48, 128
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %67

51:                                               ; preds = %47
  %52 = load ptr, ptr %3, align 8
  %53 = getelementptr inbounds %struct.buf, ptr %52, i32 0, i32 2
  store ptr null, ptr %53, align 8
  %54 = load ptr, ptr @front, align 8
  %55 = load ptr, ptr %3, align 8
  %56 = getelementptr inbounds %struct.buf, ptr %55, i32 0, i32 1
  store ptr %54, ptr %56, align 8
  %57 = load ptr, ptr @front, align 8
  %58 = icmp eq ptr %57, null
  br i1 %58, label %59, label %61

59:                                               ; preds = %51
  %60 = load ptr, ptr %3, align 8
  store ptr %60, ptr @rear, align 8
  br label %65

61:                                               ; preds = %51
  %62 = load ptr, ptr %3, align 8
  %63 = load ptr, ptr @front, align 8
  %64 = getelementptr inbounds %struct.buf, ptr %63, i32 0, i32 2
  store ptr %62, ptr %64, align 8
  br label %65

65:                                               ; preds = %61, %59
  %66 = load ptr, ptr %3, align 8
  store ptr %66, ptr @front, align 8
  br label %83

67:                                               ; preds = %47
  %68 = load ptr, ptr @rear, align 8
  %69 = load ptr, ptr %3, align 8
  %70 = getelementptr inbounds %struct.buf, ptr %69, i32 0, i32 2
  store ptr %68, ptr %70, align 8
  %71 = load ptr, ptr %3, align 8
  %72 = getelementptr inbounds %struct.buf, ptr %71, i32 0, i32 1
  store ptr null, ptr %72, align 8
  %73 = load ptr, ptr @rear, align 8
  %74 = icmp eq ptr %73, null
  br i1 %74, label %75, label %77

75:                                               ; preds = %67
  %76 = load ptr, ptr %3, align 8
  store ptr %76, ptr @front, align 8
  br label %81

77:                                               ; preds = %67
  %78 = load ptr, ptr %3, align 8
  %79 = load ptr, ptr @rear, align 8
  %80 = getelementptr inbounds %struct.buf, ptr %79, i32 0, i32 1
  store ptr %78, ptr %80, align 8
  br label %81

81:                                               ; preds = %77, %75
  %82 = load ptr, ptr %3, align 8
  store ptr %82, ptr @rear, align 8
  br label %83

83:                                               ; preds = %81, %65
  %84 = load i32, ptr %4, align 4
  %85 = and i32 %84, 64
  %86 = icmp ne i32 %85, 0
  br i1 %86, label %87, label %101

87:                                               ; preds = %83
  %88 = load ptr, ptr %3, align 8
  %89 = getelementptr inbounds %struct.buf, ptr %88, i32 0, i32 6
  %90 = load i8, ptr %89, align 4
  %91 = sext i8 %90 to i32
  %92 = icmp eq i32 %91, 1
  br i1 %92, label %93, label %101

93:                                               ; preds = %87
  %94 = load ptr, ptr %3, align 8
  %95 = getelementptr inbounds %struct.buf, ptr %94, i32 0, i32 5
  %96 = load i16, ptr %95, align 2
  %97 = zext i16 %96 to i32
  %98 = icmp ne i32 %97, 65535
  br i1 %98, label %99, label %101

99:                                               ; preds = %93
  %100 = load ptr, ptr %3, align 8
  call void @rw_block(ptr noundef %100, i32 noundef 1)
  br label %101

101:                                              ; preds = %99, %93, %87, %83
  %102 = load i32, ptr %4, align 4
  %103 = icmp eq i32 %102, 197
  br i1 %103, label %104, label %107

104:                                              ; preds = %101
  %105 = load ptr, ptr %3, align 8
  %106 = getelementptr inbounds %struct.buf, ptr %105, i32 0, i32 5
  store i16 -1, ptr %106, align 2
  br label %107

107:                                              ; preds = %9, %20, %104, %101
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @alloc_zone(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca i16, align 2
  %7 = alloca i16, align 2
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = trunc i32 %0 to i16
  %12 = trunc i32 %1 to i16
  store i16 %11, ptr %4, align 2
  store i16 %12, ptr %5, align 2
  %13 = load i16, ptr %4, align 2
  %14 = zext i16 %13 to i32
  %15 = call ptr (i32, ...) @get_super(i32 noundef %14)
  store ptr %15, ptr %8, align 8
  %16 = load i16, ptr %5, align 2
  %17 = zext i16 %16 to i32
  %18 = load ptr, ptr %8, align 8
  %19 = getelementptr inbounds %struct.super_block, ptr %18, i32 0, i32 4
  %20 = load i16, ptr %19, align 8
  %21 = zext i16 %20 to i32
  %22 = sub nsw i32 %21, 1
  %23 = sub nsw i32 %17, %22
  %24 = trunc i32 %23 to i16
  store i16 %24, ptr %7, align 2
  %25 = load ptr, ptr %8, align 8
  %26 = getelementptr inbounds %struct.super_block, ptr %25, i32 0, i32 9
  %27 = getelementptr inbounds [8 x ptr], ptr %26, i64 0, i64 0
  %28 = load ptr, ptr %8, align 8
  %29 = getelementptr inbounds %struct.super_block, ptr %28, i32 0, i32 1
  %30 = load i16, ptr %29, align 2
  %31 = zext i16 %30 to i32
  %32 = load ptr, ptr %8, align 8
  %33 = getelementptr inbounds %struct.super_block, ptr %32, i32 0, i32 4
  %34 = load i16, ptr %33, align 8
  %35 = zext i16 %34 to i32
  %36 = sub nsw i32 %31, %35
  %37 = add nsw i32 %36, 1
  %38 = load ptr, ptr %8, align 8
  %39 = getelementptr inbounds %struct.super_block, ptr %38, i32 0, i32 3
  %40 = load i16, ptr %39, align 2
  %41 = zext i16 %40 to i32
  %42 = load i16, ptr %7, align 2
  %43 = zext i16 %42 to i32
  %44 = call zeroext i16 (ptr, i32, i32, i32, ...) @alloc_bit(ptr noundef %27, i32 noundef %37, i32 noundef %41, i32 noundef %43)
  store i16 %44, ptr %6, align 2
  %45 = load i16, ptr %6, align 2
  %46 = zext i16 %45 to i32
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %72

48:                                               ; preds = %2
  store i32 -28, ptr @err_code, align 4
  %49 = load ptr, ptr %8, align 8
  %50 = getelementptr inbounds %struct.super_block, ptr %49, i32 0, i32 10
  %51 = load i16, ptr %50, align 8
  %52 = zext i16 %51 to i32
  %53 = ashr i32 %52, 8
  %54 = and i32 %53, 255
  store i32 %54, ptr %9, align 4
  %55 = load ptr, ptr %8, align 8
  %56 = getelementptr inbounds %struct.super_block, ptr %55, i32 0, i32 10
  %57 = load i16, ptr %56, align 8
  %58 = zext i16 %57 to i32
  %59 = ashr i32 %58, 0
  %60 = and i32 %59, 255
  store i32 %60, ptr %10, align 4
  %61 = load ptr, ptr %8, align 8
  %62 = getelementptr inbounds %struct.super_block, ptr %61, i32 0, i32 10
  %63 = load i16, ptr %62, align 8
  %64 = zext i16 %63 to i32
  %65 = load i16, ptr @boot_parameters, align 2
  %66 = zext i16 %65 to i32
  %67 = icmp eq i32 %64, %66
  %68 = zext i1 %67 to i64
  %69 = select i1 %67, ptr @.str.3, ptr @.str.4
  %70 = load i32, ptr %9, align 4
  %71 = load i32, ptr %10, align 4
  call void (ptr, ptr, i32, i32, ...) @printk(ptr noundef @.str.2, ptr noundef %69, i32 noundef %70, i32 noundef %71)
  store i16 0, ptr %3, align 2
  br label %82

72:                                               ; preds = %2
  %73 = load ptr, ptr %8, align 8
  %74 = getelementptr inbounds %struct.super_block, ptr %73, i32 0, i32 4
  %75 = load i16, ptr %74, align 8
  %76 = zext i16 %75 to i32
  %77 = sub nsw i32 %76, 1
  %78 = load i16, ptr %6, align 2
  %79 = zext i16 %78 to i32
  %80 = add nsw i32 %77, %79
  %81 = trunc i32 %80 to i16
  store i16 %81, ptr %3, align 2
  br label %82

82:                                               ; preds = %72, %48
  %83 = load i16, ptr %3, align 2
  ret i16 %83
}

declare ptr @get_super(...) #1

declare zeroext i16 @alloc_bit(...) #1

declare void @printk(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @free_zone(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca ptr, align 8
  %6 = trunc i32 %0 to i16
  %7 = trunc i32 %1 to i16
  store i16 %6, ptr %3, align 2
  store i16 %7, ptr %4, align 2
  %8 = load i16, ptr %4, align 2
  %9 = zext i16 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  br label %27

12:                                               ; preds = %2
  %13 = load i16, ptr %3, align 2
  %14 = zext i16 %13 to i32
  %15 = call ptr (i32, ...) @get_super(i32 noundef %14)
  store ptr %15, ptr %5, align 8
  %16 = load ptr, ptr %5, align 8
  %17 = getelementptr inbounds %struct.super_block, ptr %16, i32 0, i32 9
  %18 = getelementptr inbounds [8 x ptr], ptr %17, i64 0, i64 0
  %19 = load i16, ptr %4, align 2
  %20 = zext i16 %19 to i32
  %21 = load ptr, ptr %5, align 8
  %22 = getelementptr inbounds %struct.super_block, ptr %21, i32 0, i32 4
  %23 = load i16, ptr %22, align 8
  %24 = zext i16 %23 to i32
  %25 = sub nsw i32 %24, 1
  %26 = sub nsw i32 %20, %25
  call void (ptr, i32, ...) @free_bit(ptr noundef %18, i32 noundef %26)
  br label %27

27:                                               ; preds = %12, %11
  ret void
}

declare void @free_bit(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_block(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.buf, ptr %8, i32 0, i32 5
  %10 = load i16, ptr %9, align 2
  store i16 %10, ptr %7, align 2
  %11 = zext i16 %10 to i32
  %12 = icmp ne i32 %11, 65535
  br i1 %12, label %13, label %58

13:                                               ; preds = %2
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.buf, ptr %14, i32 0, i32 4
  %16 = load i16, ptr %15, align 8
  %17 = zext i16 %16 to i64
  %18 = mul nsw i64 %17, 1024
  store i64 %18, ptr %6, align 8
  %19 = load i32, ptr %4, align 4
  %20 = load i16, ptr %7, align 2
  %21 = zext i16 %20 to i32
  %22 = load i64, ptr %6, align 8
  %23 = load ptr, ptr %3, align 8
  %24 = getelementptr inbounds %struct.buf, ptr %23, i32 0, i32 0
  %25 = getelementptr inbounds [1024 x i8], ptr %24, i64 0, i64 0
  %26 = call i32 (i32, i32, i32, i64, i32, i32, ptr, ...) @dev_io(i32 noundef %19, i32 noundef 0, i32 noundef %21, i64 noundef %22, i32 noundef 1024, i32 noundef 1, ptr noundef %25)
  store i32 %26, ptr %5, align 4
  %27 = load i32, ptr %5, align 4
  %28 = icmp ne i32 %27, 1024
  br i1 %28, label %29, label %57

29:                                               ; preds = %13
  %30 = load i32, ptr %5, align 4
  %31 = icmp sge i32 %30, 0
  br i1 %31, label %32, label %33

32:                                               ; preds = %29
  store i32 -104, ptr %5, align 4
  br label %33

33:                                               ; preds = %32, %29
  %34 = load i32, ptr %5, align 4
  %35 = icmp ne i32 %34, -104
  br i1 %35, label %36, label %49

36:                                               ; preds = %33
  %37 = load i16, ptr %7, align 2
  %38 = zext i16 %37 to i32
  %39 = ashr i32 %38, 8
  %40 = and i32 %39, 255
  %41 = load i16, ptr %7, align 2
  %42 = zext i16 %41 to i32
  %43 = ashr i32 %42, 0
  %44 = and i32 %43, 255
  %45 = load ptr, ptr %3, align 8
  %46 = getelementptr inbounds %struct.buf, ptr %45, i32 0, i32 4
  %47 = load i16, ptr %46, align 8
  %48 = zext i16 %47 to i32
  call void (ptr, i32, i32, i32, ...) @printk(ptr noundef @.str.5, i32 noundef %40, i32 noundef %44, i32 noundef %48)
  br label %49

49:                                               ; preds = %36, %33
  %50 = load ptr, ptr %3, align 8
  %51 = getelementptr inbounds %struct.buf, ptr %50, i32 0, i32 5
  store i16 -1, ptr %51, align 2
  %52 = load i32, ptr %4, align 4
  %53 = icmp eq i32 %52, 0
  br i1 %53, label %54, label %56

54:                                               ; preds = %49
  %55 = load i32, ptr %5, align 4
  store i32 %55, ptr @rdwt_err, align 4
  br label %56

56:                                               ; preds = %54, %49
  br label %57

57:                                               ; preds = %56, %13
  br label %58

58:                                               ; preds = %57, %2
  %59 = load ptr, ptr %3, align 8
  %60 = getelementptr inbounds %struct.buf, ptr %59, i32 0, i32 6
  store i8 0, ptr %60, align 4
  ret void
}

declare i32 @dev_io(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @invalidate(i32 noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = alloca ptr, align 8
  %4 = trunc i32 %0 to i16
  store i16 %4, ptr %2, align 2
  store ptr @buf, ptr %3, align 8
  br label %5

5:                                                ; preds = %20, %1
  %6 = load ptr, ptr %3, align 8
  %7 = icmp ult ptr %6, getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 30)
  br i1 %7, label %8, label %23

8:                                                ; preds = %5
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.buf, ptr %9, i32 0, i32 5
  %11 = load i16, ptr %10, align 2
  %12 = zext i16 %11 to i32
  %13 = load i16, ptr %2, align 2
  %14 = zext i16 %13 to i32
  %15 = icmp eq i32 %12, %14
  br i1 %15, label %16, label %19

16:                                               ; preds = %8
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.buf, ptr %17, i32 0, i32 5
  store i16 -1, ptr %18, align 2
  br label %19

19:                                               ; preds = %16, %8
  br label %20

20:                                               ; preds = %19
  %21 = load ptr, ptr %3, align 8
  %22 = getelementptr inbounds %struct.buf, ptr %21, i32 1
  store ptr %22, ptr %3, align 8
  br label %5

23:                                               ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @flushall(i32 noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = trunc i32 %0 to i16
  store i16 %5, ptr %2, align 2
  store ptr @buf, ptr %3, align 8
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %30, %1
  %7 = load ptr, ptr %3, align 8
  %8 = icmp ult ptr %7, getelementptr inbounds ([30 x %struct.buf], ptr @buf, i64 0, i64 30)
  br i1 %8, label %9, label %33

9:                                                ; preds = %6
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.buf, ptr %10, i32 0, i32 6
  %12 = load i8, ptr %11, align 4
  %13 = sext i8 %12 to i32
  %14 = icmp eq i32 %13, 1
  br i1 %14, label %15, label %29

15:                                               ; preds = %9
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.buf, ptr %16, i32 0, i32 5
  %18 = load i16, ptr %17, align 2
  %19 = zext i16 %18 to i32
  %20 = load i16, ptr %2, align 2
  %21 = zext i16 %20 to i32
  %22 = icmp eq i32 %19, %21
  br i1 %22, label %23, label %29

23:                                               ; preds = %15
  %24 = load ptr, ptr %3, align 8
  %25 = load i32, ptr %4, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %4, align 4
  %27 = sext i32 %25 to i64
  %28 = getelementptr inbounds [30 x ptr], ptr @flushall.dirty, i64 0, i64 %27
  store ptr %24, ptr %28, align 8
  br label %29

29:                                               ; preds = %23, %15, %9
  br label %30

30:                                               ; preds = %29
  %31 = load ptr, ptr %3, align 8
  %32 = getelementptr inbounds %struct.buf, ptr %31, i32 1
  store ptr %32, ptr %3, align 8
  br label %6

33:                                               ; preds = %6
  %34 = load i16, ptr %2, align 2
  %35 = zext i16 %34 to i32
  %36 = load i32, ptr %4, align 4
  call void @rw_scattered(i32 noundef %35, ptr noundef @flushall.dirty, i32 noundef %36, i32 noundef 1)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @rw_scattered(i32 noundef %0, ptr noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i16, align 2
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = trunc i32 %0 to i16
  store i16 %14, ptr %5, align 2
  store ptr %1, ptr %6, align 8
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %15 = load i32, ptr %7, align 4
  %16 = icmp sle i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %4
  br label %201

18:                                               ; preds = %4
  %19 = load i32, ptr %7, align 4
  %20 = icmp sgt i32 %19, 30
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  call void (ptr, i32, ...) @panic(ptr noundef @.str.6, i32 noundef 32768)
  br label %22

22:                                               ; preds = %21, %18
  store i32 1, ptr %10, align 4
  br label %23

23:                                               ; preds = %27, %22
  %24 = load i32, ptr %10, align 4
  %25 = mul nsw i32 3, %24
  %26 = add nsw i32 %25, 1
  store i32 %26, ptr %10, align 4
  br label %27

27:                                               ; preds = %23
  %28 = load i32, ptr %10, align 4
  %29 = load i32, ptr %7, align 4
  %30 = icmp sle i32 %28, %29
  br i1 %30, label %23, label %31

31:                                               ; preds = %27
  br label %32

32:                                               ; preds = %104, %31
  %33 = load i32, ptr %10, align 4
  %34 = icmp ne i32 %33, 1
  br i1 %34, label %35, label %105

35:                                               ; preds = %32
  %36 = load i32, ptr %10, align 4
  %37 = sdiv i32 %36, 3
  store i32 %37, ptr %10, align 4
  %38 = load i32, ptr %10, align 4
  store i32 %38, ptr %13, align 4
  br label %39

39:                                               ; preds = %101, %35
  %40 = load i32, ptr %13, align 4
  %41 = load i32, ptr %7, align 4
  %42 = icmp slt i32 %40, %41
  br i1 %42, label %43, label %104

43:                                               ; preds = %39
  %44 = load i32, ptr %13, align 4
  %45 = load i32, ptr %10, align 4
  %46 = sub nsw i32 %44, %45
  store i32 %46, ptr %11, align 4
  br label %47

47:                                               ; preds = %96, %43
  %48 = load i32, ptr %11, align 4
  %49 = icmp sge i32 %48, 0
  br i1 %49, label %50, label %70

50:                                               ; preds = %47
  %51 = load ptr, ptr %6, align 8
  %52 = load i32, ptr %11, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds ptr, ptr %51, i64 %53
  %55 = load ptr, ptr %54, align 8
  %56 = getelementptr inbounds %struct.buf, ptr %55, i32 0, i32 4
  %57 = load i16, ptr %56, align 8
  %58 = zext i16 %57 to i32
  %59 = load ptr, ptr %6, align 8
  %60 = load i32, ptr %11, align 4
  %61 = load i32, ptr %10, align 4
  %62 = add nsw i32 %60, %61
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds ptr, ptr %59, i64 %63
  %65 = load ptr, ptr %64, align 8
  %66 = getelementptr inbounds %struct.buf, ptr %65, i32 0, i32 4
  %67 = load i16, ptr %66, align 8
  %68 = zext i16 %67 to i32
  %69 = icmp sgt i32 %58, %68
  br label %70

70:                                               ; preds = %50, %47
  %71 = phi i1 [ false, %47 ], [ %69, %50 ]
  br i1 %71, label %72, label %100

72:                                               ; preds = %70
  %73 = load ptr, ptr %6, align 8
  %74 = load i32, ptr %11, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds ptr, ptr %73, i64 %75
  %77 = load ptr, ptr %76, align 8
  store ptr %77, ptr %9, align 8
  %78 = load ptr, ptr %6, align 8
  %79 = load i32, ptr %11, align 4
  %80 = load i32, ptr %10, align 4
  %81 = add nsw i32 %79, %80
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds ptr, ptr %78, i64 %82
  %84 = load ptr, ptr %83, align 8
  %85 = load ptr, ptr %6, align 8
  %86 = load i32, ptr %11, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds ptr, ptr %85, i64 %87
  store ptr %84, ptr %88, align 8
  %89 = load ptr, ptr %9, align 8
  %90 = load ptr, ptr %6, align 8
  %91 = load i32, ptr %11, align 4
  %92 = load i32, ptr %10, align 4
  %93 = add nsw i32 %91, %92
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds ptr, ptr %90, i64 %94
  store ptr %89, ptr %95, align 8
  br label %96

96:                                               ; preds = %72
  %97 = load i32, ptr %10, align 4
  %98 = load i32, ptr %11, align 4
  %99 = sub nsw i32 %98, %97
  store i32 %99, ptr %11, align 4
  br label %47

100:                                              ; preds = %70
  br label %101

101:                                              ; preds = %100
  %102 = load i32, ptr %13, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %13, align 4
  br label %39

104:                                              ; preds = %39
  br label %32

105:                                              ; preds = %32
  store i32 0, ptr %11, align 4
  store ptr @rw_scattered.iovec, ptr %12, align 8
  br label %106

106:                                              ; preds = %137, %105
  %107 = load i32, ptr %11, align 4
  %108 = load i32, ptr %7, align 4
  %109 = icmp slt i32 %107, %108
  br i1 %109, label %110, label %142

110:                                              ; preds = %106
  %111 = load ptr, ptr %6, align 8
  %112 = load i32, ptr %11, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds ptr, ptr %111, i64 %113
  %115 = load ptr, ptr %114, align 8
  store ptr %115, ptr %9, align 8
  %116 = load ptr, ptr %9, align 8
  %117 = getelementptr inbounds %struct.buf, ptr %116, i32 0, i32 4
  %118 = load i16, ptr %117, align 8
  %119 = zext i16 %118 to i64
  %120 = mul nsw i64 %119, 1024
  %121 = load ptr, ptr %12, align 8
  %122 = getelementptr inbounds %struct.iorequest_s, ptr %121, i32 0, i32 0
  store i64 %120, ptr %122, align 8
  %123 = load ptr, ptr %9, align 8
  %124 = getelementptr inbounds %struct.buf, ptr %123, i32 0, i32 0
  %125 = getelementptr inbounds [1024 x i8], ptr %124, i64 0, i64 0
  %126 = load ptr, ptr %12, align 8
  %127 = getelementptr inbounds %struct.iorequest_s, ptr %126, i32 0, i32 1
  store ptr %125, ptr %127, align 8
  %128 = load ptr, ptr %12, align 8
  %129 = getelementptr inbounds %struct.iorequest_s, ptr %128, i32 0, i32 2
  store i16 1024, ptr %129, align 8
  %130 = load i32, ptr %8, align 4
  %131 = icmp eq i32 %130, 1
  %132 = zext i1 %131 to i64
  %133 = select i1 %131, i32 4, i32 19
  %134 = trunc i32 %133 to i16
  %135 = load ptr, ptr %12, align 8
  %136 = getelementptr inbounds %struct.iorequest_s, ptr %135, i32 0, i32 3
  store i16 %134, ptr %136, align 2
  br label %137

137:                                              ; preds = %110
  %138 = load i32, ptr %11, align 4
  %139 = add nsw i32 %138, 1
  store i32 %139, ptr %11, align 4
  %140 = load ptr, ptr %12, align 8
  %141 = getelementptr inbounds %struct.iorequest_s, ptr %140, i32 1
  store ptr %141, ptr %12, align 8
  br label %106

142:                                              ; preds = %106
  %143 = load i16, ptr %5, align 2
  %144 = zext i16 %143 to i32
  %145 = load i32, ptr %7, align 4
  %146 = call i32 (i32, i32, i32, i64, i32, i32, ptr, ...) @dev_io(i32 noundef 6, i32 noundef 0, i32 noundef %144, i64 noundef 0, i32 noundef %145, i32 noundef 1, ptr noundef @rw_scattered.iovec)
  store i32 0, ptr %11, align 4
  store ptr @rw_scattered.iovec, ptr %12, align 8
  br label %147

147:                                              ; preds = %196, %142
  %148 = load i32, ptr %11, align 4
  %149 = load i32, ptr %7, align 4
  %150 = icmp slt i32 %148, %149
  br i1 %150, label %151, label %201

151:                                              ; preds = %147
  %152 = load ptr, ptr %6, align 8
  %153 = load i32, ptr %11, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds ptr, ptr %152, i64 %154
  %156 = load ptr, ptr %155, align 8
  store ptr %156, ptr %9, align 8
  %157 = load i32, ptr %8, align 4
  %158 = icmp eq i32 %157, 0
  br i1 %158, label %159, label %171

159:                                              ; preds = %151
  %160 = load ptr, ptr %12, align 8
  %161 = getelementptr inbounds %struct.iorequest_s, ptr %160, i32 0, i32 2
  %162 = load i16, ptr %161, align 8
  %163 = zext i16 %162 to i32
  %164 = icmp eq i32 %163, 0
  br i1 %164, label %165, label %169

165:                                              ; preds = %159
  %166 = load i16, ptr %5, align 2
  %167 = load ptr, ptr %9, align 8
  %168 = getelementptr inbounds %struct.buf, ptr %167, i32 0, i32 5
  store i16 %166, ptr %168, align 2
  br label %169

169:                                              ; preds = %165, %159
  %170 = load ptr, ptr %9, align 8
  call void @put_block(ptr noundef %170, i32 noundef 7)
  br label %195

171:                                              ; preds = %151
  %172 = load ptr, ptr %12, align 8
  %173 = getelementptr inbounds %struct.iorequest_s, ptr %172, i32 0, i32 2
  %174 = load i16, ptr %173, align 8
  %175 = zext i16 %174 to i32
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %177, label %192

177:                                              ; preds = %171
  %178 = load i16, ptr %5, align 2
  %179 = zext i16 %178 to i32
  %180 = ashr i32 %179, 8
  %181 = and i32 %180, 255
  %182 = load i16, ptr %5, align 2
  %183 = zext i16 %182 to i32
  %184 = ashr i32 %183, 0
  %185 = and i32 %184, 255
  %186 = load ptr, ptr %9, align 8
  %187 = getelementptr inbounds %struct.buf, ptr %186, i32 0, i32 4
  %188 = load i16, ptr %187, align 8
  %189 = zext i16 %188 to i32
  call void (ptr, i32, i32, i32, ...) @printk(ptr noundef @.str.7, i32 noundef %181, i32 noundef %185, i32 noundef %189)
  %190 = load ptr, ptr %9, align 8
  %191 = getelementptr inbounds %struct.buf, ptr %190, i32 0, i32 5
  store i16 -1, ptr %191, align 2
  br label %192

192:                                              ; preds = %177, %171
  %193 = load ptr, ptr %9, align 8
  %194 = getelementptr inbounds %struct.buf, ptr %193, i32 0, i32 6
  store i8 0, ptr %194, align 4
  br label %195

195:                                              ; preds = %192, %169
  br label %196

196:                                              ; preds = %195
  %197 = load i32, ptr %11, align 4
  %198 = add nsw i32 %197, 1
  store i32 %198, ptr %11, align 4
  %199 = load ptr, ptr %12, align 8
  %200 = getelementptr inbounds %struct.iorequest_s, ptr %199, i32 1
  store ptr %200, ptr %12, align 8
  br label %147

201:                                              ; preds = %17, %147
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
