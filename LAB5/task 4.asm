extern	printf		
extern	scanf		

SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",10,0
int: dq 0
out_str_fmt: db "%s",10,0
in_str_fmt:	 db "%s",0
o1: db "equal",0
o2: db "Not equal",0

SECTION .bss
str: resb 100
arr: resq 100
s1: resb 100
s2: resb 100


SECTION .text

global main		
main:				
	push rbp	
	
	call scan_str
	mov rsi,str
	mov rdi, s1	
	call str_copy	;scan s1
	call scan_str
	mov rsi,str
	mov rdi, s2
	call str_copy	;scan s2
	
	mov rsi, s1
	mov rdi, s2
	call str_cmp	;check for equal
	
	cmp rax,0
	je ne
	mov rsi,o1	;if(equal){print "Equal"}
	jmp en
	ne:
	mov rsi,o2	;if(!equal){print "Not equal"}
	en:
	call print_str
	
		
	mov rax,0
	pop rbp
	ret
	

;compares two strings on rsi and rdi
;puts 1 on rax if equal,0 otherwise
str_cmp:
	push rcx
	push rsi
	push rdi
	push rdx
	push rbx
	mov rdx,1
	call str_len
	lop_str_cmp:
		cmp rcx,0
		jl dne_str_cmp
		mov al,[rsi]
		mov bl,[rdi]
		cmp al,bl
		je nxt_str_cmp
		mov rdx,0
		jmp dne_str_cmp 
		nxt_str_cmp:
		add rsi,1
		add rdi,1
		sub rcx,1
		jmp lop_str_cmp
	
	dne_str_cmp:
	mov rax,rdx
	pop rbx
	pop rdx
	pop rdi
	pop rsi
	pop rcx
	ret


;copy string pointed by rsi to rdi
str_copy:
	push rcx
	push rsi
	push rdi
	push rax
	call str_len
	lop_str_copy:
		cmp rcx,0
		jl dne_str_copy
		mov al,[rsi]
		mov [rdi],al
		add rsi,1
		add rdi,1
		sub rcx,1
		jmp lop_str_copy
	
	dne_str_copy:
	pop rax
	pop rdi
	pop rsi
	pop rcx
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
