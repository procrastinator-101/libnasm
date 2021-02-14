section .text

global _ft_atoi_base

;int	ft_atoi_base(char *num, char *base);
;======================================================================
_ft_atoi_base :
;	preserve the necessary registers
;----------------------------------------------------------------------
	push		r8			;used to hold base number
	push		r9			;used to hold the number to return
	push		r10			;used to hold the index of the sign if there is one
;----------------------------------------------------------------------

;	check if str or base are null
;----------------------------------------------------------------------
	cmp			rdi, 0
	je			_manage_error
	cmp			rsi, 0
	je			_manage_error
;----------------------------------------------------------------------

;	check if base has the same character twice , '-' or '+'
;	and store the base number in r8
;----------------------------------------------------------------------
	push		rdi
	mov			rdi, rsi
	call		_check_base
	pop			rdi
	cmp			rax, -1
	je			_manage_error
	mov			r8, rax
;----------------------------------------------------------------------
	
;	traverse white spaces and store the sign in r10
;----------------------------------------------------------------------
	call		_traverse_white_spaces
	mov			r10, 0
	call		_manage_sign			;rcx incremented the sign if there is one
	cmp			r10, -1
	je			_quit
	mov			r10, rcx
	mov			r9, 0
;----------------------------------------------------------------------

	call		_convert_to_base

;	restore the used registers and return
;----------------------------------------------------------------------
_quit :
	pop			r10
	pop			r9
	pop			r8
	ret

_manage_error :
	mov			rax, 0
	pop			r10
	pop			r9
	pop			r8
	ret
;======================================================================


;store the sign in r10 : 1 ->positive || 0 ->negative | -1 ->error
;======================================================================
_manage_sign :
	mov		dl, byte[rdi + rcx]
	cmp		dl, 43
	je		_check_base
	cmp		dl, 45
	je		_check_base
	ret

_check_base :
	cmp		r8, 10
	je		_set_sign
	mov		rax, 0
	mov		r10, -1
	ret

_set_sign :
	inc		rcx
	ret
;======================================================================


;convert c to the right index and add it to ret
;======================================================================
_convert_to_base :
;	preserve the necessary registers
;----------------------------------------------------------------------
	push		rdi
	push		rsi
;----------------------------------------------------------------------

	inc			rcx
	mov			dl, byte[rdi + rcx]
	cmp			dl, 0
	je			_return_result
	mov			rdi, rsi
	mov			rsi, rdx
	call		_get_index
	mov			rdi, rax
	mov			rax, r9
	mul			r8
	mov			r9, rax
	add			r9, rdi

;	restore the used registers
;----------------------------------------------------------------------
	pop			rsi
	pop			rdi
	call		_convert_to_base
	ret
;----------------------------------------------------------------------

_return_result:
	pop			rsi
	pop			rdi
	mov			rax, r9
	ret
;======================================================================

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


;int	check_base(char *base)
;returns -1 if base is invalid, otherwise it length(base number)
;======================================================================
_check_base :
	mov			rcx, -1
	mov			rdx, 0
	call		_check_base__body
	ret

_check_base__body :
	inc			rcx
	mov			dl, byte[rdi + rcx]
	cmp			dl, 0
	je			_check_base_size
	cmp			dl, 43
	je			_invalid_base
	cmp			dl, 45
	je			_invalid_base
	push		rcx
	mov			rax, 0
	call		_check_repetitiveness
	pop			rcx
	cmp			rax, 1
	je			_invalid_base
	call		_check_base__body
	ret

_check_base_size :
	cmp			rcx, 2
	jl			_invalid_base
	mov			rax, rcx
	ret

_invalid_base :
	mov			rax, -1
	ret


;int	check_repetitiveness(char *base + start)
;returns 1 if base[start] appears twice | 0 otherwise
;======================================================================
_check_repetitiveness :
	inc			rcx
	mov			al, byte[rdi + rcx]
	cmp			al, 0
	je			_uniq_character
	cmp			dl, al
	je			_repetitive_character
	call		_check_repetitiveness
	ret

_uniq_character :
	mov			rax, 0
	ret

_repetitive_character :
	mov			rax, 1
	ret
