	.syntax unified
	.cpu cortex-m4
	.thumb
.data
	result: .word  0
	max_size:  .word  0
	m: .word  0x5E
	n: .word  0x60
.text
	.global main

main:
	ldr r0, =m
	ldr r1, [r0]
	ldr r0, =n
	ldr r2, [r0]
	movs r3, #1
	movs r0, #2
	movs r12, #4
	
	push {r3}
	push {r1}
	push {r2}
	bl GCDS
	b GCDEnd
GCDS:
	pop {r2}
	pop {r1}
	push {lr}
	adds r12, r12, #8
	b GCDT
GCD:
    //TODO: Implement your GCD function
	pop {r2}
	pop {r1}
GCDT:
	bl Gofunction
	pop {r11}
	mul r8, r11, r8
	pop {pc}
	

Gofunction:
	cmp r1, #0
	beq ReturnHandleReturnB
	cmp r2, #0
	beq ReturnHandleReturnA
	ands r4, r1, r3
	ands r5, r2, r3
	adds r6, r4, r5
	cmp r6, #0
	beq function1
	
	subs r7, r6, r5
	cmp r7, #0
	beq function2
	
	subs r7, r6, r4
	cmp r7, #0
	beq function3
	
	push {r3}
	push {lr}
	adds r12, r12, #8
	bl function4
	push {r9}
	push {r10}
	b GCD
	

	
ReturnHandleReturnA:
	ldr r8, =max_size
	str r12, [r8]
	movs r8, r1
	pop {pc}
	
ReturnHandleReturnB:
	ldr r8, =max_size
	str r12, [r8]
	movs r8, r2
	pop {pc}

function1:
	lsrs r1, r1, #1
	lsrs r2, r2, #1
	push {r0}
	push {lr}
	adds r12, r12, #8
	push {r1}
	push {r2}
	b GCD
	
function2:
	lsrs r1, r1, #1
	push {r3}
	push {lr}
	adds r12, r12, #8
	push {r1}
	push {r2}
	b GCD
	
function3:
	lsrs r2, r2, #1
	push {r3}
	push {lr}
	adds r12, r12, #8
	push {r1}
	push {r2}
	b GCD
	
function4:
	subs r9, r1, r2
	cmp r9, #0
	ble negHandle
	movs r10, r2
	bx lr
	
negHandle:
	neg r9, r9
	movs r10, r1
	bx lr
	
GCDEnd:
	ldr r12, =result
	str r8, [r12]
	b GCDEnd

	
	
	
/*	
	int Gcd(int a, int b)
{
    if(a == 0) return b;
    if(b == 0) return a;
1=>    if(a % 2 == 0 && b % 2 == 0) return 2 * gcd(a >> 1, b >> 1);
2=>    else if(a % 2 == 0)  return gcd(a >> 1, b);
3=>    else if(b % 2 == 0) return gcd(a, b >> 1);
4=>    else return gcd(abs(a - b), Min(a, b));
}
r0 = 2
r1 = a
r2 = b
r3 = 1
r4 = flag a
r5 = flag b
r6 = flag a + b
r7 = other function flag
r8 = answer
r9 = calculate abs mins a
r10 = calculate abs mins b
r12 stack max size
*/