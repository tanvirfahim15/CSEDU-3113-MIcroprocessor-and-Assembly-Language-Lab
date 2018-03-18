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

Loop:				;loop 5 times
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	mov rax,[c]		;scan a number
	
	mov rcx,[cnt]
	mov [arr+8*rcx],rax	;save to arr
	
	add rcx,1
	mov [cnt],rcx
	cmp rcx,5
	jnz Loop
	
	
	mov rax,[cnt]
	sub rax,1
	mov [last],rax
				;insertion sort
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

	mov rdi,out_fmt
	mov rsi,[arr+8*2]
	mov rax,0
    	call printf		;print 3rd element in the sorted arr

	pop	rbp		

	mov	rax,0		
	ret			
