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
HelloMsg:   db " Hello World! "
HelloLen:   equ $-HelloMsg


SECTION .bss

SECTION .text


global _start

_start:
    nop             ; no-op for debugger
    mov eax, 4      ; sys write call
;    mov ebx, 2      ; file descriptor: stdErr
    mov ebx, 1      ; file descriptor: stdOut

    mov ecx, HelloMsg   ; Hando over message
    mov edx, HelloLen   ; Hand over length of message
    int 80H

    mov eax, 1
    mov ebx, 0
    int 80H

