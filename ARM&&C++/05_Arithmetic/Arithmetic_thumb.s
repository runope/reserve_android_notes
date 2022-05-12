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
	.file	"Arithmetic.c"
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
	.pad	#48
	sub	sp, #48
	str	r0, [sp, #44]
	str	r1, [sp, #40]
	add	r1, sp, #36
	movs	r0, #97
	strb	r0, [r1]
	add	r1, sp, #32
	movs	r0, #98
	strb	r0, [r1]
	add	r1, sp, #28
	movs	r0, #16
	strh	r0, [r1]
	add	r1, sp, #24
	movs	r0, #32
	strh	r0, [r1]
	movs	r0, #1
	lsls	r1, r0, #8
	str	r1, [sp, #20]
	lsls	r1, r0, #9
	str	r1, [sp, #16]
	ldr	r1, [sp, #36]
	ldr	r2, [sp, #32]
	adds	r1, r1, r2
	add	r2, sp, #12
	strb	r1, [r2]
	ldr	r1, [sp, #28]
	ldr	r2, [sp, #24]
	subs	r1, r1, r2
	add	r2, sp, #8
	strh	r1, [r2]
	ldr	r2, [sp, #20]
	ldr	r1, [sp, #16]
	muls	r1, r2, r1   @ mul
	str	r1, [sp, #4]
	lsls	r0, r0, #12  @ 0x1000
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	movs	r1, #7
	bl	__aeabi_idivmod  @ bl
	str	r1, [sp]
	movs	r0, #0
	add	sp, #48
	pop	{r7}
	pop	{r1}
	mov	lr, r1
	bx	lr
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
