	.syntax unified
	.cpu cortex-m4
	.thumb

.data
	user_stack:	.zero 128
	expr_result:	.word   0
	postfix_expr:   .asciz    "-100 10 20 + - 10 +"

.text
	.global main
main:
	LDR	R0, =postfix_expr
	ldr r4, =user_stack
	adds r4, r4, #0x78
	
PostFixLoop:
	ldrb r1, [r0], #1
	movs r5, #0
	cmp r1, #0
	beq program_end
	cmp r1, #0x20
	beq PostFixLoop
	bl atoi
	cmp r5, #1
	beq ChangeToNegative
backPostFixLoop:
	push {r2}
	str r2, [r4]
	subs r4, r4, #4
	b PostFixLoop
	

//TODO: Setup stack pointer to end of user_stack and calculate the expression using PUSH, POP operators, and store the result into expr_result

program_end:
	ldr r1, [r4, #4]
	ldr r4, =expr_result
	pop {r1}
	str r1, [r4]
L:		B L

atoi:
	cmp r1, #0x2D				//0x2D => -
	beq HandleNegative
	cmp r1, #0x2B				//0x2B => +
	beq DoOperation
	
back:
	subs r1, r1, #48    		
	movs r2, r1
	movs r3, #10
	
ConvertIntegerLoop:
	ldrb r1, [r0], #1
	cmp r1, #0x20
	beq EndAtoi
	subs r1, r1, #48
	muls r2, r2, r3
	adds r2, r1
	b ConvertIntegerLoop

EndAtoi: 
    bx lr
	
HandleNegative:
	ldrb r1, [r0], #1
	movs r5, #1
	cmp r1, #0x20
	ble DoOperation
	b back
	
DoOperation:
	pop {r7, r6}
	adds r4, r4, #4
	ldr r6, [r4]
	adds r4, r4, #4
	ldr r7, [r4]
	cmp r5, #1
	beq DoSub
	adds r6, r6, r7
backDoOperation:
	push {r6}
	str r6, [r4]
	subs r4, r4, #4
    b PostFixLoop
	
DoSub:
	subs r6, r7, r6
	b backDoOperation

ChangeToNegative:
	neg r2, r2
	b backPostFixLoop
	

/*
r2 tmp integer
r3 10
r4 own stack pointer
r5 defaut 0, if set 1 => negative
r6 pop's data 1
r7 pop's data 2
*/