
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
;   The current setup will resutl in register position switching:
;   (gdb) info registers
;    eax            0x5a595857  1515804759
;    ebx            0x5857      22615
;    ecx            0x5758      22360
;   .....
;    eip            0x804806d   0x804806d <_start+13>

SECTION .data

SECTION .bss

SECTION .text


global _start

_start:
======
    nop             ; start of code
    mov eax, 5A595857h
    mov bx, ax              ; moves last bytes to bx
                            ; resulting in the least sign. bytes in eax beeing set
    mov ch, bl              ; moving lowest byte from bx to second least in cx
    mov cl, bh              ; mowing second lowest byte from bx least sign. in cx

    ; This last instruction does the same as xchg cl, ch

    mov eax, 1
    mov ebx, 0
    int 80h
    nop             ; end of code
