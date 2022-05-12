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
	.file	"func.c"
	.globl	func_arg_type                   @ -- Begin function func_arg_type
	.p2align	2
	.type	func_arg_type,%function
	.code	16                              @ @func_arg_type
	.thumb_func
func_arg_type:
	.fnstart
@ %bb.0:
	.save	{r4, r6, r7, lr}
	push	{r4, r6, r7, lr}
	.setfp	r7, sp, #8
	add	r7, sp, #8
	.pad	#24
	sub	sp, #24
	movs	r4, r1
	ldr	r1, [r7, #16]
	ldr	r1, [r7, #12]
	ldr	r1, [r7, #8]
                                        @ kill: def $r1 killed $r4
                                        @ kill: def $r1 killed $r0
	add	r1, sp, #20
	strb	r0, [r1]
	add	r0, sp, #16
	strh	r4, [r0]
	str	r2, [sp, #12]
	str	r3, [sp, #8]
	ldrb	r1, [r1]
	ldrh	r0, [r0]
	lsls	r0, r0, #16
	asrs	r2, r0, #16
	ldr	r3, [sp, #12]
	ldr	r0, [sp, #8]
	ldr	r4, [r7, #8]
	str	r4, [sp, #4]
	str	r0, [sp]
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc
	bl	printf
	add	sp, #24
	pop	{r4, r6, r7}
	pop	{r0}
	mov	lr, r0
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+4)
.Lfunc_end0:
	.size	func_arg_type, .Lfunc_end0-func_arg_type
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
	.pad	#32
	sub	sp, #32
	movs	r2, #0
	str	r2, [sp, #16]                   @ 4-byte Spill
	str	r2, [sp, #28]
	str	r0, [sp, #24]
	str	r1, [sp, #20]
	movs	r0, #75
	lsls	r0, r0, #2
	str	r0, [sp, #8]
	movs	r0, #200
	str	r0, [sp, #4]
	movs	r0, #57
	lsls	r0, r0, #3
	str	r0, [sp]
	movs	r0, #125
	lsls	r2, r0, #3
	movs	r0, #97
	movs	r1, #10
	movs	r3, #123
	bl	func_arg_type
	ldr	r0, [sp, #16]                   @ 4-byte Reload
	add	sp, #32
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cantunwind
	.fnend
                                        @ -- End function
	.type	.L.str,%object                  @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"%c %d %d %d %d\r\n"
	.size	.L.str, 17

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
