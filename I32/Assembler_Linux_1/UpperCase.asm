;
;   Executable name:        30.06.2018
;   Version:                1
;   Created date:           29.06.2018
;   Last update:            30.06.2018
;   Author:                 Thomas Lange
;   Status:                 INCOMPLETE
;
;   Short:      String to Upper Case
;   Description:Load a string from memory and upper case it
;
;   Instructions Used:
;       MOV, CMP, SAL (Arithm. Left Shift)
;       XOR, JLE, JGE
;
;   Learned/Missconceptions/Errors:
;       Biggest missconception was the way memory is written to:
;       Instead of writing bytes, it wrote 4bytes
;
;       This was fixed by: $$$ADD$$$
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
Text:       db "this is Some teXt with wireD caSIng ! see&%$! what will HAP?N", 10
TxtLen:     equ $-Text

SECTION .bss

SECTION .text


global _start

_start:
    nop             ; start of code

    ; initial print of sentence
    mov eax, 4
    mov ebx, 1

    mov ecx, Text
    mov edx, TxtLen
    int 80H

    ; intended upper casing
    mov eax, Text
    mov edx, TxtLen
    sal edx, 3
    mov ecx, 0
loop:
    mov bl, byte [eax + ecx]
    ; do check on modification here

    cmp bl, 'a'
    jl continue

    cmp bl, 'z'
    jg continue

    ; modify to  upper case

    xor bl, 00100000b
    mov [eax + ecx], byte bl

continue:       ; continue with execution and check if still in range of memory
    inc ecx
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
