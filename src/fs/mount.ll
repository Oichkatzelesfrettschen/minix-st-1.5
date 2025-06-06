; NOTE: Generated from src/fs/mount.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/mount.c'
source_filename = "src/fs/mount.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.mess_3 = type { i32, i32, ptr, [14 x i8] }

@super_user = external global i32, align 4
@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@user_path = external global [255 x i8], align 16
@super_block = external global [5 x %struct.super_block], align 16
@inode = external global [32 x %struct.inode], align 16
@.str = private unnamed_addr constant [10 x i8] c"do_umount\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_mount() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i16, align 2
  %7 = alloca i16, align 2
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = load i32, ptr @super_user, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %14, label %13

13:                                               ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %219

14:                                               ; preds = %0
  %15 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %16 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %17 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %15, i32 noundef %16, i32 noundef 1)
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %14
  %20 = load i32, ptr @err_code, align 4
  store i32 %20, ptr %1, align 4
  br label %219

21:                                               ; preds = %14
  %22 = call zeroext i16 @name_to_dev(ptr noundef @user_path)
  store i16 %22, ptr %6, align 2
  %23 = zext i16 %22 to i32
  %24 = icmp eq i32 %23, 65535
  br i1 %24, label %25, label %27

25:                                               ; preds = %21
  %26 = load i32, ptr @err_code, align 4
  store i32 %26, ptr %1, align 4
  br label %219

27:                                               ; preds = %21
  store ptr null, ptr %5, align 8
  store i32 0, ptr %9, align 4
  store ptr @super_block, ptr %4, align 8
  br label %28

28:                                               ; preds = %49, %27
  %29 = load ptr, ptr %4, align 8
  %30 = icmp ult ptr %29, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %30, label %31, label %52

31:                                               ; preds = %28
  %32 = load ptr, ptr %4, align 8
  %33 = getelementptr inbounds %struct.super_block, ptr %32, i32 0, i32 10
  %34 = load i16, ptr %33, align 8
  %35 = zext i16 %34 to i32
  %36 = load i16, ptr %6, align 2
  %37 = zext i16 %36 to i32
  %38 = icmp eq i32 %35, %37
  br i1 %38, label %39, label %40

39:                                               ; preds = %31
  store i32 1, ptr %9, align 4
  br label %40

40:                                               ; preds = %39, %31
  %41 = load ptr, ptr %4, align 8
  %42 = getelementptr inbounds %struct.super_block, ptr %41, i32 0, i32 10
  %43 = load i16, ptr %42, align 8
  %44 = zext i16 %43 to i32
  %45 = icmp eq i32 %44, 65535
  br i1 %45, label %46, label %48

46:                                               ; preds = %40
  %47 = load ptr, ptr %4, align 8
  store ptr %47, ptr %5, align 8
  br label %48

48:                                               ; preds = %46, %40
  br label %49

49:                                               ; preds = %48
  %50 = load ptr, ptr %4, align 8
  %51 = getelementptr inbounds %struct.super_block, ptr %50, i32 1
  store ptr %51, ptr %4, align 8
  br label %28

52:                                               ; preds = %28
  %53 = load i32, ptr %9, align 4
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %56

55:                                               ; preds = %52
  store i32 -16, ptr %1, align 4
  br label %219

56:                                               ; preds = %52
  %57 = load ptr, ptr %5, align 8
  %58 = icmp eq ptr %57, null
  br i1 %58, label %59, label %60

59:                                               ; preds = %56
  store i32 -23, ptr %1, align 4
  br label %219

60:                                               ; preds = %56
  %61 = load i16, ptr %6, align 2
  %62 = load ptr, ptr %5, align 8
  %63 = getelementptr inbounds %struct.super_block, ptr %62, i32 0, i32 10
  store i16 %61, ptr %63, align 8
  %64 = load ptr, ptr %5, align 8
  call void (ptr, i32, ...) @rw_super(ptr noundef %64, i32 noundef 0)
  %65 = load i16, ptr %6, align 2
  %66 = load ptr, ptr %5, align 8
  %67 = getelementptr inbounds %struct.super_block, ptr %66, i32 0, i32 10
  store i16 %65, ptr %67, align 8
  %68 = load ptr, ptr %5, align 8
  %69 = getelementptr inbounds %struct.super_block, ptr %68, i32 0, i32 7
  %70 = load i16, ptr %69, align 8
  %71 = sext i16 %70 to i32
  %72 = icmp ne i32 %71, 4991
  br i1 %72, label %97, label %73

73:                                               ; preds = %60
  %74 = load ptr, ptr %5, align 8
  %75 = getelementptr inbounds %struct.super_block, ptr %74, i32 0, i32 0
  %76 = load i16, ptr %75, align 8
  %77 = zext i16 %76 to i32
  %78 = icmp slt i32 %77, 1
  br i1 %78, label %97, label %79

79:                                               ; preds = %73
  %80 = load ptr, ptr %5, align 8
  %81 = getelementptr inbounds %struct.super_block, ptr %80, i32 0, i32 1
  %82 = load i16, ptr %81, align 2
  %83 = zext i16 %82 to i32
  %84 = icmp slt i32 %83, 1
  br i1 %84, label %97, label %85

85:                                               ; preds = %79
  %86 = load ptr, ptr %5, align 8
  %87 = getelementptr inbounds %struct.super_block, ptr %86, i32 0, i32 2
  %88 = load i16, ptr %87, align 4
  %89 = zext i16 %88 to i32
  %90 = icmp slt i32 %89, 1
  br i1 %90, label %97, label %91

91:                                               ; preds = %85
  %92 = load ptr, ptr %5, align 8
  %93 = getelementptr inbounds %struct.super_block, ptr %92, i32 0, i32 3
  %94 = load i16, ptr %93, align 2
  %95 = zext i16 %94 to i32
  %96 = icmp slt i32 %95, 1
  br i1 %96, label %97, label %100

97:                                               ; preds = %91, %85, %79, %73, %60
  %98 = load ptr, ptr %5, align 8
  %99 = getelementptr inbounds %struct.super_block, ptr %98, i32 0, i32 10
  store i16 -1, ptr %99, align 8
  store i32 -22, ptr %1, align 4
  br label %219

100:                                              ; preds = %91
  %101 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 4), align 8
  %102 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %103 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %101, i32 noundef %102, i32 noundef 1)
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %109

105:                                              ; preds = %100
  %106 = load ptr, ptr %5, align 8
  %107 = getelementptr inbounds %struct.super_block, ptr %106, i32 0, i32 10
  store i16 -1, ptr %107, align 8
  %108 = load i32, ptr @err_code, align 4
  store i32 %108, ptr %1, align 4
  br label %219

109:                                              ; preds = %100
  %110 = call ptr (ptr, ...) @eat_path(ptr noundef @user_path)
  store ptr %110, ptr %2, align 8
  %111 = icmp eq ptr %110, null
  br i1 %111, label %112, label %116

112:                                              ; preds = %109
  %113 = load ptr, ptr %5, align 8
  %114 = getelementptr inbounds %struct.super_block, ptr %113, i32 0, i32 10
  store i16 -1, ptr %114, align 8
  %115 = load i32, ptr @err_code, align 4
  store i32 %115, ptr %1, align 4
  br label %219

116:                                              ; preds = %109
  store i32 0, ptr %8, align 4
  %117 = load ptr, ptr %2, align 8
  %118 = getelementptr inbounds %struct.inode, ptr %117, i32 0, i32 11
  %119 = load i16, ptr %118, align 4
  %120 = sext i16 %119 to i32
  %121 = icmp sgt i32 %120, 1
  br i1 %121, label %122, label %123

122:                                              ; preds = %116
  store i32 -16, ptr %8, align 4
  br label %123

123:                                              ; preds = %122, %116
  %124 = load ptr, ptr %2, align 8
  %125 = getelementptr inbounds %struct.inode, ptr %124, i32 0, i32 0
  %126 = load i16, ptr %125, align 8
  %127 = zext i16 %126 to i32
  %128 = and i32 %127, 61440
  %129 = trunc i32 %128 to i16
  store i16 %129, ptr %7, align 2
  %130 = load i16, ptr %7, align 2
  %131 = zext i16 %130 to i32
  %132 = icmp eq i32 %131, 24576
  br i1 %132, label %137, label %133

133:                                              ; preds = %123
  %134 = load i16, ptr %7, align 2
  %135 = zext i16 %134 to i32
  %136 = icmp eq i32 %135, 8192
  br i1 %136, label %137, label %138

137:                                              ; preds = %133, %123
  store i32 -20, ptr %8, align 4
  br label %138

138:                                              ; preds = %137, %133
  store ptr null, ptr %3, align 8
  %139 = load i32, ptr %8, align 4
  %140 = icmp eq i32 %139, 0
  br i1 %140, label %141, label %149

141:                                              ; preds = %138
  %142 = load i16, ptr %6, align 2
  %143 = zext i16 %142 to i32
  %144 = call ptr (i32, i32, ...) @get_inode(i32 noundef %143, i32 noundef 1)
  store ptr %144, ptr %3, align 8
  %145 = icmp eq ptr %144, null
  br i1 %145, label %146, label %148

146:                                              ; preds = %141
  %147 = load i32, ptr @err_code, align 4
  store i32 %147, ptr %8, align 4
  br label %148

148:                                              ; preds = %146, %141
  br label %149

149:                                              ; preds = %148, %138
  %150 = load ptr, ptr %3, align 8
  %151 = icmp ne ptr %150, null
  br i1 %151, label %152, label %159

152:                                              ; preds = %149
  %153 = load ptr, ptr %3, align 8
  %154 = getelementptr inbounds %struct.inode, ptr %153, i32 0, i32 0
  %155 = load i16, ptr %154, align 8
  %156 = zext i16 %155 to i32
  %157 = icmp eq i32 %156, 0
  br i1 %157, label %158, label %159

158:                                              ; preds = %152
  store i32 -22, ptr %8, align 4
  br label %159

159:                                              ; preds = %158, %152, %149
  store i32 0, ptr %10, align 4
  %160 = load i32, ptr %8, align 4
  %161 = icmp eq i32 %160, 0
  br i1 %161, label %162, label %169

162:                                              ; preds = %159
  %163 = load i16, ptr %6, align 2
  %164 = zext i16 %163 to i32
  %165 = call i32 (i32, ...) @load_bit_maps(i32 noundef %164)
  %166 = icmp ne i32 %165, 0
  br i1 %166, label %167, label %168

167:                                              ; preds = %162
  store i32 -23, ptr %8, align 4
  br label %168

168:                                              ; preds = %167, %162
  store i32 1, ptr %10, align 4
  br label %169

169:                                              ; preds = %168, %159
  %170 = load i32, ptr %8, align 4
  %171 = icmp eq i32 %170, 0
  br i1 %171, label %172, label %187

172:                                              ; preds = %169
  %173 = load ptr, ptr %2, align 8
  %174 = getelementptr inbounds %struct.inode, ptr %173, i32 0, i32 0
  %175 = load i16, ptr %174, align 8
  %176 = zext i16 %175 to i32
  %177 = and i32 %176, 61440
  %178 = icmp eq i32 %177, 16384
  br i1 %178, label %179, label %187

179:                                              ; preds = %172
  %180 = load ptr, ptr %3, align 8
  %181 = getelementptr inbounds %struct.inode, ptr %180, i32 0, i32 0
  %182 = load i16, ptr %181, align 8
  %183 = zext i16 %182 to i32
  %184 = and i32 %183, 61440
  %185 = icmp ne i32 %184, 16384
  br i1 %185, label %186, label %187

186:                                              ; preds = %179
  store i32 -20, ptr %8, align 4
  br label %187

187:                                              ; preds = %186, %179, %172, %169
  %188 = load i32, ptr %8, align 4
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %190, label %206

190:                                              ; preds = %187
  %191 = load ptr, ptr %2, align 8
  call void (ptr, ...) @put_inode(ptr noundef %191)
  %192 = load ptr, ptr %3, align 8
  call void (ptr, ...) @put_inode(ptr noundef %192)
  %193 = load i32, ptr %10, align 4
  %194 = icmp ne i32 %193, 0
  br i1 %194, label %195, label %199

195:                                              ; preds = %190
  %196 = load i16, ptr %6, align 2
  %197 = zext i16 %196 to i32
  %198 = call i32 (i32, ...) @unload_bit_maps(i32 noundef %197)
  br label %199

199:                                              ; preds = %195, %190
  %200 = call i32 (...) @do_sync()
  %201 = load i16, ptr %6, align 2
  %202 = zext i16 %201 to i32
  call void (i32, ...) @invalidate(i32 noundef %202)
  %203 = load ptr, ptr %5, align 8
  %204 = getelementptr inbounds %struct.super_block, ptr %203, i32 0, i32 10
  store i16 -1, ptr %204, align 8
  %205 = load i32, ptr %8, align 4
  store i32 %205, ptr %1, align 4
  br label %219

206:                                              ; preds = %187
  %207 = load ptr, ptr %2, align 8
  %208 = getelementptr inbounds %struct.inode, ptr %207, i32 0, i32 14
  store i8 1, ptr %208, align 8
  %209 = load ptr, ptr %2, align 8
  %210 = load ptr, ptr %5, align 8
  %211 = getelementptr inbounds %struct.super_block, ptr %210, i32 0, i32 12
  store ptr %209, ptr %211, align 8
  %212 = load ptr, ptr %3, align 8
  %213 = load ptr, ptr %5, align 8
  %214 = getelementptr inbounds %struct.super_block, ptr %213, i32 0, i32 11
  store ptr %212, ptr %214, align 8
  %215 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %216 = trunc i32 %215 to i8
  %217 = load ptr, ptr %5, align 8
  %218 = getelementptr inbounds %struct.super_block, ptr %217, i32 0, i32 14
  store i8 %216, ptr %218, align 8
  store i32 0, ptr %1, align 4
  br label %219

219:                                              ; preds = %206, %199, %112, %105, %97, %59, %55, %25, %19, %13
  %220 = load i32, ptr %1, align 4
  ret i32 %220
}

declare i32 @fetch_name(...) #1

declare void @rw_super(...) #1

declare ptr @eat_path(...) #1

declare ptr @get_inode(...) #1

declare i32 @load_bit_maps(...) #1

declare void @put_inode(...) #1

declare i32 @unload_bit_maps(...) #1

declare i32 @do_sync(...) #1

declare void @invalidate(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_umount() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  %6 = alloca i32, align 4
  %7 = load i32, ptr @super_user, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %0
  store i32 -1, ptr %1, align 4
  br label %106

10:                                               ; preds = %0
  %11 = load ptr, ptr getelementptr inbounds (%struct.mess_3, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 2), align 8
  %12 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %13 = call i32 (ptr, i32, i32, ...) @fetch_name(ptr noundef %11, i32 noundef %12, i32 noundef 3)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %10
  %16 = load i32, ptr @err_code, align 4
  store i32 %16, ptr %1, align 4
  br label %106

17:                                               ; preds = %10
  %18 = call zeroext i16 @name_to_dev(ptr noundef @user_path)
  store i16 %18, ptr %5, align 2
  %19 = zext i16 %18 to i32
  %20 = icmp eq i32 %19, 65535
  br i1 %20, label %21, label %23

21:                                               ; preds = %17
  %22 = load i32, ptr @err_code, align 4
  store i32 %22, ptr %1, align 4
  br label %106

23:                                               ; preds = %17
  store i32 0, ptr %6, align 4
  store ptr @inode, ptr %2, align 8
  br label %24

24:                                               ; preds = %49, %23
  %25 = load ptr, ptr %2, align 8
  %26 = icmp ult ptr %25, getelementptr inbounds ([32 x %struct.inode], ptr @inode, i64 0, i64 32)
  br i1 %26, label %27, label %52

27:                                               ; preds = %24
  %28 = load ptr, ptr %2, align 8
  %29 = getelementptr inbounds %struct.inode, ptr %28, i32 0, i32 11
  %30 = load i16, ptr %29, align 4
  %31 = sext i16 %30 to i32
  %32 = icmp sgt i32 %31, 0
  br i1 %32, label %33, label %48

33:                                               ; preds = %27
  %34 = load ptr, ptr %2, align 8
  %35 = getelementptr inbounds %struct.inode, ptr %34, i32 0, i32 9
  %36 = load i16, ptr %35, align 8
  %37 = zext i16 %36 to i32
  %38 = load i16, ptr %5, align 2
  %39 = zext i16 %38 to i32
  %40 = icmp eq i32 %37, %39
  br i1 %40, label %41, label %48

41:                                               ; preds = %33
  %42 = load ptr, ptr %2, align 8
  %43 = getelementptr inbounds %struct.inode, ptr %42, i32 0, i32 11
  %44 = load i16, ptr %43, align 4
  %45 = sext i16 %44 to i32
  %46 = load i32, ptr %6, align 4
  %47 = add nsw i32 %46, %45
  store i32 %47, ptr %6, align 4
  br label %48

48:                                               ; preds = %41, %33, %27
  br label %49

49:                                               ; preds = %48
  %50 = load ptr, ptr %2, align 8
  %51 = getelementptr inbounds %struct.inode, ptr %50, i32 1
  store ptr %51, ptr %2, align 8
  br label %24

52:                                               ; preds = %24
  %53 = load i32, ptr %6, align 4
  %54 = icmp sgt i32 %53, 1
  br i1 %54, label %55, label %56

55:                                               ; preds = %52
  store i32 -16, ptr %1, align 4
  br label %106

56:                                               ; preds = %52
  store ptr null, ptr %3, align 8
  store ptr @super_block, ptr %4, align 8
  br label %57

57:                                               ; preds = %71, %56
  %58 = load ptr, ptr %4, align 8
  %59 = icmp ult ptr %58, getelementptr inbounds ([5 x %struct.super_block], ptr @super_block, i64 0, i64 5)
  br i1 %59, label %60, label %74

60:                                               ; preds = %57
  %61 = load ptr, ptr %4, align 8
  %62 = getelementptr inbounds %struct.super_block, ptr %61, i32 0, i32 10
  %63 = load i16, ptr %62, align 8
  %64 = zext i16 %63 to i32
  %65 = load i16, ptr %5, align 2
  %66 = zext i16 %65 to i32
  %67 = icmp eq i32 %64, %66
  br i1 %67, label %68, label %70

68:                                               ; preds = %60
  %69 = load ptr, ptr %4, align 8
  store ptr %69, ptr %3, align 8
  br label %74

70:                                               ; preds = %60
  br label %71

71:                                               ; preds = %70
  %72 = load ptr, ptr %4, align 8
  %73 = getelementptr inbounds %struct.super_block, ptr %72, i32 1
  store ptr %73, ptr %4, align 8
  br label %57

74:                                               ; preds = %68, %57
  %75 = load ptr, ptr %3, align 8
  %76 = icmp ne ptr %75, null
  br i1 %76, label %77, label %84

77:                                               ; preds = %74
  %78 = load i16, ptr %5, align 2
  %79 = zext i16 %78 to i32
  %80 = call i32 (i32, ...) @unload_bit_maps(i32 noundef %79)
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %82, label %83

82:                                               ; preds = %77
  call void (ptr, i32, ...) @panic(ptr noundef @.str, i32 noundef 32768)
  br label %83

83:                                               ; preds = %82, %77
  br label %84

84:                                               ; preds = %83, %74
  %85 = call i32 (...) @do_sync()
  %86 = load i16, ptr %5, align 2
  %87 = zext i16 %86 to i32
  call void (i32, ...) @invalidate(i32 noundef %87)
  %88 = load ptr, ptr %3, align 8
  %89 = icmp eq ptr %88, null
  br i1 %89, label %90, label %91

90:                                               ; preds = %84
  store i32 -22, ptr %1, align 4
  br label %106

91:                                               ; preds = %84
  %92 = load ptr, ptr %3, align 8
  %93 = getelementptr inbounds %struct.super_block, ptr %92, i32 0, i32 12
  %94 = load ptr, ptr %93, align 8
  %95 = getelementptr inbounds %struct.inode, ptr %94, i32 0, i32 14
  store i8 0, ptr %95, align 8
  %96 = load ptr, ptr %3, align 8
  %97 = getelementptr inbounds %struct.super_block, ptr %96, i32 0, i32 12
  %98 = load ptr, ptr %97, align 8
  call void (ptr, ...) @put_inode(ptr noundef %98)
  %99 = load ptr, ptr %3, align 8
  %100 = getelementptr inbounds %struct.super_block, ptr %99, i32 0, i32 11
  %101 = load ptr, ptr %100, align 8
  call void (ptr, ...) @put_inode(ptr noundef %101)
  %102 = load ptr, ptr %3, align 8
  %103 = getelementptr inbounds %struct.super_block, ptr %102, i32 0, i32 12
  store ptr null, ptr %103, align 8
  %104 = load ptr, ptr %3, align 8
  %105 = getelementptr inbounds %struct.super_block, ptr %104, i32 0, i32 10
  store i16 -1, ptr %105, align 8
  store i32 0, ptr %1, align 4
  br label %106

106:                                              ; preds = %91, %90, %55, %21, %15, %9
  %107 = load i32, ptr %1, align 4
  ret i32 %107
}

declare void @panic(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i16 @name_to_dev(ptr noundef %0) #0 {
  %2 = alloca i16, align 2
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i16, align 2
  store ptr %0, ptr %3, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = call ptr (ptr, ...) @eat_path(ptr noundef %6)
  store ptr %7, ptr %4, align 8
  %8 = icmp eq ptr %7, null
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  store i16 -1, ptr %2, align 2
  br label %26

10:                                               ; preds = %1
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.inode, ptr %11, i32 0, i32 0
  %13 = load i16, ptr %12, align 8
  %14 = zext i16 %13 to i32
  %15 = and i32 %14, 61440
  %16 = icmp ne i32 %15, 24576
  br i1 %16, label %17, label %19

17:                                               ; preds = %10
  store i32 -15, ptr @err_code, align 4
  %18 = load ptr, ptr %4, align 8
  call void (ptr, ...) @put_inode(ptr noundef %18)
  store i16 -1, ptr %2, align 2
  br label %26

19:                                               ; preds = %10
  %20 = load ptr, ptr %4, align 8
  %21 = getelementptr inbounds %struct.inode, ptr %20, i32 0, i32 6
  %22 = getelementptr inbounds [9 x i16], ptr %21, i64 0, i64 0
  %23 = load i16, ptr %22, align 2
  store i16 %23, ptr %5, align 2
  %24 = load ptr, ptr %4, align 8
  call void (ptr, ...) @put_inode(ptr noundef %24)
  %25 = load i16, ptr %5, align 2
  store i16 %25, ptr %2, align 2
  br label %26

26:                                               ; preds = %19, %17, %9
  %27 = load i16, ptr %2, align 2
  ret i16 %27
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
