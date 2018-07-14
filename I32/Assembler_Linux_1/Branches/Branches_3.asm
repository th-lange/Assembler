
;   Version:                1
;   Created date:           2018.07.14
;   Last update:            2018.07.14
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Playing with Call / Return
;
;   Instructions Used:
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

    nop             ; end of code
