;
;   Executable name:        HelloWorld
;   Version:                1
;   Created date:           19/06/2018
;   Last update:            19/06/2018
;   Author:                 Thomas Lange
;   Status:                 ToDo
;   Description:            This will read characters from the command line and 
;                           Print them back on the screen
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
