extern	printf		
extern	scanf		

SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",10,0
int: dq 0
out_str_fmt: db "%s",10,0
in_str_fmt:	 db "%s",0
n1: dq 0
n2: dq 0
ev: dq 0
od: dq 0
s1: db "output",0
s2: db "difference",0

SECTION .bss
str: resb 100
arr: resq 100
ar: resq 100

SECTION .text

global main		
main:				
	push rbp	
	
	call scan_int		;scan n1
	inc rax
	mov [n1],rax	
	
	call scan_int		;scan n2
	dec rax
	mov [n2],rax	

	mov rax,[n1]
	mov rbx,[n2]
	mov rcx,0
	
	lop:			;iterate between n1 and n2
	cmp rax,rbx
	jg dne
	
	push rax
	call prime_check	;checks if prime	
	mov r9,rax
	pop rax
	cmp r9,0
	je np			;jump to np for not prime
	
	mov rdi,ar		;append to ar if prime
	call put_arr_i
	push rax
	push rbx
	push rcx
	push rdx
	push rax
	mov rax,rcx
	mov rbx,2
	mov rdx,0
	idiv rbx
	pop rax
	cmp rdx,0		;checks even or odd position
	je evn
	add [od],rax		;add to od if odd position
	jmp end
	evn:
	add [ev],rax		;add to ev if even position
	end:
	pop rdx
	pop rcx
	pop rbx
	pop rax
	inc rcx			;increament prime count
	
	np:
	inc rax
	jmp lop
	dne:
	
	mov rsi,s1
	call print_str
	mov rsi,ar
	call print_arr		;prints ar
	
	mov rsi,s2
	call print_str
	mov rax,[ev]
	mov rbx,[od]
	sub rax,rbx
	call abs_rax		;find abs(ev - od)
	call print_int		;print difference
		
	mov rax,0
	pop rbp
	ret
	
; puts abs(rax) on rax
abs_rax:
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	cmp rax,0
	jge abs_dne
	neg rax
	abs_dne:
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	ret

;puts 1 on rax if rax is prime, 0 otherwise
prime_check:
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rbx,1
	mov rcx ,rax
	dec rcx
	lop_prime_check:
	cmp rcx,1
	jle dne_prime_check
	push rax
	push rdx
	mov rdx,0
	idiv rcx
	cmp rdx,0
	jne nxt_prime_check
	mov rbx,0
	jmp nxt_prime_check
	nxt_prime_check:
	pop rdx
	pop rax
	dec rcx
	jmp lop_prime_check
	dne_prime_check:
	mov rax,rbx
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	ret

;put rax to rsi[rcx]
put_arr_i:
	push rdx
	push rax
	push rcx
	push rbx
	push rdi
	push rsi
	mov rbx,rax
	mov rax,8
	imul rcx
	add rdi,rax
	mov [rdi],rbx
	pop rsi
	pop rdi
	pop rbx
	pop rcx
	pop rax
	pop rdx
	ret
;print rcx elements(64 bit int) pointed by rsi
print_arr:
	push rsi
	push rcx
	push rax
	lop_print_arr:
		cmp rcx,0
		je dne_print_arr
		
		mov rax,[rsi]
		call print_int
		add rsi,8
		sub rcx,1
		jmp lop_print_arr
		
	dne_print_arr:	
	pop rax
	pop rcx
	pop rsi
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
