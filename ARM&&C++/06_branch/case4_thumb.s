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
	.file	"case4.c"
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
	.pad	#16
	sub	sp, #16
	movs	r0, #0
	str	r0, [sp, #12]
	movs	r0, #3
	str	r0, [sp, #8]
	ldr	r0, [sp, #8]
	subs	r0, r0, #1
	str	r0, [sp, #4]                    @ 4-byte Spill
	cmp	r0, #3
	bhi	.LBB0_7
@ %bb.1:
	ldr	r0, [sp, #4]                    @ 4-byte Reload
	lsls	r1, r0, #2
	adr	r0, .LJTI0_0
	ldr	r1, [r0, r1]
	adds	r0, r0, r1
	mov	pc, r0							@ 4个及以上case采用查表法，更改PC指针强制跳转
@ %bb.2:
	.p2align	2
.LJTI0_0:
	.long	.LBB0_3-.LJTI0_0
	.long	.LBB0_4-.LJTI0_0
	.long	.LBB0_5-.LJTI0_0
	.long	.LBB0_6-.LJTI0_0
.LBB0_3:
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc
	bl	printf
	b	.LBB0_8
.LBB0_4:
	ldr	r0, .LCPI0_1
.LPC0_1:
	add	r0, pc
	bl	printf
	b	.LBB0_8
.LBB0_5:
	ldr	r0, .LCPI0_2
.LPC0_2:
	add	r0, pc
	bl	printf
	b	.LBB0_8
.LBB0_6:
	ldr	r0, .LCPI0_3
.LPC0_3:
	add	r0, pc
	bl	printf
	b	.LBB0_8
.LBB0_7:
	ldr	r0, .LCPI0_4
.LPC0_4:
	add	r0, pc
	bl	printf
	b	.LBB0_8
.LBB0_8:
	movs	r0, #0
	add	sp, #16
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
	.p2align	2
@ %bb.9:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+4)
.LCPI0_1:
	.long	.L.str.1-(.LPC0_1+4)
.LCPI0_2:
	.long	.L.str.2-(.LPC0_2+4)
.LCPI0_3:
	.long	.L.str.3-(.LPC0_3+4)
.LCPI0_4:
	.long	.L.str.4-(.LPC0_4+4)
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object                  @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"case 1\r\n"
	.size	.L.str, 9

	.type	.L.str.1,%object                @ @.str.1
.L.str.1:
	.asciz	"case 2\r\n"
	.size	.L.str.1, 9

	.type	.L.str.2,%object                @ @.str.2
.L.str.2:
	.asciz	"case 3\r\n"
	.size	.L.str.2, 9

	.type	.L.str.3,%object                @ @.str.3
.L.str.3:
	.asciz	"case 4\r\n"
	.size	.L.str.3, 9

	.type	.L.str.4,%object                @ @.str.4
.L.str.4:
	.asciz	"case default\r\n"
	.size	.L.str.4, 15

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
