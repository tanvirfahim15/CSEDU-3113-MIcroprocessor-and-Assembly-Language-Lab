extern	printf		
extern	scanf		

SECTION .data		

a:	dq	5
b:	dq	2	
c:	dq	0

enter:	db "Enter number: ",0
out_fmt:	db "%ld", 10, 0	
out_fmt_2:	db "%s",10,0
evenout:	db "even",0
oddout:	db "odd",0
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
	
	mov rcx,[c]
		
	mov rax,0
	mov rbx,0
	
loop:	add rax,1
	add rbx,rax
	sub rcx,1
	cmp rcx,0
	jz end
	jmp loop

end:
	mov rsi,rbx
	mov rdi,out_fmt
	mov rax,0
	call printf
        
        
	pop	rbp		

	mov	rax,0		
	ret			
	
