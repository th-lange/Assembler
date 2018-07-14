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

SECTION .bss

SECTION .text


global _start

_start:
    nop             ; start of code

    MOV     EAX, 0FEDCBA98h
    MOV     EDX, 8

iterate:
    MOV     EBX, EAX
    AND     EBX, 0Fh
    OR      ECX, EBX
    ROL     EAX, 4
    ROL     ECX, 4
    DEC     EDX
    JNZ     iterate

    nop             ; end of code
