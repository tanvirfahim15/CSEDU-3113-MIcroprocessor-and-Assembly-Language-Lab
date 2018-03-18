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
out_fmt:	db "Largest number %ld was found at location %ld", 10, 0	
out_fmt2:	db "Smallest number %ld was found at location  %ld", 10, 0	
in_fmt:		db "%ld",0
SECTION .bss
arr: resq 21

SECTION .text

global main		
main:				
	push    rbp	
Loop:				;loop 5 times
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	mov rax,[c]		;scan a number
	
	mov rcx,[cnt]
	mov [arr+8*rcx],rax	;save to arr
		
	add rcx,1
	mov [cnt],rcx
	cmp rcx,5
	jnz Loop
	mov rax,0
	mov [cnt],rax
	
print:				;iterate through arr
	mov rcx,[cnt]
	mov rax,[arr+8*rcx]

	mov rbx,[lo]		;if(number< low){update low and lowi} 
	cmp rax,rbx
	jg skip		
	mov [lo],rax
	mov [loi],rcx
skip:
	mov rbx,[hi]		;if(number> hi){update hi and hii}
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

	mov rdi,out_fmt2	;print low and index
	mov rsi,[lo]
	mov rdx,[loi]
	mov rax,0
    	call printf

	mov rdi,out_fmt		;print high and index
	mov rsi,[hi]
	mov rdx,[hii]
	mov rax,0
	call printf
	
	pop	rbp		
	mov	rax,0		
	ret			
