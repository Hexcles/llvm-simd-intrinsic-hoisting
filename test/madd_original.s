	.text
	.file	"madd_original.ll"
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
	xorl	%eax, %eax
	movl	$0, -36(%rbp)
	movaps	a(%rip), %xmm0
	movaps	b(%rip), %xmm1
	movaps	%xmm0, -16(%rbp)
	movaps	%xmm1, -32(%rbp)
	movaps	-16(%rbp), %xmm0
	pmaddwd	%xmm1, %xmm0
	movaps	%xmm0, %xmm1
	movdqa	%xmm0, c
	movaps	%xmm1, -64(%rbp)        # 16-byte Spill
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

	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
