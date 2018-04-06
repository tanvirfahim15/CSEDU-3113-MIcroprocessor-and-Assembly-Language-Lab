extern printf
SECTION .data
fmt:	db	"%d %d %d %d %d",10,0

SECTION .code
global main
main:
	push rbp
	
	mov rsi,2
	mov rdx,3
	mov rcx,4
	mov r8,5
	mov r9,6
	mov rdi,fmt
	mov rax,0
	call printf
	
	pop rbp
	ret
	
