	.text
	.file	"Arithmetic.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	str	w0, [sp, #44]
	str	x1, [sp, #32]
	mov	w8, #97
	strb	w8, [sp, #31]
	mov	w8, #98
	strb	w8, [sp, #30]
	mov	w8, #16
	strh	w8, [sp, #28]
	mov	w8, #32
	strh	w8, [sp, #26]
	mov	w8, #256
	str	w8, [sp, #20]
	mov	w8, #512
	str	w8, [sp, #16]
	ldrb	w8, [sp, #31]
	ldrb	w9, [sp, #30]
	add	w8, w8, w9
	strb	w8, [sp, #15]
	ldrsh	w8, [sp, #28]
	ldrsh	w9, [sp, #26]
	subs	w8, w8, w9
	strh	w8, [sp, #12]
	ldr	w8, [sp, #20]
	ldr	w9, [sp, #16]
	mul	w8, w8, w9
	str	w8, [sp, #8]
	mov	w8, #4096		 @ -- Initialize w8 0x1000
	str	w8, [sp, #8]
	ldr	w8, [sp, #8]
	mov	w10, #7
	sdiv	w9, w8, w10	 @ sdiv，除取整，0x1000 / 0x7 = 0x249   
	mul	w9, w9, w10		 @ 0x249 * 0x7 = 0xfff
	subs	w8, w8, w9	 @ 0x1000 - 0xfff = 0x1
	str	w8, [sp, #4]
	mov	w0, wzr
	add	sp, sp, #48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
