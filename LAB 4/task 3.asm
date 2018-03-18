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

Loop:				;loop 10 times
	mov rdi,in_fmt
	mov rsi,c
	call scanf		;scan a number
			
	mov rdx,0
	mov	rax,[c]
	mov	rbx,2	
	idiv	rbx
	mov rcx,0
	cmp rcx,rdx		;checks for odd
	jz notodd
	
	mov rax,[flag]		;check if first odd is already found
	cmp rax,1		;if(!found){update first odd}
	jz nf
	mov rax,1
	mov [flag],rax
	mov rax,[c]
	mov [fodd],rax
nf:
	mov rax,[c]		;update last odd
	mov [lodd],rax

notodd:
	mov rcx,[cnt]
	add rcx,1
	mov [cnt],rcx	
	cmp rcx,10
	jnz Loop
print:	
	mov rdi,out_fmt		;print first odd
	mov rsi,[fodd]
	mov rax,0
	call printf
	
	mov rdi,out_fmt		;print last odd
	mov rsi,[lodd]
	mov rax,0
	call printf
	
	pop	rbp		
	mov	rax,0		
	ret			
