extern	printf		
extern	scanf		

SECTION .data		
	
out_fmt:	db "%s",10,0
in_fmt:		db "%s",0
SECTION .bss
str:	resb 20
SECTION .text

global main		
main:		
        push rbp
        mov rax, 0
	mov rdi, in_fmt
	mov rsi, str
	call scanf
	
		
	mov	rdi,out_fmt		
	mov	rsi,str         
	mov	rax,0		
        call    printf		

	pop	rbp			
	ret			
	
