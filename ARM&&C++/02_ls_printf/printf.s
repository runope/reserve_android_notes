	.text
	.cpu	arm7tdmi
	.globl	main                            @ -- Begin function main
	.type	main,%function
	.code	32   

main:
    push {lr}
    ldr r0, [r1, #0x4]
    bl printf
    mov r0, #0
    pop {lr}
    bx lr