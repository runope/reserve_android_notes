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
	.file	"struct.c"
	.globl	func_ret_int                    @ -- Begin function func_ret_int
	.p2align	2
	.type	func_ret_int,%function
	.code	16                              @ @func_ret_int
	.thumb_func
func_ret_int:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, #16
	movs	r0, #0
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	str	r0, [sp, #4]
	str	r0, [sp]
	movs	r0, #1
	str	r0, [sp]
	movs	r0, #2
	str	r0, [sp, #4]
	movs	r0, #3
	str	r0, [sp, #8]
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc
	str	r0, [sp, #12]
	ldr	r0, [sp, #8]
	add	sp, #16
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+4)
.Lfunc_end0:
	.size	func_ret_int, .Lfunc_end0-func_ret_int
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	func_ret_struct                 @ -- Begin function func_ret_struct
	.p2align	2
	.type	func_ret_struct,%function
	.code	16                              @ @func_ret_struct
	.thumb_func
func_ret_struct:
	.fnstart
@ %bb.0:
	movs	r1, r0
	movs	r0, #0
	str	r0, [r1, #12]
	str	r0, [r1, #8]
	str	r0, [r1, #4]
	str	r0, [r1]
	movs	r0, #1
	str	r0, [r1]
	movs	r0, #2
	str	r0, [r1, #4]
	movs	r0, #3
	str	r0, [r1, #8]
	ldr	r0, .LCPI1_0
.LPC1_0:
	add	r0, pc
	str	r0, [r1, #12]
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	.L.str-(.LPC1_0+4)
.Lfunc_end1:
	.size	func_ret_struct, .Lfunc_end1-func_ret_struct
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	main                            @ -- Begin function main
	.p2align	1
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
	.pad	#40
	sub	sp, #40
	add	r0, sp, #24
	bl	func_ret_struct
	bl	func_ret_int
	movs	r0, #0
	str	r0, [sp, #20]
	str	r0, [sp, #16]
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	movs	r1, #1
	str	r1, [sp, #8]
	movs	r1, #2
	str	r1, [sp, #12]
	movs	r1, #3
	str	r1, [sp, #16]
	add	r1, sp, #8
	str	r1, [sp, #4]
	ldr	r2, [sp, #4]
	movs	r1, #4
	str	r1, [r2]
	ldr	r2, [sp, #4]
	movs	r1, #5
	str	r1, [r2, #4]
	add	sp, #40
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object                  @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"123"
	.size	.L.str, 4

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
