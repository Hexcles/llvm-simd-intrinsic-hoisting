	.text
	.file	"pshl.ll"
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
	movaps	-64(%rbp), %xmm0
	movaps	-96(%rbp), %xmm1
	movaps	%xmm0, -16(%rbp)
	movaps	%xmm1, -32(%rbp)
	movaps	-16(%rbp), %xmm0
	pshufd	$68, %xmm1, %xmm2       # xmm2 = xmm1[0,1,0,1]
	psllq	%xmm1, %xmm0
	movdqa	%xmm0, -80(%rbp)
	movaps	%xmm2, -112(%rbp)       # 16-byte Spill
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
