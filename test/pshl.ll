; ModuleID = 'pshl.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca <2 x i64>, align 16
  %2 = alloca <2 x i64>, align 16
  %3 = alloca i32, align 4
  %a = alloca <2 x i64>, align 16
  %b = alloca <2 x i64>, align 16
  %count = alloca <2 x i64>, align 16
  store i32 0, i32* %3
  %4 = load <2 x i64>, <2 x i64>* %a, align 16
  %5 = load <2 x i64>, <2 x i64>* %count, align 16
  store <2 x i64> %4, <2 x i64>* %1, align 16
  store <2 x i64> %5, <2 x i64>* %2, align 16
  %6 = load <2 x i64>, <2 x i64>* %1, align 16
  %7 = load <2 x i64>, <2 x i64>* %2, align 16
  %8 = shufflevector <2 x i64> %7, <2 x i64> undef, <2 x i32> zeroinitializer
  %9 = shl <2 x i64> %6, %8
  store <2 x i64> %9, <2 x i64>* %b, align 16
  ret i32 0
}

; Function Attrs: nounwind readnone
declare <2 x i64> @llvm.x86.sse2.psll.q(<2 x i64>, <2 x i64>) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
