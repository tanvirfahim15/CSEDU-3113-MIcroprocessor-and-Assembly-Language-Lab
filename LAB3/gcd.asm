extern	printf		
extern	scanf		

SECTION .data		

a:	dq	0
b:	dq	1	
c:	dq	0

enter:	db "Enter number: ",0
out_fmt:	db "gcd = %ld", 10, 0	
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
	mov rsi,a
	call scanf
	
	mov rdi,in_fmt
	mov rsi,b
	call scanf
	
	
	mov rax,[a]
	mov rbx,[b]
	
loop:	mov rcx,0
	mov rdx,0	
	idiv rbx
	cmp rdx,0
	jz end
	mov rax,rbx
	mov rbx,rdx
	jmp loop
end:
	mov rdi,out_fmt
	mov rsi,rbx
	call printf
	
	pop	rbp		

	mov	rax,0		
	ret			
	
