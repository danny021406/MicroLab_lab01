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
	str r5, [r2]
	bx lr

main:
	ldr r0, =X 
	ldr r1, =Y
	ldr r3, [r0]
	ldr r4, [r1]
	
	ldr r2, =result
	bl hamm

L: b L
