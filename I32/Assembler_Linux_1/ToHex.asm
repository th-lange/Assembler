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
    HEXSTRING       db      " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
    HEXSTRING_LN    equ     $-HEXSTRING

SECTION .bss
    ; Buffer to read into
    BUFFER_LN   equ     16
    BUFFER:     resb    BUFFER_LN

SECTION .text

;       EAX - this is where we will read one byte into (low nibble of byte)
;           - we will zero it out and work on it with the DIGITS Chars
;
;       EBX - second buffer for HIGH nibble of byte
;       EBP - how much have we read


global _start

_start:
    nop             ; start of code

read:                           ; we read stdIn into the buffer
    MOV     eax, 3              ; read system call
    MOV     ebx, 0              ; from descriptor: stdIn
    MOV     ecx, BUFFER         ; we specify the buffer
    MOV     edx, BUFFER_LN    ; and the size we want to read
    INT     80h

    CMP     eax, 0
    JE      done

; now we set up the values we need for later
    MOV     ebp, eax            ; EBP -> bytes read from last read

; Dont think we need this
;    MOV     esi, BUFFER
;    MOV     edi, HEXSTRING

    XOR     ecx, ecx            ; clear buffer for iteration
; we iterate over the bytes of the buffer
scan:
; Calculate, where we will write to in HEXSTRING (_XX_XX_XX...)
    XOR     eax, eax            ; Because we will only write a byte to it and need it to be zero

    MOV     edx, ecx            ; we start the iteration with ECX (zeroed above)
    SHL     edx, 1
    ADD     edx, ecx

; we separate the nibbles
    MOV     al, byte[BUFFER + ecx]
    MOV     ebx, eax            ; we copy eax (zeroed) + byte to ebx
    SHR     ebx, 4
    AND     eax, 0Fh
    AND     ebx, 0Fh

; we replace nibbles with ASCII chars via DIGITS (lookup table)
    MOV     al, byte [DIGITS + eax]
    MOV     bl, byte [DIGITS + ebx]

; we write to the buffer
    MOV     byte [HEXSTRING + edx + 2], al
    MOV     byte [HEXSTRING + edx + 1], bl

; we increment ecx and check if we are done
    INC     ecx
    CMP     ecx, ebp
    JNA     scan

; we zero out the remaining bytes so that we do not reprint unused chars
; from this buffer that have been set by the last buffer
fillZero:
    CMP     ecx, BUFFER_LN
    JE      write

    MOV     edx, ecx
    SHL     edx, 1
    ADD     edx, ecx

    MOV     word [HEXSTRING + edx + 1], '00'
    INC     ecx
    JMP     fillZero


; we write HEXSTRING to StdOut
write:
    MOV     eax, 4
    MOV     ebx, 1
    MOV     ecx, HEXSTRING
    MOV     edx, HEXSTRING_LN
    INT     80h

; once we have written, we jump back and read some more
    JMP     read


; we end the programm
done:
    MOV     eax, 1
    MOV     ebx, 0
    INT     80h

