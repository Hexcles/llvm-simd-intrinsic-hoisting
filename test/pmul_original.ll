; ModuleID = 'pmul.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global <2 x i64> zeroinitializer, align 16
@b = common global <2 x i64> zeroinitializer, align 16
@c = common global <2 x i64> zeroinitializer, align 16
@.str = private unnamed_addr constant [11 x i8] c"%llu %llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca <4 x i32>, align 16
  %6 = alloca <2 x i64>, align 16
  %7 = alloca <2 x i64>, align 16
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca <4 x i32>, align 16
  %13 = alloca i32, align 4
  store i32 0, i32* %13
  store i32 1, i32* %8, align 4
  store i32 2, i32* %9, align 4
  store i32 3, i32* %10, align 4
  store i32 4, i32* %11, align 4
  %14 = load i32, i32* %11, align 4
  %15 = insertelement <4 x i32> undef, i32 %14, i32 0
  %16 = load i32, i32* %10, align 4
  %17 = insertelement <4 x i32> %15, i32 %16, i32 1
  %18 = load i32, i32* %9, align 4
  %19 = insertelement <4 x i32> %17, i32 %18, i32 2
  %20 = load i32, i32* %8, align 4
  %21 = insertelement <4 x i32> %19, i32 %20, i32 3
  store <4 x i32> %21, <4 x i32>* %12
  %22 = load <4 x i32>, <4 x i32>* %12
  %23 = bitcast <4 x i32> %22 to <2 x i64>
  store <2 x i64> %23, <2 x i64>* @a, align 16
  store i32 5, i32* %1, align 4
  store i32 3, i32* %2, align 4
  store i32 2, i32* %3, align 4
  store i32 1, i32* %4, align 4
  %24 = load i32, i32* %4, align 4
  %25 = insertelement <4 x i32> undef, i32 %24, i32 0
  %26 = load i32, i32* %3, align 4
  %27 = insertelement <4 x i32> %25, i32 %26, i32 1
  %28 = load i32, i32* %2, align 4
  %29 = insertelement <4 x i32> %27, i32 %28, i32 2
  %30 = load i32, i32* %1, align 4
  %31 = insertelement <4 x i32> %29, i32 %30, i32 3
  store <4 x i32> %31, <4 x i32>* %5
  %32 = load <4 x i32>, <4 x i32>* %5
  %33 = bitcast <4 x i32> %32 to <2 x i64>
  store <2 x i64> %33, <2 x i64>* @b, align 16
  %34 = load <2 x i64>, <2 x i64>* @a, align 16
  %35 = load <2 x i64>, <2 x i64>* @b, align 16
  store <2 x i64> %34, <2 x i64>* %6, align 16
  store <2 x i64> %35, <2 x i64>* %7, align 16
  %36 = load <2 x i64>, <2 x i64>* %6, align 16
  %37 = bitcast <2 x i64> %36 to <4 x i32>
  %38 = load <2 x i64>, <2 x i64>* %7, align 16
  %39 = bitcast <2 x i64> %38 to <4 x i32>
  %40 = call <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32> %37, <4 x i32> %39) #3
  store <2 x i64> %40, <2 x i64>* @c, align 16
  %41 = load <2 x i64>, <2 x i64>* @c, align 16
  %42 = extractelement <2 x i64> %41, i32 1
  %43 = load <2 x i64>, <2 x i64>* @c, align 16
  %44 = extractelement <2 x i64> %43, i32 0
  %45 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i64 %42, i64 %44)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readnone
declare <2 x i64> @llvm.x86.sse2.pmulu.dq(<4 x i32>, <4 x i32>) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
