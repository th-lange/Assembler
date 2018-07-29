
;   Version:                1
;   Created date:           2018.07.14
;   Last update:            2018.07.14
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Playing with Call / Return
;                           Directly pushing values with push and pop
;
;   New Instructions Used:
;       push, pop
;
;   Learned/Missconceptions/Errors:
;       - 
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
    TEXT_1:           db  " Error Message 1", 10
    TEXT_1_LEN:       equ $-TEXT_1

    TEXT_2:         db    " Error Message 2", 10
    TEXT_2_LEN:     equ     $-TEXT_2

SECTION .bss

SECTION .text

printWarning:
    mov     eax, 4
    mov     ebx, 1
    int     80h
    ret

warning:
    push    ebx
    push    ecx
    push    edx
    cmp     eax, 1
    jne     message2
    mov     ecx, TEXT_1
    mov     edx, TEXT_1_LEN
    call    printWarning
message2:
    cmp     eax, 2
    jne     warningEnd
    mov     ecx, TEXT_2
    mov     edx, TEXT_2_LEN
    call    printWarning
warningEnd:
    pop     edx
    pop     ecx
    pop     ebx
    ret



global _start

_start:
    nop             ; start of code
    mov     eax, 1
    call    warning
    mov     eax, 2

    ; these should not do anything
    call    warning
    mov     eax, 3
    call    warning
    mov     eax, 3
    call    warning

    ; this one should print TEXT_1
    mov     eax, 1
    call    warning


exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    nop             ; end of code
