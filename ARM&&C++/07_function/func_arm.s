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
	.code	32                              @ @func_arg_type
func_arg_type:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#24
	sub	sp, sp, #24
	ldr	r12, [r11, #16]
	ldr	r12, [r11, #12]
	ldr	r12, [r11, #8]
                                        @ kill: def $r12 killed $r1
                                        @ kill: def $r12 killed $r0
	strb	r0, [r11, #-1]
	strh	r1, [r11, #-4]
	str	r2, [r11, #-8]
	str	r3, [sp, #12]
	ldrb	r1, [r11, #-1]
	ldrsh	r2, [r11, #-4]
	ldr	r3, [r11, #-8]
	ldr	r0, [sp, #12]
	ldr	lr, [r11, #8]
	mov	r12, sp
	str	lr, [r12, #4]
	str	r0, [r12]
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc, r0
	bl	printf
	mov	sp, r11
	pop	{r11, lr}
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+8)
.Lfunc_end0:
	.size	func_arg_type, .Lfunc_end0-func_arg_type
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	main                            @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	32                              @ @main
main:
	.fnstart
@ %bb.0:
	.save	{r11, lr}
	push	{r11, lr}
	.setfp	r11, sp
	mov	r11, sp
	.pad	#32
	sub	sp, sp, #32
	mov	r2, #0
	str	r2, [sp, #16]                   @ 4-byte Spill
	str	r2, [r11, #-4]
	str	r0, [r11, #-8]
	str	r1, [r11, #-12]
	mov	r1, sp
	mov	r0, #300
	str	r0, [r1, #8]
	mov	r0, #200
	str	r0, [r1, #4]
	mov	r0, #456
	str	r0, [r1]
	mov	r0, #97
	mov	r1, #10
	mov	r2, #1000
	mov	r3, #123						@ r0 ~ r3传前4个参数
	bl	func_arg_type
	ldr	r0, [sp, #16]                   @ 4-byte Reload
	mov	sp, r11
	pop	{r11, lr}
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
