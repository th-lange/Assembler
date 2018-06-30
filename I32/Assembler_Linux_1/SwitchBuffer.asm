
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
;       nasm -f elf -g -F darf HelloWrold.asm
;       ld -m elf_i386 -o HelloWorld helloWorld.o
;


SECTION .data

SECTION .bss

SECTION .text


global _start

_start:
    nop                 ; LITTLE ENDIAN PLAYS
    mov eax, 0FFFEFDFCh ; we write "11111111111111101111110111111100" to EAX
    mov bx, ax          ; we mov the "lower" half to bx: FDFC
                        ; this should result in bx: "1111111111101110" (or better: "1110111011111111")

    mov ch, bl          ; this moves FF to ch
    mov cl, bh          ; this moves EE to cl

                        ; Result is: cx: FF EE
    mov eax, 1
    mov ebx, 0
    int 80H
    nop
