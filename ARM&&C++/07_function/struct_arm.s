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
	.code	32                              @ @func_ret_int
func_ret_int:
	.fnstart
@ %bb.0:
	.pad	#16
	sub	sp, sp, #16						 @ 函数内开辟空间
	mov	r0, #0
	str	r0, [sp, #12]
	str	r0, [sp, #8]
	str	r0, [sp, #4]
	str	r0, [sp]
	mov	r0, #1
	str	r0, [sp]
	mov	r0, #2
	str	r0, [sp, #4]
	mov	r0, #3
	str	r0, [sp, #8]
	ldr	r0, .LCPI0_0
.LPC0_0:
	add	r0, pc, r0
	str	r0, [sp, #12]
	ldr	r0, [sp, #8]
	add	sp, sp, #16
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+8)
.Lfunc_end0:
	.size	func_ret_int, .Lfunc_end0-func_ret_int
	.cantunwind
	.fnend
                                        @ -- End function
	.globl	func_ret_struct                 @ -- Begin function func_ret_struct
	.p2align	2
	.type	func_ret_struct,%function
	.code	32                              @ @func_ret_struct
func_ret_struct:
	.fnstart
@ %bb.0:
	mov	r1, r0					@ r1 = r0， 结构体的保存地址
	mov	r0, #0
	str	r0, [r1, #12]
	str	r0, [r1, #8]
	str	r0, [r1, #4]			
	str	r0, [r1]				@ 结构体初始化， 下面开始赋值
	mov	r0, #1
	str	r0, [r1]
	mov	r0, #2
	str	r0, [r1, #4]
	mov	r0, #3
	str	r0, [r1, #8]
	ldr	r0, .LCPI1_0
.LPC1_0:
	add	r0, pc, r0
	str	r0, [r1, #12]
	bx	lr
	.p2align	2
@ %bb.1:
.LCPI1_0:
	.long	.L.str-(.LPC1_0+8)
.Lfunc_end1:
	.size	func_ret_struct, .Lfunc_end1-func_ret_struct
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
	.pad	#40
	sub	sp, sp, #40
	sub	r0, r11, #16         @ 开空间
	bl	func_ret_struct    	 @ r0作为参数，把地址空间传入和传出
	bl	func_ret_int
	mov	r0, #0
	str	r0, [sp, #20]
	str	r0, [sp, #16]
	str	r0, [sp, #12]
	str	r0, [sp, #8]		@ 初始化结构体
	mov	r1, #1
	str	r1, [sp, #8]
	mov	r1, #2
	str	r1, [sp, #12]
	mov	r1, #3
	str	r1, [sp, #16]
	add	r1, sp, #8
	str	r1, [sp, #4]
	ldr	r2, [sp, #4]
	mov	r1, #4
	str	r1, [r2]
	ldr	r2, [sp, #4]
	mov	r1, #5
	str	r1, [r2, #4]
	mov	sp, r11
	pop	{r11, lr}
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
