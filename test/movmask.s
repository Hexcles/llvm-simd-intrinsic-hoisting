	.text
	.file	"movmask.ll"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp2:
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movabsq	$.L.str, %rdi
	movl	$0, -52(%rbp)
	movl	$-252645136, -20(%rbp)  # imm = 0xFFFFFFFFF0F0F0F0
	movl	$-252645136, -24(%rbp)  # imm = 0xFFFFFFFFF0F0F0F0
	movl	$-252645136, -28(%rbp)  # imm = 0xFFFFFFFFF0F0F0F0
	movl	$-252645136, -32(%rbp)  # imm = 0xFFFFFFFFF0F0F0F0
	movd	-20(%rbp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-28(%rbp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movl	$-252645136, %eax       # imm = 0xFFFFFFFFF0F0F0F0
	movd	%eax, %xmm0
	movd	-24(%rbp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movaps	%xmm0, -48(%rbp)
	movaps	%xmm0, a(%rip)
	movaps	%xmm0, -16(%rbp)
	movaps	-16(%rbp), %xmm0
	xorps	%xmm1, %xmm1
	pcmpgtb	%xmm0, %xmm1
	movaps	%xmm1, -80(%rbp)
	movb	-65(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-66(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-67(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-68(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-69(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-70(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-71(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-72(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-73(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-74(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-75(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-76(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-77(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-78(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-79(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movb	-80(%rbp), %cl
	andb	$1, %cl
	movb	%cl, -64(%rbp)
	movzwl	-64(%rbp), %eax
	movw	%ax, %dx
	movzwl	%dx, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %esi
	movb	$0, %al
	callq	printf
	xorl	%esi, %esi
	movl	%eax, -84(%rbp)         # 4-byte Spill
	movl	%esi, %eax
	addq	$96, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	a,@object               # @a
	.comm	a,16,16
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%x\n"
	.size	.L.str, 4


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
