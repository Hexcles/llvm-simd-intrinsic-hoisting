	.text
	.file	"madd.ll"
	.section	.rodata.cst16,"aM",@progbits,16
	.align	16
.LCPI0_0:
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
	.long	65535                   # 0xffff
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
	xorl	%eax, %eax
	movl	$0, -36(%rbp)
	movaps	a(%rip), %xmm0
	movaps	b(%rip), %xmm1
	movaps	%xmm0, -16(%rbp)
	movaps	%xmm1, -32(%rbp)
	movaps	-16(%rbp), %xmm0
	movaps	.LCPI0_0(%rip), %xmm2   # xmm2 = [65535,65535,65535,65535]
	movaps	%xmm0, %xmm3
	pand	%xmm2, %xmm3
	movaps	%xmm1, %xmm4
	pand	%xmm2, %xmm4
	movaps	%xmm3, %xmm5
	pmuludq	%xmm4, %xmm5
	pshufd	$232, %xmm5, %xmm5      # xmm5 = xmm5[0,2,2,3]
	pshufd	$245, %xmm4, %xmm4      # xmm4 = xmm4[1,1,3,3]
	pshufd	$245, %xmm3, %xmm3      # xmm3 = xmm3[1,1,3,3]
	pmuludq	%xmm4, %xmm3
	pshufd	$232, %xmm3, %xmm3      # xmm3 = xmm3[0,2,2,3]
	punpckldq	%xmm3, %xmm5    # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
	psrld	$16, %xmm0
	psrld	$16, %xmm1
	pand	%xmm2, %xmm0
	pand	%xmm2, %xmm1
	movaps	%xmm0, %xmm2
	pmuludq	%xmm1, %xmm2
	pshufd	$232, %xmm2, %xmm2      # xmm2 = xmm2[0,2,2,3]
	pshufd	$245, %xmm1, %xmm1      # xmm1 = xmm1[1,1,3,3]
	pshufd	$245, %xmm0, %xmm0      # xmm0 = xmm0[1,1,3,3]
	pmuludq	%xmm1, %xmm0
	pshufd	$232, %xmm0, %xmm0      # xmm0 = xmm0[0,2,2,3]
	punpckldq	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
	paddd	%xmm2, %xmm5
	movaps	%xmm5, %xmm0
	movdqa	%xmm5, c
	movaps	%xmm0, -64(%rbp)        # 16-byte Spill
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
