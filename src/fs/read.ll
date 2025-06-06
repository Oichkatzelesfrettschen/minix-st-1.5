; NOTE: Generated from src/fs/read.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/fs/read.c'
source_filename = "src/fs/read.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.filp = type { i16, i32, i32, ptr, i64 }
%struct.inode = type { i16, i16, i64, i64, i8, i8, [9 x i16], i64, i64, i16, i16, i16, i8, i8, i8, i8, i8 }
%struct.super_block = type { i16, i16, i16, i16, i16, i16, i64, i16, [8 x ptr], [8 x ptr], i16, ptr, ptr, i64, i8, i8 }
%struct.buf = type { %union.anon.0, ptr, ptr, ptr, i16, i16, i8, i8 }
%union.anon.0 = type { [21 x %struct.d_inode], [16 x i8] }
%struct.d_inode = type { i16, i16, i64, i64, i8, i8, [9 x i16] }
%struct.mess_5 = type { i8, i8, i32, i32, i64, i64, i64 }

@who = external global i32, align 4
@m = external global %struct.message, align 8
@err_code = external global i32, align 4
@rdwt_err = external global i32, align 4
@rdahed_inode = external global ptr, align 8
@rdahedpos = external global i64, align 8
@umess = internal global %struct.message zeroinitializer, align 8
@rahead.read_q = internal global [30 x ptr] zeroinitializer, align 16
@bufs_in_use = external global i32, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_read() #0 {
  %1 = call i32 @read_write(i32 noundef 0)
  ret i32 %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @read_write(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  store i32 %0, ptr %3, align 4
  %21 = load i32, ptr @who, align 4
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %36

23:                                               ; preds = %1
  %24 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %25 = and i32 %24, -256
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %27, label %36

27:                                               ; preds = %23
  %28 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %29 = ashr i32 %28, 8
  %30 = and i32 %29, 255
  store i32 %30, ptr %15, align 4
  %31 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %32 = ashr i32 %31, 6
  %33 = and i32 %32, 3
  store i32 %33, ptr %16, align 4
  %34 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %35 = and i32 %34, 63
  store i32 %35, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  br label %38

36:                                               ; preds = %23, %1
  %37 = load i32, ptr @who, align 4
  store i32 %37, ptr %15, align 4
  store i32 1, ptr %16, align 4
  br label %38

38:                                               ; preds = %36, %27
  %39 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %40 = icmp slt i32 %39, 0
  br i1 %40, label %41, label %42

41:                                               ; preds = %38
  store i32 -22, ptr %2, align 4
  br label %362

42:                                               ; preds = %38
  %43 = load i32, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), align 8
  %44 = call ptr (i32, ...) @get_filp(i32 noundef %43)
  store ptr %44, ptr %5, align 8
  %45 = icmp eq ptr %44, null
  br i1 %45, label %46, label %48

46:                                               ; preds = %42
  %47 = load i32, ptr @err_code, align 4
  store i32 %47, ptr %2, align 4
  br label %362

48:                                               ; preds = %42
  %49 = load ptr, ptr %5, align 8
  %50 = getelementptr inbounds %struct.filp, ptr %49, i32 0, i32 0
  %51 = load i16, ptr %50, align 8
  %52 = zext i16 %51 to i32
  %53 = load i32, ptr %3, align 4
  %54 = icmp eq i32 %53, 0
  %55 = zext i1 %54 to i64
  %56 = select i1 %54, i32 4, i32 2
  %57 = and i32 %52, %56
  %58 = icmp eq i32 %57, 0
  br i1 %58, label %59, label %60

59:                                               ; preds = %48
  store i32 -9, ptr %2, align 4
  br label %362

60:                                               ; preds = %48
  %61 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %62 = icmp eq i32 %61, 0
  br i1 %62, label %63, label %64

63:                                               ; preds = %60
  store i32 0, ptr %2, align 4
  br label %362

64:                                               ; preds = %60
  %65 = load ptr, ptr %5, align 8
  %66 = getelementptr inbounds %struct.filp, ptr %65, i32 0, i32 4
  %67 = load i64, ptr %66, align 8
  store i64 %67, ptr %11, align 8
  %68 = load i64, ptr %11, align 8
  %69 = icmp slt i64 %68, 0
  br i1 %69, label %73, label %70

70:                                               ; preds = %64
  %71 = load i64, ptr %11, align 8
  %72 = icmp sgt i64 %71, 2147483647
  br i1 %72, label %73, label %74

73:                                               ; preds = %70, %64
  store i32 -22, ptr %2, align 4
  br label %362

74:                                               ; preds = %70
  %75 = load ptr, ptr %5, align 8
  %76 = getelementptr inbounds %struct.filp, ptr %75, i32 0, i32 1
  %77 = load i32, ptr %76, align 4
  store i32 %77, ptr %10, align 4
  %78 = load ptr, ptr %5, align 8
  %79 = getelementptr inbounds %struct.filp, ptr %78, i32 0, i32 3
  %80 = load ptr, ptr %79, align 8
  store ptr %80, ptr %4, align 8
  %81 = load ptr, ptr %4, align 8
  %82 = getelementptr inbounds %struct.inode, ptr %81, i32 0, i32 2
  %83 = load i64, ptr %82, align 8
  store i64 %83, ptr %7, align 8
  store i32 0, ptr %12, align 4
  store i32 0, ptr %9, align 4
  %84 = load ptr, ptr %4, align 8
  %85 = getelementptr inbounds %struct.inode, ptr %84, i32 0, i32 0
  %86 = load i16, ptr %85, align 8
  %87 = zext i16 %86 to i32
  %88 = and i32 %87, 61440
  store i32 %88, ptr %14, align 4
  %89 = load i32, ptr %14, align 4
  %90 = icmp eq i32 %89, 32768
  br i1 %90, label %94, label %91

91:                                               ; preds = %74
  %92 = load i32, ptr %14, align 4
  %93 = icmp eq i32 %92, 4096
  br label %94

94:                                               ; preds = %91, %74
  %95 = phi i1 [ true, %74 ], [ %93, %91 ]
  %96 = zext i1 %95 to i32
  store i32 %96, ptr %19, align 4
  %97 = load i32, ptr %14, align 4
  %98 = icmp eq i32 %97, 8192
  %99 = zext i1 %98 to i64
  %100 = select i1 %98, i32 1, i32 0
  store i32 %100, ptr %18, align 4
  %101 = load i32, ptr %14, align 4
  %102 = icmp eq i32 %101, 24576
  %103 = zext i1 %102 to i64
  %104 = select i1 %102, i32 1, i32 0
  store i32 %104, ptr %17, align 4
  %105 = load i32, ptr %17, align 4
  %106 = icmp ne i32 %105, 0
  br i1 %106, label %107, label %111

107:                                              ; preds = %94
  %108 = load i64, ptr %7, align 8
  %109 = icmp eq i64 %108, 0
  br i1 %109, label %110, label %111

110:                                              ; preds = %107
  store i64 2147483647, ptr %7, align 8
  br label %111

111:                                              ; preds = %110, %107, %94
  store i32 0, ptr @rdwt_err, align 4
  %112 = load i32, ptr %18, align 4
  %113 = icmp ne i32 %112, 0
  br i1 %113, label %114, label %136

114:                                              ; preds = %111
  %115 = load i32, ptr %3, align 4
  %116 = load i32, ptr %10, align 4
  %117 = and i32 %116, 2048
  %118 = load ptr, ptr %4, align 8
  %119 = getelementptr inbounds %struct.inode, ptr %118, i32 0, i32 6
  %120 = getelementptr inbounds [9 x i16], ptr %119, i64 0, i64 0
  %121 = load i16, ptr %120, align 2
  %122 = zext i16 %121 to i32
  %123 = load i64, ptr %11, align 8
  %124 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %125 = load i32, ptr @who, align 4
  %126 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %127 = call i32 (i32, i32, i32, i64, i32, i32, ptr, ...) @dev_io(i32 noundef %115, i32 noundef %117, i32 noundef %122, i64 noundef %123, i32 noundef %124, i32 noundef %125, ptr noundef %126)
  store i32 %127, ptr %12, align 4
  %128 = icmp sge i32 %127, 0
  br i1 %128, label %129, label %135

129:                                              ; preds = %114
  %130 = load i32, ptr %12, align 4
  store i32 %130, ptr %9, align 4
  %131 = load i32, ptr %12, align 4
  %132 = sext i32 %131 to i64
  %133 = load i64, ptr %11, align 8
  %134 = add nsw i64 %133, %132
  store i64 %134, ptr %11, align 8
  store i32 0, ptr %12, align 4
  br label %135

135:                                              ; preds = %129, %114
  br label %270

136:                                              ; preds = %111
  %137 = load i32, ptr %3, align 4
  %138 = icmp eq i32 %137, 1
  br i1 %138, label %139, label %170

139:                                              ; preds = %136
  %140 = load i32, ptr %17, align 4
  %141 = icmp eq i32 %140, 0
  br i1 %141, label %142, label %170

142:                                              ; preds = %139
  %143 = load i64, ptr %11, align 8
  %144 = load ptr, ptr %4, align 8
  %145 = getelementptr inbounds %struct.inode, ptr %144, i32 0, i32 9
  %146 = load i16, ptr %145, align 8
  %147 = zext i16 %146 to i32
  %148 = call ptr (i32, ...) @get_super(i32 noundef %147)
  %149 = getelementptr inbounds %struct.super_block, ptr %148, i32 0, i32 6
  %150 = load i64, ptr %149, align 8
  %151 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %152 = sext i32 %151 to i64
  %153 = sub nsw i64 %150, %152
  %154 = icmp sgt i64 %143, %153
  br i1 %154, label %155, label %156

155:                                              ; preds = %142
  store i32 -27, ptr %2, align 4
  br label %362

156:                                              ; preds = %142
  %157 = load i32, ptr %10, align 4
  %158 = and i32 %157, 1024
  %159 = icmp ne i32 %158, 0
  br i1 %159, label %160, label %162

160:                                              ; preds = %156
  %161 = load i64, ptr %7, align 8
  store i64 %161, ptr %11, align 8
  br label %162

162:                                              ; preds = %160, %156
  %163 = load i64, ptr %11, align 8
  %164 = load i64, ptr %7, align 8
  %165 = icmp sgt i64 %163, %164
  br i1 %165, label %166, label %169

166:                                              ; preds = %162
  %167 = load ptr, ptr %4, align 8
  %168 = load i64, ptr %7, align 8
  call void (ptr, i64, i32, ...) @clear_zone(ptr noundef %167, i64 noundef %168, i32 noundef 0)
  br label %169

169:                                              ; preds = %166, %162
  br label %170

170:                                              ; preds = %169, %139, %136
  %171 = load ptr, ptr %4, align 8
  %172 = getelementptr inbounds %struct.inode, ptr %171, i32 0, i32 13
  %173 = load i8, ptr %172, align 1
  %174 = sext i8 %173 to i32
  %175 = icmp ne i32 %174, 0
  br i1 %175, label %176, label %186

176:                                              ; preds = %170
  %177 = load ptr, ptr %4, align 8
  %178 = load i32, ptr %3, align 4
  %179 = load i32, ptr %10, align 4
  %180 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %181 = load i64, ptr %11, align 8
  %182 = call i32 (ptr, i32, i32, i32, i64, ...) @pipe_check(ptr noundef %177, i32 noundef %178, i32 noundef %179, i32 noundef %180, i64 noundef %181)
  store i32 %182, ptr %12, align 4
  %183 = icmp sle i32 %182, 0
  br i1 %183, label %184, label %186

184:                                              ; preds = %176
  %185 = load i32, ptr %12, align 4
  store i32 %185, ptr %2, align 4
  br label %362

186:                                              ; preds = %176, %170
  br label %187

187:                                              ; preds = %254, %186
  %188 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %190, label %269

190:                                              ; preds = %187
  %191 = load i64, ptr %11, align 8
  %192 = srem i64 %191, 1024
  %193 = trunc i64 %192 to i32
  store i32 %193, ptr %8, align 4
  %194 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %195 = load i32, ptr %8, align 4
  %196 = sub i32 1024, %195
  %197 = icmp ult i32 %194, %196
  br i1 %197, label %198, label %200

198:                                              ; preds = %190
  %199 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  br label %203

200:                                              ; preds = %190
  %201 = load i32, ptr %8, align 4
  %202 = sub i32 1024, %201
  br label %203

203:                                              ; preds = %200, %198
  %204 = phi i32 [ %199, %198 ], [ %202, %200 ]
  store i32 %204, ptr %13, align 4
  %205 = load i32, ptr %13, align 4
  %206 = icmp slt i32 %205, 0
  br i1 %206, label %207, label %210

207:                                              ; preds = %203
  %208 = load i32, ptr %8, align 4
  %209 = sub i32 1024, %208
  store i32 %209, ptr %13, align 4
  br label %210

210:                                              ; preds = %207, %203
  %211 = load i32, ptr %3, align 4
  %212 = icmp eq i32 %211, 0
  br i1 %212, label %219, label %213

213:                                              ; preds = %210
  %214 = load i32, ptr %17, align 4
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %216, label %236

216:                                              ; preds = %213
  %217 = load i32, ptr %3, align 4
  %218 = icmp eq i32 %217, 1
  br i1 %218, label %219, label %236

219:                                              ; preds = %216, %210
  %220 = load i64, ptr %7, align 8
  %221 = load i64, ptr %11, align 8
  %222 = sub nsw i64 %220, %221
  store i64 %222, ptr %6, align 8
  %223 = load i64, ptr %11, align 8
  %224 = load i64, ptr %7, align 8
  %225 = icmp sge i64 %223, %224
  br i1 %225, label %226, label %227

226:                                              ; preds = %219
  br label %269

227:                                              ; preds = %219
  %228 = load i32, ptr %13, align 4
  %229 = sext i32 %228 to i64
  %230 = load i64, ptr %6, align 8
  %231 = icmp sgt i64 %229, %230
  br i1 %231, label %232, label %235

232:                                              ; preds = %227
  %233 = load i64, ptr %6, align 8
  %234 = trunc i64 %233 to i32
  store i32 %234, ptr %13, align 4
  br label %235

235:                                              ; preds = %232, %227
  br label %236

236:                                              ; preds = %235, %216, %213
  %237 = load ptr, ptr %4, align 8
  %238 = load i64, ptr %11, align 8
  %239 = load i32, ptr %8, align 4
  %240 = load i32, ptr %13, align 4
  %241 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %242 = load i32, ptr %3, align 4
  %243 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %244 = load i32, ptr %16, align 4
  %245 = load i32, ptr %15, align 4
  %246 = call i32 @rw_chunk(ptr noundef %237, i64 noundef %238, i32 noundef %239, i32 noundef %240, i32 noundef %241, i32 noundef %242, ptr noundef %243, i32 noundef %244, i32 noundef %245)
  store i32 %246, ptr %12, align 4
  %247 = load i32, ptr %12, align 4
  %248 = icmp ne i32 %247, 0
  br i1 %248, label %249, label %250

249:                                              ; preds = %236
  br label %269

250:                                              ; preds = %236
  %251 = load i32, ptr @rdwt_err, align 4
  %252 = icmp slt i32 %251, 0
  br i1 %252, label %253, label %254

253:                                              ; preds = %250
  br label %269

254:                                              ; preds = %250
  %255 = load i32, ptr %13, align 4
  %256 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %257 = sext i32 %255 to i64
  %258 = getelementptr inbounds i8, ptr %256, i64 %257
  store ptr %258, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 3), align 8
  %259 = load i32, ptr %13, align 4
  %260 = load i32, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %261 = sub nsw i32 %260, %259
  store i32 %261, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @m, i32 0, i32 2), i32 0, i32 1), align 4
  %262 = load i32, ptr %13, align 4
  %263 = load i32, ptr %9, align 4
  %264 = add i32 %263, %262
  store i32 %264, ptr %9, align 4
  %265 = load i32, ptr %13, align 4
  %266 = sext i32 %265 to i64
  %267 = load i64, ptr %11, align 8
  %268 = add nsw i64 %267, %266
  store i64 %268, ptr %11, align 8
  br label %187

269:                                              ; preds = %253, %249, %226, %187
  br label %270

270:                                              ; preds = %269, %135
  %271 = load i32, ptr %3, align 4
  %272 = icmp eq i32 %271, 1
  br i1 %272, label %273, label %293

273:                                              ; preds = %270
  %274 = load i32, ptr %19, align 4
  %275 = icmp ne i32 %274, 0
  br i1 %275, label %279, label %276

276:                                              ; preds = %273
  %277 = load i32, ptr %14, align 4
  %278 = icmp eq i32 %277, 16384
  br i1 %278, label %279, label %292

279:                                              ; preds = %276, %273
  %280 = load i64, ptr %11, align 8
  %281 = load i64, ptr %7, align 8
  %282 = icmp sgt i64 %280, %281
  br i1 %282, label %283, label %287

283:                                              ; preds = %279
  %284 = load i64, ptr %11, align 8
  %285 = load ptr, ptr %4, align 8
  %286 = getelementptr inbounds %struct.inode, ptr %285, i32 0, i32 2
  store i64 %284, ptr %286, align 8
  br label %287

287:                                              ; preds = %283, %279
  %288 = load ptr, ptr %4, align 8
  %289 = getelementptr inbounds %struct.inode, ptr %288, i32 0, i32 16
  store i8 8, ptr %289, align 2
  %290 = load ptr, ptr %4, align 8
  %291 = getelementptr inbounds %struct.inode, ptr %290, i32 0, i32 12
  store i8 1, ptr %291, align 2
  br label %292

292:                                              ; preds = %287, %276
  br label %316

293:                                              ; preds = %270
  %294 = load ptr, ptr %4, align 8
  %295 = getelementptr inbounds %struct.inode, ptr %294, i32 0, i32 13
  %296 = load i8, ptr %295, align 1
  %297 = sext i8 %296 to i32
  %298 = icmp ne i32 %297, 0
  br i1 %298, label %299, label %315

299:                                              ; preds = %293
  %300 = load i64, ptr %11, align 8
  %301 = load ptr, ptr %4, align 8
  %302 = getelementptr inbounds %struct.inode, ptr %301, i32 0, i32 2
  %303 = load i64, ptr %302, align 8
  %304 = icmp sge i64 %300, %303
  br i1 %304, label %305, label %315

305:                                              ; preds = %299
  %306 = load ptr, ptr %4, align 8
  %307 = getelementptr inbounds %struct.inode, ptr %306, i32 0, i32 2
  store i64 0, ptr %307, align 8
  store i64 0, ptr %11, align 8
  %308 = load ptr, ptr %4, align 8
  %309 = call ptr (ptr, i32, ...) @find_filp(ptr noundef %308, i32 noundef 2)
  store ptr %309, ptr %20, align 8
  %310 = icmp ne ptr %309, null
  br i1 %310, label %311, label %314

311:                                              ; preds = %305
  %312 = load ptr, ptr %20, align 8
  %313 = getelementptr inbounds %struct.filp, ptr %312, i32 0, i32 4
  store i64 0, ptr %313, align 8
  br label %314

314:                                              ; preds = %311, %305
  br label %315

315:                                              ; preds = %314, %299, %293
  br label %316

316:                                              ; preds = %315, %292
  %317 = load i64, ptr %11, align 8
  %318 = load ptr, ptr %5, align 8
  %319 = getelementptr inbounds %struct.filp, ptr %318, i32 0, i32 4
  store i64 %317, ptr %319, align 8
  %320 = load i32, ptr %3, align 4
  %321 = icmp eq i32 %320, 0
  br i1 %321, label %322, label %341

322:                                              ; preds = %316
  %323 = load ptr, ptr %4, align 8
  %324 = getelementptr inbounds %struct.inode, ptr %323, i32 0, i32 15
  %325 = load i8, ptr %324, align 1
  %326 = sext i8 %325 to i32
  %327 = icmp eq i32 %326, 0
  br i1 %327, label %328, label %341

328:                                              ; preds = %322
  %329 = load i64, ptr %11, align 8
  %330 = srem i64 %329, 1024
  %331 = icmp eq i64 %330, 0
  br i1 %331, label %332, label %341

332:                                              ; preds = %328
  %333 = load i32, ptr %19, align 4
  %334 = icmp ne i32 %333, 0
  br i1 %334, label %338, label %335

335:                                              ; preds = %332
  %336 = load i32, ptr %14, align 4
  %337 = icmp eq i32 %336, 16384
  br i1 %337, label %338, label %341

338:                                              ; preds = %335, %332
  %339 = load ptr, ptr %4, align 8
  store ptr %339, ptr @rdahed_inode, align 8
  %340 = load i64, ptr %11, align 8
  store i64 %340, ptr @rdahedpos, align 8
  br label %341

341:                                              ; preds = %338, %335, %328, %322, %316
  %342 = load ptr, ptr %4, align 8
  %343 = getelementptr inbounds %struct.inode, ptr %342, i32 0, i32 15
  store i8 0, ptr %343, align 1
  %344 = load i32, ptr @rdwt_err, align 4
  %345 = icmp ne i32 %344, 0
  br i1 %345, label %346, label %348

346:                                              ; preds = %341
  %347 = load i32, ptr @rdwt_err, align 4
  store i32 %347, ptr %12, align 4
  br label %348

348:                                              ; preds = %346, %341
  %349 = load i32, ptr @rdwt_err, align 4
  %350 = icmp eq i32 %349, -104
  br i1 %350, label %351, label %353

351:                                              ; preds = %348
  %352 = load i32, ptr %9, align 4
  store i32 %352, ptr %12, align 4
  br label %353

353:                                              ; preds = %351, %348
  %354 = load i32, ptr %12, align 4
  %355 = icmp eq i32 %354, 0
  br i1 %355, label %356, label %358

356:                                              ; preds = %353
  %357 = load i32, ptr %9, align 4
  br label %360

358:                                              ; preds = %353
  %359 = load i32, ptr %12, align 4
  br label %360

360:                                              ; preds = %358, %356
  %361 = phi i32 [ %357, %356 ], [ %359, %358 ]
  store i32 %361, ptr %2, align 4
  br label %362

362:                                              ; preds = %360, %184, %155, %73, %63, %59, %46, %41
  %363 = load i32, ptr %2, align 4
  ret i32 %363
}

declare ptr @get_filp(...) #1

declare i32 @dev_io(...) #1

declare ptr @get_super(...) #1

declare void @clear_zone(...) #1

declare i32 @pipe_check(...) #1

declare ptr @find_filp(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @read_map(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  %14 = load ptr, ptr %4, align 8
  %15 = call i32 (ptr, ...) @scale_factor(ptr noundef %14)
  store i32 %15, ptr %12, align 4
  %16 = load i64, ptr %5, align 8
  %17 = sdiv i64 %16, 1024
  store i64 %17, ptr %11, align 8
  %18 = load i64, ptr %11, align 8
  %19 = load i32, ptr %12, align 4
  %20 = zext i32 %19 to i64
  %21 = ashr i64 %18, %20
  store i64 %21, ptr %10, align 8
  %22 = load i64, ptr %11, align 8
  %23 = load i64, ptr %10, align 8
  %24 = load i32, ptr %12, align 4
  %25 = zext i32 %24 to i64
  %26 = shl i64 %23, %25
  %27 = sub nsw i64 %22, %26
  %28 = trunc i64 %27 to i32
  store i32 %28, ptr %13, align 4
  %29 = load i64, ptr %10, align 8
  %30 = icmp slt i64 %29, 7
  br i1 %30, label %31, label %51

31:                                               ; preds = %2
  %32 = load ptr, ptr %4, align 8
  %33 = getelementptr inbounds %struct.inode, ptr %32, i32 0, i32 6
  %34 = load i64, ptr %10, align 8
  %35 = trunc i64 %34 to i32
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds [9 x i16], ptr %33, i64 0, i64 %36
  %38 = load i16, ptr %37, align 2
  store i16 %38, ptr %7, align 2
  %39 = zext i16 %38 to i32
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %42

41:                                               ; preds = %31
  store i16 0, ptr %3, align 2
  br label %134

42:                                               ; preds = %31
  %43 = load i16, ptr %7, align 2
  %44 = zext i16 %43 to i32
  %45 = load i32, ptr %12, align 4
  %46 = shl i32 %44, %45
  %47 = load i32, ptr %13, align 4
  %48 = add nsw i32 %46, %47
  %49 = trunc i32 %48 to i16
  store i16 %49, ptr %8, align 2
  %50 = load i16, ptr %8, align 2
  store i16 %50, ptr %3, align 2
  br label %134

51:                                               ; preds = %2
  %52 = load i64, ptr %10, align 8
  %53 = sub nsw i64 %52, 7
  store i64 %53, ptr %9, align 8
  %54 = load i64, ptr %9, align 8
  %55 = icmp ult i64 %54, 512
  br i1 %55, label %56, label %61

56:                                               ; preds = %51
  %57 = load ptr, ptr %4, align 8
  %58 = getelementptr inbounds %struct.inode, ptr %57, i32 0, i32 6
  %59 = getelementptr inbounds [9 x i16], ptr %58, i64 0, i64 7
  %60 = load i16, ptr %59, align 2
  store i16 %60, ptr %7, align 2
  br label %95

61:                                               ; preds = %51
  %62 = load ptr, ptr %4, align 8
  %63 = getelementptr inbounds %struct.inode, ptr %62, i32 0, i32 6
  %64 = getelementptr inbounds [9 x i16], ptr %63, i64 0, i64 8
  %65 = load i16, ptr %64, align 2
  store i16 %65, ptr %7, align 2
  %66 = zext i16 %65 to i32
  %67 = icmp eq i32 %66, 0
  br i1 %67, label %68, label %69

68:                                               ; preds = %61
  store i16 0, ptr %3, align 2
  br label %134

69:                                               ; preds = %61
  %70 = load i64, ptr %9, align 8
  %71 = sub i64 %70, 512
  store i64 %71, ptr %9, align 8
  %72 = load i16, ptr %7, align 2
  %73 = zext i16 %72 to i32
  %74 = load i32, ptr %12, align 4
  %75 = shl i32 %73, %74
  %76 = trunc i32 %75 to i16
  store i16 %76, ptr %8, align 2
  %77 = load ptr, ptr %4, align 8
  %78 = getelementptr inbounds %struct.inode, ptr %77, i32 0, i32 9
  %79 = load i16, ptr %78, align 8
  %80 = zext i16 %79 to i32
  %81 = load i16, ptr %8, align 2
  %82 = zext i16 %81 to i32
  %83 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %80, i32 noundef %82, i32 noundef 0)
  store ptr %83, ptr %6, align 8
  %84 = load ptr, ptr %6, align 8
  %85 = getelementptr inbounds %struct.buf, ptr %84, i32 0, i32 0
  %86 = load i64, ptr %9, align 8
  %87 = udiv i64 %86, 512
  %88 = trunc i64 %87 to i32
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [512 x i16], ptr %85, i64 0, i64 %89
  %91 = load i16, ptr %90, align 2
  store i16 %91, ptr %7, align 2
  %92 = load ptr, ptr %6, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %92, i32 noundef 2)
  %93 = load i64, ptr %9, align 8
  %94 = urem i64 %93, 512
  store i64 %94, ptr %9, align 8
  br label %95

95:                                               ; preds = %69, %56
  %96 = load i16, ptr %7, align 2
  %97 = zext i16 %96 to i32
  %98 = icmp eq i32 %97, 0
  br i1 %98, label %99, label %100

99:                                               ; preds = %95
  store i16 0, ptr %3, align 2
  br label %134

100:                                              ; preds = %95
  %101 = load i16, ptr %7, align 2
  %102 = zext i16 %101 to i32
  %103 = load i32, ptr %12, align 4
  %104 = shl i32 %102, %103
  %105 = trunc i32 %104 to i16
  store i16 %105, ptr %8, align 2
  %106 = load ptr, ptr %4, align 8
  %107 = getelementptr inbounds %struct.inode, ptr %106, i32 0, i32 9
  %108 = load i16, ptr %107, align 8
  %109 = zext i16 %108 to i32
  %110 = load i16, ptr %8, align 2
  %111 = zext i16 %110 to i32
  %112 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %109, i32 noundef %111, i32 noundef 0)
  store ptr %112, ptr %6, align 8
  %113 = load ptr, ptr %6, align 8
  %114 = getelementptr inbounds %struct.buf, ptr %113, i32 0, i32 0
  %115 = load i64, ptr %9, align 8
  %116 = trunc i64 %115 to i32
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds [512 x i16], ptr %114, i64 0, i64 %117
  %119 = load i16, ptr %118, align 2
  store i16 %119, ptr %7, align 2
  %120 = load ptr, ptr %6, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %120, i32 noundef 2)
  %121 = load i16, ptr %7, align 2
  %122 = zext i16 %121 to i32
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %124, label %125

124:                                              ; preds = %100
  store i16 0, ptr %3, align 2
  br label %134

125:                                              ; preds = %100
  %126 = load i16, ptr %7, align 2
  %127 = zext i16 %126 to i32
  %128 = load i32, ptr %12, align 4
  %129 = shl i32 %127, %128
  %130 = load i32, ptr %13, align 4
  %131 = add nsw i32 %129, %130
  %132 = trunc i32 %131 to i16
  store i16 %132, ptr %8, align 2
  %133 = load i16, ptr %8, align 2
  store i16 %133, ptr %3, align 2
  br label %134

134:                                              ; preds = %125, %124, %99, %68, %42, %41
  %135 = load i16, ptr %3, align 2
  ret i16 %135
}

declare i32 @scale_factor(...) #1

declare ptr @get_block(...) #1

declare void @put_block(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @rw_user(i32 noundef %0, i32 noundef %1, i64 noundef %2, i64 noundef %3, ptr noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  store i32 %0, ptr %7, align 4
  store i32 %1, ptr %8, align 4
  store i64 %2, ptr %9, align 8
  store i64 %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store i32 %5, ptr %12, align 4
  %13 = load i32, ptr %12, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %22

15:                                               ; preds = %6
  store i8 1, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), align 8
  store i32 1, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 2), align 4
  %16 = load ptr, ptr %11, align 8
  %17 = ptrtoint ptr %16 to i64
  store i64 %17, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 4), align 8
  %18 = load i32, ptr %7, align 4
  %19 = trunc i32 %18 to i8
  store i8 %19, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 1), align 1
  %20 = load i32, ptr %8, align 4
  store i32 %20, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 3), align 8
  %21 = load i64, ptr %9, align 8
  store i64 %21, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 5), align 8
  br label %29

22:                                               ; preds = %6
  %23 = load i32, ptr %7, align 4
  %24 = trunc i32 %23 to i8
  store i8 %24, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), align 8
  %25 = load i32, ptr %8, align 4
  store i32 %25, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 2), align 4
  %26 = load i64, ptr %9, align 8
  store i64 %26, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 4), align 8
  store i8 1, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 1), align 1
  store i32 1, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 3), align 8
  %27 = load ptr, ptr %11, align 8
  %28 = ptrtoint ptr %27 to i64
  store i64 %28, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 5), align 8
  br label %29

29:                                               ; preds = %22, %15
  %30 = load i64, ptr %10, align 8
  store i64 %30, ptr getelementptr inbounds (%struct.mess_5, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 2), i32 0, i32 6), align 8
  call void (ptr, ...) @sys_copy(ptr noundef @umess)
  %31 = load i32, ptr getelementptr inbounds (%struct.message, ptr @umess, i32 0, i32 1), align 4
  ret i32 %31
}

declare void @sys_copy(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @read_ahead() #0 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca i16, align 2
  %4 = load ptr, ptr @rdahed_inode, align 8
  store ptr %4, ptr %1, align 8
  store ptr null, ptr @rdahed_inode, align 8
  %5 = load ptr, ptr %1, align 8
  %6 = load i64, ptr @rdahedpos, align 8
  %7 = call zeroext i16 @read_map(ptr noundef %5, i64 noundef %6)
  store i16 %7, ptr %3, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %0
  br label %18

11:                                               ; preds = %0
  %12 = load ptr, ptr %1, align 8
  %13 = load i16, ptr %3, align 2
  %14 = zext i16 %13 to i32
  %15 = load i64, ptr @rdahedpos, align 8
  %16 = call ptr @rahead(ptr noundef %12, i32 noundef %14, i64 noundef %15, i32 noundef 1024)
  store ptr %16, ptr %2, align 8
  %17 = load ptr, ptr %2, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %17, i32 noundef 7)
  br label %18

18:                                               ; preds = %11, %10
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @rahead(ptr noundef %0, i32 noundef %1, i64 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i16, align 2
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i16, align 2
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca i16, align 2
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = trunc i32 %1 to i16
  store ptr %0, ptr %6, align 8
  store i16 %24, ptr %7, align 2
  store i64 %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  %25 = load ptr, ptr %6, align 8
  %26 = getelementptr inbounds %struct.inode, ptr %25, i32 0, i32 0
  %27 = load i16, ptr %26, align 8
  %28 = zext i16 %27 to i32
  %29 = and i32 %28, 61440
  %30 = icmp eq i32 %29, 24576
  %31 = zext i1 %30 to i32
  store i32 %31, ptr %14, align 4
  %32 = load i32, ptr %14, align 4
  %33 = icmp ne i32 %32, 0
  br i1 %33, label %34, label %39

34:                                               ; preds = %4
  %35 = load ptr, ptr %6, align 8
  %36 = getelementptr inbounds %struct.inode, ptr %35, i32 0, i32 6
  %37 = getelementptr inbounds [9 x i16], ptr %36, i64 0, i64 0
  %38 = load i16, ptr %37, align 2
  store i16 %38, ptr %15, align 2
  br label %43

39:                                               ; preds = %4
  %40 = load ptr, ptr %6, align 8
  %41 = getelementptr inbounds %struct.inode, ptr %40, i32 0, i32 9
  %42 = load i16, ptr %41, align 8
  store i16 %42, ptr %15, align 2
  br label %43

43:                                               ; preds = %39, %34
  %44 = load i16, ptr %15, align 2
  %45 = zext i16 %44 to i32
  %46 = load i16, ptr %7, align 2
  %47 = zext i16 %46 to i32
  %48 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %45, i32 noundef %47, i32 noundef 2)
  store ptr %48, ptr %13, align 8
  %49 = load ptr, ptr %13, align 8
  %50 = getelementptr inbounds %struct.buf, ptr %49, i32 0, i32 5
  %51 = load i16, ptr %50, align 2
  %52 = zext i16 %51 to i32
  %53 = icmp ne i32 %52, 65535
  br i1 %53, label %54, label %56

54:                                               ; preds = %43
  %55 = load ptr, ptr %13, align 8
  store ptr %55, ptr %5, align 8
  br label %219

56:                                               ; preds = %43
  %57 = load i32, ptr %14, align 4
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %63

59:                                               ; preds = %56
  %60 = load ptr, ptr %6, align 8
  %61 = getelementptr inbounds %struct.inode, ptr %60, i32 0, i32 2
  %62 = load i64, ptr %61, align 8
  store i64 %62, ptr %16, align 8
  br label %64

63:                                               ; preds = %56
  store i64 737280, ptr %16, align 8
  br label %64

64:                                               ; preds = %63, %59
  %65 = load i64, ptr %16, align 8
  %66 = icmp eq i64 %65, 0
  br i1 %66, label %67, label %68

67:                                               ; preds = %64
  store i32 17, ptr %12, align 4
  br label %68

68:                                               ; preds = %67, %64
  %69 = load i64, ptr %16, align 8
  %70 = icmp slt i64 %69, 1228800
  br i1 %70, label %71, label %72

71:                                               ; preds = %68
  store i32 9, ptr %12, align 4
  br label %78

72:                                               ; preds = %68
  %73 = load i64, ptr %16, align 8
  %74 = icmp slt i64 %73, 1474560
  br i1 %74, label %75, label %76

75:                                               ; preds = %72
  store i32 15, ptr %12, align 4
  br label %77

76:                                               ; preds = %72
  store i32 18, ptr %12, align 4
  br label %77

77:                                               ; preds = %76, %75
  br label %78

78:                                               ; preds = %77, %71
  %79 = load ptr, ptr %6, align 8
  %80 = getelementptr inbounds %struct.inode, ptr %79, i32 0, i32 2
  %81 = load i64, ptr %80, align 8
  store i64 %81, ptr %17, align 8
  %82 = load i32, ptr %14, align 4
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %88

84:                                               ; preds = %78
  %85 = load i64, ptr %17, align 8
  %86 = icmp eq i64 %85, 0
  br i1 %86, label %87, label %88

87:                                               ; preds = %84
  store i64 2147483647, ptr %17, align 8
  br label %88

88:                                               ; preds = %87, %84, %78
  %89 = load i64, ptr %8, align 8
  %90 = srem i64 %89, 1024
  %91 = trunc i64 %90 to i32
  store i32 %91, ptr %18, align 4
  %92 = load i64, ptr %8, align 8
  %93 = load i32, ptr %18, align 4
  %94 = zext i32 %93 to i64
  %95 = sub nsw i64 %92, %94
  %96 = add nsw i64 %95, 1024
  store i64 %96, ptr %8, align 8
  %97 = load i32, ptr %18, align 4
  %98 = load i32, ptr %9, align 4
  %99 = add i32 %97, %98
  %100 = add i32 %99, 1024
  %101 = sub i32 %100, 1
  %102 = udiv i32 %101, 1024
  %103 = sub i32 %102, 1
  store i32 %103, ptr %11, align 4
  %104 = load i32, ptr %14, align 4
  %105 = icmp ne i32 %104, 0
  %106 = zext i1 %105 to i64
  %107 = select i1 %105, i32 30, i32 28
  store i32 %107, ptr %19, align 4
  %108 = load ptr, ptr %13, align 8
  %109 = getelementptr inbounds %struct.buf, ptr %108, i32 0, i32 4
  %110 = load i16, ptr %109, align 8
  %111 = zext i16 %110 to i32
  %112 = load i32, ptr %12, align 4
  %113 = udiv i32 %111, %112
  store i32 %113, ptr %20, align 4
  store i32 0, ptr %21, align 4
  %114 = load ptr, ptr %13, align 8
  store ptr %114, ptr @rahead.read_q, align 16
  store i32 1, ptr %22, align 4
  br label %115

115:                                              ; preds = %88, %173, %209
  %116 = load i64, ptr %8, align 8
  %117 = load i64, ptr %17, align 8
  %118 = icmp sge i64 %116, %117
  br i1 %118, label %123, label %119

119:                                              ; preds = %115
  %120 = load i32, ptr @bufs_in_use, align 4
  %121 = load i32, ptr %19, align 4
  %122 = icmp uge i32 %120, %121
  br i1 %122, label %123, label %124

123:                                              ; preds = %119, %115
  br label %210

124:                                              ; preds = %119
  %125 = load i32, ptr %11, align 4
  %126 = icmp ne i32 %125, 0
  br i1 %126, label %127, label %130

127:                                              ; preds = %124
  %128 = load i32, ptr %11, align 4
  %129 = add i32 %128, -1
  store i32 %129, ptr %11, align 4
  br label %149

130:                                              ; preds = %124
  %131 = load i32, ptr %21, align 4
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %145, label %133

133:                                              ; preds = %130
  %134 = load ptr, ptr %6, align 8
  %135 = getelementptr inbounds %struct.inode, ptr %134, i32 0, i32 15
  %136 = load i8, ptr %135, align 1
  %137 = sext i8 %136 to i32
  %138 = icmp eq i32 %137, 1
  br i1 %138, label %145, label %139

139:                                              ; preds = %133
  %140 = load i32, ptr %18, align 4
  %141 = load i32, ptr %9, align 4
  %142 = add i32 %140, %141
  %143 = urem i32 %142, 1024
  %144 = icmp ne i32 %143, 0
  br i1 %144, label %145, label %146

145:                                              ; preds = %139, %133, %130
  br label %210

146:                                              ; preds = %139
  %147 = load i32, ptr %12, align 4
  %148 = add i32 %147, 6
  store i32 %148, ptr %11, align 4
  store i32 1, ptr %21, align 4
  br label %149

149:                                              ; preds = %146, %127
  %150 = load i32, ptr %14, align 4
  %151 = icmp ne i32 %150, 0
  br i1 %151, label %152, label %156

152:                                              ; preds = %149
  %153 = load i64, ptr %8, align 8
  %154 = sdiv i64 %153, 1024
  %155 = trunc i64 %154 to i16
  store i16 %155, ptr %10, align 2
  br label %160

156:                                              ; preds = %149
  %157 = load ptr, ptr %6, align 8
  %158 = load i64, ptr %8, align 8
  %159 = call zeroext i16 @read_map(ptr noundef %157, i64 noundef %158)
  store i16 %159, ptr %10, align 2
  br label %160

160:                                              ; preds = %156, %152
  %161 = load i64, ptr %8, align 8
  %162 = add nsw i64 %161, 1024
  store i64 %162, ptr %8, align 8
  %163 = load i16, ptr %10, align 2
  %164 = zext i16 %163 to i32
  %165 = load i32, ptr %12, align 4
  %166 = udiv i32 %164, %165
  store i32 %166, ptr %23, align 4
  %167 = load i32, ptr %21, align 4
  %168 = icmp ne i32 %167, 0
  br i1 %168, label %169, label %175

169:                                              ; preds = %160
  %170 = load i32, ptr %23, align 4
  %171 = load i32, ptr %20, align 4
  %172 = icmp ne i32 %170, %171
  br i1 %172, label %173, label %174

173:                                              ; preds = %169
  br label %115

174:                                              ; preds = %169
  br label %182

175:                                              ; preds = %160
  %176 = load i32, ptr %23, align 4
  %177 = load i32, ptr %20, align 4
  %178 = icmp ugt i32 %176, %177
  br i1 %178, label %179, label %181

179:                                              ; preds = %175
  %180 = load i32, ptr %23, align 4
  store i32 %180, ptr %20, align 4
  br label %181

181:                                              ; preds = %179, %175
  br label %182

182:                                              ; preds = %181, %174
  %183 = load i32, ptr %14, align 4
  %184 = icmp ne i32 %183, 0
  br i1 %184, label %189, label %185

185:                                              ; preds = %182
  %186 = load i16, ptr %10, align 2
  %187 = zext i16 %186 to i32
  %188 = icmp ne i32 %187, 0
  br i1 %188, label %189, label %209

189:                                              ; preds = %185, %182
  %190 = load i16, ptr %15, align 2
  %191 = zext i16 %190 to i32
  %192 = load i16, ptr %10, align 2
  %193 = zext i16 %192 to i32
  %194 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %191, i32 noundef %193, i32 noundef 2)
  store ptr %194, ptr %13, align 8
  %195 = load ptr, ptr %13, align 8
  %196 = getelementptr inbounds %struct.buf, ptr %195, i32 0, i32 5
  %197 = load i16, ptr %196, align 2
  %198 = zext i16 %197 to i32
  %199 = icmp eq i32 %198, 65535
  br i1 %199, label %200, label %206

200:                                              ; preds = %189
  %201 = load ptr, ptr %13, align 8
  %202 = load i32, ptr %22, align 4
  %203 = add nsw i32 %202, 1
  store i32 %203, ptr %22, align 4
  %204 = sext i32 %202 to i64
  %205 = getelementptr inbounds [30 x ptr], ptr @rahead.read_q, i64 0, i64 %204
  store ptr %201, ptr %205, align 8
  br label %208

206:                                              ; preds = %189
  %207 = load ptr, ptr %13, align 8
  call void (ptr, i32, ...) @put_block(ptr noundef %207, i32 noundef 6)
  br label %208

208:                                              ; preds = %206, %200
  br label %209

209:                                              ; preds = %208, %185
  br label %115

210:                                              ; preds = %145, %123
  %211 = load i16, ptr %15, align 2
  %212 = zext i16 %211 to i32
  %213 = load i32, ptr %22, align 4
  call void (i32, ptr, i32, i32, ...) @rw_scattered(i32 noundef %212, ptr noundef @rahead.read_q, i32 noundef %213, i32 noundef 0)
  %214 = load i16, ptr %15, align 2
  %215 = zext i16 %214 to i32
  %216 = load i16, ptr %7, align 2
  %217 = zext i16 %216 to i32
  %218 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %215, i32 noundef %217, i32 noundef 0)
  store ptr %218, ptr %5, align 8
  br label %219

219:                                              ; preds = %210, %54
  %220 = load ptr, ptr %5, align 8
  ret ptr %220
}

declare void @rw_scattered(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @rw_chunk(ptr noundef %0, i64 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, ptr noundef %6, i32 noundef %7, i32 noundef %8) #0 {
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca i64, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca ptr, align 8
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i16, align 2
  %26 = alloca i16, align 2
  store ptr %0, ptr %11, align 8
  store i64 %1, ptr %12, align 8
  store i32 %2, ptr %13, align 4
  store i32 %3, ptr %14, align 4
  store i32 %4, ptr %15, align 4
  store i32 %5, ptr %16, align 4
  store ptr %6, ptr %17, align 8
  store i32 %7, ptr %18, align 4
  store i32 %8, ptr %19, align 4
  %27 = load ptr, ptr %11, align 8
  %28 = getelementptr inbounds %struct.inode, ptr %27, i32 0, i32 0
  %29 = load i16, ptr %28, align 8
  %30 = zext i16 %29 to i32
  %31 = and i32 %30, 61440
  %32 = icmp eq i32 %31, 24576
  %33 = zext i1 %32 to i32
  store i32 %33, ptr %24, align 4
  %34 = load i32, ptr %24, align 4
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %36, label %44

36:                                               ; preds = %9
  %37 = load i64, ptr %12, align 8
  %38 = sdiv i64 %37, 1024
  %39 = trunc i64 %38 to i16
  store i16 %39, ptr %25, align 2
  %40 = load ptr, ptr %11, align 8
  %41 = getelementptr inbounds %struct.inode, ptr %40, i32 0, i32 6
  %42 = getelementptr inbounds [9 x i16], ptr %41, i64 0, i64 0
  %43 = load i16, ptr %42, align 2
  store i16 %43, ptr %26, align 2
  br label %51

44:                                               ; preds = %9
  %45 = load ptr, ptr %11, align 8
  %46 = load i64, ptr %12, align 8
  %47 = call zeroext i16 @read_map(ptr noundef %45, i64 noundef %46)
  store i16 %47, ptr %25, align 2
  %48 = load ptr, ptr %11, align 8
  %49 = getelementptr inbounds %struct.inode, ptr %48, i32 0, i32 9
  %50 = load i16, ptr %49, align 8
  store i16 %50, ptr %26, align 2
  br label %51

51:                                               ; preds = %44, %36
  %52 = load i32, ptr %24, align 4
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %73, label %54

54:                                               ; preds = %51
  %55 = load i16, ptr %25, align 2
  %56 = zext i16 %55 to i32
  %57 = icmp eq i32 %56, 0
  br i1 %57, label %58, label %73

58:                                               ; preds = %54
  %59 = load i32, ptr %16, align 4
  %60 = icmp eq i32 %59, 0
  br i1 %60, label %61, label %64

61:                                               ; preds = %58
  %62 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef 65535, i32 noundef 0, i32 noundef 0)
  store ptr %62, ptr %20, align 8
  %63 = load ptr, ptr %20, align 8
  call void (ptr, ...) @zero_block(ptr noundef %63)
  br label %72

64:                                               ; preds = %58
  %65 = load ptr, ptr %11, align 8
  %66 = load i64, ptr %12, align 8
  %67 = call ptr (ptr, i64, ...) @new_block(ptr noundef %65, i64 noundef %66)
  store ptr %67, ptr %20, align 8
  %68 = icmp eq ptr %67, null
  br i1 %68, label %69, label %71

69:                                               ; preds = %64
  %70 = load i32, ptr @err_code, align 4
  store i32 %70, ptr %10, align 4
  br label %162

71:                                               ; preds = %64
  br label %72

72:                                               ; preds = %71, %61
  br label %108

73:                                               ; preds = %54, %51
  %74 = load i32, ptr %16, align 4
  %75 = icmp eq i32 %74, 0
  br i1 %75, label %76, label %83

76:                                               ; preds = %73
  %77 = load ptr, ptr %11, align 8
  %78 = load i16, ptr %25, align 2
  %79 = zext i16 %78 to i32
  %80 = load i64, ptr %12, align 8
  %81 = load i32, ptr %15, align 4
  %82 = call ptr @rahead(ptr noundef %77, i32 noundef %79, i64 noundef %80, i32 noundef %81)
  store ptr %82, ptr %20, align 8
  br label %107

83:                                               ; preds = %73
  %84 = load i32, ptr %14, align 4
  %85 = icmp eq i32 %84, 1024
  %86 = zext i1 %85 to i64
  %87 = select i1 %85, i32 1, i32 0
  store i32 %87, ptr %23, align 4
  %88 = load i32, ptr %24, align 4
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %100, label %90

90:                                               ; preds = %83
  %91 = load i32, ptr %13, align 4
  %92 = icmp eq i32 %91, 0
  br i1 %92, label %93, label %100

93:                                               ; preds = %90
  %94 = load i64, ptr %12, align 8
  %95 = load ptr, ptr %11, align 8
  %96 = getelementptr inbounds %struct.inode, ptr %95, i32 0, i32 2
  %97 = load i64, ptr %96, align 8
  %98 = icmp sge i64 %94, %97
  br i1 %98, label %99, label %100

99:                                               ; preds = %93
  store i32 1, ptr %23, align 4
  br label %100

100:                                              ; preds = %99, %93, %90, %83
  %101 = load i16, ptr %26, align 2
  %102 = zext i16 %101 to i32
  %103 = load i16, ptr %25, align 2
  %104 = zext i16 %103 to i32
  %105 = load i32, ptr %23, align 4
  %106 = call ptr (i32, i32, i32, ...) @get_block(i32 noundef %102, i32 noundef %104, i32 noundef %105)
  store ptr %106, ptr %20, align 8
  br label %107

107:                                              ; preds = %100, %76
  br label %108

108:                                              ; preds = %107, %72
  %109 = load i32, ptr %16, align 4
  %110 = icmp eq i32 %109, 1
  br i1 %110, label %111, label %128

111:                                              ; preds = %108
  %112 = load i32, ptr %14, align 4
  %113 = icmp ne i32 %112, 1024
  br i1 %113, label %114, label %128

114:                                              ; preds = %111
  %115 = load i32, ptr %24, align 4
  %116 = icmp ne i32 %115, 0
  br i1 %116, label %128, label %117

117:                                              ; preds = %114
  %118 = load i64, ptr %12, align 8
  %119 = load ptr, ptr %11, align 8
  %120 = getelementptr inbounds %struct.inode, ptr %119, i32 0, i32 2
  %121 = load i64, ptr %120, align 8
  %122 = icmp sge i64 %118, %121
  br i1 %122, label %123, label %128

123:                                              ; preds = %117
  %124 = load i32, ptr %13, align 4
  %125 = icmp eq i32 %124, 0
  br i1 %125, label %126, label %128

126:                                              ; preds = %123
  %127 = load ptr, ptr %20, align 8
  call void (ptr, ...) @zero_block(ptr noundef %127)
  br label %128

128:                                              ; preds = %126, %123, %117, %114, %111, %108
  %129 = load i32, ptr %16, align 4
  %130 = icmp eq i32 %129, 0
  %131 = zext i1 %130 to i64
  %132 = select i1 %130, i32 0, i32 1
  store i32 %132, ptr %22, align 4
  %133 = load i32, ptr %18, align 4
  %134 = load i32, ptr %19, align 4
  %135 = load ptr, ptr %17, align 8
  %136 = ptrtoint ptr %135 to i64
  %137 = load i32, ptr %14, align 4
  %138 = sext i32 %137 to i64
  %139 = load ptr, ptr %20, align 8
  %140 = getelementptr inbounds %struct.buf, ptr %139, i32 0, i32 0
  %141 = getelementptr inbounds [1024 x i8], ptr %140, i64 0, i64 0
  %142 = load i32, ptr %13, align 4
  %143 = zext i32 %142 to i64
  %144 = getelementptr inbounds i8, ptr %141, i64 %143
  %145 = load i32, ptr %22, align 4
  %146 = call i32 @rw_user(i32 noundef %133, i32 noundef %134, i64 noundef %136, i64 noundef %138, ptr noundef %144, i32 noundef %145)
  store i32 %146, ptr %21, align 4
  %147 = load i32, ptr %16, align 4
  %148 = icmp eq i32 %147, 1
  br i1 %148, label %149, label %152

149:                                              ; preds = %128
  %150 = load ptr, ptr %20, align 8
  %151 = getelementptr inbounds %struct.buf, ptr %150, i32 0, i32 6
  store i8 1, ptr %151, align 4
  br label %152

152:                                              ; preds = %149, %128
  %153 = load i32, ptr %13, align 4
  %154 = load i32, ptr %14, align 4
  %155 = add i32 %153, %154
  %156 = icmp eq i32 %155, 1024
  %157 = zext i1 %156 to i64
  %158 = select i1 %156, i32 6, i32 7
  store i32 %158, ptr %23, align 4
  %159 = load ptr, ptr %20, align 8
  %160 = load i32, ptr %23, align 4
  call void (ptr, i32, ...) @put_block(ptr noundef %159, i32 noundef %160)
  %161 = load i32, ptr %21, align 4
  store i32 %161, ptr %10, align 4
  br label %162

162:                                              ; preds = %152, %69
  %163 = load i32, ptr %10, align 4
  ret i32 %163
}

declare void @zero_block(...) #1

declare ptr @new_block(...) #1

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
