	.text
	.file	"pshl_original.ll"
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
	movdqa	-64(%rbp), %xmm0
	movdqa	-96(%rbp), %xmm1
	movdqa	%xmm0, -16(%rbp)
	movdqa	%xmm1, -32(%rbp)
	movdqa	-16(%rbp), %xmm0
	movdqa	-32(%rbp), %xmm1
	psllq	%xmm1, %xmm0
	movdqa	%xmm0, -80(%rbp)
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
