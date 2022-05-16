    .text
    .global asm_syscall
    .type asm_syscall, %function

asm_syscall:
    MOV             R12, SP
    PUSH            {R4-R7}
    MOV             R7, R0
    MOV             R0, R1
    MOV             R1, R2
    MOV             R2, R3
    LDM             R12, {R3-R6}
    SVC             0
    POP             {R4-R7}
    CMN             R0, #0x1000
    MOV             PC, LR