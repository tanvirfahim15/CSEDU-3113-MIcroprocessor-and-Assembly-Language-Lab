segment .data
Hello: db "HEllo world",0
fmt: db "%s",10,0

segment .text

global main
extern printf

main:
push RBP

mov RDI,fmt
mov RSI,Hello
mov RAX,0
call printf

mov RAx,0 
pop RBP
ret
;nasm -f elf64 hello.asm &&  gcc -o hello  hello.o && ./hello
