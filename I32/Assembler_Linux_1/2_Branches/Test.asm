
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
    mov     eax, 'ABC'
    mov     ebx, BASE_64_MAP
    nop

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

;==============================================================================
; BASE_64 Encode first 3 Bytes of EAX
;   IN: eax 3 Bytes (or more, rest ignored)
;       ebx Location of translation table
;   OUT: eax 4 Byte translation
;==============================================================================

Mod:
    push    ecx
    push    edx
;   Preparation of Segment
    mov     edx, eax        ; we copy the target
    xor     eax, eax
    bswap   edx             ; we change endianness to big endian
    ror     edx, 26          ; we move to the first segment
    mov     ecx, 4
.mod:
    mov     al, dl
    and     al, 03fh
    xlat
    ror     eax, 8
    rol     edx, 6
    sub     ecx, 1
    jnz     .mod
    pop     edx
    pop     ecx
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
