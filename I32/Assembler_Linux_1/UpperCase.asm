;
;   Executable name:        HelloWorld
;   Version:                1
;   Created date:           19/06/2018
;   Last update:            19/06/2018
;   Author:                 Thomas Lange
;   Altered copy from:      Jeff Duntmann
;   Description:            Simple CLI Programm to write to SysOut
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
Text:       db "this is Some teXt with wireD caSIng", 10
TxtLen:     equ $-Text

SECTION .bss

SECTION .text


global _start

_start:
    nop             ; start of code
    mov eax, Text
    mov edx, TxtLen
    sal edx, 3
    mov ecx, 0
loop:
    mov bl, [eax + ecx]
    ; do check on modification here

    cmp bl, 'a'
    jl continue

    cmp bl, 'z'
    jg continue

    ; modify to  upper case

    xor bl, 00100000b
    mov [eax + ecx], bl

continue:       ; continue with execution and check if still in range of memory
    add ecx, 8
    cmp ecx, edx
    jle loop

print:
    mov eax, 4
    mov ebx, 1

    mov ecx, Text
    mov edx, TxtLen
    int 80H


stop:
    mov eax, 1
    mov ebx, 0
    int 80H 

    nop             ; end of code
