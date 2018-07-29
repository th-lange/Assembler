
;
;   Version:                1
;   Created date:           2018.07.28
;   Last update:            2018.07.30
;   Author:                 Thomas Lange
;   Status:                 DONE
;
;   Description:            Copy and Modify Input
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


SECTION .bss
    ; Buffer to read into
    BUFFER_IN_LEN    equ     64
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
    xor     ebx, ebx
.cpy:
    lea     ecx, [BUFFER_IN + 3 * ebx]
    mov     edx, [ecx]
    lea     ecx, [BUFFER_OUT + 4 * ebx]
    mov     [ecx], edx
    inc     ebx
    cmp     ebx, eax
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
