extern	printf		
extern	scanf		

SECTION .data		

a:	dq	5
b:	dq	2	
c:	dq	0

enter:	db "Enter two numbers: ",0
out_fmt:	db "max=%ld", 10, 0	
out_fmt_2:	db "%s",10,0
in_fmt:		db "%d",0
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
	
	
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, b
	call scanf	
	
	mov rax,[a]
	mov rbx,[b]
	cmp rax,rbx
	jge great
	jmp less
great:
	mov [c],rax

	jmp next
less:
	mov [c],rbx
next:
	
		
	mov	rdi,out_fmt		
	mov	rsi,[c]         
	mov	rax,0		
        call    printf		

	pop	rbp		

	mov	rax,0		
	ret			
	