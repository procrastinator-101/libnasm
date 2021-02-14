section .text

gloabl _convert_to_base

;convert c to the right index and add it to ret
;======================================================================
_convert_to_base :
;	preserve the necessary registers
;----------------------------------------------------------------------
	push			r8
	push			r9
	push			r10
	mov				r8, 10
	mov				r9, 0
	mov				r10, 0
;----------------------------------------------------------------------





;int	get_index(char *str, char c);
;======================================================================
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
;======================================================================
