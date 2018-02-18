extern	printf		
SECTION .data		

a:	dq	5
b:	dq	2	
c:	dq	0
fmt:    db "%ld %ld", 10, 0	
table:	db 2h , 3h ,4h
SECTION .text

global main		
main:				
        push    rbp	
        
        mov	rax,2h
        mov	rbx,3h
        
        
        xchg	rax,rbx
        
        
        mov	rsi,rax
        mov	rdx,rbx
                 
        mov	rdi,fmt
	mov	rax,0		
        call    printf
       		

	pop	rbp		

	mov	rax,0		
	ret			
	
