;
;   Executable name:        ToHexString
;   Version:                1
;   Created date:           2018.07.04
;   Last update:            2018.07.04
;   Author:                 Thomas Lange
;   Copied from:            Jeff Duntemann
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
    HEXSTR:     db      " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"
    HEX_LEN     equ     $-HEXSTR

    DIGITS:     db      "0123456789ABCDEF"

SECTION .bss

    BUFFLEN     equ     16
    BUFF:       resb    BUFFLEN

SECTION .text

global _start

_start:
    nop             ; start of code


read:               ; read BUFFLEN Bytes from stdIn
    MOV     EAX, 3
    MOV     EBX, 0
    MOV     ECX, BUFF
    MOV     EDX, BUFFLEN
    INT     80h

    MOV     EBP, EAX
    CMP     EAX, 0
    JE      done

; Set Up Buffers

    MOV     ESI, BUFF
    MOV     EDI, HEXSTR

    XOR     ECX, ECX

scan:                           ; from here we go through and read and convert
                                ; first: calculate offset into HEXSTR
    MOV     EDX, ECX
    SHL     EDX, 1
    ADD     EDX, ECX


; Go through Buffer and convert to hex
; prepare two buffers
    MOV     byte AL, byte [ESI + ECX]
    MOV     EBX, EAX

; shift and AND them to get the corresponding nibbles
    AND     AL, 0Fh
    AND     BL, 0F0h
    SHR     EBX, 4

; look up the corresponding items and write them to the register
    MOV     AL, byte [DIGITS + EAX]
    MOV     BL, byte [DIGITS + EBX]

    MOV     [HEXSTR + EDX + 1], EAX
    MOV     [HEXSTR + EDX + 2], EBX

; verify if we are done
    INC     ECX
    CMP     ECX, EBP
    JNA     scan

; write
    MOV     EAX, 4
    MOV     EBX, 1
    MOV     ECX, HEXSTR
    MOV     EDX, HEX_LEN
    INT     80h
    JMP     read

done:
    MOV     EAX, 1
    MOV     EBX, 0
    INT     80h




    nop             ; end of code
