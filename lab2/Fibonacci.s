 .syntax unified
 .cpu cortex-m4
 .thumb 
 
.text     
	.global main 
	.equ N, 20

fib:     
	cmp r0, r1
	ble end  // less than equal than
	adds r4, r2, r3
	cmp r4, #0           // > 0x7FFFFFFF=>2147483647
	ble endOverflow
	movs r2, r4
	adds r1, r1, #1 
	cmp r0, r1
	ble end
	adds r4, r2, r3
	cmp r4, #0           // > 0x7FFFFFFF=>2147483647
	ble endOverflow
	movs r3, r4
	adds r1, r1, #1 
	b fib
	
end:
	bx lr 
	
endOverflow:
	//put -2 if overrange
	movs r4, #0
	subs r4, #2
	bx lr 
	
main:     
	movs r0, #N     
	movs r1, #3
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
