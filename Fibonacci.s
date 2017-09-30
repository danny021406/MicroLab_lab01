 .syntax unified
 .cpu cortex-m4
 .thumb 
 
.text     
	.global main 
	.equ N, 10

fib:     
	cmp r0, r1
	ble end
	adds r4, r2, r3
	movs r2, r4
	adds r1, r1, #1 
	cmp r0, r1
	ble end
	adds r4, r2, r3
	movs r3, r4
	adds r1, r1, #1 
	b fib
	
end:
	cmp r0, #0
	ble endOverflow
	bx lr 
	
endOverflow:
	//put -2 if overrange
	movs r4, #0
	subs r4, #2
	bx lr 
	
main:     
	movs r0, #N     
	movs r1, #0
	movs r2, #1
	movs r3, #1
	movs r4, #0
	//put -1 if overrange
	subs r4, #1
	movs r5,  #100
	cmp r5, r0
	ble L
	cmp r0, #1
	ble L
	bl fib 
L: b L