extern	printf		
extern	scanf		
SECTION .data		
int_in_fmt: db "%ld",0
int_out_fmt: db "%ld",10,0
int: dq 0
out_str_fmt: db "%s",10,0
in_str_fmt:	 db "%s",0
ofmt: db "Number already exists. Give %ld more numbers.",10,0
ofmt2: db "Give %ld more numbers.",10,0

SECTION .bss
str: resb 100
arr: resq 100
ar: resq 100


SECTION .text

global main		
main:				
	push rbp	
	
	mov rcx,10
	mov rdi,ar
	mov rsi,ar
	mov rax,0FFFFFFFFh
	call clear_arr		;clears ar
	
	lop:			;while(rcx!=0) {...}
	cmp rcx,0
	je dne
		
	call scan_int		;scan an int
	mov rbx,rax
	push rcx
	mov rcx,10
	call find_arr		;find in ar
	pop rcx
	cmp rax,0
	jne dup
	mov rax,rbx		;if(!duplicate){print proper msg; rcx--;}
	dec rcx
	call put_arr_i		;append to ar
		push rax
		push rbx
		push rcx
		push rdx
		push rdi
		push rsi
		mov rsi,rcx
		mov rdi,ofmt2		         
		mov rax,0		
	        call printf
	        pop rsi
	        pop rdi
	        pop rdx
	        pop rcx
	        pop rbx
	        pop rax
	inc rcx	
	dec rcx
	jmp en
	dup:			;if(duplicate){print proper msg}
		push rax
		push rbx
		push rcx
		push rdx
		push rdi
		push rsi
		mov rsi,rcx
		mov rdi,ofmt		         
		mov rax,0		
	        call printf
	        pop rsi
	        pop rdi
	        pop rdx
	        pop rcx
	        pop rbx
	        pop rax
	en:
	jmp lop
	dne:
	
	
	mov rcx,10
	call reverse_arr
	call print_arr		;prints ar
	
		
	mov rax,0
	pop rbp
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
