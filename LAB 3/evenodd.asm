extern	printf		
extern	scanf		

SECTION .data		

a:	dq	5
b:	dq	2	
c:	dq	0

enter:	db "Enter number: ",0
out_fmt:	db "quotient= %ld  remainder=%ld", 10, 0	
out_fmt_2:	db "%s",10,0
evenout:	db "even",0
oddout:	db "odd",0
in_fmt:		db "%ld",0
SECTION .text

global main		
main:				
        push    rbp	
        mov rax,0
        mov rdi,out_fmt_2
        mov rsi,enter
        call printf
        
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, a
	call scanf
	
	
        
       	
	mov rax,0
	mov rbx,0
	mov rcx,0
	mov rdx,0
	mov	rax,[a]
	mov	rbx,[b]	
	idiv	rbx
	
	mov rcx,1
	cmp rcx,rdx
	
	jz odd

even:
        mov rax,0
        mov rdi,out_fmt_2
        mov rsi,evenout
        call printf
        jmp end		
odd:

        mov rax,0
        mov rdi,out_fmt_2
        mov rsi,oddout
        call printf
end:
	pop	rbp		

	mov	rax,0		
	ret			
	
