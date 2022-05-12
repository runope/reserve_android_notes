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
	.file	"array.c"
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
	.pad	#120
	sub	sp, #120
	movs	r2, #0
	str	r2, [sp, #4]                    @ 4-byte Spill
	str	r2, [sp, #116]
	str	r0, [sp, #112]
	str	r1, [sp, #108]
	add	r0, sp, #28
	movs	r1, #80
	bl	__aeabi_memclr4					@ 数组初始化， 80 = 20 * 4bit
	ldr	r0, [sp, #4]                    @ 4-byte Reload
	movs	r1, #3
	str	r1, [sp, #40]
	str	r0, [sp, #24]
	b	.LBB0_1
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #24]
	cmp	r0, #79
	bhi	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r1, [sp, #24]
	adds	r0, r1, #3
	lsls	r2, r1, #2
	add	r1, sp, #28
	str	r0, [r1, r2]
	ldr	r2, [sp, #24]
	adds	r0, r2, #6
	lsls	r2, r2, #2
	str	r0, [r1, r2]
	b	.LBB0_3
.LBB0_3:                                @   in Loop: Header=BB0_1 Depth=1
	ldr	r0, [sp, #24]
	adds	r0, r0, #1
	str	r0, [sp, #24]
	b	.LBB0_1
.LBB0_4:
	add	r0, sp, #28
	str	r0, [sp, #20]
	movs	r0, #79
	str	r0, [sp, #16]
	b	.LBB0_5
.LBB0_5:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #16]
	cmp	r0, #0
	blo	.LBB0_8
	b	.LBB0_6
.LBB0_6:                                @   in Loop: Header=BB0_5 Depth=1
	ldr	r2, [sp, #16]
	movs	r0, r2
	adds	r0, #9
	ldr	r1, [sp, #20]
	lsls	r2, r2, #2
	subs	r1, r1, r2
	str	r0, [r1]
	b	.LBB0_7
.LBB0_7:                                @   in Loop: Header=BB0_5 Depth=1
	ldr	r0, [sp, #16]
	subs	r0, r0, #1
	str	r0, [sp, #16]
	b	.LBB0_5
.LBB0_8:
	movs	r0, #0
	str	r0, [sp, #12]
	b	.LBB0_9
.LBB0_9:                                @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #12]
	cmp	r0, #99
	bhi	.LBB0_12
	b	.LBB0_10
.LBB0_10:                               @   in Loop: Header=BB0_9 Depth=1
	ldr	r0, [sp, #12]
	ldr	r1, .LCPI0_0
.LPC0_0:
	add	r1, pc
	strb	r0, [r1, r0]
	b	.LBB0_11
.LBB0_11:                               @   in Loop: Header=BB0_9 Depth=1
	ldr	r0, [sp, #12]
	adds	r0, r0, #1
	str	r0, [sp, #12]
	b	.LBB0_9
.LBB0_12:
	movs	r0, #0
	str	r0, [sp, #8]
	b	.LBB0_13
.LBB0_13:                               @ =>This Inner Loop Header: Depth=1
	ldr	r0, [sp, #8]
	cmp	r0, #99
	bhi	.LBB0_16
	b	.LBB0_14
.LBB0_14:                               @   in Loop: Header=BB0_13 Depth=1
	ldr	r0, [sp, #8]
	ldr	r1, .LCPI0_1
.LPC0_1:
	add	r1, pc
	strb	r0, [r1, r0]
	b	.LBB0_15
.LBB0_15:                               @   in Loop: Header=BB0_13 Depth=1
	ldr	r0, [sp, #8]
	adds	r0, r0, #1
	str	r0, [sp, #8]
	b	.LBB0_13
.LBB0_16:
	movs	r0, #0
	add	sp, #120
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
	.p2align	2
@ %bb.17:
.LCPI0_0:
	.long	main.static_array-(.LPC0_0+4)
.LCPI0_1:
	.long	global_array-(.LPC0_1+4)
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	global_array,%object            @ @global_array
	.bss
	.globl	global_array
global_array:
	.zero	100
	.size	global_array, 100

	.type	main.static_array,%object       @ @main.static_array
	.local	main.static_array
	.comm	main.static_array,100,1
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
