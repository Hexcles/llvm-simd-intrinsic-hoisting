	.text
	.file	"pack_original.ll"
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
	subq	$192, %rsp
	movabsq	$.L.str, %rdi
	movl	$0, -100(%rbp)
	movw	$800, -66(%rbp)         # imm = 0x320
	movw	$700, -68(%rbp)         # imm = 0x2BC
	movw	$600, -70(%rbp)         # imm = 0x258
	movw	$500, -72(%rbp)         # imm = 0x1F4
	movw	$400, -74(%rbp)         # imm = 0x190
	movw	$300, -76(%rbp)         # imm = 0x12C
	movw	$200, -78(%rbp)
	movw	$100, -80(%rbp)
	movl	$100, %eax
	movd	%eax, %xmm0
	movzwl	-72(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-76(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-68(%rbp), %eax
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movzwl	-78(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-70(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-74(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-66(%rbp), %eax
	movd	%eax, %xmm3
	punpcklwd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movaps	%xmm3, -96(%rbp)
	movaps	%xmm3, -128(%rbp)
	movw	$0, -2(%rbp)
	movw	$-100, -4(%rbp)
	movw	$-200, -6(%rbp)
	movw	$-300, -8(%rbp)         # imm = 0xFFFFFFFFFFFFFED4
	movw	$-400, -10(%rbp)        # imm = 0xFFFFFFFFFFFFFE70
	movw	$-500, -12(%rbp)        # imm = 0xFFFFFFFFFFFFFE0C
	movw	$-600, -14(%rbp)        # imm = 0xFFFFFFFFFFFFFDA8
	movw	$-700, -16(%rbp)        # imm = 0xFFFFFFFFFFFFFD44
	movl	$64836, %eax            # imm = 0xFD44
	movd	%eax, %xmm0
	movzwl	-8(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-12(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-4(%rbp), %eax
	movd	%eax, %xmm2
	punpcklwd	%xmm0, %xmm2    # xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3]
	punpcklwd	%xmm1, %xmm2    # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	movzwl	-14(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-6(%rbp), %eax
	movd	%eax, %xmm1
	punpcklwd	%xmm0, %xmm1    # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
	movzwl	-10(%rbp), %eax
	movd	%eax, %xmm0
	movzwl	-2(%rbp), %eax
	movd	%eax, %xmm3
	punpcklwd	%xmm0, %xmm3    # xmm3 = xmm3[0],xmm0[0],xmm3[1],xmm0[1],xmm3[2],xmm0[2],xmm3[3],xmm0[3]
	punpcklwd	%xmm1, %xmm3    # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3]
	punpcklwd	%xmm2, %xmm3    # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movaps	%xmm3, -32(%rbp)
	movaps	%xmm3, -144(%rbp)
	movaps	-128(%rbp), %xmm0
	movaps	%xmm0, -48(%rbp)
	movaps	%xmm3, -64(%rbp)
	movaps	-48(%rbp), %xmm0
	packuswb	%xmm3, %xmm0
	movaps	%xmm0, %xmm1
	movdqa	%xmm0, -160(%rbp)
	movdqa	-128(%rbp), %xmm0
	movb	$1, %al
	movaps	%xmm1, -176(%rbp)       # 16-byte Spill
	callq	printf
	movabsq	$.L.str.1, %rdi
	movdqa	-144(%rbp), %xmm0
	movl	%eax, -180(%rbp)        # 4-byte Spill
	movb	$1, %al
	callq	printf
	movabsq	$.L.str.2, %rdi
	movdqa	-160(%rbp), %xmm0
	movl	%eax, -184(%rbp)        # 4-byte Spill
	movb	$1, %al
	callq	printf
	xorl	%ecx, %ecx
	movl	%eax, -188(%rbp)        # 4-byte Spill
	movl	%ecx, %eax
	addq	$192, %rsp
	popq	%rbp
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"resultLo = %vhd\n"
	.size	.L.str, 17

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"resultHi = %vhd\n"
	.size	.L.str.1, 17

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"result   = %vu\n"
	.size	.L.str.2, 16


	.ident	"clang version 3.7.1 (tags/RELEASE_371/final)"
	.section	".note.GNU-stack","",@progbits
