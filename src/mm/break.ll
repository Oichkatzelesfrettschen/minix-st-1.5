; NOTE: Generated from src/mm/break.c with clang -S -emit-llvm. Do not edit.
; ModuleID = 'src/mm/break.c'
source_filename = "src/mm/break.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.message = type { i32, i32, %union.anon }
%union.anon = type { %struct.mess_1 }
%struct.mess_1 = type { i32, i32, i32, ptr, ptr, ptr }
%struct.mproc = type { [3 x %struct.mem_map], i8, i8, i32, i32, i32, i16, i16, i8, i8, i16, i16, ptr, i32 }
%struct.mem_map = type { i32, i32, i32 }

@mp = external global ptr, align 8
@mm_in = external global %struct.message, align 8
@res_ptr = external global ptr, align 8
@who = external global i32, align 4
@mproc = external global [32 x %struct.mproc], align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @do_brk() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = load ptr, ptr @mp, align 8
  store ptr %7, ptr %2, align 8
  %8 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 3), align 8
  %9 = ptrtoint ptr %8 to i64
  store i64 %9, ptr %4, align 8
  %10 = load i64, ptr %4, align 8
  %11 = add nsw i64 %10, 256
  %12 = sub nsw i64 %11, 1
  %13 = ashr i64 %12, 8
  %14 = trunc i64 %13 to i32
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %6, align 4
  %16 = load ptr, ptr %2, align 8
  %17 = getelementptr inbounds %struct.mproc, ptr %16, i32 0, i32 0
  %18 = getelementptr inbounds [3 x %struct.mem_map], ptr %17, i64 0, i64 1
  %19 = getelementptr inbounds %struct.mem_map, ptr %18, i32 0, i32 0
  %20 = load i32, ptr %19, align 4
  %21 = icmp ult i32 %15, %20
  br i1 %21, label %22, label %23

22:                                               ; preds = %0
  store ptr inttoptr (i64 -1 to ptr), ptr @res_ptr, align 8
  store i32 -12, ptr %1, align 4
  br label %44

23:                                               ; preds = %0
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.mproc, ptr %24, i32 0, i32 0
  %26 = getelementptr inbounds [3 x %struct.mem_map], ptr %25, i64 0, i64 1
  %27 = getelementptr inbounds %struct.mem_map, ptr %26, i32 0, i32 0
  %28 = load i32, ptr %27, align 4
  %29 = load i32, ptr %6, align 4
  %30 = sub i32 %29, %28
  store i32 %30, ptr %6, align 4
  %31 = load i32, ptr @who, align 4
  call void (i32, ptr, ...) @sys_getsp(i32 noundef %31, ptr noundef %5)
  %32 = load ptr, ptr %2, align 8
  %33 = load i32, ptr %6, align 4
  %34 = load i64, ptr %5, align 8
  %35 = call i32 @adjust(ptr noundef %32, i32 noundef %33, i64 noundef %34)
  store i32 %35, ptr %3, align 4
  %36 = load i32, ptr %3, align 4
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %40

38:                                               ; preds = %23
  %39 = load ptr, ptr getelementptr inbounds (%struct.mess_1, ptr getelementptr inbounds (%struct.message, ptr @mm_in, i32 0, i32 2), i32 0, i32 3), align 8
  br label %41

40:                                               ; preds = %23
  br label %41

41:                                               ; preds = %40, %38
  %42 = phi ptr [ %39, %38 ], [ inttoptr (i64 -1 to ptr), %40 ]
  store ptr %42, ptr @res_ptr, align 8
  %43 = load i32, ptr %3, align 4
  store i32 %43, ptr %1, align 4
  br label %44

44:                                               ; preds = %41, %22
  %45 = load i32, ptr %1, align 4
  ret i32 %45
}

declare void @sys_getsp(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @adjust(ptr noundef %0, i32 noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i64 %2, ptr %7, align 8
  %19 = load ptr, ptr %5, align 8
  %20 = getelementptr inbounds %struct.mproc, ptr %19, i32 0, i32 0
  %21 = getelementptr inbounds [3 x %struct.mem_map], ptr %20, i64 0, i64 1
  store ptr %21, ptr %9, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = getelementptr inbounds %struct.mproc, ptr %22, i32 0, i32 0
  %24 = getelementptr inbounds [3 x %struct.mem_map], ptr %23, i64 0, i64 2
  store ptr %24, ptr %8, align 8
  store i32 0, ptr %14, align 4
  %25 = load ptr, ptr %5, align 8
  %26 = ptrtoint ptr %25 to i64
  %27 = sub i64 %26, ptrtoint (ptr @mproc to i64)
  %28 = sdiv exact i64 %27, 80
  %29 = icmp eq i64 %28, 2
  br i1 %29, label %30, label %31

30:                                               ; preds = %3
  store i32 0, ptr %4, align 4
  br label %203

31:                                               ; preds = %3
  %32 = load ptr, ptr %8, align 8
  %33 = getelementptr inbounds %struct.mem_map, ptr %32, i32 0, i32 0
  %34 = load i32, ptr %33, align 4
  %35 = zext i32 %34 to i64
  %36 = load ptr, ptr %8, align 8
  %37 = getelementptr inbounds %struct.mem_map, ptr %36, i32 0, i32 2
  %38 = load i32, ptr %37, align 4
  %39 = zext i32 %38 to i64
  %40 = add nsw i64 %35, %39
  store i64 %40, ptr %17, align 8
  %41 = load i64, ptr %7, align 8
  %42 = ashr i64 %41, 8
  %43 = trunc i64 %42 to i32
  store i32 %43, ptr %10, align 4
  %44 = load i32, ptr %10, align 4
  %45 = zext i32 %44 to i64
  %46 = load i64, ptr %17, align 8
  %47 = icmp sge i64 %45, %46
  br i1 %47, label %48, label %49

48:                                               ; preds = %31
  store i32 -12, ptr %4, align 4
  br label %203

49:                                               ; preds = %31
  %50 = load ptr, ptr %8, align 8
  %51 = getelementptr inbounds %struct.mem_map, ptr %50, i32 0, i32 0
  %52 = load i32, ptr %51, align 4
  %53 = zext i32 %52 to i64
  %54 = load i32, ptr %10, align 4
  %55 = zext i32 %54 to i64
  %56 = sub nsw i64 %53, %55
  store i64 %56, ptr %18, align 8
  %57 = load i64, ptr %18, align 8
  %58 = icmp sgt i64 %57, 0
  br i1 %58, label %59, label %61

59:                                               ; preds = %49
  %60 = load i32, ptr %10, align 4
  br label %65

61:                                               ; preds = %49
  %62 = load ptr, ptr %8, align 8
  %63 = getelementptr inbounds %struct.mem_map, ptr %62, i32 0, i32 0
  %64 = load i32, ptr %63, align 4
  br label %65

65:                                               ; preds = %61, %59
  %66 = phi i32 [ %60, %59 ], [ %64, %61 ]
  store i32 %66, ptr %12, align 4
  %67 = load ptr, ptr %9, align 8
  %68 = getelementptr inbounds %struct.mem_map, ptr %67, i32 0, i32 0
  %69 = load i32, ptr %68, align 4
  %70 = load i32, ptr %6, align 4
  %71 = add i32 %69, %70
  %72 = zext i32 %71 to i64
  %73 = add i64 %72, 12
  %74 = trunc i64 %73 to i32
  store i32 %74, ptr %11, align 4
  %75 = load i32, ptr %12, align 4
  %76 = load i32, ptr %11, align 4
  %77 = icmp ult i32 %75, %76
  br i1 %77, label %78, label %79

78:                                               ; preds = %65
  store i32 -12, ptr %4, align 4
  br label %203

79:                                               ; preds = %65
  %80 = load ptr, ptr %9, align 8
  %81 = getelementptr inbounds %struct.mem_map, ptr %80, i32 0, i32 2
  %82 = load i32, ptr %81, align 4
  store i32 %82, ptr %13, align 4
  %83 = load i32, ptr %6, align 4
  %84 = load ptr, ptr %9, align 8
  %85 = getelementptr inbounds %struct.mem_map, ptr %84, i32 0, i32 2
  %86 = load i32, ptr %85, align 4
  %87 = icmp ne i32 %83, %86
  br i1 %87, label %88, label %94

88:                                               ; preds = %79
  %89 = load i32, ptr %6, align 4
  %90 = load ptr, ptr %9, align 8
  %91 = getelementptr inbounds %struct.mem_map, ptr %90, i32 0, i32 2
  store i32 %89, ptr %91, align 4
  %92 = load i32, ptr %14, align 4
  %93 = or i32 %92, 1
  store i32 %93, ptr %14, align 4
  br label %94

94:                                               ; preds = %88, %79
  %95 = load i64, ptr %18, align 8
  %96 = icmp sgt i64 %95, 0
  br i1 %96, label %97, label %121

97:                                               ; preds = %94
  %98 = load i64, ptr %18, align 8
  %99 = load ptr, ptr %8, align 8
  %100 = getelementptr inbounds %struct.mem_map, ptr %99, i32 0, i32 0
  %101 = load i32, ptr %100, align 4
  %102 = zext i32 %101 to i64
  %103 = sub nsw i64 %102, %98
  %104 = trunc i64 %103 to i32
  store i32 %104, ptr %100, align 4
  %105 = load i64, ptr %18, align 8
  %106 = load ptr, ptr %8, align 8
  %107 = getelementptr inbounds %struct.mem_map, ptr %106, i32 0, i32 1
  %108 = load i32, ptr %107, align 4
  %109 = zext i32 %108 to i64
  %110 = sub nsw i64 %109, %105
  %111 = trunc i64 %110 to i32
  store i32 %111, ptr %107, align 4
  %112 = load i64, ptr %18, align 8
  %113 = load ptr, ptr %8, align 8
  %114 = getelementptr inbounds %struct.mem_map, ptr %113, i32 0, i32 2
  %115 = load i32, ptr %114, align 4
  %116 = zext i32 %115 to i64
  %117 = add nsw i64 %116, %112
  %118 = trunc i64 %117 to i32
  store i32 %118, ptr %114, align 4
  %119 = load i32, ptr %14, align 4
  %120 = or i32 %119, 2
  store i32 %120, ptr %14, align 4
  br label %121

121:                                              ; preds = %97, %94
  %122 = load ptr, ptr %5, align 8
  %123 = getelementptr inbounds %struct.mproc, ptr %122, i32 0, i32 13
  %124 = load i32, ptr %123, align 8
  %125 = and i32 %124, 32
  store i32 %125, ptr %16, align 4
  %126 = load i32, ptr %16, align 4
  %127 = load ptr, ptr %5, align 8
  %128 = getelementptr inbounds %struct.mproc, ptr %127, i32 0, i32 0
  %129 = getelementptr inbounds [3 x %struct.mem_map], ptr %128, i64 0, i64 0
  %130 = getelementptr inbounds %struct.mem_map, ptr %129, i32 0, i32 2
  %131 = load i32, ptr %130, align 8
  %132 = load ptr, ptr %5, align 8
  %133 = getelementptr inbounds %struct.mproc, ptr %132, i32 0, i32 0
  %134 = getelementptr inbounds [3 x %struct.mem_map], ptr %133, i64 0, i64 1
  %135 = getelementptr inbounds %struct.mem_map, ptr %134, i32 0, i32 2
  %136 = load i32, ptr %135, align 4
  %137 = load ptr, ptr %5, align 8
  %138 = getelementptr inbounds %struct.mproc, ptr %137, i32 0, i32 0
  %139 = getelementptr inbounds [3 x %struct.mem_map], ptr %138, i64 0, i64 2
  %140 = getelementptr inbounds %struct.mem_map, ptr %139, i32 0, i32 2
  %141 = load i32, ptr %140, align 8
  %142 = load ptr, ptr %5, align 8
  %143 = getelementptr inbounds %struct.mproc, ptr %142, i32 0, i32 0
  %144 = getelementptr inbounds [3 x %struct.mem_map], ptr %143, i64 0, i64 1
  %145 = getelementptr inbounds %struct.mem_map, ptr %144, i32 0, i32 0
  %146 = load i32, ptr %145, align 4
  %147 = load ptr, ptr %5, align 8
  %148 = getelementptr inbounds %struct.mproc, ptr %147, i32 0, i32 0
  %149 = getelementptr inbounds [3 x %struct.mem_map], ptr %148, i64 0, i64 2
  %150 = getelementptr inbounds %struct.mem_map, ptr %149, i32 0, i32 0
  %151 = load i32, ptr %150, align 8
  %152 = call i32 @size_ok(i32 noundef %126, i32 noundef %131, i32 noundef %136, i32 noundef %141, i32 noundef %146, i32 noundef %151)
  store i32 %152, ptr %15, align 4
  %153 = load i32, ptr %15, align 4
  %154 = icmp eq i32 %153, 0
  br i1 %154, label %155, label %168

155:                                              ; preds = %121
  %156 = load i32, ptr %14, align 4
  %157 = icmp ne i32 %156, 0
  br i1 %157, label %158, label %167

158:                                              ; preds = %155
  %159 = load ptr, ptr %5, align 8
  %160 = ptrtoint ptr %159 to i64
  %161 = sub i64 %160, ptrtoint (ptr @mproc to i64)
  %162 = sdiv exact i64 %161, 80
  %163 = trunc i64 %162 to i32
  %164 = load ptr, ptr %5, align 8
  %165 = getelementptr inbounds %struct.mproc, ptr %164, i32 0, i32 0
  %166 = getelementptr inbounds [3 x %struct.mem_map], ptr %165, i64 0, i64 0
  call void (i32, ptr, ...) @sys_newmap(i32 noundef %163, ptr noundef %166)
  br label %167

167:                                              ; preds = %158, %155
  store i32 0, ptr %4, align 4
  br label %203

168:                                              ; preds = %121
  %169 = load i32, ptr %14, align 4
  %170 = and i32 %169, 1
  %171 = icmp ne i32 %170, 0
  br i1 %171, label %172, label %176

172:                                              ; preds = %168
  %173 = load i32, ptr %13, align 4
  %174 = load ptr, ptr %9, align 8
  %175 = getelementptr inbounds %struct.mem_map, ptr %174, i32 0, i32 2
  store i32 %173, ptr %175, align 4
  br label %176

176:                                              ; preds = %172, %168
  %177 = load i32, ptr %14, align 4
  %178 = and i32 %177, 2
  %179 = icmp ne i32 %178, 0
  br i1 %179, label %180, label %202

180:                                              ; preds = %176
  %181 = load i64, ptr %18, align 8
  %182 = load ptr, ptr %8, align 8
  %183 = getelementptr inbounds %struct.mem_map, ptr %182, i32 0, i32 0
  %184 = load i32, ptr %183, align 4
  %185 = zext i32 %184 to i64
  %186 = add nsw i64 %185, %181
  %187 = trunc i64 %186 to i32
  store i32 %187, ptr %183, align 4
  %188 = load i64, ptr %18, align 8
  %189 = load ptr, ptr %8, align 8
  %190 = getelementptr inbounds %struct.mem_map, ptr %189, i32 0, i32 1
  %191 = load i32, ptr %190, align 4
  %192 = zext i32 %191 to i64
  %193 = add nsw i64 %192, %188
  %194 = trunc i64 %193 to i32
  store i32 %194, ptr %190, align 4
  %195 = load i64, ptr %18, align 8
  %196 = load ptr, ptr %8, align 8
  %197 = getelementptr inbounds %struct.mem_map, ptr %196, i32 0, i32 2
  %198 = load i32, ptr %197, align 4
  %199 = zext i32 %198 to i64
  %200 = sub nsw i64 %199, %195
  %201 = trunc i64 %200 to i32
  store i32 %201, ptr %197, align 4
  br label %202

202:                                              ; preds = %180, %176
  store i32 -12, ptr %4, align 4
  br label %203

203:                                              ; preds = %202, %167, %78, %48, %30
  %204 = load i32, ptr %4, align 4
  ret i32 %204
}

declare void @sys_newmap(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @size_ok(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %8, align 4
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  %14 = load i32, ptr %12, align 4
  %15 = load i32, ptr %10, align 4
  %16 = add i32 %14, %15
  %17 = load i32, ptr %13, align 4
  %18 = icmp ugt i32 %16, %17
  br i1 %18, label %19, label %20

19:                                               ; preds = %6
  store i32 -12, ptr %7, align 4
  br label %21

20:                                               ; preds = %6
  store i32 0, ptr %7, align 4
  br label %21

21:                                               ; preds = %20, %19
  %22 = load i32, ptr %7, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @stack_fault(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  store i32 %0, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds [32 x %struct.mproc], ptr @mproc, i64 0, i64 %7
  store ptr %8, ptr %3, align 8
  %9 = load ptr, ptr %3, align 8
  %10 = ptrtoint ptr %9 to i64
  %11 = sub i64 %10, ptrtoint (ptr @mproc to i64)
  %12 = sdiv exact i64 %11, 80
  %13 = trunc i64 %12 to i32
  call void (i32, ptr, ...) @sys_getsp(i32 noundef %13, ptr noundef %5)
  %14 = load i64, ptr %5, align 8
  %15 = sub nsw i64 %14, 256
  store i64 %15, ptr %5, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.mproc, ptr %17, i32 0, i32 0
  %19 = getelementptr inbounds [3 x %struct.mem_map], ptr %18, i64 0, i64 1
  %20 = getelementptr inbounds %struct.mem_map, ptr %19, i32 0, i32 2
  %21 = load i32, ptr %20, align 4
  %22 = load i64, ptr %5, align 8
  %23 = call i32 @adjust(ptr noundef %16, i32 noundef %21, i64 noundef %22)
  store i32 %23, ptr %4, align 4
  %24 = load i32, ptr %4, align 4
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %1
  br label %31

27:                                               ; preds = %1
  %28 = load ptr, ptr %3, align 8
  %29 = getelementptr inbounds %struct.mproc, ptr %28, i32 0, i32 11
  store i16 0, ptr %29, align 4
  %30 = load ptr, ptr %3, align 8
  call void (ptr, i32, ...) @sig_proc(ptr noundef %30, i32 noundef 11)
  br label %31

31:                                               ; preds = %27, %26
  ret void
}

declare void @sig_proc(...) #1

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
