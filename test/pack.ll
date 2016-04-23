; ModuleID = 'pack.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [17 x i8] c"resultLo = %vhd\0A\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"resultHi = %vhd\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"result   = %vu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i16, align 2
  %2 = alloca i16, align 2
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca i16, align 2
  %6 = alloca i16, align 2
  %7 = alloca i16, align 2
  %8 = alloca i16, align 2
  %9 = alloca <8 x i16>, align 16
  %10 = alloca <2 x i64>, align 16
  %11 = alloca <2 x i64>, align 16
  %12 = alloca i16, align 2
  %13 = alloca i16, align 2
  %14 = alloca i16, align 2
  %15 = alloca i16, align 2
  %16 = alloca i16, align 2
  %17 = alloca i16, align 2
  %18 = alloca i16, align 2
  %19 = alloca i16, align 2
  %20 = alloca <8 x i16>, align 16
  %21 = alloca i32, align 4
  %resultLo = alloca <2 x i64>, align 16
  %resultHi = alloca <2 x i64>, align 16
  %result = alloca <2 x i64>, align 16
  store i32 0, i32* %21
  store i16 800, i16* %12, align 2
  store i16 700, i16* %13, align 2
  store i16 600, i16* %14, align 2
  store i16 500, i16* %15, align 2
  store i16 400, i16* %16, align 2
  store i16 300, i16* %17, align 2
  store i16 200, i16* %18, align 2
  store i16 100, i16* %19, align 2
  %22 = load i16, i16* %12, align 2
  %23 = insertelement <8 x i16> undef, i16 %22, i32 0
  %24 = load i16, i16* %13, align 2
  %25 = insertelement <8 x i16> %23, i16 %24, i32 1
  %26 = load i16, i16* %14, align 2
  %27 = insertelement <8 x i16> %25, i16 %26, i32 2
  %28 = load i16, i16* %15, align 2
  %29 = insertelement <8 x i16> %27, i16 %28, i32 3
  %30 = load i16, i16* %16, align 2
  %31 = insertelement <8 x i16> %29, i16 %30, i32 4
  %32 = load i16, i16* %17, align 2
  %33 = insertelement <8 x i16> %31, i16 %32, i32 5
  %34 = load i16, i16* %18, align 2
  %35 = insertelement <8 x i16> %33, i16 %34, i32 6
  %36 = load i16, i16* %19, align 2
  %37 = insertelement <8 x i16> %35, i16 %36, i32 7
  store <8 x i16> %37, <8 x i16>* %20
  %38 = load <8 x i16>, <8 x i16>* %20
  %39 = bitcast <8 x i16> %38 to <2 x i64>
  store <2 x i64> %39, <2 x i64>* %resultLo, align 16
  store i16 0, i16* %1, align 2
  store i16 -100, i16* %2, align 2
  store i16 -200, i16* %3, align 2
  store i16 -300, i16* %4, align 2
  store i16 -400, i16* %5, align 2
  store i16 -500, i16* %6, align 2
  store i16 -600, i16* %7, align 2
  store i16 -700, i16* %8, align 2
  %40 = load i16, i16* %1, align 2
  %41 = insertelement <8 x i16> undef, i16 %40, i32 0
  %42 = load i16, i16* %2, align 2
  %43 = insertelement <8 x i16> %41, i16 %42, i32 1
  %44 = load i16, i16* %3, align 2
  %45 = insertelement <8 x i16> %43, i16 %44, i32 2
  %46 = load i16, i16* %4, align 2
  %47 = insertelement <8 x i16> %45, i16 %46, i32 3
  %48 = load i16, i16* %5, align 2
  %49 = insertelement <8 x i16> %47, i16 %48, i32 4
  %50 = load i16, i16* %6, align 2
  %51 = insertelement <8 x i16> %49, i16 %50, i32 5
  %52 = load i16, i16* %7, align 2
  %53 = insertelement <8 x i16> %51, i16 %52, i32 6
  %54 = load i16, i16* %8, align 2
  %55 = insertelement <8 x i16> %53, i16 %54, i32 7
  store <8 x i16> %55, <8 x i16>* %9
  %56 = load <8 x i16>, <8 x i16>* %9
  %57 = bitcast <8 x i16> %56 to <2 x i64>
  store <2 x i64> %57, <2 x i64>* %resultHi, align 16
  %58 = load <2 x i64>, <2 x i64>* %resultLo, align 16
  %59 = load <2 x i64>, <2 x i64>* %resultHi, align 16
  store <2 x i64> %58, <2 x i64>* %10, align 16
  store <2 x i64> %59, <2 x i64>* %11, align 16
  %60 = load <2 x i64>, <2 x i64>* %10, align 16
  %61 = bitcast <2 x i64> %60 to <8 x i16>
  %62 = load <2 x i64>, <2 x i64>* %11, align 16
  %63 = bitcast <2 x i64> %62 to <8 x i16>
  %64 = bitcast <8 x i16> %61 to <16 x i8>
  %65 = bitcast <8 x i16> %63 to <16 x i8>
  %66 = shufflevector <16 x i8> %64, <16 x i8> %65, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30>
  %67 = bitcast <16 x i8> %66 to <2 x i64>
  store <2 x i64> %67, <2 x i64>* %result, align 16
  %68 = load <2 x i64>, <2 x i64>* %resultLo, align 16
  %69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i32 0, i32 0), <2 x i64> %68)
  %70 = load <2 x i64>, <2 x i64>* %resultHi, align 16
  %71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), <2 x i64> %70)
  %72 = load <2 x i64>, <2 x i64>* %result, align 16
  %73 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i32 0, i32 0), <2 x i64> %72)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readnone
declare <16 x i8> @llvm.x86.sse2.packuswb.128(<8 x i16>, <8 x i16>) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
