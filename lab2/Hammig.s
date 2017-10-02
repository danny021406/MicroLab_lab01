 .syntax unified
 .cpu cortex-m4
 .thumb 
 
.data
	result: .byte 0
	X: .word 0x55AA  //AA550000
	Y: .word 0xAA55  //55AA0000
.text
	.global main

hamm:
	eors r5, r3, r4
    movs r6, #0
	bx lr
dis:
    cmp r5, #0
    beq end
    sub r7, r5, #1
    and r5, r5, r7
    add r6, r6, #1
    b dis
main:
	ldr r0, =X
	ldr r1, =Y
	ldr r3, [r0]
	ldr r4, [r1]
	
	ldr r2, =result
	bl hamm
    b dis
end:
    str r6, [r2]
L: b L
