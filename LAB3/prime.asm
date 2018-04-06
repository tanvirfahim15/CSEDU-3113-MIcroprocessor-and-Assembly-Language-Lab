extern	printf		
extern	scanf		

SECTION .data		

a:	dq	0
b:	dq	1	
c:	dq	0

enter:	db "Enter number: ",0
out_fmt:	db "%ld", 10, 0	
out_fmt_2:	db "%s",10,0
primeout:	db "prime",0
notprimeout:	db "not prime",0
in_fmt:		db "%ld",0
SECTION .text

global main		
main:				
        push    rbp	
	mov rax,0
	mov rbx,0
	
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	
	
	mov rbx,[c]
	sub rbx,1
	
	mov rax,[c]
	cmp rax,2
	jz prime
	cmp rax,1
	jz prime
	
loop:	mov rcx,0
	mov rdx,0
	push rax	
	idiv rbx
	pop rax
	cmp rdx,0
	jz notprime
	sub rbx,1
	cmp rbx,1
	jz prime
	jmp loop
	
prime:
	mov rsi,primeout
	jmp end

notprime:
	mov rsi,notprimeout

end:
	
	mov rdi,out_fmt_2
	mov rax,0
	call printf
        
        
	pop	rbp		

	mov	rax,0		
	ret			
	
