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
	.file	"class_function.cc"
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
	.pad	#24
	sub	sp, sp, #24
	mov	r2, #0
	str	r2, [r11, #-4]
	str	r0, [r11, #-8]
	str	r1, [sp, #12]
	mov	r0, #1
	str	r0, [sp]					@ num1 = 1
	mov	r0, #2				
	str	r0, [sp, #4]				@ num2 = 2
	mov	r0, sp						@ class的成员函数有一个隐藏的this指针参数，使用r0传递
	bl	_ZN7CNumber7getNum2Ev		@ 这样看很明显，但是实际中得so会用strip抹掉符号表，见class_function_strip
	mov	sp, r11
	pop	{r11, lr}
	bx	lr
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.fnend
                                        @ -- End function
	.section	.text._ZN7CNumber7getNum2Ev,"axG",%progbits,_ZN7CNumber7getNum2Ev,comdat
	.weak	_ZN7CNumber7getNum2Ev           @ -- Begin function _ZN7CNumber7getNum2Ev
	.p2align	2
	.type	_ZN7CNumber7getNum2Ev,%function
	.code	32                              @ @_ZN7CNumber7getNum2Ev
_ZN7CNumber7getNum2Ev:
	.fnstart
@ %bb.0:
	.pad	#4
	sub	sp, sp, #4
	str	r0, [sp]				@ r0 是 this指针
	ldr	r0, [sp]
	ldr	r0, [r0, #4]			@ 取第二个参数即this.num2作为返回值给r0
	add	sp, sp, #4
	bx	lr
.Lfunc_end1:
	.size	_ZN7CNumber7getNum2Ev, .Lfunc_end1-_ZN7CNumber7getNum2Ev
	.cantunwind
	.fnend
                                        @ -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",%progbits
