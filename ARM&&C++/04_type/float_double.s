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
	.file	"float_double.c"
	.globl	main                            @ -- Begin function main
	.p2align	2
	.type	main,%function
	.code	32                              @ @main
main:
	.fnstart
@ %bb.0:
	.pad	#40
	sub	sp, sp, #40
	mov	r2, r0
	mov	r0, #0
	str	r0, [sp, #36]
	str	r2, [sp, #32]
	str	r1, [sp, #28]
	ldr	r1, .LCPI0_0
	str	r1, [sp, #24]
	ldr	r1, .LCPI0_1
	str	r1, [sp, #20]
	ldr	r1, .LCPI0_2
	str	r1, [sp, #12]
	ldr	r1, .LCPI0_3
	str	r1, [sp, #8]
	ldr	r2, .LCPI0_4
	str	r2, [sp, #4]
	str	r1, [sp]
	add	sp, sp, #40
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	1092626678                      @ 0x412028f6
.LCPI0_1:
	.long	1101015286                      @ 0x41a028f6
.LCPI0_2:
	.long	1079574544                      @ 0x40590010
.LCPI0_3:
	.long	1649267442                      @ 0x624dd2f2
.LCPI0_4:
	.long	1080623120                      @ 0x40690010
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
