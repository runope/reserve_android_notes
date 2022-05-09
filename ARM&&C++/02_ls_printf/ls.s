	.text
	.cpu	arm7tdmi
	.globl	main
	.type	main,%function
	.code	32
main:
    push {r4, r5, lr}
    ldr r0, [r1, #0x4]
    bl opendir
    cmp r0, #0
    beq .LABEL_EXIT
    mov r4, r0
    bl readdir
    cmp r0, #0
    beq .LABEL_CLOSEDIR
    ldr r5, .format_str_
.LABLE0:
    add r5, r5, pc

.LOOP_READDIR:
    add r1, r0, #0x13
    mov r0, r5
    bl printf
    mov r0, r4
    bl readdir
    cmp r0, #0
    bne .LOOP_READDIR

.LABEL_CLOSEDIR:
    mov r0, r4
    bl closedir

.LABEL_EXIT:
    mov r0, #0
    pop {r4, r5, lr}
    bx lr

.format_str_:
    .long .format_str-(.LABLE0 + 8)

.format_str:
    .asciz "%s\r\n"