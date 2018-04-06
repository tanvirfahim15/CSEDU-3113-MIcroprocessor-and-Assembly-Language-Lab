extern	printf		
extern	scanf		

SECTION .data		

a:	dq	0
b:	dq	0	
c:	dq	0

enter:	db "Enter number: ",0
out_fmt:	db "gcd = %ld", 10, 0	
out_fmt_2:	db "%s",10,0
palout:	db "palindrome",0
notpalout:	db "not palindrome",0
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
	
	mov rax,[a]
	mov rbx,10
loop:
	mov rcx,0
	mov rdx,0
	idiv rbx
	mov rcx,[b]
	imul rcx,10
	add rcx,rdx
	mov [b],rcx
	cmp rax,0
	jz end
	jmp loop
end:	mov rax,[a]
	mov rbx,[b]
	cmp rax,rbx
	
	mov rdi,out_fmt_2
	jz pal
	jmp npal
pal:	mov rsi,palout
	jmp endd

npal:	mov rsi,notpalout

endd:	call printf
	
	
	pop	rbp		

	mov	rax,0		
	ret			
	
