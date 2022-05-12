	.text
	.file	"array.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	sub	sp, sp, #160
	stp	x29, x30, [sp, #144]            // 16-byte Folded Spill
	add	x29, sp, #144
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x1
	mov	w1, wzr
	stur	wzr, [x29, #-4]
	stur	w0, [x29, #-8]
	stur	x8, [x29, #-16]
	add	x0, sp, #48
	mov	x2, #80
	bl	memset
	mov	w8, #3
	str	w8, [sp, #60]
	str	xzr, [sp, #40]
	b	.LBB0_1
.LBB0_1:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #40]
	subs	x8, x8, #80
	b.hs	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                //   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #40]
	add	x8, x8, #3
	ldr	x10, [sp, #40]
	add	x9, sp, #48
                                        // kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, x10, lsl #2]
	ldr	x8, [sp, #40]
	add	x8, x8, #6
	ldr	x10, [sp, #40]
                                        // kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, x10, lsl #2]
	b	.LBB0_3
.LBB0_3:                                //   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #40]
	add	x8, x8, #1
	str	x8, [sp, #40]
	b	.LBB0_1
.LBB0_4:
	add	x8, sp, #48
	str	x8, [sp, #32]
	mov	x8, #79
	str	x8, [sp, #24]
	b	.LBB0_5
.LBB0_5:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]
	subs	x8, x8, #0
	b.lo	.LBB0_8
	b	.LBB0_6
.LBB0_6:                                //   in Loop: Header=BB0_5 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #9
	ldr	x9, [sp, #32]
	ldr	x11, [sp, #24]
	mov	x10, xzr
	subs	x10, x10, x11
                                        // kill: def $w8 killed $w8 killed $x8
	str	w8, [x9, x10, lsl #2]
	b	.LBB0_7
.LBB0_7:                                //   in Loop: Header=BB0_5 Depth=1
	ldr	x8, [sp, #24]
	subs	x8, x8, #1
	str	x8, [sp, #24]
	b	.LBB0_5
.LBB0_8:
	str	xzr, [sp, #16]
	b	.LBB0_9
.LBB0_9:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #16]
	subs	x8, x8, #100
	b.hs	.LBB0_12
	b	.LBB0_10
.LBB0_10:                               //   in Loop: Header=BB0_9 Depth=1
	ldr	x8, [sp, #16]
	ldr	x10, [sp, #16]
	adrp	x9, main.static_array
	add	x9, x9, :lo12:main.static_array
                                        // kill: def $w8 killed $w8 killed $x8
	strb	w8, [x9, x10]
	b	.LBB0_11
.LBB0_11:                               //   in Loop: Header=BB0_9 Depth=1
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	.LBB0_9
.LBB0_12:
	str	xzr, [sp, #8]
	b	.LBB0_13
.LBB0_13:                               // =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	subs	x8, x8, #100
	b.hs	.LBB0_16
	b	.LBB0_14
.LBB0_14:                               //   in Loop: Header=BB0_13 Depth=1
	ldr	x8, [sp, #8]
	ldr	x10, [sp, #8]
	adrp	x9, global_array
	add	x9, x9, :lo12:global_array
                                        // kill: def $w8 killed $w8 killed $x8
	strb	w8, [x9, x10]
	b	.LBB0_15
.LBB0_15:                               //   in Loop: Header=BB0_13 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	.LBB0_13
.LBB0_16:
	mov	w0, wzr
	ldp	x29, x30, [sp, #144]            // 16-byte Folded Reload
	add	sp, sp, #160
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	global_array,@object            // @global_array
	.bss
	.globl	global_array
global_array:
	.zero	100
	.size	global_array, 100

	.type	main.static_array,@object       // @main.static_array
	.local	main.static_array
	.comm	main.static_array,100,1
	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
