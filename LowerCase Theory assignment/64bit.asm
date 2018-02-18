extern	printf		
extern	scanf		

SECTION .data		

a:	db	0

enter:	db "Enter an upper case character: ",0	
prompt:	db "%s",10,0
in_fmt:		db "%c",0
out_fmt:	db "%c",10,0
SECTION .text

global main		
main:				
        push    rbp	
        
        mov rax,0
        mov rdi,prompt
        mov rsi,enter
        call printf
        
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, a
	call scanf
	
	mov al,[a]
	add al,32
	mov [a],al
	
			
	mov	rdi,out_fmt		
	mov	rsi,[a]         
	mov	rax,0		
        call    printf		

	pop	rbp		

	mov	rax,0		
	ret			
	
