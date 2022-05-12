	.text
	.file	"static.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	mov	w8, w0
	mov	w0, wzr
	str	wzr, [sp, #28]
	str	w8, [sp, #24]
	str	x1, [sp, #16]
	mov	w8, #5
	str	w8, [sp, #12]
	ldr	w8, [sp, #12]
	adrp	x9, main.n
	str	w8, [x9, :lo12:main.n]
	add	sp, sp, #32
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	main.n,@object                  // @main.n
	.data								// 在data段中
	.p2align	2
main.n:
	.word	222                             // 0xde
	.size	main.n, 4

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
