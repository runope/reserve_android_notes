	.text
	.syntax unified
	.eabi_attribute	67, "2.09"	@ Tag_conformance
	.cpu	arm7tdmi
	.eabi_attribute	6, 2	@ Tag_CPU_arch
	.eabi_attribute	8, 1	@ Tag_ARM_ISA_use
	.eabi_attribute	9, 1	@ Tag_THUMB_ISA_use
	.eabi_attribute	34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute	15, 1	@ Tag_ABI_PCS_RW_data
	.eabi_attribute	16, 1	@ Tag_ABI_PCS_RO_data
	.eabi_attribute	17, 2	@ Tag_ABI_PCS_GOT_use
	.eabi_attribute	20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute	21, 0	@ Tag_ABI_FP_exceptions
	.eabi_attribute	23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute	24, 1	@ Tag_ABI_align_needed
	.eabi_attribute	25, 1	@ Tag_ABI_align_preserved
	.eabi_attribute	38, 1	@ Tag_ABI_FP_16bit_format
	.eabi_attribute	18, 4	@ Tag_ABI_PCS_wchar_t
	.eabi_attribute	26, 2	@ Tag_ABI_enum_size
	.eabi_attribute	14, 0	@ Tag_ABI_PCS_R9_use
	.file	"loop.c"
	.globl	main                            @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	16                              @ @main
	.thumb_func
main:
	.fnstart
@ %bb.0:
	.save	{r7, lr}
	push	{r7, lr}
	.setfp	r7, sp
	add	r7, sp, #0
	.pad	#24
	sub	sp, #24
	movs	r2, r0
	movs	r0, #0
	str	r0, [sp, #20]
	str	r2, [sp, #16]
	str	r1, [sp, #12]
	str	r0, [sp, #8]
	b	.LBB0_1
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	cmp	r0, #19
	bgt	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r1, [sp, #8]
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc
	bl	printf
	b	.LBB0_3
.LBB0_3:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp, #8]
	adds	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB0_1
.LBB0_4:
	movs	r0, #30
	str	r0, [sp, #4]
	b	.LBB0_5
.LBB0_5:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #4]
	cmp	r0, #0
	beq	.LBB0_7
	b	.LBB0_6
.LBB0_6:                                @   in Loop: Header=BB0_5 Depth=1
	ldr	r1, [sp, #4]
	ldr	r0, .LCPI0_1
.LPC0_1:
	add	r0, pc
	bl	printf
	ldr	r0, [sp, #4]
	subs	r0, r0, #1
	str	r0, [sp, #4]
	b	.LBB0_5
.LBB0_7:
	movs	r0, #40
	str	r0, [sp]
	b	.LBB0_8
.LBB0_8:                                @ =>This Inner Loop Header: Depth=1
	ldr	r1, [sp]
	subs	r0, r1, #1
	str	r0, [sp]
	ldr	r0, .LCPI0_2
.LPC0_2:
	add	r0, pc
	bl	printf
	b	.LBB0_9
.LBB0_9:                                @   in Loop: Header=BB0_8 Depth=1
	ldr	r0, [sp]
	cmp	r0, #0
	bne	.LBB0_8
	b	.LBB0_10
.LBB0_10:
	movs	r0, #0
	add	sp, #24
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
	.p2align	2
@ %bb.11:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+4)
.LCPI0_1:
	.long	.L.str.1-(.LPC0_1+4)
.LCPI0_2:
	.long	.L.str.2-(.LPC0_2+4)
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object                  @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"for i : %d\r\n"
	.size	.L.str, 13

	.type	.L.str.1,%object                @ @.str.1
.L.str.1:
	.asciz	"while j : %d\r\n"
	.size	.L.str.1, 15

	.type	.L.str.2,%object                @ @.str.2
.L.str.2:
	.asciz	"do while k : %d\r\n"
	.size	.L.str.2, 18

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
