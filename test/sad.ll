; ModuleID = 'sad.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global <2 x i64> zeroinitializer, align 16
@b = common global <2 x i64> zeroinitializer, align 16
@c = common global <2 x i64> zeroinitializer, align 16
@.str = private unnamed_addr constant [11 x i8] c"%llx %llx\0A\00", align 1

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
  store i32 0, i32* %21
  store i16 1, i16* %12, align 2
  store i16 2, i16* %13, align 2
  store i16 3, i16* %14, align 2
  store i16 4, i16* %15, align 2
  store i16 5, i16* %16, align 2
  store i16 5, i16* %17, align 2
  store i16 6, i16* %18, align 2
  store i16 4, i16* %19, align 2
  %22 = load i16, i16* %19, align 2
  %23 = insertelement <8 x i16> undef, i16 %22, i32 0
  %24 = load i16, i16* %18, align 2
  %25 = insertelement <8 x i16> %23, i16 %24, i32 1
  %26 = load i16, i16* %17, align 2
  %27 = insertelement <8 x i16> %25, i16 %26, i32 2
  %28 = load i16, i16* %16, align 2
  %29 = insertelement <8 x i16> %27, i16 %28, i32 3
  %30 = load i16, i16* %15, align 2
  %31 = insertelement <8 x i16> %29, i16 %30, i32 4
  %32 = load i16, i16* %14, align 2
  %33 = insertelement <8 x i16> %31, i16 %32, i32 5
  %34 = load i16, i16* %13, align 2
  %35 = insertelement <8 x i16> %33, i16 %34, i32 6
  %36 = load i16, i16* %12, align 2
  %37 = insertelement <8 x i16> %35, i16 %36, i32 7
  store <8 x i16> %37, <8 x i16>* %20
  %38 = load <8 x i16>, <8 x i16>* %20
  %39 = bitcast <8 x i16> %38 to <2 x i64>
  store <2 x i64> %39, <2 x i64>* @a, align 16
  store i16 5, i16* %1, align 2
  store i16 3, i16* %2, align 2
  store i16 2, i16* %3, align 2
  store i16 1, i16* %4, align 2
  store i16 4, i16* %5, align 2
  store i16 3, i16* %6, align 2
  store i16 6, i16* %7, align 2
  store i16 1, i16* %8, align 2
  %40 = load i16, i16* %8, align 2
  %41 = insertelement <8 x i16> undef, i16 %40, i32 0
  %42 = load i16, i16* %7, align 2
  %43 = insertelement <8 x i16> %41, i16 %42, i32 1
  %44 = load i16, i16* %6, align 2
  %45 = insertelement <8 x i16> %43, i16 %44, i32 2
  %46 = load i16, i16* %5, align 2
  %47 = insertelement <8 x i16> %45, i16 %46, i32 3
  %48 = load i16, i16* %4, align 2
  %49 = insertelement <8 x i16> %47, i16 %48, i32 4
  %50 = load i16, i16* %3, align 2
  %51 = insertelement <8 x i16> %49, i16 %50, i32 5
  %52 = load i16, i16* %2, align 2
  %53 = insertelement <8 x i16> %51, i16 %52, i32 6
  %54 = load i16, i16* %1, align 2
  %55 = insertelement <8 x i16> %53, i16 %54, i32 7
  store <8 x i16> %55, <8 x i16>* %9
  %56 = load <8 x i16>, <8 x i16>* %9
  %57 = bitcast <8 x i16> %56 to <2 x i64>
  store <2 x i64> %57, <2 x i64>* @b, align 16
  %58 = load <2 x i64>, <2 x i64>* @a, align 16
  %59 = load <2 x i64>, <2 x i64>* @b, align 16
  store <2 x i64> %58, <2 x i64>* %10, align 16
  store <2 x i64> %59, <2 x i64>* %11, align 16
  %60 = load <2 x i64>, <2 x i64>* %10, align 16
  %61 = bitcast <2 x i64> %60 to <16 x i8>
  %62 = load <2 x i64>, <2 x i64>* %11, align 16
  %63 = bitcast <2 x i64> %62 to <16 x i8>
  %64 = sub <16 x i8> %61, %63
  %65 = sub <16 x i8> zeroinitializer, %64
  %66 = icmp slt <16 x i8> %64, zeroinitializer
  %67 = select <16 x i1> %66, <16 x i8> %65, <16 x i8> %64
  %68 = shufflevector <16 x i8> %67, <16 x i8> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %69 = shufflevector <16 x i8> %67, <16 x i8> undef, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %70 = shufflevector <8 x i8> %68, <8 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %71 = shufflevector <8 x i8> %68, <8 x i8> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %72 = add <4 x i8> %70, %71
  %73 = shufflevector <4 x i8> %72, <4 x i8> undef, <2 x i32> <i32 0, i32 1>
  %74 = shufflevector <4 x i8> %72, <4 x i8> undef, <2 x i32> <i32 2, i32 3>
  %75 = add <2 x i8> %73, %74
  %76 = extractelement <2 x i8> %75, i8 0
  %77 = extractelement <2 x i8> %75, i8 1
  %78 = add i8 %76, %77
  %79 = zext i8 %78 to i64
  %80 = shufflevector <8 x i8> %69, <8 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %81 = shufflevector <8 x i8> %69, <8 x i8> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %82 = add <4 x i8> %80, %81
  %83 = shufflevector <4 x i8> %82, <4 x i8> undef, <2 x i32> <i32 0, i32 1>
  %84 = shufflevector <4 x i8> %82, <4 x i8> undef, <2 x i32> <i32 2, i32 3>
  %85 = add <2 x i8> %83, %84
  %86 = extractelement <2 x i8> %85, i8 0
  %87 = extractelement <2 x i8> %85, i8 1
  %88 = add i8 %86, %87
  %89 = zext i8 %88 to i64
  %90 = insertelement <2 x i64> undef, i64 %79, i32 0
  %91 = insertelement <2 x i64> %90, i64 %89, i32 1
  store <2 x i64> %91, <2 x i64>* @c, align 16
  %92 = load <2 x i64>, <2 x i64>* @c, align 16
  %93 = extractelement <2 x i64> %92, i32 1
  %94 = load <2 x i64>, <2 x i64>* @c, align 16
  %95 = extractelement <2 x i64> %94, i32 0
  %96 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i64 %93, i64 %95)
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readnone
declare <2 x i64> @llvm.x86.sse2.psad.bw(<16 x i8>, <16 x i8>) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
