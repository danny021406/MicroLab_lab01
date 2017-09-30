 .syntax unified
 .cpu cortex-m4
 .thumb 
 

.data
	arr1: .byte 0x19, 0x34, 0x14, 0x32, 0x52, 0x23, 0x61, 0x29
	arr2: .byte 0x18, 0x17, 0x33, 0x16, 0xFA, 0x20, 0x55, 0xAC 
	size:	.word	8

.text     
	.global main 
	.equ len, 8
	.equ oneElement, 1
	
	
do_sort:    
	movs r2, #0
	subs r2, r2, #1
	movs r7, #len
	
	
outLoop:	
	adds r2, r2, #1
	cmp r2, r7
	beq end
	movs r3, #0
	subs r3, r3, #1
	movs r8, r0
	subs r8, #1
	subs r6, r7, r2
	
innerLoop:
	adds r3, r3, #1
	adds r8, r8, #1
	
	cmp r3, r6
	beq outLoop
	
	ldrb r4, [r8]
	ldrb r5, [r8, #1]
	
	cmp r4, r5
	ble innerLoop
	
	strb r5, [r8]
	strb r4, [r8, #1]
	
	bl innerLoop

end:
	bx lr 
main:
	ldr r0, =arr1     
	bl do_sort     
	ldr r0, =arr2     
	bl do_sort 

L: b L 

/*

int bubbleSort(int a[], int len)
{
	int i, j, temp;
	for (i = 0; i < len - 1; i++)
		for (j = 0; j < len - 1 - i; j++)
			if (a[j] > a[j + 1]) 
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
	return *a;
}
r0 = start address of array
r1 = length of array
r2 = i
r3 = j
r4 = j's tmp data
r5 = j+1's tmp data
r6 = j's end judge
r7 = length
r8 = array tmp address
*/