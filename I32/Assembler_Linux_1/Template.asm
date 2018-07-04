;
;   Version:                1
;   Created date:           {DATE}
;   Last update:            {DATE}
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            ADD NAME HERE
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
