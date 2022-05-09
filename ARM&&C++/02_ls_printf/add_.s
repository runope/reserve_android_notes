	.text
	.cpu	arm7tdmi
	.globl	main                            @ -- Begin function main
	.type	main,%function
	.code	32                              @ @main
main:
	push	{r11, lr}
	mov	r11, sp
	sub	sp, sp, #16
	mov	r0, #5
	mov r1, #10
	add r1, r0, r1
	ldr r0, ._L.str1
.LABEL0:
	add r0, r0, pc
	bl	printf
	mov r0, 0
	mov sp, r11
	pop	{r11, lr}
	
._L.str1:
	.long .L.str1 - (.LABEL0 + 8)

.L.str1:
	.asciz	"a + b = %d\n"

