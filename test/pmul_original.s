	.text
	.file	"pmul_original.ll"
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
	subq	$112, %rsp
	movabsq	$.L.str, %rdi
	movl	$0, -100(%rbp)
	movl	$1, -68(%rbp)
	movl	$2, -72(%rbp)
	movl	$3, -76(%rbp)
	movl	$4, -80(%rbp)
	movd	-68(%rbp), %xmm0        # xmm0 = mem[0],zero,zero,zero
	movd	-76(%rbp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movl	$4, %eax
	movd	%eax, %xmm0
	movd	-72(%rbp), %xmm2        # xmm2 = mem[0],zero,zero,zero
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movaps	%xmm0, -96(%rbp)
	movaps	%xmm0, a(%rip)
	movl	$5, -4(%rbp)
	movl	$3, -8(%rbp)
	movl	$2, -12(%rbp)
	movl	$1, -16(%rbp)
	movd	-4(%rbp), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movd	-12(%rbp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	punpckldq	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
	movl	$1, %eax
	movd	%eax, %xmm0
	movd	-8(%rbp), %xmm2         # xmm2 = mem[0],zero,zero,zero
	punpckldq	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	movaps	%xmm0, -32(%rbp)
	movaps	%xmm0, b(%rip)
	movaps	a(%rip), %xmm1
	movaps	%xmm1, -48(%rbp)
	movaps	%xmm0, -64(%rbp)
	movaps	-48(%rbp), %xmm1
	pmuludq	%xmm0, %xmm1
	movaps	%xmm1, c(%rip)
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	movd	%xmm0, %rsi
	movd	%xmm1, %rdx
	movb	$0, %al
	callq	printf
	xorl	%ecx, %ecx
	movl	%eax, -104(%rbp)        # 4-byte Spill
	movl	%ecx, %eax
	addq	$112, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	a,@object               # @a
	.comm	a,16,16
	.type	b,@object               # @b
	.comm	b,16,16
	.type	c,@object               # @c
	.comm	c,16,16
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%llu %llu\n"
	.size	.L.str, 11


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
