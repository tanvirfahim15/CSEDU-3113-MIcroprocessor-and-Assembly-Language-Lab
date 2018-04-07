extern	printf		
extern	scanf		
extern gets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nasm -f elf64 hello.asm &&  gcc -o hello  hello.o && ./hello
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",0
int: dq 0
char: db 0
out_str_fmt: db "%s",10,0
in_str_fmt:	 db "%s",0
out_char_fmt: db "%c",10,0
in_char_fmt:	 db "%c",0
strs: db 0
;;;;;;;;;;;;;;;;;;;; data segment starts here;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION .bss
str: resb 100
arr: resq 100
;;;;;;;;;;;;;;;;;;;; section starts bss here;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION .text

global main		
main:				
	push rbp
	mov rbp,rsp	
;;;;;;;;;;;;;;;;;;;;;;;;;main code goes here;;;;;;;;;;;;;;;;;;;;;
	call scan_int
	push rax
	call binary
	mov rsi, strs
	call print_str
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	leave
	ret
	

;;;;;;;;;;;;;;;;;;;;;;;;define functions here;;;;;;;;;;;;;;;;;;;

binary:
	push rbp
	mov rbp,rsp
	
	mov rax,[rbp+16]
	cmp rax,0
	je return
	
	mov rdx,0
	mov rbx,2
	div rbx
	push rdx
	push rax
	call binary
	pop rax
	pop rax
	call print_int
	
	
	return:
	leave
	ret
	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;scan string and put it on rdi
get_s:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	call gets
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax

;put 1 on rax if rax even, 0 otherwise
even_check:
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rbx,2
	mov rdx,0
	idiv rbx
	cmp rdx,0
	je evn_even_check
	mov rax,0
	jmp end_even_check
	evn_even_check:
	mov rax,1
	end_even_check:
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
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


;put rax on first rcx elements of arr pointed by rdi
clear_arr:
	push rdi
	push rcx
	push rax
	lop_clear_arr:
		cmp rcx,0
		je dne_clear_arr
		
		mov [rdi],rax
		add rdi,8
		
		sub rcx,1
		jmp lop_clear_arr
		
	dne_clear_arr:
	pop rax
	pop rcx
	pop rdi
	ret

;find rax in first rcx elements of arr pointed by rsi
;puts 1 on rax if found, 0 otherwise
find_arr:
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rbx,0
	lop_find_arr:
	cmp rcx,0
	jz dne_find_arr
	mov rdx,[rsi]
	add rsi,8
	cmp rdx,rax
	jne nf_find_arr
	mov rbx,1
	nf_find_arr:
	dec rcx
	jmp lop_find_arr
	dne_find_arr:
	mov rax,rbx
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	ret


;dependency:sort_arr_dec,reverse_arr
;sort first rcx elements of arr pointed by rsi
;small to large
sort_arr:
	call sort_arr_dec
	call reverse_arr
	ret

;dependency:get_arr_i,swap_arr
;sort first rcx elements of arr pointed by rsi
;large to small
sort_arr_dec:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	mov rax,1
	outer_sort_lop:
		cmp rcx,rax
		je outer_sort_dne
		push rcx
		mov rcx,rax
		push rax
		push rbx
		push rcx
		push rdx
		push rsi
		push rdi
		inner_sort:
			cmp rcx,0
			je inner_sort_dne
			call get_arr_i
			mov rbx,rax
			sub rcx,1
			call get_arr_i
			mov rdx,rcx
			add rcx,1
			cmp rax,rbx
			jge inner_sort_not_swap
			call swap_arr
			inner_sort_not_swap:
		
			sub rcx,1
			jmp inner_sort
		inner_sort_dne:
		pop rdi
		pop rsi
		pop rdx
		pop rcx
		pop rbx
		pop rax
		pop rcx
		inc rax
		jmp outer_sort_lop
	outer_sort_dne:
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret	

;dependency:swap_arr
;reverse first rcx element of arr pointed by rsi
reverse_arr:
	push rax
	push rbx
	push rcx
	push rdx
	push rsi
	push rdi
	dec rcx
	mov rdx,0
	arr_rev_lop:
	cmp rcx,rdx
	jl arr_rev_done
	call swap_arr
	inc rdx
	dec rcx
	jmp arr_rev_lop
	arr_rev_done:
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret
	
;dependency:get_arr_i,put_arr_i
;swap rsi[rcx],rsi[rdx]
swap_arr:
	push rbx
	push rax
	push r9
	push rcx
	push rdx
	push rsi
	push rdi
	call get_arr_i
	mov rbx,rax
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	call get_arr_i
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	call put_arr_i
	mov rax,rbx
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	call put_arr_i
	pop rdi
	pop rsi
	pop rdx
	pop rcx
	pop r9
	pop rax
	pop rbx
	ret	

;dependency:get_arr_i,put_arr_i
;swap rsi[rcx],rdi[rdx]
swap_arrd:
	push rbx
	push rax
	push r9
	push r8
	push rcx
	push rdx
	call get_arr_i
	mov rbx,rax
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	mov r8,rsi
	mov rsi,rdi
	call get_arr_i
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	call put_arr_i
	mov rsi,r8
	mov rax,rbx
	mov r9,rcx
	mov rcx,rdx
	mov rdx,r9
	call put_arr_i
	pop rdx
	pop rcx
	pop r8
	pop r9
	pop rax
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
	
;get rsi[rcx] to rax
get_arr_i:
	push rbx
	push rdx
	push rcx
	push rsi
	push rdi
	mov rax,8
	imul rcx
	add rsi,rax
	mov rax,[rsi]
	pop rdi
	pop rsi
	pop rcx
	pop rdx
	pop rbx
	ret
;copy rcx elements(64bit) from arr pointed by rsi to rdi
copy_arr:
	push rcx
	push rsi
	push rdi
	push rax
	lop_arr_copy:
		cmp rcx,0
		je dne_arr_copy
		mov rax,[rsi]
		mov [rdi],rax
		add rsi,8
		add rdi,8
		sub rcx,1
		jmp lop_arr_copy
	dne_arr_copy:
	pop rax
	pop rdi
	pop rsi
	pop rcx
	ret
	
;dependency:print_int
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

;dependency:scan_int
;scans rcx 64 bit integers into arr pointed by rdi
;puts array size on rax
;enter number of elements and then elements
scan_arr:
	push rdi
	push rcx
	push rax
	lop_scan_arr:
		cmp rcx,0
		je dne_scan_arr
		
		call scan_int
		mov [rdi],rax
		add rdi,8
		
		sub rcx,1
		jmp lop_scan_arr
		
	dne_scan_arr:
	pop rax
	pop rcx
	pop rdi
	ret

;dependency:str_len
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

;dependency:str_len
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

;scans char and puts it on al
scan_char:
	push rdx
	push rcx
	push rax
	push rdi
	push rsi
	mov rdi,in_char_fmt
	mov rsi,char
	mov rax,0
    call scanf
    pop rsi
    pop rdi
    pop rax
    pop rcx
    pop rdx
    mov rax,0
    mov al,[char]
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
