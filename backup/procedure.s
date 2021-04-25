
extern _printf
global _main

section .text

_main:  push    rbp
        mov     rbp, rsp
        mov     rdi, msg
        mov     rsi, 17
        lea     rsi, [rel _printf wrt ..gotpcrel]
        xor     eax, eax
        call    [rsi]
        xor     eax, eax
        leave
        ret

        section .data

msg:    db "printf: 0x%lx", 10, 0
