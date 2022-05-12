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
	.file	"int_char.c"
	.globl	main                            @ -- Begin function main
	.p2align	1
	.type	main,%function
	.code	16                              @ @main
	.thumb_func
main:
	.fnstart
@ %bb.0:
	.pad	#64
	sub	sp, #64
	movs	r2, r0
	movs	r0, #0
	str	r0, [sp, #60]
	str	r2, [sp, #56]
	str	r1, [sp, #52]
	add	r2, sp, #48
	movs	r1, #97
	strb	r1, [r2]      @ char 'a', use strb(b -> byte), bytes
	add	r2, sp, #44
	movs	r1, #98
	strb	r1, [r2]	  @ char 'b', use strb(b -> byte), bytes
	add	r2, sp, #40
	movs	r1, #16
	strh	r1, [r2]	  @ short 0X10, use strh(h -> halfword), 2 bytes
	add	r2, sp, #36
	movs	r1, #32
	strh	r1, [r2]	  @ short 0X20, use strh(h -> halfword), 2 bytes
	movs	r1, #1
	lsls	r2, r1, #8	  @ 通过左移得到 0x100
	str	r2, [sp, #32]	  @ int 0x100, use str, 4bytes
	lsls	r2, r1, #9	  @ 通过左移得到 0x200
	str	r2, [sp, #28]	  @ int 0x200, use str, 4bytes
	lsls	r2, r1, #12   @ 通过左移得到 0x1000
	str	r2, [sp, #24]     @ long 0x1000, use str, 4bytes
	lsls	r2, r1, #13   @ 通过左移得到 0x2000
	str	r2, [sp, #20]     @ long 0x2000, use str, 4bytes
	str	r0, [sp, #12]    
	lsls	r2, r1, #16   @ 通过左移得到 0x10000
	str	r2, [sp, #8]      @ long 0x10000, use str, 4bytes
	str	r0, [sp, #4]      
	lsls	r1, r1, #17   @ 通过左移得到 0x20000
	str	r1, [sp]          @ long 0x20000, use str, 4bytes
	add	sp, #64
	bx	lr
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cantunwind
	.fnend
                                        @ -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
