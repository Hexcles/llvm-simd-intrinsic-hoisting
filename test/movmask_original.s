	.text
	.file	"movmask_original.ll"
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
	movaps	%xmm0, %xmm1
	pmovmskb	%xmm0, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %esi
	movb	$0, %al
	movaps	%xmm1, -80(%rbp)        # 16-byte Spill
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
