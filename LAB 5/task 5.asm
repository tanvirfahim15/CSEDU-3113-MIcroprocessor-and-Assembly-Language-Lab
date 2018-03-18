extern	printf		
extern	scanf		
SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",10,0
int: dq 0
out_str_fmt: db "%s",0
in_str_fmt:	 db "%s",0
st: db "*",0
sc: db " ",0
nw: db 10,0

SECTION .bss
str: resb 100
arr: resq 100

SECTION .text

global main		
main:				
	push rbp	
	
	
	call scan_int	;scan n
	dec rax
	mov rcx,rax
	
	lop:		;iterate n times
	cmp rcx,0
	jl dne
	
	je last_line	; for last line
	
	push rcx
	dec rcx
	lop2:		;prints n-i space on ith line,indexed by zero
	cmp rcx,0
	jl dne2
	call print_sc
	dec rcx
	jmp lop2
	dne2:
	pop rcx
	
	call print_st	;prints one star
	
	
	cmp rax,rcx	;for first line skip printing more spaces and star
	je dne3
	
	push rax
	push rcx
	sub rax,rcx	;find 2i+1 for ith line
	dec rax
	add rax,rax
	inc rax
	
	lop4:		;prints 2i+1 spaces
	cmp rax,0
	je dne4
	call print_sc
	dec rax
	jmp lop4
	dne4:
	
	call print_st	;print one star
	pop rcx
	pop rax
	
	dne3:
	
	
	call print_nw	;print new line
	dec rcx
	jmp lop
	dne:
	
	last_line:
	add rax,rax 	;find 2n +1
	inc rax
	mov rcx,rax
	lop5:		;prints 2n+1 stars
	call print_st 
	loop lop5
	
	call print_nw 	;prints new line
	mov rax,0
	pop rbp
	ret
	

print_st:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rsi,st
	call print_str
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret
print_sc:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rsi,sc
	call print_str
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

print_nw:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rsi,nw
	call print_str
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret
;print str(string) pointed by rsi	
print_str:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov	rdi,out_str_fmt		         
	mov	rax,0		
    call printf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx	
    ret		

;scans 64 bit int and puts it on rax
scan_int:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,int_in_fmt
	mov rsi,int
	mov rax,0
    call scanf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
    mov rax,[int]
	ret
	
;print rax(64 bit int) 	
print_int:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,int_out_fmt
	mov rsi,rax
	mov rax,0
    call printf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
	ret
