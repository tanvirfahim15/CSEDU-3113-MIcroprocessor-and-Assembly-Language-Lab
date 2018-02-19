extern	printf		
extern	scanf		

SECTION .data		

cnt:	dq	0	
c:	dq	0
fodd: dq 0
lodd: dq 0
flag: dq 0
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
	
	
	mov rax,0
	mov rbx,0
	mov rcx,0
	mov rdx,0
	mov	rax,[c]
	mov	rbx,2	
	idiv	rbx
	
	mov rcx,0
	cmp rcx,rdx
	
	jz notodd
	
	
	mov rax,[flag]
	cmp rax,1
	jz nf
	
	mov rax,1
	mov [flag],rax
	mov rax,[c]
	mov [fodd],rax
	
	
nf:
	
	mov rax,[c]
	mov [lodd],rax

notodd:
	
	mov rcx,[cnt]
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,11
	jnz Loop
	

print:
	
	
	
	mov rdi,out_fmt
	mov rsi,[fodd]
	mov rax,0
	call printf
	
	mov rdi,out_fmt
	mov rsi,[lodd]
	mov rax,0
	call printf

	
	pop	rbp		

	mov	rax,0		
	ret			
