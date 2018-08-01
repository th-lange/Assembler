
SECTION .data
    BUFFER_IN_NAME      db  "Buffer In:", 10
    BUFFER_IN_NAME_LEN  equ $-BUFFER_IN_NAME

    BUFFER_OUT_NAME      db  "Buffer Out:", 10
    BUFFER_OUT_NAME_LEN  equ $-BUFFER_OUT_NAME


    BASE_64_MAP:    db      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                    db      "abcdefghijklmnopqrstuvwxyz",
                    db      "0123456789+/"
    BASE_64_MAP_LEN equ     $-BASE_64_MAP


SECTION .text


global _start

_start:
    nop             ; start of code
    mov     eax, 'ABCD'
    mov     ebx, BASE_64_MAP
    mov     edx, eax
    nop

    call Mod
    call Mod
    call Mod
    call Mod

    mov [BUFFER_OUT_NAME], eax

    mov ecx, BUFFER_OUT_NAME
    mov edx, 4
    call Print



Exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    nop             ; end of code



Mod:
    mov     al, dl
    and     al, 03fh
    xlat
    ror     edx, 6
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ror     eax, 1
    ret

Print:
    push    eax
    push    ebx
    mov     eax, 4
    mov     ebx, 1
    int     80h
    pop     ebx
    pop     eax
    ret
