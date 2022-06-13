	.text
	.file	"charArray.c"
	.globl	main                            // -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	x29, x30, [sp, #-32]!           // 16-byte Folded Spill
	str	x28, [sp, #16]                  // 8-byte Folded Spill
	mov	x29, sp
	sub	sp, sp, #1648
	.cfi_def_cfa w29, 32
	.cfi_offset w28, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	mov	w8, wzr
	str	w8, [sp, #28]                   // 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	stur	w0, [x29, #-8]
	stur	x1, [x29, #-16]
	add	x0, sp, #832
	str	x0, [sp, #8]                    // 8-byte Folded Spill
	adrp	x1, .L.str
	add	x1, x1, :lo12:.L.str
	bl	sprintf
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	add	x0, sp, #32
	str	x0, [sp, #16]                   // 8-byte Folded Spill
	bl	strcpy
	ldr	x1, [sp, #16]                   // 8-byte Folded Reload
	mov	x8, #111
	str	x8, [sp, #64]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printf
	ldr	w0, [sp, #28]                   // 4-byte Folded Reload
	add	sp, sp, #1648
	ldr	x28, [sp, #16]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp], #32             // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Hello, world!"
	.size	.L.str, 14

	.type	.L.str.1,@object                // @.str.1
.L.str.1:
	.asciz	"%s"
	.size	.L.str.1, 3

	.ident	"Android (8075178, based on r437112b) clang version 14.0.1 (https://android.googlesource.com/toolchain/llvm-project 8671348b81b95fc603505dfc881b45103bee1731)"
	.section	".note.GNU-stack","",@progbits
