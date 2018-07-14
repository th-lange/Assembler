
;   Version:                1
;   Created date:           2018.07.14
;   Last update:            2018.07.14
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Playing with Call / Return
;
;   New Instructions Used:
;       pushad, popad, call, ret
;
;   Learned/Missconceptions/Errors:
;       Typos can hit you hard. I misspeled pushad and no error occured.
;       But programm crashed, as random values where poped from stack...
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
    TEXT:       db " This is a test !", 10
    TEXT_LEN:   equ $-TEXT

SECTION .bss

SECTION .text

function_a:
; let's see how pushad and popad work
    pushad
    mov     eax, 0
    mov     ebx, 0
    mov     ecx, 0
    mov     edx, 0
    popad
    ret

print_a:
    mov     eax, 4
    mov     ebx, 1
    int     80h
    ret


global _start

_start:
    nop             ; start of code
    mov     ecx, TEXT
    mov     edx, TEXT_LEN
    call    print_a
    call    function_a
    call    print_a
exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    nop             ; end of code
