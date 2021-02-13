section .text

global _get_index

_get_index :
    push        rcx
    push        rdx
    mov         rcx, -1
    mov         rdx, 0
    call        _find_char
    pop         rdx
    pop         rcx
    ret

_find_char :
    inc         rcx
    mov         dl, byte[rdi + rcx]
    cmp         dl, sil
    je          _return_index
    cmp         dl, 0
    je          _return_index_error
    call        _find_char
	ret

_return_index :
    mov         rax, rcx
    ret

_return_index_error :
    mov         rax, -1
    ret
