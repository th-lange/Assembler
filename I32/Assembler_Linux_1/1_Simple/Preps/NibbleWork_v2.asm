;
;   Executable name:        NibbleWork
;   Version:                1
;   Created date:           2018.07.06
;   Last update:            2018.07.06
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Working With Nibbles
;                           This is the test to see, how one can work on the
;                           nibbles of different bytes.
;                           Preparation to finish the ToHexString 
;
;   Instructions Used:
;   MOV, AND, OR, ROR, ROL, DEC, JNZ
;
;   Learned/Missconceptions/Errors:
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
    DIGITS:     db "0123456789ABCDEF"
    TEXT:       db "This is the text to display", 10
    TXT_LEN:    equ $-TEXT

SECTION .bss

    BUFFER_SIZE equ 1024
    BUFFER:     resb BUFFER_SIZE

SECTION .text


global _start

_start:
    nop             ; start of code
    MOV     ESI, 0

nextLetter:
    MOV     EAX, [TEXT + ESI]
    MOV     EDX, 4

iterate:
    MOV     EBX, EAX
    AND     EBX, 0Fh
    MOV     BL, byte [EBX + DIGITS]
    OR      ECX, EBX
    ROR     EAX, 4
    ROR     ECX, 8
    DEC     EDX
    JNZ     iterate
; we have mangaged 4 nibbles => and write one byte
    MOV     [BUFFER + ESI + ESI], ECX

    ADD     ESI, 4
    CMP     ESI, TXT_LEN
    JLE     nextLetter

; lets print and see what we have

    mov eax, 4      ; sys write call
    mov ebx, 1      ; file descriptor: stdOut

    mov ecx, BUFFER   ; Hando over message
    mov edx, BUFFER_SIZE   ; Hand over length of message
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H

    nop             ; end of code
