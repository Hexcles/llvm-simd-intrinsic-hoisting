; ModuleID = 'movmask.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global <4 x float> zeroinitializer, align 16
@.str = private unnamed_addr constant [4 x i8] c"%x\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca <2 x i64>, align 16
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca <4 x i32>, align 16
  %7 = alloca i32, align 4
  %r = alloca i32, align 4
  store i32 0, i32* %7
  store i32 -252645136, i32* %2, align 4
  store i32 -252645136, i32* %3, align 4
  store i32 -252645136, i32* %4, align 4
  store i32 -252645136, i32* %5, align 4
  %8 = load i32, i32* %5, align 4
  %9 = insertelement <4 x i32> undef, i32 %8, i32 0
  %10 = load i32, i32* %4, align 4
  %11 = insertelement <4 x i32> %9, i32 %10, i32 1
  %12 = load i32, i32* %3, align 4
  %13 = insertelement <4 x i32> %11, i32 %12, i32 2
  %14 = load i32, i32* %2, align 4
  %15 = insertelement <4 x i32> %13, i32 %14, i32 3
  store <4 x i32> %15, <4 x i32>* %6
  %16 = load <4 x i32>, <4 x i32>* %6
  %17 = bitcast <4 x i32> %16 to <2 x i64>
  %18 = bitcast <2 x i64> %17 to <4 x float>
  store <4 x float> %18, <4 x float>* @a, align 16
  %19 = load <4 x float>, <4 x float>* @a, align 16
  %20 = bitcast <4 x float> %19 to <2 x i64>
  store <2 x i64> %20, <2 x i64>* %1, align 16
  %21 = load <2 x i64>, <2 x i64>* %1, align 16
  %22 = bitcast <2 x i64> %21 to <16 x i8>
  %23 = icmp slt <16 x i8> %22, zeroinitializer
  %24 = bitcast <16 x i1> %23 to i16
  %25 = zext i16 %24 to i32
  store i32 %25, i32* %r, align 4
  %26 = load i32, i32* %r, align 4
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %26)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.x86.sse2.pmovmskb.128(<16 x i8>) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
