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

SECTION .bss

SECTION .text


global _start

_start:
    nop             ; start of code

    nop             ; end of code
