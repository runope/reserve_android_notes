	.text
	.file	"int_char.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	mov	w8, w0
	mov	w0, wzr
	str	wzr, [sp, #60]
	str	w8, [sp, #56]
	str	x1, [sp, #48]
	mov	w8, #97
	strb	w8, [sp, #47]
	mov	w8, #98
	strb	w8, [sp, #46]
	mov	w8, #16
	strh	w8, [sp, #44]
	mov	w8, #32
	strh	w8, [sp, #42]
	mov	w8, #256
	str	w8, [sp, #36]
	mov	w8, #512
	str	w8, [sp, #32]
	mov	x8, #4096
	str	x8, [sp, #24]     @ long
	mov	x8, #8192
	str	x8, [sp, #16]     @ long
	mov	x8, #65536
	str	x8, [sp, #8]      @ long long
	mov	x8, #131072
	str	x8, [sp]          @ long long
	add	sp, sp, #64
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
