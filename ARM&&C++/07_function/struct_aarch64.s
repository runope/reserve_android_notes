	.text
	.file	"struct.c"
	.globl	func_ret_int                    // -- Begin function func_ret_int
	.p2align	2
	.type	func_ret_int,@function
func_ret_int:                           // @func_ret_int
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	xzr, [sp, #8]
	str	xzr, [sp, #16]
	str	xzr, [sp, #24]					// 置0, 初始化结构体
	mov	w8, #1
	str	w8, [sp, #8]
	mov	w8, #2
	str	w8, [sp, #12]
	mov	w8, #3
	str	w8, [sp, #16]
	adrp	x8, .L.str
	add	x8, x8, :lo12:.L.str
	str	x8, [sp, #24]
	ldr	w0, [sp, #16]
	add	sp, sp, #32
	ret
.Lfunc_end0:
	.size	func_ret_int, .Lfunc_end0-func_ret_int
	.cfi_endproc
                                        // -- End function
	.globl	func_ret_struct                 // -- Begin function func_ret_struct
	.p2align	2
	.type	func_ret_struct,@function
func_ret_struct:                        // @func_ret_struct
	.cfi_startproc
// %bb.0:
	mov	x9, x8
	str	xzr, [x9]
	str	xzr, [x9, #8]
	str	xzr, [x9, #16]					// 置0, 初始化结构体
	mov	w8, #1
	str	w8, [x9]
	mov	w8, #2
	str	w8, [x9, #4]
	mov	w8, #3
	str	w8, [x9, #8]
	adrp	x8, .L.str
	add	x8, x8, :lo12:.L.str
	str	x8, [x9, #16]
	ret
.Lfunc_end1:
	.size	func_ret_struct, .Lfunc_end1-func_ret_struct
	.cfi_endproc
                                        // -- End function
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             // 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sub	x8, x29, #24					@ x8 作为结构体的空间地址传入返回
	bl	func_ret_struct
	bl	func_ret_int
	add	x8, sp, #16
	str	xzr, [sp, #16]
	str	xzr, [sp, #24]
	str	xzr, [sp, #32]					// 置0, 初始化结构体
	mov	w9, #1
	str	w9, [sp, #16]
	mov	w9, #2
	str	w9, [sp, #20]
	mov	w9, #3
	str	w9, [sp, #24]
	str	x8, [sp, #8]
	ldr	x9, [sp, #8]
	mov	w8, #4
	str	w8, [x9]
	ldr	x9, [sp, #8]
	mov	w8, #5
	str	w8, [x9, #4]
	mov	w0, wzr
	ldp	x29, x30, [sp, #64]             // 16-byte Folded Reload
	add	sp, sp, #80
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"123"
	.size	.L.str, 4

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
