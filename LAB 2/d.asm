extern	printf		
extern	scanf		

SECTION .data		

a:	dq	5
b:	dq	2	
c:	dq	0	
d:	dq	0

out_fmt:	db "ans= %ld", 10, 0
in_fmt:		db "%ld",0
SECTION .text

global main		
main:		
        push rbp
        
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, a
	call scanf
	
	
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, b
	call scanf
       	
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, c
	call scanf
       	
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, d
	call scanf
       	
       	mov rax,[b]
       	mov rbx,[c]
       	imul rbx
       	mov rbx,[d]
       	idiv rbx
       	mov rbx,[a]
       	add rax,rbx
       	mov [c],rax
       	
       	mov	rdi,out_fmt		
	mov	rsi,[c]         
	mov	rax,0		
        call    printf
       	
       	
	pop	rbp				
	ret			
	
