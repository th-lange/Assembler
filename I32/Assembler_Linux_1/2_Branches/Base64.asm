
;
;   Version:                1
;   Created date:           2018.07.28
;   Last update:            2018.07.28
;   Author:                 Thomas Lange
;   Status:                 TODO
;       ToDo:
;       - fix padding issues when printing
;
;   Description:            Transform Input to Base64
;
;   Instructions Used:
;
;   Learned/Missconceptions/Errors:
;
;
;   Build Commands:
;       nasm -f elf -g -F dwarf Base64.asm
;       ld -m elf_i386 -o Base64 Base64.asm
;Base64Recon.txt


SECTION .data
    BASE_64_MAP:    db      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                    db      "abcdefghijklmnopqrstuvwxyz",
                    db      "0123456789+/"
    BASE_64_MAP_LEN equ     $-BASE_64_MAP


SECTION .bss
    ; Buffer to read into
    BUFFER_IN_LEN    equ        48
    BUFFER_IN       resb    BUFFER_IN_LEN

    ; Buffer to write into
    BUFFER_OUT_LEN   equ        64
    BUFFER_OUT      resb    BUFFER_OUT_LEN

    BUFFER_OUT_LEN_CUR:     resb     4

SECTION .text


global _start

_start:
    nop             ; start of code
;   Init

;------------------------------------------------------------------------------
;   # Read StdIn to BUFFER_IN
;       - If Buffer Read is Zero - no more in buffer - jump to exit
;   OUT:
;       - eax: Bytes Read
;    Modifies:
;------------------------------------------------------------------------------
Read:
    mov     eax, 3          ; sys read call
    mov     ebx, 0          ; use StdIn
    mov     ecx, BUFFER_IN
    mov     edx, BUFFER_IN_LEN
    int     80h
    cmp     eax, 0
    je      Exit
    mov     [BUFFER_OUT_LEN_CUR], eax
;------------------------------------------------------------------------------
;   # Operate on DWords (32 Bit) in BUFFER_IN
;   Load one DWord
;------------------------------------------------------------------------------
;    xor     edx, edx        ; set eax to 0
;    mov     ebx, BASE_64_MAP; Prepare map for XLAT

Load:
    mov     ebp, eax
    xor     edx, edx
    mov     ebx, BASE_64_MAP

.peak:
    ; load the bytes at postion
    lea     ecx, [BUFFER_IN + edx * 3]
    mov     eax, [ecx]
    ; translate
    call     Translate
    ; write translated
    lea     ecx, [BUFFER_OUT + edx * 4]
    mov     [ecx], eax
    add     edx, 1
    cmp     edx, ebp
    jle     .peak
    call    Print
    jmp     Read




Exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    nop             ; end of code


;------------------------------------------------------------------------------
;   ## Map to Translation Table
;       - We take one DWord and Split it into the Base64 Segments
;       - Then we use XLAT to map those to the corresponding items
;   IN:
;       - eax:      Byte to translate
;       - ebx:      where to write to
;
;------------------------------------------------------------------------------
Translate:
    push    ecx
    push    edx
;   Preparation of Segment
    mov     edx, eax        ; we copy the target
    xor     eax, eax
    bswap   edx             ; we change endianness to big endian
    ror     edx, 26          ; we move to the first segment
    mov     ecx, 4
.translate:
    mov     al, dl
    and     al, 03fh
    xlat
    ror     eax, 8
    rol     edx, 6
    sub     ecx, 1
    jnz     .translate
    pop     edx
    pop     ecx
    ret

;   Write BUFFER_OUT to StdOut
Print:
    push    eax
    push    ebx
    push    ecx
    push    edx
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, BUFFER_OUT
;    mov     edx, [BUFFER_OUT_LEN_CUR]
    mov     edx, BUFFER_OUT_LEN
    int     80h
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax
    ret
