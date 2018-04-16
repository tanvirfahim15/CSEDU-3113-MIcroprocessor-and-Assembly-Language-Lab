extern	printf		
extern	scanf		
extern gets

SECTION .data		
int_out_fmt: db "%ld",0
in_str_fmt:	 db "%s",0
out_char_fmt: db "%c",0

SECTION .bss
str: resb 100

SECTION .text

global main		
main:				
	push rbp
	mov rbp,rsp	
	
	call scan_str
	mov rsi,str
	call str_len
	dec rcx
	push rsi
	push 0
	push rcx
	mov rax,0
	mov al,[rsi]
	push rax
	push 0
	call comp
		
	leave
	ret
	



comp:
	push rbp
	mov rbp,rsp
	
	mov rsi,[rbp+48]
	mov rbx,[rbp+40]
	mov rcx,[rbp+32]
	mov rax,[rbp+24]
	mov rdx,[rbp+16]
	
	cmp rbx,rcx
	jle skip
	call print_char
	mov rax,rdx
	call print_int
	mov al,10
	call print_char
	
	jmp return
	skip:
	
	add rsi,rbx
	mov ah,[rsi]
	cmp ah,al
	jne else
	
	mov rax,0
	mov al,[rsi]
	mov rsi,[rbp+48]
	push rsi
	inc rbx
	push rbx
	push rcx
	push rax
	inc rdx
	push rdx
	call comp
	jmp return
	
	
	else:
	
	mov rsi,[rbp+48]
	mov rbx,[rbp+40]
	mov rcx,[rbp+32]
	mov rax,[rbp+24]
	mov rdx,[rbp+16]
	
	call print_char
	mov rax,rdx
	call print_int
	
	
	add rsi,rbx
	mov rax,0
	mov al,[rsi]
	
	mov rsi,[rbp+48]
	push rsi
	
	inc rbx
	push rbx
	push rcx
	push rax
	push 1
	call comp
	
	
	
	return:
	leave
	ret

	


;returns string pointed by rsi length on rcx	
str_len:
	push rax
	push rsi
	mov rcx,0
	lop_str_len:
		mov al,[rsi]
		cmp al,0
		je dne_str_len
		add rsi,1
		add rcx,1
		jmp lop_str_len
	dne_str_len:
	pop rsi
	pop rax
	ret
	
;scan string and put it on str
scan_str:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rax, 0
	mov rdi, in_str_fmt
	mov rsi, str
	call scanf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
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


	
;print rax(char) 	
print_char:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,out_char_fmt
	mov rsi,rax
	mov rax,0
    call printf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
	ret
