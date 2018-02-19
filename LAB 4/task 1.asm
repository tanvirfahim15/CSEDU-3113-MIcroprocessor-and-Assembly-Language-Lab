extern	printf		
extern	scanf		

SECTION .data		

cnt:	dq	0	
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
	
	
	mov rcx,3
Loop:
	
	
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	mov rax,[c]
	
	add [sum],rax
	
	mov rcx,[cnt]
	mov [arr+8*rcx],rax
	
	
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,20
	jnz Loop
	
	mov rax,0
	mov [cnt],rax
	
	mov rdi,out_fmt
	mov rsi,[sum]
	
	mov rax,0
    call printf

print:
	mov rcx,[cnt]
	mov rcx,[arr+8*rcx]
	
	mov rdi,out_fmt
	mov rsi,rcx
	
	mov rax,0
    call printf
	
	mov rcx,[cnt]
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,20
	jnz print

	
	pop	rbp		

	mov	rax,0		
	ret			
