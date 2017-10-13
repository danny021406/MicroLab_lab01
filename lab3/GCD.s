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
	push {r1}
	push {r2}
	bl GCD
	
GCD:
    //TODO: Implement your GCD function
	pop {r2}
	pop {r1}
	bl Gofunction
	b GCD
	

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
	
	bl function4
	push {r9}
	push {r10}
	b GCD
	

	
ReturnHandleReturnA:
	movs r8, r1
	b GCDEnd
	
ReturnHandleReturnB:
	movs r8, r2
	b GCDEnd

function1:
	lsrs r1, r1, #1
	lsrs r2, r2, #1
	push {r1}
	push {r2}
	bx lr
	
function2:
	lsrs r1, r1, #1
	push {r1}
	push {r2}
	bx lr
	
function3:
	lsrs r2, r2, #1
	push {r1}
	push {r2}
	bx lr
	
function4:
	push {lr}
	bl Abs
	pop {pc}
	
	
Abs:
	push {lr}
	subs r9, r1, r2
	cmp r9, #0
	ble negHandle
	movs r10, r2
	pop {pc}
	
negHandle:
	neg r9, r9
	movs r10, r1
	pop {pc}
	

	
GCDEnd:
	adds r10, r10, r11
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
*/