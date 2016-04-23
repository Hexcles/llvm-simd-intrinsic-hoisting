; ModuleID = 'madd.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global <2 x i64> zeroinitializer, align 16
@b = common global <2 x i64> zeroinitializer, align 16
@c = common global <2 x i64> zeroinitializer, align 16

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca <2 x i64>, align 16
  %2 = alloca <2 x i64>, align 16
  %3 = alloca i32, align 4
  store i32 0, i32* %3
  %4 = load <2 x i64>, <2 x i64>* @a, align 16
  %5 = load <2 x i64>, <2 x i64>* @b, align 16
  store <2 x i64> %4, <2 x i64>* %1, align 16
  store <2 x i64> %5, <2 x i64>* %2, align 16
  %6 = load <2 x i64>, <2 x i64>* %1, align 16
  %7 = bitcast <2 x i64> %6 to <8 x i16>
  %8 = load <2 x i64>, <2 x i64>* %2, align 16
  %9 = bitcast <2 x i64> %8 to <8 x i16>
  %10 = call <4 x i32> @llvm.x86.sse2.pmadd.wd(<8 x i16> %7, <8 x i16> %9) #2
  %11 = bitcast <4 x i32> %10 to <2 x i64>
  store <2 x i64> %11, <2 x i64>* @c, align 16
  ret i32 0
}

; Function Attrs: nounwind readnone
declare <4 x i32> @llvm.x86.sse2.pmadd.wd(<8 x i16>, <8 x i16>) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
