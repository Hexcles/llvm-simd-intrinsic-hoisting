# Introduction

Intel provides a thin wrapper of SIMD instructions in the form of C functions, called (SIMD) intrinsics. Although they provide a maintainability better than hand-written assembly code, they still have the problem of portability. There are two main parts in this project:
1. To create portable code and to gain potential benefits from ISAupgrade, we implemented a custom LLVM pass to hoist hard-codedintrinsics to equivalent platform-agnostic LLVM IR. Using SSE2 as ourresearch subject, we categorized all of its intrinsics and pickedrepresentative examples.
2. While doing so, we discovered even some seemingly trivial IRtransformed from intrinsics would be compiled to sub-optimal,scalarized code. Hence, we also studied the back end (especiallyCodeGen) of LLVM to find out why some IR could or could not becompiled to optimal SIMD instructions, and proposed some potentialimprovements along with their obstacles.

#Design


IntrinsicHoister is a custom LLVM pass working on IR level, inspired byHuang’s work [1]. The pass scans for intrinsic calls and replaces the callwith the a sequence of native IR having the equivalent effect, essentiallya peephole expansion. We chose our examples from SSE2 in a structuralmanner based on our categorization. We tried to maximize the coverageand looked for the optimal transformation. Here are the results:
1. Many intrinsics are already implemented with native C expressionsdirectly in the header file (provided by clang). These are the ones thatmatch the semantics of (combinations of) C operators, usually purevertical. Shuffle and unpack also belong to this case. (e.g. add, sub, and,set, load, cmp_epi)
2. Some intrinsics have an optimal transformation that can be compiledback to the original SIMD instruction. They cannot be expressed withsimple C expressions, but can be implemented by a few IR statementsand usually become a single ISD node in SelectionDAG. (e.g. cmp_pd,shift, sqrt, min, max)
3. The other intrinsics seem impossible to be hoisted to efficient code.All the hoisting methods we tried were scalarized by LLVM backend.These intrinsics are either compound operations or beyond somelimitations of LLVM IR such as saturated arithmetic and change of fieldsizes in the result. (e.g. avg, madd, sad, pack, pmuludq)
After making a survey of the whole SSE2 extension, we find that although there are lots of SSE2 intrinsics, they actually fall into these three categories. Here are the detailed statistical results:
###Case 1: 
Already implemented in C expressions in clang header


operation| count
-----|-----:
add | 11
sub | 11
div | 2
mullo, mul_sd, mul_pd | 3
and | 4
xor | 2
or | 2
cast | 6
cmp\*_epi | 9
set | 21
extract | 1
insert | 1
load | 11
store | 11
shuffle | 4
unpack | 10

####Characteristics

* Can be expressed by standard C operators (arithmetic & bit operations)
* Mostly pure vertical operations
* Special case: shuffle & unpack (element selection with immediate operands or constant/hard-coded patterns) via shufflevector

###Case 2: 
Hoisted and compiled to efficient SIMD instructions

operation| count
-----|-----:
cmp\*_pd | 12
comi | 12
shift | 20
sqrt | 2
min | 4
max | 4

####Characteristics

* Can be represented by a short sequence of LLVM IR or ISD Ops
* Mostly pure vertical operations


###Case 3:
Hoisted but scalarized during compilation

operation| count
-----|-----:
cmp*_sd | 12
avg | 2
pmuludq, mulhi, madd | 4
pack | 3
movemask | 3
move | 4
sad | 1

####Characteristics

* Saturated operations
* Horizontal operations
* Field width changed

###Others: 
Not researched

operation| count
-----|-----:
clflush | 1
lfence | 1
mfence | 1
pause | 1
stream | 4
convert cvt | 29



##key findings

1. After looking deep into the header files provided by clang, we find there are many simple SSE2 intrinsics which can be represented by simple, standard C operations.
 
2. On the other hand, there are some intrinsics which seem to be simple at frist sight turn out have slightly different semantics for SIMD operations. For example, in the "shift" operation of SSE2, we must first divide the operand into different lains, which means the shifting will not cross the border of lains. In another instance, the multiplication in SSE2, there is a problem that LLVM doesn't support saturation natively.

3. A more interesting case is the "min" operation in SSE2. It will be translated into an LLVM intrinsic call finally. Then we can manually hoist the intrinsic call into two operations: icmp and select. These two operations in LLVM IR will eventually be compiled into the original SIMD instruction by the backend. It actually happens during the "SelectionDAG" phase: whenever there is a "select" operation, the llvm will look deep into the operand of "select", and try to detect whether it is an "icmp" operation. If so, the LLVM will replace the whole thing into a single operation "smin", which is actually an operation in the "SelectionDAG" phase. Later on, the "smin" operation will be mapped to an original SIMD instruction during the "Instruction Selection" phase.


#Implementation Details

Most of SSE2 intrinsics can be expressed with a few lines of LLVM standard IR instructions. A bit more examples are listed here:



Implementation of *llvm.x86.sse2.psll.q* with LLVM IR:

```
define <2 x i64> @llvm_x86_sse2_psll_q(<2 x i64> %x, <2 x i64> %y) {
	%result = shl <2 x i64> %x,  %y
	ret <2 x i64> %result
}
``` 
       

Implementation of *llvm.x86.sse2.psrl.q* with LLVM IR:

```
define  <2 x i64> @llvm_x86_sse2_psrl_q(<2 x i64> %x, <2 x i64> %y) {
	%result = lshr <2 x i64> %x,  %y
	ret <2 x i64> %result
}
```


Implementation of *llvm.x86.sse2.pmadd.wd* with LLVM IR:

```
define  <4 x i32> @llvm_x86_sse2_pmadd_wd(<8 x i16> %x, <8 x i16> %y){
	%m0 = bitcast <8 x i16> %x to <4 x i32>
	%m1 = bitcast <8 x i16> %y to <4 x i32>
	%andm0 = and <4 x i32> %m0, <i32 65535, i32 65535, i32 65535, i32 65535>
	%andm1 = and <4 x i32> %m1, <i32 65535, i32 65535, i32 65535, i32 65535>
	%result0 = mul <4 x i32> %andm0, %andm1
	%n0 = lshr <4 x i32> %m0, <i32 16, i32 16, i32 16, i32 16>
	%n1 = lshr <4 x i32> %m1, <i32 16, i32 16, i32 16, i32 16>
	%andn0 = and <4 x i32> %n0, <i32 65535, i32 65535, i32 65535, i32 65535>
	%andn1 = and <4 x i32> %n1, <i32 65535, i32 65535, i32 65535, i32 65535>
	%result1 = mul <4 x i32> %andn0, %andn1
	%result = add <4 x i32> %result0, %result1
	ret <4 x i32> %result
}
```


Implementation of *llvm.x86.fma.vfmadd.pd* with LLVM IR:

```
define  <2 x double> @llvm_x86_fma_vfmadd_pd(<2 x double> %x, <2 x double> %y, <2 x double> %z){
	%result = call double @llvm.fma.f64(double %x, double %y, double %z)
	ret <2 x double> %result
}
```


Implementation of *llvm.x86.sse2.sqrt.pd* with LLVM IR:

```
define  <2 x double> @llvm_x86_sse2_sqrt_pd(<2 x double> %x){
	%result = call <2 x double> @llvm.sqrt.v2f64(<2 x double> %x)
	ret <2 x double> %result
}
```



Implementation of *llvm.x86.sse2.cmp.pd* with LLVM IR:

```
define  <2 x double> @llvm_x86_sse2_cmp_pd(<2 x double> %x, <2 x double> %y, i8 z){
	(z == 0) ? (%comp = fcmp ueq <2 x double> %x, %y) : (%comp = fcmp ult <2 x double> %x, %y)
	%temp = sext <2 x i1> %comp to <2 x i64>
	%result = bitcast <2 x i64> %temp to <2 x double>
	ret <2 x double> %result
}
```


Implementation of *llvm.x86.sse2.cmp.sd* with LLVM IR:

```
define  <2 x double> @llvm_x86_sse2_cmp_sd(<2 x double> %x, <2 x double> %y{
	%a0 = extractelement <2 x double> %x, i32 0
	%a1 = extractelement <2 x double> %y, i32 0
	%comp = fcmp ueq double %a0, %a1
	%temp = sext i1 %comp to i64
	%b0 = bitcast i64 %temp to double
	%b1 = extractelement <2 x double> %x, i32 1
	%res = insertelement <2 x double> undef, double %b0, i32 0
	%result = insertelement <2 x double> %11, double %b1, i32 1
	ret <2 x double> %result
}
```


Implementation of *llvm.x86.sse2.pavg.w* with LLVM IR:

```
define  <8 x i16> @llvm_x86_sse2_pavg_w(<8 x i16> %x, <8 x i16> %y){
	%sum0 = add <8 x i16> %x, %y
	%sum1 = add <8 x i16> %sum0, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
	%avg = lshr <8 x i16> %sum1, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
	%result = %bitcast <8 x i16> %avg to <2 x i64>
	ret <2 x i64> %result
}
```


Implementation of *llvm.x86.sse2.packuswb.128* with LLVM IR:

```
define <16 x i8> @llvm_x86_sse2_packuswb_128(<8 x i16> %x, <8 x i16> %y) {
	%high8 = trunc <8 x i16> %y to <8 x i8>
	%low8 = trunc <8 x i16> %x to <8 x i8>
	%result = shufflevector <8 x i8> %low8, <8 x i8> %high8, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7 ,i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
	ret <16 x i8> %result
}
```

Implementation of *llvm.x86.sse2.pmulu.dq* with LLVM IR:

```
define  <2 x i64> @llvm_x86_sse2_pmulu_dq(<4 x i32> %x, <4 x i32> %y){
	%m0 = bitcast %x to <2 x i64>
	%m1 = bitcast %y to <2 x i64>
	%and0 = and %m0, <2 x i64> <i64 4294967295, i64 4294967295>
	%and1 = and %m1, <2 x i64> <i64 4294967295, i64 4294967295>
	%result = mul %and0, %and1
	ret <2 x i64> %result
}
```

Implementation of *llvm.x86.sse2.pmovmskb.128* with LLVM IR:

```
define i32 @llvm_x86_sse2_pmovmskb_128(<16 x i8> %x) {
	%msb = lshr <16 x i8> %x, <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
	%tmp = trunc <16 x i8> %msb to <16 x i1>
	%result16 = bitcast <16 x i1> %tmp to i16
	%result = zext i16 %result16 to i32 
	ret i32 %result
}
```

Implementation of *llvm.x86.sse2.psad.bw* with LLVM IR:

```
define <2 x i64> @llvm_x86_sse2_psad_bw(<16 x i8> %x, <16 x i8> %y) {
	%1 = sub <16 x i8> %x , %y
	%2 = shufflevector <16 x i8> %1, <16 x i8> %1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
	%3 = shufflevector <16 x i8> %1, <16 x i8> %1, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
	%abssum0 = call i64 @absSum(<8 x i8> %2)
	%abssum1 = call i64 @absSum(<8 x i8> %3)
	%4 = insertelement <2 x i64> <i64 0, i64 0> , i64 %abssum0, i32 0
	%result = insertelement <2 x i64> %4, i64 %abssum1, i32 1
	ret <2 x i64> %result
}
```

Implementation of *llvm.x86.sse2.pmins.w* with LLVM IR:

```
define  <8 x i16> @llvm_x86_sse2_pmins_w(<8 x i16> %x, <8 x i16> %y){
	%comp = icmp slt <8 x i16> %x, %y
	%result = select <8 x i1> %comp, <8 x i16> %x, <8 x i16> %y
	ret <8 x i16> %result
}
```

#Implementation Evaluation


#Conclusion: Lessons Learned and Further Work
The idea of intrinsic hoisting is at least successful in Case 2. As clang has already hoisted some intrinsics, some transformation in Case 2 could bebuilt into clang or its header file to hoist more intrinsics automatically.As for intrinsics in Case 3, they are currently not feasible or worthwhile to hoist unless some improvements are made in LLVM backend.
Lastly, native saturation support would also help. Many SSE instructionsare doing saturated arithmetic. Because of the lack of native saturationsupport, expressing these operations in IR and later pattern matchingthem are extremely painful.

#Reference
[1] Kai Huang, SSE2Removal, homework of another SIMD-related course taught by Dr. Cameron (https://github.com/134579/SSE2Removal)
[2] Charles Stark Draper Lab, How An IR Statement Becomes An Instruction (https://github.com/draperlaboratory/fracture/wiki/How-An-IR-Statement-Becomes-An-Instruction)* Inkscape template based on Alexander Erlich's work (http://airlich.de/posters/)

#Appendixes: Source Code, Scripts, Sample Data