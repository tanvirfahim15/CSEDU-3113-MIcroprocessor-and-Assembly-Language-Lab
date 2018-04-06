extern	printf		
extern	scanf		
extern gets
SECTION .data		
v: dq 0
c: dq 0	
spc: dq 0
cnt: dq 0	
out_fmt:	db "%s",10,0
out_fmti:	db "Consonants: %ld",10,0
out_fmtv:	db "Vowels: %ld",10,0
out_fmtc:	db "%c",10,0
in_fmt:		db "%s",0
SECTION .bss
str:	resb 20
SECTION .text

global main		
main:		
	push rbp
	
	mov rax,0		;scan string
	mov rdi,str
	call gets

	
loop:				;loop through characters
	mov rax,0
	mov rcx,[cnt]
	mov al,[str+rcx]
	mov rbx,[cnt]
	add rbx,1
	mov [cnt],rbx
	
	mov rbx,65		;check for vowel
	cmp rax,rbx
	jz vo
	mov rbx,69
	cmp rax,rbx
	jz vo
	mov rbx,73
	cmp rax,rbx
	jz vo
	mov rbx,79
	cmp rax,rbx
	jz vo
	mov rbx,85
	cmp rax,rbx
	jz vo
	mov rbx,32
	cmp rax,rbx
	jne nsp
	mov rbx,[spc]
	add rbx,1
	mov [spc],rbx
	nsp:
	jmp ex
vo:
	mov rbx,[v]		;increase vowel count
	add rbx,1
	mov [v],rbx
ex:
	cmp rax,0
	jnz loop
	
	mov rax,[cnt]
	mov rbx,[v]
	sub rax,rbx
	dec rax
	mov rbx,[spc]
	sub rax,rbx
	mov rdi,out_fmti	;print Consonants
	mov rsi,rax
	mov rax,0
	call printf	
    
	mov rdi,out_fmtv	;print vowels
	mov rsi,[v]
	mov rax,0
	call printf		

	pop	rbp			
	ret	
