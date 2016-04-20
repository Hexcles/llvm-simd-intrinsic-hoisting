	.text
	.file	"pmul.ll"
	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI0_0:
	.quad	4294967295              # 0xffffffff
	.quad	4294967295              # 0xffffffff
	.text
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
	movdqa	%xmm0, -96(%rbp)
	movdqa	%xmm0, a(%rip)
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
	movdqa	%xmm0, -32(%rbp)
	movdqa	%xmm0, b(%rip)
	movaps	a(%rip), %xmm1
	movaps	%xmm1, -48(%rbp)
	movdqa	%xmm0, -64(%rbp)
	movdqa	.LCPI0_0(%rip), %xmm1   # xmm1 = [4294967295,4294967295]
	pand	%xmm1, %xmm0
	pand	-48(%rbp), %xmm1
	movdqa	%xmm1, %xmm2
	pmuludq	%xmm0, %xmm2
	movdqa	%xmm0, %xmm3
	psrlq	$32, %xmm3
	pmuludq	%xmm1, %xmm3
	psllq	$32, %xmm3
	paddq	%xmm2, %xmm3
	psrlq	$32, %xmm1
	pmuludq	%xmm0, %xmm1
	psllq	$32, %xmm1
	paddq	%xmm3, %xmm1
	movdqa	%xmm1, c(%rip)
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	movd	%xmm0, %rsi
	movd	%xmm1, %rdx
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
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
