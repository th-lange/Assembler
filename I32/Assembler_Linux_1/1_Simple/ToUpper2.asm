;
;   Executable name:        04.07.2018
;   Version:                1
;   Created date:           04.07.2018
;   Last update:            04.07.2018
;   Author:                 Thomas Lange
;   Status:                 DONE
;
;   Short:          String to Upper Case
;   Description:    Read String from StdIn Buffer 1024 bytes at a time
;                   And process it
;
;                   Timed Version to see how buffer mangement works
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
; Error Messages
; Will be used later

SECTION .bss
    BUFFER_SIZE equ 1024
    BUFFER:     resb BUFFER_SIZE

SECTION .text


global _start

_start:
        NOP                                     ; start

; Read from StdIn into the buffer
read:
    MOV     eax, 3
    MOV     ebx, 0
    MOV     ecx, BUFFER
    MOV     edx, BUFFER_SIZE
    INT     80h
    MOV     ESI, EAX
    CMP     EAX, 0
    JE      done

; Operate on items in the buffer
    MOV     ecx, esi
    MOV     ebp, BUFFER
    DEC     ebp

toUpper:
    MOV     al, byte [ebp + ecx]
    CMP     byte al, 'a'
    JB      next

    CMP     byte al, 'z'
    JA      next

    XOR     al, 00100000b
    MOV     byte [ebp + ecx], al

next:
    DEC     ecx
    JNZ     toUpper

write:
    MOV     eax, 4
    MOV     ebx, 1
    MOV     ecx, BUFFER
    MOV     edx, esi
    INT     80h

    JMP     read




; Exit gracefully once you are done
done:
    MOV     eax, 1
    MOV     ebx, 0
    INT     80h


    NOP;
