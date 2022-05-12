	.text
	.file	"float_double.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3                               // -- Begin function main
.LCPI0_0:
	.xword	0x40690010624dd2f2              // double 200.00200000000001
.LCPI0_1:
	.xword	0x40590010624dd2f2              // double 100.001
	.text
	.globl	main
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
	fmov	s0, #9.00000000
	str	s0, [sp, #28]
	mov	w8, #10486				 @ hex(10486) = 0x28f6
	movk	w8, #16800, lsl #16  @ movk, Move 16-bit immediate into register, keeping other bits unchanged. 16800 << 16 = 0x41a00000. so w8 = 0x41a028f6
	fmov	s0, w8
	str	s0, [sp, #24]
	adrp	x8, .LCPI0_1
	ldr	d0, [x8, :lo12:.LCPI0_1]
	str	d0, [sp, #16]
	adrp	x8, .LCPI0_0
	ldr	d0, [x8, :lo12:.LCPI0_0]
	str	d0, [sp, #8]
	add	sp, sp, #48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
