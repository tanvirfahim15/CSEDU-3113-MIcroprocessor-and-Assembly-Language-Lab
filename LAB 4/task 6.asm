extern	printf		
extern	scanf		

SECTION .data		

icnt:	dq	0	
cnt:	dq	0
last: dq 0	
c:	dq	0
sum:	dq	0
out_fmt:	db "%ld", 10, 0	
in_fmt:		db "%ld",0
SECTION .bss
arr: resq 21

SECTION .text

global main		
main:				
	push    rbp	
	
Loop:				;scans 5 numbers and puts it on arr
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	mov rax,[c]
	mov rcx,[cnt]
	mov [arr+8*rcx],rax	
	add rcx,1
	mov [cnt],rcx
	cmp rcx,5
	jnz Loop
	
	mov rax,[cnt]		;insertion sort
	sub rax,1
	mov [last],rax
check:				;outer loop
	mov rcx,[last]
	mov [icnt],rcx
inner:				;inner loop
	mov rcx,[icnt]
	mov rax,[arr+8*rcx]
	sub rcx,1
	mov rbx,[arr+8*rcx]
	cmp rax,rbx
	jge nswap
	
	mov rcx,[icnt]		;swap
	mov [arr+8*rcx],rbx
	sub rcx,1
	mov [arr+8*rcx],rax
nswap:
	mov rcx,[icnt]
	sub rcx,1
	mov [icnt],rcx
	cmp rcx,0
	jnz inner
	mov rcx,[cnt]
	sub rcx,1
	mov [cnt],rcx
	cmp rcx,0
	jnz check
	mov rax,0
	mov [cnt],rax
	
print:				;print the sorted arr
	mov rcx,[cnt]
	mov rcx,[arr+8*rcx]
	mov rdi,out_fmt
	mov rsi,rcx
	mov rax,0
	call printf
	mov rcx,[cnt]
	add rcx,1
	mov [cnt],rcx
	cmp rcx,5
	jnz print

	pop	rbp		
	mov	rax,0		
	ret			
