extern	printf		
extern	scanf		

SECTION .data		
lo: dq 99999
hi: dq 0
loi: dq 0
hii: dq 0
cnt:	dq	0	
c:	dq	0
sum:	dq	0
out_fmt:	db "%ld", 10, 0	
in_fmt:		db "%ld",0
SECTION .bss
arr: resq 21

SECTION .text

global main		
main:				
    push    rbp	
	
	
	mov rcx,3
Loop:
	
	
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	mov rax,[c]
	
	mov rcx,[cnt]
	mov [arr+8*rcx],rax
	
	
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,5
	jnz Loop
	
	mov rax,0
	mov [cnt],rax
	

print:
	mov rcx,[cnt]
	mov rax,[arr+8*rcx]
	
	mov rbx,[lo]
	cmp rax,rbx
	jg skip	
	
	mov [lo],rax
	mov [loi],rcx
skip:

	mov rbx,[hi]
	cmp rbx,rax
	jg skip2
	
	
	mov [hi],rax
	mov [hii],rcx
skip2:	

	
	mov rcx,[cnt]
	add rcx,1
	mov [cnt],rcx
	
	cmp rcx,5
	jnz print

	mov rdi,out_fmt
	mov rsi,[lo]
	mov rax,0
    call printf

	mov rdi,out_fmt
	mov rsi,[loi]
	mov rax,0
    call printf
	

	mov rdi,out_fmt
	mov rsi,[hi]
	mov rax,0
    call printf

	mov rdi,out_fmt
	mov rsi,[hii]
	mov rax,0
    call printf
	
	pop	rbp		

	mov	rax,0		
	ret			
