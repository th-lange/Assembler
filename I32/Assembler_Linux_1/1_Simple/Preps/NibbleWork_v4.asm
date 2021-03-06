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
    DIGITS:     db "0123456789ABCDEF"
    TEXT:       db "This is the text to display", 10
    TXT_LEN:    equ $-TEXT

SECTION .bss
    BUFFER_SIZE equ 1024
    BUFFER_A:       resb BUFFER_SIZE
    BUFFER_B:       resb BUFFER_SIZE + BUFFER_SIZE

SECTION .text


global _start

_start:
    nop             ; start of code
read:
    MOV     eax, 3
    MOV     ebx, 0
    MOV     ecx, BUFFER_A
    MOV     edx, BUFFER_SIZE
    INT     80h

    MOV     ESI, EAX
    CMP     EAX, 0
    JE      done

    XOR     EBX, EBX        ; prepatre for iteration to copy

iterateBytes:
    MOV     ECX, [BUFFER_A + EBX]

; we have read 32 bits

moveToBufferB:
    ; nibble 1
    XOR     EAX, EAX
    MOV     EDX, ECX
    AND     EDX, 0Fh
    MOV     AL, byte [EDX + DIGITS]
    ROR     EAX, 8

    ; nibble 2
    ROR     ECX, 4
    MOV     EDX, ECX
    AND     EDX, 0Fh
    OR      AL, byte [EDX + DIGITS]
    ROR     EAX, 8
    ROR     EAX, 8

    ; nibble 3
    ROR     ECX, 4
    MOV     EDX, ECX
    AND     EDX, 0Fh
    OR      AL, byte [EDX + DIGITS]
    ROR     EAX, 8
    ROR     EAX, 8

    ; nibble 4
    ROR     ECX, 4
    MOV     EDX, ECX
    AND     EDX, 0Fh
    OR      AL, byte [EDX + DIGITS]
    ROR     EAX, 8
    ROR     EAX, 8

    MOV     [BUFFER_B + EBX + EBX], EAX

    ADD     EBX, 4
    CMP     EBX, ESI
    JLE     iterateBytes

    MOV     byte [BUFFER_B + EBX + EBX], 10

print:
    MOV     EAX, EAX
    ADD     EAX, EAX
    MOV     EDX, EAX
    MOV     EAX, 4
    MOV     EBX, 1
    MOV     ECX, BUFFER_B
    INT     80h
    JMP     _start

done:
    MOV     eax, 1
    MOV     ebx, 0
    INT     80h

    nop             ; end of code
