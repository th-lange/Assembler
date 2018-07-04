;
;   Executable name:        ToHexString
;   Version:                1
;   Created date:           2018.07.04
;   Last update:            2018.07.04
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Display StdIn as HEX
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
    ; This will be used to resolve the byte
    DIGITS:         db      "01234567890ABCDEF"


    ; This will be the container for the representation
    HEXSTRING       db      "0000000000000000", 10
    HEXSTRING_LN    equ     $-HEXSTRING

SECTION .bss
    ; Buffer to read into
    BUFFER_SIZE equ     16
    BUFFER:     resb    BUFFER_SIZE

SECTION .text


global _start

_start:
    nop             ; start of code
    MOV     ebp, BUFFER
    MOV     edi, DIGITS

; we read from StdIn and Check, that it was not empty
read:
    MOV     eax, 3
    MOV     ebx, 0
    MOV     ecx, ebp
    MOV     edx, BUFFER_SIZE

    INT     80h

    MOV     esi, eax
    CMP     eax, 0      ; EAX will indicate how much we have read!
    JE      done

; scan the items we just read and transform them
scan:
    ; we read 32 bits / 4 bytes
    MOV     edx, HEXSTRING
    XOR     eax, eax
    MOV     ebx, [ebp + eax]

    ; while within double word / 32 bits
    MOV     ecx, ebx
    AND     ecx, 00000000Fh     ; masque the nibble
    MOV     [edx + eax], byte [edi + ecx]

    SHR     ecx, 4

    ; for each nibble we push to HEXSTRING
    MOV     [edx + eax], byte [bl]


    ; now we shift values and write them as strings
    ; question: in which direction will we have to shift?


    


    ; we read the data as 4 bytes


    ; we rotate

    ; we null out

print:
    MOV     eax, 4
    MOV     ebx, 1
    MOV     ecx, HEXSTRING
    MOV     edx, HEXSTRING_LN
    INT     80h
    JMP     read


done:
    MOV     eax, 1
    MOV     ebx, 0
    INT     80h

    nop             ; end of code
