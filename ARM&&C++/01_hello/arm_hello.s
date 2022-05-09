	.text
	.syntax unified
	.cpu	arm7tdmi
	.globl	main                    @ -- Begin function main
	.type	main,%function
	.code	32                      @ @main
main:
	.fnstart
	push	{r11, lr}		@保存寄存器lr, r11到栈里面, lr记录函数的返回地址
	mov	r11, sp				@把sp赋值给r11  寄存器寻址
	sub	sp, sp, #24			@sp=sp-24	@sub rm, rn, #24 rm=rn-24
	mov	r2, #0				@r2=0			立即数寻址
	str	r2, [r11, #-4]		@把r2的值存到r11-4的地址上		基址寻址
	str	r0, [r11, #-8]		@把r0的值存到r11-8的地址上		基址寻址
	str	r1, [r11, #-12]		@把r1的值存到sp-12的地址上		基址寻址
	ldr	r0, .LCPI0_0		@ldr    r0,  [pc,  #40], 从pc+40读取内容存到r0, PC是当前指令的地址+两条指令长度 0x17a8, 
.LPC0_0:
	add	r0, pc, r0			@r0=pc+r0
	ldr	r1, .LCPI0_1
.LPC0_1:
	add	r1, pc, r1
	str	r2, [sp, #8]            @ 4-byte Spill
	bl	printf				@子程序的调用， r0~r3传递参数， 大于4个参数的时候，多的参数用栈传参数， si单步步入， 
							@r0用作返回值
	ldr	r1, [sp, #8]            @ 4-byte Reload
	str	r0, [sp, #4]            @ 4-byte Spill
	mov	r0, r1				@r0返回值
	mov	sp, r11				@恢复栈
	pop	{r11, lr}			@恢复r11, lr
	bx	lr					@bx lr， 跳转到lr地址， arm -> thumb 或者 thumb -> arm
@ %bb.1:
.LCPI0_0:
	.long	.L.str-(.LPC0_0+8)
.LCPI0_1:
	.long	.L.str.1-(.LPC0_1+8)
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.fnend
                                        @ -- End function
	.type	.L.str,%object          @ @.str
	.section	.rodata.str1.1,"aMS",%progbits,1
.L.str:
	.asciz	"hello %s!\r\n"
	.size	.L.str, 12

	.type	.L.str.1,%object        @ @.str.1
.L.str.1:
	.asciz	"arm"
	.size	.L.str.1, 7

	.section	".note.GNU-stack","",%progbits
