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
	.p2align	2
	.type	main,%function
	.code	32                              @ @main
main:
	.fnstart
@ %bb.0:
	.pad	#36
	sub	sp, sp, #36
	str	r0, [sp, #32]
	str	r1, [sp, #28]
	mov	r0, #97
	strb	r0, [sp, #27]
	mov	r0, #98
	strb	r0, [sp, #26]
	mov	r0, #16
	strh	r0, [sp, #24]
	mov	r0, #32
	strh	r0, [sp, #22]
	mov	r0, #256
	str	r0, [sp, #16]
	mov	r0, #512
	str	r0, [sp, #12]
	ldrb	r0, [sp, #27]
	ldrb	r1, [sp, #26]
	add	r0, r0, r1					@ char ch3 = ch1 + ch2;
	strb	r0, [sp, #11]
	ldrh	r0, [sp, #24]
	ldrh	r1, [sp, #22]
	sub	r0, r0, r1					@ short s3 = s1 - s2;
	strh	r0, [sp, #8]
	ldr	r1, [sp, #16]
	ldr	r2, [sp, #12]
	mul	r0, r1, r2					@ int i3 = i1 * i2;
	str	r0, [sp, #4]
	mov	r0, #4096					@ r0 = 0x1000
	str	r0, [sp, #4]
	ldr	r0, [sp, #4]
	ldr	r3, .LCPI0_0				@ r1 = 0x92492493  魔数
	smull	r2, r1, r0, r3			@ 有符号长乘 SMULL{<cond>}{S}   <RdLow>，<RdHigh>，<Rm>，<Rs> r1:r2 = r0 * r3
									@ r0 * r3 = 0xfffff924 92493000, 有符号用补码存，补符号位
	add	r2, r1, r0					@ r2 = r1 + r0 = 0xfffff924 + 0x1000 =  0x1 0000 0924 = 0x 0000 0924
	asr	r1, r2, #2					@ 0x 0000 0924 >> 2 = 0x0000 0249
	add	r1, r1, r2, lsr #31			@ 0x249 + (0x00000924 >> 31) = 0x249
	sub	r1, r1, r1, lsl #3			@ 0x249 - (0x249 << 3) = 0x1(符号位)fff => 补码 0xfffff001
	add	r0, r0, r1					@ 0xfffff001 + 0x1000 = 0x1
	str	r0, [sp]
	mov	r0, #0
	add	sp, sp, #36
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	2454267027                      @ 0x92492493
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
