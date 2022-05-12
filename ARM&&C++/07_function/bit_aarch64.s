	.text
	.file	"bit.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	mov	w8, w0
	mov	w0, wzr
	str	wzr, [sp, #44]
	str	w8, [sp, #40]
	str	x1, [sp, #32]
	mov	w8, #256
	str	w8, [sp, #28]
	ldr	w8, [sp, #28]
	mvn	w8, w8
	str	w8, [sp, #24]
	ldr	w8, [sp, #28]
	ldr	w9, [sp, #24]
	and	w8, w8, w9
	str	w8, [sp, #20]
	ldr	w8, [sp, #28]
	ldr	w9, [sp, #20]
	eor	w8, w8, w9
	str	w8, [sp, #16]
	ldr	w8, [sp, #28]
	asr	w8, w8, #1
	str	w8, [sp, #12]
	ldr	w8, [sp, #28]
	lsl	w8, w8, #1
	str	w8, [sp, #8]
	ldr	w8, [sp, #28]
	ldr	w9, [sp, #24]
	orr	w8, w8, w9
	str	w8, [sp, #4]
	add	sp, sp, #48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
