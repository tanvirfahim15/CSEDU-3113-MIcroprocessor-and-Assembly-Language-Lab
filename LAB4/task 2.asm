extern	printf		
extern	scanf		

SECTION .data		

cnt:	dq	0	
c:	dq	0
out_fmt:	db "%ld", 10, 0	
in_fmt:		db "%ld",0
SECTION .bss
arr: resq 21

SECTION .text

global main		
main:				
    push    rbp	
	
Loop:
	mov rdi,in_fmt		;scan 10 numbers
	mov rsi,c
	call scanf
	mov rax,[c]
	
	mov rcx,[cnt]
	mov [arr+8*rcx],rax
	
	
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,11
	jnz Loop
	
	mov rax,0
	mov [cnt],rax

print:
	mov rsi,c
	call scanf		;scan position
	mov rax,[c]
	
	mov rcx,[arr+8*rax]
	
	mov rdi,out_fmt		;print arr[position]
	mov rsi,rcx
	mov rax,0
	call printf

	
	pop	rbp		

	mov	rax,0		
	ret			
