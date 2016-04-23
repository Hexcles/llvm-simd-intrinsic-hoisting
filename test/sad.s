	.text
	.file	"sad.ll"
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
	subq	$160, %rsp
	movabsq	$.L.str, %rdi
	movl	$0, -100(%rbp)
	movw	$1, -66(%rbp)
	movw	$2, -68(%rbp)
	movw	$3, -70(%rbp)
	movw	$4, -72(%rbp)
	movw	$5, -74(%rbp)
	movw	$5, -76(%rbp)
	movw	$6, -78(%rbp)
	movw	$4, -80(%rbp)
	movzwl	-66(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-74(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-70(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-78(%rbp), %eax
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movzwl	-68(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-76(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movl	$4, %eax
	movd	%eax, %xmm0
	movzwl	-72(%rbp), %eax
	movd	%eax, %xmm3
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movaps	%xmm0, -96(%rbp)
	movaps	%xmm0, a(%rip)
	movw	$5, -2(%rbp)
	movw	$3, -4(%rbp)
	movw	$2, -6(%rbp)
	movw	$1, -8(%rbp)
	movw	$4, -10(%rbp)
	movw	$3, -12(%rbp)
	movw	$6, -14(%rbp)
	movw	$1, -16(%rbp)
	movzwl	-2(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-10(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-6(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-14(%rbp), %eax
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movzwl	-4(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-12(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movl	$1, %eax
	movd	%eax, %xmm0
	movzwl	-8(%rbp), %eax
	movd	%eax, %xmm3
	punpcklwd	%xmm3, %xmm0    # xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
	punpcklwd	%xmm2, %xmm0    # xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
	movaps	%xmm0, -32(%rbp)
	movaps	%xmm0, b(%rip)
	movaps	a(%rip), %xmm1
	movaps	%xmm1, -48(%rbp)
	movaps	%xmm0, -64(%rbp)
	movaps	-48(%rbp), %xmm0
	movaps	-64(%rbp), %xmm1
	psubb	%xmm1, %xmm0
	xorps	%xmm1, %xmm1
	movaps	%xmm1, %xmm2
	pcmpgtb	%xmm0, %xmm2
	paddb	%xmm2, %xmm0
	pxor	%xmm2, %xmm0
                                        # implicit-def: XMM2
	movaps	%xmm0, %xmm3
	punpcklbw	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
                                        # implicit-def: XMM2
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movaps	%xmm0, %xmm2
	punpcklbw	%xmm2, %xmm2    # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	punpckhwd	%xmm2, %xmm2    # xmm2 = xmm2[4,4,5,5,6,6,7,7]
	paddd	%xmm2, %xmm3
	pshufd	$212, %xmm3, %xmm2      # xmm2 = xmm3[0,1,1,3]
	pshufd	$250, %xmm3, %xmm3      # xmm3 = xmm3[2,2,3,3]
	paddq	%xmm3, %xmm2
	movaps	%xmm2, -144(%rbp)
	movb	-144(%rbp), %cl
	movb	-136(%rbp), %dl
	addb	%dl, %cl
	punpckhbw	%xmm0, %xmm0    # xmm0 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
                                        # implicit-def: XMM2
	movaps	%xmm0, %xmm3
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	punpckhwd	%xmm0, %xmm0    # xmm0 = xmm0[4,4,5,5,6,6,7,7]
	paddd	%xmm0, %xmm3
	pshufd	$212, %xmm3, %xmm0      # xmm0 = xmm3[0,1,1,3]
	pshufd	$250, %xmm3, %xmm2      # xmm2 = xmm3[2,2,3,3]
	paddq	%xmm2, %xmm0
	movaps	%xmm0, -128(%rbp)
	movb	-128(%rbp), %dl
	movb	-120(%rbp), %sil
	addb	%sil, %dl
	movzbl	%cl, %eax
	pinsrw	$0, %eax, %xmm1
	movzbl	%dl, %eax
	pinsrw	$4, %eax, %xmm1
	movaps	%xmm1, c(%rip)
	pshufd	$78, %xmm1, %xmm0       # xmm0 = xmm1[2,3,0,1]
	movd	%xmm0, %rsi
	movd	%xmm1, %rdx
	movb	$0, %al
	callq	printf
	xorl	%r8d, %r8d
	movl	%eax, -148(%rbp)        # 4-byte Spill
	movl	%r8d, %eax
	addq	$160, %rsp
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
	.asciz	"%llx %llx\n"
	.size	.L.str, 11


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
