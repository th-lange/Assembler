
;
;   Executable name:        04.07.2018
;   Version:                1
;   Created date:           04.07.2018
;   Last update:            04.07.2018
;   Author:                 Thomas Lange
;   Status:                 DONE
;   Altered copy from:      Jeff Duntmann
;
;   Short:          String to Upper Case
;   Description:    Read String from StdIn Buffer 1024 bytes at a time
;                   And process it
;
;   Instructions Used:
;       Biggest missconception was the way memory is written to:
;       Instead of writing bytes, it wrote 4bytes
;
;       This also meant that initaly i was changing much more then just the text
;       Instead i did 8 times the character changes
;       This is why I added a test line
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
    CMP     byte [ebp + ecx], 'a'
    JB      next

    CMP     byte [ebp + ecx], 'z'
    JA      next

    XOR     byte[ebp + ecx], 00100000b

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
