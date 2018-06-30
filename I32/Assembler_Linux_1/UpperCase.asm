;
;   Executable name:        30.06.2018
;   Version:                1
;   Created date:           29.06.2018
;   Last update:            30.06.2018
;   Author:                 Thomas Lange
;   Status:                 DONE
;
;   Short:          String to Upper Case
;   Description:    Load a string from memory and upper case it
;
;   Instructions Used:
;       MOV, CMP, (not used in the end) SAL (Arithm. Left Shift)
;       XOR, JLE, JGE, JL, JG
;
;   Learned/Missconceptions/Errors:
;       Biggest missconception was the way memory is written to:
;       Instead of writing bytes, it wrote 4bytes
;
;       This also meant that initaly i was changing much more then just the text
;       Instead i did 8 times the character changes
;       This is why I added a test line
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data
Text:       db "this is Some teXt with wireD caSIng foo /&%%(/%/&%%(/%  bar   ", 10
TxtLen:     equ $-Text
Test:       db "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 10, "this is the test that no other bytes are modified - all lower case", 10
TestLen:    equ $-Test


SECTION .bss

SECTION .text


global _start

_start:
    nop
                                ; initial print of sentence
    mov eax, 4
    mov ebx, 1

    mov ecx, Text
    mov edx, TxtLen
    int 80H

start_upper_case:               ; start of upper casing
    mov eax, Text               ; load the position and length into memory
    mov edx, TxtLen
    mov ecx, 0                  ; for the loop condition init the variable
loop:
    mov bl, byte [eax + ecx]    ; now we read one byte at a time

    cmp bl, 'a'                 ; check if byte less then 'a'
    jl continue                 ; break if it is

    cmp bl, 'z'                 ; check if greater then 'z'
    jg continue                 ; break ir it is

modify:                         ; modify to  upper case
    xor bl, 00100000b
    mov [eax + ecx], byte bl    ; write back one byte

continue:                       ; continue with execution
    inc ecx                     ; and check if still in range of memory
    cmp ecx, edx
    jl loop                     ; if we are still in range: jump to start of loop

print:                          ; print (changed) sequence
    mov eax, 4
    mov ebx, 1

    mov ecx, Text
    mov edx, TxtLen
    int 80H

print_test:                     ; print controll sequence
    mov eax, 4
    mov ebx, 1

    mov ecx, Test
    mov edx, TestLen
    int 80H


stop:                           ; gracefully exit (under linux)
    mov eax, 1
    mov ebx, 0
    int 80H

    nop                         ; end of code
