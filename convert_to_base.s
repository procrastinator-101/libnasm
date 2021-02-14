extern	_printf

section .data
	fmt	 db	"index = %d"


section .text

global _convert_to_base

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
	mov				rcx, r10
;----------------------------------------------------------------------
	call			_convert_to_base__body

;	restore used registers and return
;----------------------------------------------------------------------
_quit :
    pop         r10
    pop         r9
    pop         r8
    ret
;----------------------------------------------------------------------

_convert_to_base__body :
;	reserve registers
;----------------------------------------------------------------------
	push			rcx
	push			rdi
	push			rsi
;----------------------------------------------------------------------

;	getting the index of str[rcx]
;----------------------------------------------------------------------
	movzx			rdx, byte[rdi + rcx]
	cmp				dl, 0
	je				_return_converted_base
	mov				rdi, rsi
	mov				rsi, rdx
	call			_get_index
	cmp				rax, -1
	je				_manage_conv_base_error
;----------------------------------------------------------------------

;	ret = ret * B + index
;----------------------------------------------------------------------
	mov				rdi, rax
	mov				rax, r9
	mul				r8
	mov				r9, rax
	add				r9, rdi
;----------------------------------------------------------------------

;	restore used registers
;----------------------------------------------------------------------
	pop				rsi
	pop				rdi
	pop				rcx
;----------------------------------------------------------------------

	inc				rcx
	call			_convert_to_base__body
	ret
;----------------------------------------------------------------------


_return_converted_base :
;	set rax to the return value and quit
;----------------------------------------------------------------------
	mov			rax, r9
    pop         rsi
    pop         rdi
    pop         rcx
    ret
;----------------------------------------------------------------------


_manage_conv_base_error :
;	set return value to 0 and quit
;----------------------------------------------------------------------
    mov         rax, 0
    pop         rsi
    pop         rdi
    pop         rcx
    ret
;======================================================================
	

;int	get_index(char *str, char c);
;======================================================================

_get_index :
    mov         rcx, -1
    mov         rdx, 0
    call        _find_char
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
