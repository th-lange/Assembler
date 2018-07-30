;
;   Version:                2
;   Created date:           2018.07.30
;   Last update:            2018.07.30
;   Author:                 Thomas Lange
;   Status:                 TODO
;
;   Description:            Copy and Modify Input - 2
;                           To get a better grap on how to change and copy
;                           between buffers.
;                           - Preparation for Base64
;
;   Instructions Used:
;           - LEA: Calculate memory adresses
;
;   Learned/Missconceptions/Errors:
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf Base64.asm
;       ld -m elf_i386 -o Base64 Base64.asm
;


SECTION .data
    BUFFER_IN_NAME      db  "Buffer In:", 10
    BUFFER_IN_NAME_LEN  equ $-BUFFER_IN_NAME

    BUFFER_OUT_NAME      db  "Buffer Out:", 10
    BUFFER_OUT_NAME_LEN  equ $-BUFFER_OUT_NAME


    BASE_64_MAP:    db      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                    db      "abcdefghijklmnopqrstuvwxyz",
                    db      "0123456789+/"
    BASE_64_MAP_LEN equ     $-BASE_64_MAP

SECTION .bss
    ; Buffer to read into
    BUFFER_IN_LEN    equ     48
    BUFFER_IN       resb    BUFFER_IN_LEN

    ; Buffer to write into
    BUFFER_OUT_LEN   equ     64
    BUFFER_OUT      resb    BUFFER_OUT_LEN

SECTION .text


global _start

_start:
    nop             ; start of code

Read:
    mov     eax, 3          ; sys read call
    mov     ebx, 0          ; use StdIn
    mov     ecx, BUFFER_IN
    mov     edx, BUFFER_IN_LEN
    int     80h
    cmp     eax, 0
    je      Exit

    call    Test

Copy:
    mov     ebp, eax
    xor     ecx, ecx
    mov     ebx, BASE_64_MAP

.cpy:
    lea     edx, [BUFFER_IN + 3 * ecx]
    mov     eax, [edx]
    mov     edx, eax
    ; We need 4 Translations to fill the input buffer
    call    Mod
    call    Mod
    call    Mod
    call    Mod

    lea     edx, [BUFFER_OUT + 4 * ecx]
    mov     [edx], eax
    inc     ecx
    cmp     ecx, ebp
    jne     .cpy

    call    Test

Exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    nop             ; end of code

;==============================================================================
;       PROCEDURES
;==============================================================================

Test:
    push    ecx
    push    edx
    mov     ecx, BUFFER_IN_NAME
    mov     edx, BUFFER_IN_NAME_LEN
    call    Print

    mov     ecx, BUFFER_IN
    mov     edx, BUFFER_IN_LEN
    call Print

    mov     ecx, BUFFER_OUT_NAME
    mov     edx, BUFFER_OUT_NAME_LEN
    call    Print

    mov     ecx, BUFFER_OUT
    mov     edx, BUFFER_OUT_LEN
    call    Print
    pop     edx
    pop     ecx
    ret

;------------------------------------------------------------------------------
;   Transfrom
;   - Write el, to al
;   - xlat
;   - shift and rotate
;------------------------------------------------------------------------------
Mod:
    mov     al, dl
    and     al, 03fh
    xlat
    ror     edx, 6
    ror     eax, 8
    ret


;------------------------------------------------------------------------------
;   PRINT to StdOut
;
;   IN:
;       - ecx: What to Print
;       - edx: How many Bytes to Print
;------------------------------------------------------------------------------
Print:
    push    eax
    push    ebx
    mov     eax, 4
    mov     ebx, 1
    int     80h
    pop     ebx
    pop     eax
    ret
