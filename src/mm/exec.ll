; NOTE: Generated from src/mm/exec.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/exec.c'
source_filename = "src/mm/exec.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%union.u = type { [1024 x i8] }
%struct.stat = type { i16, i16, i16, i16, i16, i16, i16, i64, i64, i64, i64 }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }

@mp = external global ptr, align 8
@mm_in = external global %struct.message, align 8
@who = external global i32, align 4
@.str = private unnamed_addr constant [23 x i8] c"do_exec stack copy err\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"MM hole list is inconsistent\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_exec() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [4096 x i8], align 16
  %8 = alloca %union.u, align 1
  %9 = alloca ptr, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  %19 = alloca i32, align 4
  %20 = alloca %struct.stat, align 8
  %21 = load ptr, ptr @mp, align 8
  store ptr %21, ptr %2, align 8
  %22 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 1), align 4
  %23 = sext i32 %22 to i64
  store i64 %23, ptr %15, align 8
  %24 = load i64, ptr %15, align 8
  %25 = icmp sgt i64 %24, 4096
  br i1 %25, label %26, label %27

26:                                               ; preds = %0
  store i32 -12, ptr %1, align 4
  br label %218

27:                                               ; preds = %0
  %28 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %29 = icmp sle i32 %28, 0
  br i1 %29, label %33, label %30

30:                                               ; preds = %27
  %31 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %32 = icmp sgt i32 %31, 255
  br i1 %32, label %33, label %34

33:                                               ; preds = %30, %27
  store i32 -22, ptr %1, align 4
  br label %218

34:                                               ; preds = %30
  %35 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 3), align 8
  %36 = ptrtoint ptr %35 to i64
  store i64 %36, ptr %10, align 8
  %37 = getelementptr inbounds [255 x i8], ptr %8, i64 0, i64 0
  %38 = ptrtoint ptr %37 to i64
  store i64 %38, ptr %11, align 8
  %39 = load i32, ptr @who, align 4
  %40 = load i64, ptr %10, align 8
  %41 = load i64, ptr %11, align 8
  %42 = load i32, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), align 8
  %43 = sext i32 %42 to i64
  %44 = call i32 (i32, i32, i64, i32, i32, i64, i64, ...) @mem_copy(i32 noundef %39, i32 noundef 1, i64 noundef %40, i32 noundef 0, i32 noundef 1, i64 noundef %41, i64 noundef %43)
  store i32 %44, ptr %4, align 4
  %45 = load i32, ptr %4, align 4
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %47, label %49

47:                                               ; preds = %34
  %48 = load i32, ptr %4, align 4
  store i32 %48, ptr %1, align 4
  br label %218

49:                                               ; preds = %34
  %50 = load i32, ptr @who, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef %50, i32 noundef 0, i32 noundef 0)
  %51 = getelementptr inbounds [255 x i8], ptr %8, i64 0, i64 0
  %52 = call i32 (ptr, ptr, i32, ...) @allowed(ptr noundef %51, ptr noundef %20, i32 noundef 1)
  store i32 %52, ptr %5, align 4
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 12, i32 noundef 0, i32 noundef 1, i32 noundef 0)
  %53 = load i32, ptr %5, align 4
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %55, label %57

55:                                               ; preds = %49
  %56 = load i32, ptr %5, align 4
  store i32 %56, ptr %1, align 4
  br label %218

57:                                               ; preds = %49
  %58 = load i64, ptr %15, align 8
  %59 = add nsw i64 %58, 256
  %60 = sub nsw i64 %59, 1
  %61 = ashr i64 %60, 8
  %62 = trunc i64 %61 to i32
  store i32 %62, ptr %19, align 4
  %63 = load i32, ptr %5, align 4
  %64 = load i32, ptr %19, align 4
  %65 = call i32 @read_header(i32 noundef %63, ptr noundef %6, ptr noundef %12, ptr noundef %13, ptr noundef %14, ptr noundef %17, ptr noundef %18, i32 noundef %64)
  store i32 %65, ptr %3, align 4
  %66 = load i32, ptr %3, align 4
  %67 = icmp slt i32 %66, 0
  br i1 %67, label %68, label %71

68:                                               ; preds = %57
  %69 = load i32, ptr %5, align 4
  %70 = call i32 (i32, ...) @close(i32 noundef %69)
  store i32 -8, ptr %1, align 4
  br label %218

71:                                               ; preds = %57
  %72 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 4), align 8
  %73 = ptrtoint ptr %72 to i64
  store i64 %73, ptr %10, align 8
  %74 = getelementptr inbounds [4096 x i8], ptr %7, i64 0, i64 0
  %75 = ptrtoint ptr %74 to i64
  store i64 %75, ptr %11, align 8
  %76 = load i32, ptr @who, align 4
  %77 = load i64, ptr %10, align 8
  %78 = load i64, ptr %11, align 8
  %79 = load i64, ptr %15, align 8
  %80 = call i32 (i32, i32, i64, i32, i32, i64, i64, ...) @mem_copy(i32 noundef %76, i32 noundef 1, i64 noundef %77, i32 noundef 0, i32 noundef 1, i64 noundef %78, i64 noundef %79)
  store i32 %80, ptr %4, align 4
  %81 = load i32, ptr %4, align 4
  %82 = icmp ne i32 %81, 0
  br i1 %82, label %83, label %86

83:                                               ; preds = %71
  %84 = load i32, ptr %5, align 4
  %85 = call i32 (i32, ...) @close(i32 noundef %84)
  store i32 -13, ptr %1, align 4
  br label %218

86:                                               ; preds = %71
  %87 = load i64, ptr %12, align 8
  %88 = load i64, ptr %13, align 8
  %89 = load i64, ptr %14, align 8
  %90 = load i64, ptr %15, align 8
  %91 = load i64, ptr %17, align 8
  %92 = getelementptr inbounds [1024 x i8], ptr %8, i64 0, i64 0
  %93 = call i32 @new_mem(i64 noundef %87, i64 noundef %88, i64 noundef %89, i64 noundef %90, i64 noundef %91, ptr noundef %92, i32 noundef 1024)
  store i32 %93, ptr %4, align 4
  %94 = load i32, ptr %4, align 4
  %95 = icmp ne i32 %94, 0
  br i1 %95, label %96, label %100

96:                                               ; preds = %86
  %97 = load i32, ptr %5, align 4
  %98 = call i32 (i32, ...) @close(i32 noundef %97)
  %99 = load i32, ptr %4, align 4
  store i32 %99, ptr %1, align 4
  br label %218

100:                                              ; preds = %86
  %101 = load ptr, ptr %2, align 8
  %102 = getelementptr inbounds %struct.mproc, ptr %101, i32 0, i32 0
  %103 = getelementptr inbounds [3 x %struct.mem_map], ptr %102, i64 0, i64 2
  %104 = getelementptr inbounds %struct.mem_map, ptr %103, i32 0, i32 0
  %105 = load i32, ptr %104, align 8
  %106 = zext i32 %105 to i64
  %107 = shl i64 %106, 8
  store i64 %107, ptr %16, align 8
  %108 = load ptr, ptr %2, align 8
  %109 = getelementptr inbounds %struct.mproc, ptr %108, i32 0, i32 0
  %110 = getelementptr inbounds [3 x %struct.mem_map], ptr %109, i64 0, i64 2
  %111 = getelementptr inbounds %struct.mem_map, ptr %110, i32 0, i32 2
  %112 = load i32, ptr %111, align 8
  %113 = zext i32 %112 to i64
  %114 = shl i64 %113, 8
  %115 = load i64, ptr %16, align 8
  %116 = add nsw i64 %115, %114
  store i64 %116, ptr %16, align 8
  %117 = load i64, ptr %15, align 8
  %118 = load i64, ptr %16, align 8
  %119 = sub nsw i64 %118, %117
  store i64 %119, ptr %16, align 8
  %120 = getelementptr inbounds [4096 x i8], ptr %7, i64 0, i64 0
  %121 = load i64, ptr %16, align 8
  call void @patch_ptr(ptr noundef %120, i64 noundef %121)
  %122 = getelementptr inbounds [4096 x i8], ptr %7, i64 0, i64 0
  %123 = ptrtoint ptr %122 to i64
  store i64 %123, ptr %10, align 8
  %124 = load i64, ptr %10, align 8
  %125 = load i32, ptr @who, align 4
  %126 = load i64, ptr %16, align 8
  %127 = load i64, ptr %15, align 8
  %128 = call i32 (i32, i32, i64, i32, i32, i64, i64, ...) @mem_copy(i32 noundef 0, i32 noundef 1, i64 noundef %124, i32 noundef %125, i32 noundef 1, i64 noundef %126, i64 noundef %127)
  store i32 %128, ptr %4, align 4
  %129 = load i32, ptr %4, align 4
  %130 = icmp ne i32 %129, 0
  br i1 %130, label %131, label %132

131:                                              ; preds = %100
  call void @panic(ptr noundef @.str, i32 noundef 32768)
  br label %132

132:                                              ; preds = %131, %100
  %133 = load i32, ptr %5, align 4
  %134 = load i64, ptr %12, align 8
  call void @load_seg(i32 noundef %133, i32 noundef 0, i64 noundef %134)
  %135 = load i32, ptr %5, align 4
  %136 = load i64, ptr %13, align 8
  call void @load_seg(i32 noundef %135, i32 noundef 1, i64 noundef %136)
  %137 = load i32, ptr %5, align 4
  %138 = load i64, ptr %18, align 8
  %139 = call i64 (i32, i64, i32, ...) @lseek(i32 noundef %137, i64 noundef %138, i32 noundef 1)
  %140 = icmp slt i64 %139, 0
  br i1 %140, label %141, label %142

141:                                              ; preds = %132
  br label %142

142:                                              ; preds = %141, %132
  %143 = load i32, ptr %5, align 4
  %144 = getelementptr inbounds [4096 x i8], ptr %7, i64 0, i64 0
  %145 = call i32 @relocate(i32 noundef %143, ptr noundef %144)
  %146 = icmp slt i32 %145, 0
  br i1 %146, label %147, label %148

147:                                              ; preds = %142
  br label %148

148:                                              ; preds = %147, %142
  %149 = load i32, ptr %5, align 4
  %150 = call i32 (i32, ...) @close(i32 noundef %149)
  %151 = load ptr, ptr %2, align 8
  %152 = getelementptr inbounds %struct.mproc, ptr %151, i32 0, i32 13
  %153 = load i32, ptr %152, align 8
  %154 = and i32 %153, 64
  %155 = icmp eq i32 %154, 0
  br i1 %155, label %156, label %198

156:                                              ; preds = %148
  %157 = getelementptr inbounds %struct.stat, ptr %20, i32 0, i32 2
  %158 = load i16, ptr %157, align 4
  %159 = zext i16 %158 to i32
  %160 = and i32 %159, 2048
  %161 = icmp ne i32 %160, 0
  br i1 %161, label %162, label %176

162:                                              ; preds = %156
  %163 = getelementptr inbounds %struct.stat, ptr %20, i32 0, i32 4
  %164 = load i16, ptr %163, align 8
  %165 = load ptr, ptr %2, align 8
  %166 = getelementptr inbounds %struct.mproc, ptr %165, i32 0, i32 7
  store i16 %164, ptr %166, align 2
  %167 = load i32, ptr @who, align 4
  %168 = load ptr, ptr %2, align 8
  %169 = getelementptr inbounds %struct.mproc, ptr %168, i32 0, i32 6
  %170 = load i16, ptr %169, align 4
  %171 = zext i16 %170 to i32
  %172 = load ptr, ptr %2, align 8
  %173 = getelementptr inbounds %struct.mproc, ptr %172, i32 0, i32 7
  %174 = load i16, ptr %173, align 2
  %175 = zext i16 %174 to i32
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 23, i32 noundef %167, i32 noundef %171, i32 noundef %175)
  br label %176

176:                                              ; preds = %162, %156
  %177 = getelementptr inbounds %struct.stat, ptr %20, i32 0, i32 2
  %178 = load i16, ptr %177, align 4
  %179 = zext i16 %178 to i32
  %180 = and i32 %179, 1024
  %181 = icmp ne i32 %180, 0
  br i1 %181, label %182, label %197

182:                                              ; preds = %176
  %183 = getelementptr inbounds %struct.stat, ptr %20, i32 0, i32 5
  %184 = load i16, ptr %183, align 2
  %185 = trunc i16 %184 to i8
  %186 = load ptr, ptr %2, align 8
  %187 = getelementptr inbounds %struct.mproc, ptr %186, i32 0, i32 9
  store i8 %185, ptr %187, align 1
  %188 = load i32, ptr @who, align 4
  %189 = load ptr, ptr %2, align 8
  %190 = getelementptr inbounds %struct.mproc, ptr %189, i32 0, i32 8
  %191 = load i8, ptr %190, align 8
  %192 = zext i8 %191 to i32
  %193 = load ptr, ptr %2, align 8
  %194 = getelementptr inbounds %struct.mproc, ptr %193, i32 0, i32 9
  %195 = load i8, ptr %194, align 1
  %196 = zext i8 %195 to i32
  call void (i32, i32, i32, i32, ...) @tell_fs(i32 noundef 46, i32 noundef %188, i32 noundef %192, i32 noundef %196)
  br label %197

197:                                              ; preds = %182, %176
  br label %198

198:                                              ; preds = %197, %148
  %199 = load ptr, ptr %2, align 8
  %200 = getelementptr inbounds %struct.mproc, ptr %199, i32 0, i32 11
  store i16 0, ptr %200, align 4
  %201 = load ptr, ptr %2, align 8
  %202 = getelementptr inbounds %struct.mproc, ptr %201, i32 0, i32 13
  %203 = load i32, ptr %202, align 8
  %204 = and i32 %203, -33
  store i32 %204, ptr %202, align 8
  %205 = load i32, ptr %6, align 4
  %206 = load ptr, ptr %2, align 8
  %207 = getelementptr inbounds %struct.mproc, ptr %206, i32 0, i32 13
  %208 = load i32, ptr %207, align 8
  %209 = or i32 %208, %205
  store i32 %209, ptr %207, align 8
  %210 = load i64, ptr %16, align 8
  %211 = inttoptr i64 %210 to ptr
  store ptr %211, ptr %9, align 8
  %212 = load i32, ptr @who, align 4
  %213 = load ptr, ptr %9, align 8
  %214 = load ptr, ptr %2, align 8
  %215 = getelementptr inbounds %struct.mproc, ptr %214, i32 0, i32 13
  %216 = load i32, ptr %215, align 8
  %217 = and i32 %216, 64
  call void (i32, ptr, i32, ...) @sys_exec(i32 noundef %212, ptr noundef %213, i32 noundef %217)
  store i32 0, ptr %1, align 4
  br label %218

218:                                              ; preds = %198, %96, %83, %68, %55, %47, %33, %26
  %219 = load i32, ptr %1, align 4
  ret i32 %219
}

declare i32 @mem_copy(...) #1

declare void @tell_fs(...) #1

declare i32 @allowed(...) #1

declare i32 @close(...) #1

declare void @panic(ptr noundef, i32 noundef) #1

declare i64 @lseek(...) #1

declare void @sys_exec(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @read_header(i32 noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, ptr noundef %6, i32 noundef %7) #0 {
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca [4 x i64], align 16
  store i32 %0, ptr %10, align 4
  store ptr %1, ptr %11, align 8
  store ptr %2, ptr %12, align 8
  store ptr %3, ptr %13, align 8
  store ptr %4, ptr %14, align 8
  store ptr %5, ptr %15, align 8
  store ptr %6, ptr %16, align 8
  store i32 %7, ptr %17, align 4
  %26 = load i32, ptr %10, align 4
  %27 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 0
  %28 = call i32 (i32, ptr, i32, ...) @read(i32 noundef %26, ptr noundef %27, i32 noundef 32)
  %29 = icmp ne i32 %28, 32
  br i1 %29, label %30, label %31

30:                                               ; preds = %8
  store i32 -8, ptr %9, align 4
  br label %151

31:                                               ; preds = %8
  %32 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 0
  %33 = load i64, ptr %32, align 16
  %34 = and i64 %33, 4279238655
  %35 = icmp ne i64 %34, 67109633
  br i1 %35, label %36, label %37

36:                                               ; preds = %31
  store i32 -8, ptr %9, align 4
  br label %151

37:                                               ; preds = %31
  %38 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 0
  %39 = load i64, ptr %38, align 16
  %40 = and i64 %39, 2097152
  %41 = icmp ne i64 %40, 0
  %42 = zext i1 %41 to i64
  %43 = select i1 %41, i32 32, i32 0
  %44 = load ptr, ptr %11, align 8
  store i32 %43, ptr %44, align 4
  %45 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 2
  %46 = load i64, ptr %45, align 16
  %47 = load ptr, ptr %12, align 8
  store i64 %46, ptr %47, align 8
  %48 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 3
  %49 = load i64, ptr %48, align 8
  %50 = load ptr, ptr %13, align 8
  store i64 %49, ptr %50, align 8
  %51 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 4
  %52 = load i64, ptr %51, align 16
  %53 = load ptr, ptr %14, align 8
  store i64 %52, ptr %53, align 8
  %54 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 7
  %55 = load i64, ptr %54, align 8
  %56 = load ptr, ptr %16, align 8
  store i64 %55, ptr %56, align 8
  %57 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 6
  %58 = load i64, ptr %57, align 16
  %59 = load ptr, ptr %15, align 8
  store i64 %58, ptr %59, align 8
  %60 = load ptr, ptr %15, align 8
  %61 = load i64, ptr %60, align 8
  %62 = icmp eq i64 %61, 0
  br i1 %62, label %63, label %64

63:                                               ; preds = %37
  store i32 -8, ptr %9, align 4
  br label %151

64:                                               ; preds = %37
  %65 = load ptr, ptr %11, align 8
  %66 = load i32, ptr %65, align 4
  %67 = icmp ne i32 %66, 32
  br i1 %67, label %68, label %89

68:                                               ; preds = %64
  %69 = load ptr, ptr %12, align 8
  %70 = load i64, ptr %69, align 8
  %71 = load ptr, ptr %13, align 8
  %72 = load i64, ptr %71, align 8
  %73 = add nsw i64 %72, %70
  store i64 %73, ptr %71, align 8
  %74 = load ptr, ptr %12, align 8
  %75 = load i64, ptr %74, align 8
  %76 = ashr i64 %75, 8
  %77 = shl i64 %76, 8
  %78 = load ptr, ptr %12, align 8
  store i64 %77, ptr %78, align 8
  %79 = load ptr, ptr %12, align 8
  %80 = load i64, ptr %79, align 8
  %81 = load ptr, ptr %13, align 8
  %82 = load i64, ptr %81, align 8
  %83 = sub nsw i64 %82, %80
  store i64 %83, ptr %81, align 8
  %84 = load ptr, ptr %12, align 8
  %85 = load i64, ptr %84, align 8
  %86 = load ptr, ptr %15, align 8
  %87 = load i64, ptr %86, align 8
  %88 = sub nsw i64 %87, %85
  store i64 %88, ptr %86, align 8
  br label %89

89:                                               ; preds = %68, %64
  %90 = load ptr, ptr %12, align 8
  %91 = load i64, ptr %90, align 8
  %92 = add nsw i64 %91, 256
  %93 = sub nsw i64 %92, 1
  %94 = ashr i64 %93, 8
  %95 = trunc i64 %94 to i32
  store i32 %95, ptr %20, align 4
  %96 = load ptr, ptr %13, align 8
  %97 = load i64, ptr %96, align 8
  %98 = load ptr, ptr %14, align 8
  %99 = load i64, ptr %98, align 8
  %100 = add nsw i64 %97, %99
  %101 = add nsw i64 %100, 256
  %102 = sub nsw i64 %101, 1
  %103 = ashr i64 %102, 8
  %104 = trunc i64 %103 to i32
  store i32 %104, ptr %21, align 4
  %105 = load ptr, ptr %15, align 8
  %106 = load i64, ptr %105, align 8
  %107 = add nsw i64 %106, 256
  %108 = sub nsw i64 %107, 1
  %109 = ashr i64 %108, 8
  %110 = trunc i64 %109 to i32
  store i32 %110, ptr %24, align 4
  %111 = load i32, ptr %21, align 4
  %112 = load i32, ptr %24, align 4
  %113 = icmp uge i32 %111, %112
  br i1 %113, label %114, label %115

114:                                              ; preds = %89
  store i32 -8, ptr %9, align 4
  br label %151

115:                                              ; preds = %89
  %116 = load ptr, ptr %11, align 8
  %117 = load i32, ptr %116, align 4
  %118 = icmp eq i32 %117, 32
  br i1 %118, label %119, label %120

119:                                              ; preds = %115
  br label %122

120:                                              ; preds = %115
  %121 = load i32, ptr %20, align 4
  br label %122

122:                                              ; preds = %120, %119
  %123 = phi i32 [ 0, %119 ], [ %121, %120 ]
  store i32 %123, ptr %23, align 4
  %124 = load i32, ptr %23, align 4
  %125 = load i32, ptr %24, align 4
  %126 = load i32, ptr %17, align 4
  %127 = sub i32 %125, %126
  %128 = add i32 %124, %127
  store i32 %128, ptr %22, align 4
  %129 = load ptr, ptr %11, align 8
  %130 = load i32, ptr %129, align 4
  %131 = load i32, ptr %20, align 4
  %132 = load i32, ptr %21, align 4
  %133 = load i32, ptr %17, align 4
  %134 = load i32, ptr %23, align 4
  %135 = load i32, ptr %22, align 4
  %136 = call i32 (i32, i32, i32, i32, i32, i32, ...) @size_ok(i32 noundef %130, i32 noundef %131, i32 noundef %132, i32 noundef %133, i32 noundef %134, i32 noundef %135)
  store i32 %136, ptr %18, align 4
  %137 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 1
  %138 = load i64, ptr %137, align 8
  %139 = and i64 %138, 255
  %140 = trunc i64 %139 to i32
  store i32 %140, ptr %19, align 4
  %141 = load i32, ptr %19, align 4
  %142 = icmp sgt i32 %141, 32
  br i1 %142, label %143, label %149

143:                                              ; preds = %122
  %144 = load i32, ptr %10, align 4
  %145 = getelementptr inbounds [4 x i64], ptr %25, i64 0, i64 0
  %146 = load i32, ptr %19, align 4
  %147 = sub nsw i32 %146, 32
  %148 = call i32 (i32, ptr, i32, ...) @read(i32 noundef %144, ptr noundef %145, i32 noundef %147)
  br label %149

149:                                              ; preds = %143, %122
  %150 = load i32, ptr %18, align 4
  store i32 %150, ptr %9, align 4
  br label %151

151:                                              ; preds = %149, %114, %63, %36, %30
  %152 = load i32, ptr %9, align 4
  ret i32 %152
}

declare i32 @read(...) #1

declare i32 @size_ok(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @new_mem(i64 noundef %0, i64 noundef %1, i64 noundef %2, i64 noundef %3, i64 noundef %4, ptr noundef %5, i32 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i64, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  store i64 %0, ptr %9, align 8
  store i64 %1, ptr %10, align 8
  store i64 %2, ptr %11, align 8
  store i64 %3, ptr %12, align 8
  store i64 %4, ptr %13, align 8
  store ptr %5, ptr %14, align 8
  store i32 %6, ptr %15, align 4
  %25 = load i64, ptr %9, align 8
  %26 = add nsw i64 %25, 256
  %27 = sub nsw i64 %26, 1
  %28 = ashr i64 %27, 8
  %29 = trunc i64 %28 to i32
  store i32 %29, ptr %17, align 4
  %30 = load i64, ptr %10, align 8
  %31 = load i64, ptr %11, align 8
  %32 = add nsw i64 %30, %31
  %33 = add nsw i64 %32, 256
  %34 = sub nsw i64 %33, 1
  %35 = ashr i64 %34, 8
  %36 = trunc i64 %35 to i32
  store i32 %36, ptr %18, align 4
  %37 = load i64, ptr %12, align 8
  %38 = add nsw i64 %37, 256
  %39 = sub nsw i64 %38, 1
  %40 = ashr i64 %39, 8
  %41 = trunc i64 %40 to i32
  store i32 %41, ptr %20, align 4
  %42 = load i64, ptr %13, align 8
  %43 = add nsw i64 %42, 256
  %44 = sub nsw i64 %43, 1
  %45 = ashr i64 %44, 8
  %46 = trunc i64 %45 to i32
  store i32 %46, ptr %21, align 4
  %47 = load i32, ptr %21, align 4
  %48 = load i32, ptr %18, align 4
  %49 = sub i32 %47, %48
  %50 = load i32, ptr %20, align 4
  %51 = sub i32 %49, %50
  store i32 %51, ptr %19, align 4
  %52 = load i32, ptr %19, align 4
  %53 = icmp slt i32 %52, 0
  br i1 %53, label %54, label %55

54:                                               ; preds = %7
  store i32 -12, ptr %8, align 4
  br label %149

55:                                               ; preds = %7
  %56 = load i32, ptr %17, align 4
  %57 = load i32, ptr %21, align 4
  %58 = add i32 %56, %57
  %59 = call i32 @max_hole()
  %60 = icmp ugt i32 %58, %59
  br i1 %60, label %61, label %62

61:                                               ; preds = %55
  store i32 -11, ptr %8, align 4
  br label %149

62:                                               ; preds = %55
  %63 = load ptr, ptr @mp, align 8
  store ptr %63, ptr %16, align 8
  %64 = load i32, ptr %17, align 4
  %65 = load i32, ptr %21, align 4
  %66 = add i32 %64, %65
  %67 = call i32 @alloc_mem(i32 noundef %66)
  store i32 %67, ptr %22, align 4
  %68 = load i32, ptr %22, align 4
  %69 = icmp eq i32 %68, 0
  br i1 %69, label %70, label %71

70:                                               ; preds = %62
  call void @panic(ptr noundef @.str.1, i32 noundef 32768)
  br label %71

71:                                               ; preds = %70, %62
  %72 = load i32, ptr %17, align 4
  %73 = load ptr, ptr %16, align 8
  %74 = getelementptr inbounds %struct.mproc, ptr %73, i32 0, i32 0
  %75 = getelementptr inbounds [3 x %struct.mem_map], ptr %74, i64 0, i64 0
  %76 = getelementptr inbounds %struct.mem_map, ptr %75, i32 0, i32 2
  store i32 %72, ptr %76, align 8
  %77 = load i32, ptr %22, align 4
  %78 = load ptr, ptr %16, align 8
  %79 = getelementptr inbounds %struct.mproc, ptr %78, i32 0, i32 0
  %80 = getelementptr inbounds [3 x %struct.mem_map], ptr %79, i64 0, i64 0
  %81 = getelementptr inbounds %struct.mem_map, ptr %80, i32 0, i32 1
  store i32 %77, ptr %81, align 4
  %82 = load i32, ptr %18, align 4
  %83 = load ptr, ptr %16, align 8
  %84 = getelementptr inbounds %struct.mproc, ptr %83, i32 0, i32 0
  %85 = getelementptr inbounds [3 x %struct.mem_map], ptr %84, i64 0, i64 1
  %86 = getelementptr inbounds %struct.mem_map, ptr %85, i32 0, i32 2
  store i32 %82, ptr %86, align 4
  %87 = load i32, ptr %22, align 4
  %88 = load i32, ptr %17, align 4
  %89 = add i32 %87, %88
  %90 = load ptr, ptr %16, align 8
  %91 = getelementptr inbounds %struct.mproc, ptr %90, i32 0, i32 0
  %92 = getelementptr inbounds [3 x %struct.mem_map], ptr %91, i64 0, i64 1
  %93 = getelementptr inbounds %struct.mem_map, ptr %92, i32 0, i32 1
  store i32 %89, ptr %93, align 4
  %94 = load i32, ptr %20, align 4
  %95 = load ptr, ptr %16, align 8
  %96 = getelementptr inbounds %struct.mproc, ptr %95, i32 0, i32 0
  %97 = getelementptr inbounds [3 x %struct.mem_map], ptr %96, i64 0, i64 2
  %98 = getelementptr inbounds %struct.mem_map, ptr %97, i32 0, i32 2
  store i32 %94, ptr %98, align 8
  %99 = load ptr, ptr %16, align 8
  %100 = getelementptr inbounds %struct.mproc, ptr %99, i32 0, i32 0
  %101 = getelementptr inbounds [3 x %struct.mem_map], ptr %100, i64 0, i64 1
  %102 = getelementptr inbounds %struct.mem_map, ptr %101, i32 0, i32 1
  %103 = load i32, ptr %102, align 4
  %104 = load i32, ptr %18, align 4
  %105 = add i32 %103, %104
  %106 = load i32, ptr %19, align 4
  %107 = add i32 %105, %106
  %108 = load ptr, ptr %16, align 8
  %109 = getelementptr inbounds %struct.mproc, ptr %108, i32 0, i32 0
  %110 = getelementptr inbounds [3 x %struct.mem_map], ptr %109, i64 0, i64 2
  %111 = getelementptr inbounds %struct.mem_map, ptr %110, i32 0, i32 1
  store i32 %107, ptr %111, align 4
  %112 = load ptr, ptr %16, align 8
  %113 = getelementptr inbounds %struct.mproc, ptr %112, i32 0, i32 0
  %114 = getelementptr inbounds [3 x %struct.mem_map], ptr %113, i64 0, i64 0
  %115 = getelementptr inbounds %struct.mem_map, ptr %114, i32 0, i32 1
  %116 = load i32, ptr %115, align 4
  %117 = load ptr, ptr %16, align 8
  %118 = getelementptr inbounds %struct.mproc, ptr %117, i32 0, i32 0
  %119 = getelementptr inbounds [3 x %struct.mem_map], ptr %118, i64 0, i64 0
  %120 = getelementptr inbounds %struct.mem_map, ptr %119, i32 0, i32 0
  store i32 %116, ptr %120, align 8
  %121 = load ptr, ptr %16, align 8
  %122 = getelementptr inbounds %struct.mproc, ptr %121, i32 0, i32 0
  %123 = getelementptr inbounds [3 x %struct.mem_map], ptr %122, i64 0, i64 1
  %124 = getelementptr inbounds %struct.mem_map, ptr %123, i32 0, i32 1
  %125 = load i32, ptr %124, align 4
  %126 = load ptr, ptr %16, align 8
  %127 = getelementptr inbounds %struct.mproc, ptr %126, i32 0, i32 0
  %128 = getelementptr inbounds [3 x %struct.mem_map], ptr %127, i64 0, i64 1
  %129 = getelementptr inbounds %struct.mem_map, ptr %128, i32 0, i32 0
  store i32 %125, ptr %129, align 4
  %130 = load ptr, ptr %16, align 8
  %131 = getelementptr inbounds %struct.mproc, ptr %130, i32 0, i32 0
  %132 = getelementptr inbounds [3 x %struct.mem_map], ptr %131, i64 0, i64 2
  %133 = getelementptr inbounds %struct.mem_map, ptr %132, i32 0, i32 1
  %134 = load i32, ptr %133, align 4
  %135 = load ptr, ptr %16, align 8
  %136 = getelementptr inbounds %struct.mproc, ptr %135, i32 0, i32 0
  %137 = getelementptr inbounds [3 x %struct.mem_map], ptr %136, i64 0, i64 2
  %138 = getelementptr inbounds %struct.mem_map, ptr %137, i32 0, i32 0
  store i32 %134, ptr %138, align 8
  %139 = load i32, ptr @who, align 4
  %140 = load ptr, ptr %16, align 8
  %141 = getelementptr inbounds %struct.mproc, ptr %140, i32 0, i32 0
  %142 = getelementptr inbounds [3 x %struct.mem_map], ptr %141, i64 0, i64 0
  %143 = load i64, ptr %10, align 8
  %144 = ashr i64 %143, 8
  %145 = trunc i64 %144 to i32
  %146 = call i32 (i32, ptr, i32, ptr, ptr, ...) @sys_fresh(i32 noundef %139, ptr noundef %142, i32 noundef %145, ptr noundef %23, ptr noundef %24)
  %147 = load i32, ptr %23, align 4
  %148 = load i32, ptr %24, align 4
  call void @free_mem(i32 noundef %147, i32 noundef %148)
  store i32 0, ptr %8, align 4
  br label %149

149:                                              ; preds = %71, %61, %54
  %150 = load i32, ptr %8, align 4
  ret i32 %150
}

declare i32 @max_hole() #1

declare i32 @alloc_mem(i32 noundef) #1

declare i32 @sys_fresh(...) #1

declare void @free_mem(i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @patch_ptr(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i8, align 1
  %7 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  store i8 0, ptr %6, align 1
  %8 = load ptr, ptr %3, align 8
  store ptr %8, ptr %5, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = getelementptr inbounds ptr, ptr %9, i32 1
  store ptr %10, ptr %5, align 8
  br label %11

11:                                               ; preds = %38, %2
  %12 = load i8, ptr %6, align 1
  %13 = sext i8 %12 to i32
  %14 = icmp slt i32 %13, 2
  br i1 %14, label %15, label %41

15:                                               ; preds = %11
  %16 = load ptr, ptr %5, align 8
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds i8, ptr %17, i64 4096
  %19 = icmp uge ptr %16, %18
  br i1 %19, label %20, label %21

20:                                               ; preds = %15
  br label %41

21:                                               ; preds = %15
  %22 = load ptr, ptr %5, align 8
  %23 = load ptr, ptr %22, align 8
  %24 = icmp ne ptr %23, null
  br i1 %24, label %25, label %35

25:                                               ; preds = %21
  %26 = load ptr, ptr %5, align 8
  %27 = load ptr, ptr %26, align 8
  %28 = ptrtoint ptr %27 to i64
  store i64 %28, ptr %7, align 8
  %29 = load i64, ptr %4, align 8
  %30 = load i64, ptr %7, align 8
  %31 = add nsw i64 %30, %29
  store i64 %31, ptr %7, align 8
  %32 = load i64, ptr %7, align 8
  %33 = inttoptr i64 %32 to ptr
  %34 = load ptr, ptr %5, align 8
  store ptr %33, ptr %34, align 8
  br label %38

35:                                               ; preds = %21
  %36 = load i8, ptr %6, align 1
  %37 = add i8 %36, 1
  store i8 %37, ptr %6, align 1
  br label %38

38:                                               ; preds = %35, %25
  %39 = load ptr, ptr %5, align 8
  %40 = getelementptr inbounds ptr, ptr %39, i32 1
  store ptr %40, ptr %5, align 8
  br label %11

41:                                               ; preds = %20, %11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @load_seg(i32 noundef %0, i32 noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i64 %2, ptr %6, align 8
  %10 = load i32, ptr @who, align 4
  %11 = shl i32 %10, 8
  %12 = load i32, ptr %5, align 4
  %13 = shl i32 %12, 6
  %14 = or i32 %11, %13
  %15 = load i32, ptr %4, align 4
  %16 = or i32 %14, %15
  store i32 %16, ptr %7, align 4
  %17 = load ptr, ptr @mp, align 8
  %18 = getelementptr inbounds %struct.mproc, ptr %17, i32 0, i32 0
  %19 = load i32, ptr %5, align 4
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [3 x %struct.mem_map], ptr %18, i64 0, i64 %20
  %22 = getelementptr inbounds %struct.mem_map, ptr %21, i32 0, i32 0
  %23 = load i32, ptr %22, align 4
  %24 = zext i32 %23 to i64
  %25 = shl i64 %24, 8
  %26 = inttoptr i64 %25 to ptr
  store ptr %26, ptr %9, align 8
  br label %27

27:                                               ; preds = %46, %3
  %28 = load i64, ptr %6, align 8
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %30, label %55

30:                                               ; preds = %27
  store i32 31744, ptr %8, align 4
  %31 = load i64, ptr %6, align 8
  %32 = load i32, ptr %8, align 4
  %33 = sext i32 %32 to i64
  %34 = icmp slt i64 %31, %33
  br i1 %34, label %35, label %38

35:                                               ; preds = %30
  %36 = load i64, ptr %6, align 8
  %37 = trunc i64 %36 to i32
  store i32 %37, ptr %8, align 4
  br label %38

38:                                               ; preds = %35, %30
  %39 = load i32, ptr %7, align 4
  %40 = load ptr, ptr %9, align 8
  %41 = load i32, ptr %8, align 4
  %42 = call i32 (i32, ptr, i32, ...) @read(i32 noundef %39, ptr noundef %40, i32 noundef %41)
  %43 = load i32, ptr %8, align 4
  %44 = icmp ne i32 %42, %43
  br i1 %44, label %45, label %46

45:                                               ; preds = %38
  br label %55

46:                                               ; preds = %38
  %47 = load i32, ptr %8, align 4
  %48 = load ptr, ptr %9, align 8
  %49 = sext i32 %47 to i64
  %50 = getelementptr inbounds i8, ptr %48, i64 %49
  store ptr %50, ptr %9, align 8
  %51 = load i32, ptr %8, align 4
  %52 = sext i32 %51 to i64
  %53 = load i64, ptr %6, align 8
  %54 = sub nsw i64 %53, %52
  store i64 %54, ptr %6, align 8
  br label %27

55:                                               ; preds = %45, %27
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @relocate(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca ptr, align 8
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %12 = load ptr, ptr @mp, align 8
  store ptr %12, ptr %11, align 8
  %13 = load ptr, ptr %11, align 8
  %14 = getelementptr inbounds %struct.mproc, ptr %13, i32 0, i32 0
  %15 = getelementptr inbounds [3 x %struct.mem_map], ptr %14, i64 0, i64 0
  %16 = getelementptr inbounds %struct.mem_map, ptr %15, i32 0, i32 1
  %17 = load i32, ptr %16, align 4
  %18 = zext i32 %17 to i64
  %19 = shl i64 %18, 8
  store i64 %19, ptr %9, align 8
  %20 = load ptr, ptr %5, align 8
  store ptr %20, ptr %7, align 8
  %21 = load i32, ptr %4, align 4
  %22 = load ptr, ptr %7, align 8
  %23 = call i32 (i32, ptr, i32, ...) @read(i32 noundef %21, ptr noundef %22, i32 noundef 4096)
  store i32 %23, ptr %6, align 4
  %24 = load i32, ptr %6, align 4
  %25 = sext i32 %24 to i64
  %26 = icmp ult i64 %25, 8
  br i1 %26, label %27, label %28

27:                                               ; preds = %2
  store i32 -1, ptr %3, align 4
  br label %91

28:                                               ; preds = %2
  %29 = load ptr, ptr %7, align 8
  %30 = load i64, ptr %29, align 8
  %31 = icmp eq i64 %30, 0
  br i1 %31, label %32, label %33

32:                                               ; preds = %28
  store i32 0, ptr %3, align 4
  br label %91

33:                                               ; preds = %28
  %34 = load i64, ptr %9, align 8
  %35 = load ptr, ptr %7, align 8
  %36 = load i64, ptr %35, align 8
  %37 = add nsw i64 %34, %36
  store i64 %37, ptr %10, align 8
  %38 = load i32, ptr %6, align 4
  %39 = sext i32 %38 to i64
  %40 = sub i64 %39, 8
  %41 = trunc i64 %40 to i32
  store i32 %41, ptr %6, align 4
  %42 = load ptr, ptr %7, align 8
  %43 = getelementptr inbounds i8, ptr %42, i64 8
  store ptr %43, ptr %7, align 8
  br label %44

44:                                               ; preds = %85, %33
  %45 = load i64, ptr %9, align 8
  %46 = load i64, ptr %10, align 8
  %47 = inttoptr i64 %46 to ptr
  %48 = load i64, ptr %47, align 8
  %49 = add nsw i64 %48, %45
  store i64 %49, ptr %47, align 8
  br label %50

50:                                               ; preds = %73, %44
  %51 = load i32, ptr %6, align 4
  %52 = add nsw i32 %51, -1
  store i32 %52, ptr %6, align 4
  %53 = icmp slt i32 %52, 0
  br i1 %53, label %54, label %64

54:                                               ; preds = %50
  %55 = load ptr, ptr %5, align 8
  store ptr %55, ptr %7, align 8
  %56 = load i32, ptr %4, align 4
  %57 = load ptr, ptr %7, align 8
  %58 = call i32 (i32, ptr, i32, ...) @read(i32 noundef %56, ptr noundef %57, i32 noundef 4096)
  store i32 %58, ptr %6, align 4
  %59 = load i32, ptr %6, align 4
  %60 = add nsw i32 %59, -1
  store i32 %60, ptr %6, align 4
  %61 = icmp slt i32 %60, 0
  br i1 %61, label %62, label %63

62:                                               ; preds = %54
  store i32 -1, ptr %3, align 4
  br label %91

63:                                               ; preds = %54
  br label %64

64:                                               ; preds = %63, %50
  %65 = load ptr, ptr %7, align 8
  %66 = getelementptr inbounds i8, ptr %65, i32 1
  store ptr %66, ptr %7, align 8
  %67 = load i8, ptr %65, align 1
  %68 = sext i8 %67 to i32
  %69 = and i32 %68, 255
  store i32 %69, ptr %8, align 4
  %70 = load i32, ptr %8, align 4
  %71 = icmp ne i32 %70, 1
  br i1 %71, label %72, label %73

72:                                               ; preds = %64
  br label %76

73:                                               ; preds = %64
  %74 = load i64, ptr %10, align 8
  %75 = add nsw i64 %74, 254
  store i64 %75, ptr %10, align 8
  br label %50

76:                                               ; preds = %72
  %77 = load i32, ptr %8, align 4
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %76
  br label %90

80:                                               ; preds = %76
  %81 = load i32, ptr %8, align 4
  %82 = and i32 %81, 1
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %85

84:                                               ; preds = %80
  store i32 -1, ptr %3, align 4
  br label %91

85:                                               ; preds = %80
  %86 = load i32, ptr %8, align 4
  %87 = sext i32 %86 to i64
  %88 = load i64, ptr %10, align 8
  %89 = add nsw i64 %88, %87
  store i64 %89, ptr %10, align 8
  br label %44

90:                                               ; preds = %79
  store i32 0, ptr %3, align 4
  br label %91

91:                                               ; preds = %90, %84, %62, %32, %27
  %92 = load i32, ptr %3, align 4
  ret i32 %92
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
