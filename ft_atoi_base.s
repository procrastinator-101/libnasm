extern ___error

section .text

global _ft_atoi_base

;int	ft_atoi_base(char *num, char *base);
;======================================================================
_ft_atoi_base :
;	preserve the necessary registers
;----------------------------------------------------------------------
	push		r8			;used to hold base number
	push		r9			;used to hold the number to return
	push		r10			;used to hold the index where the sign is 
							;supposed to be
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
	
;	traverse white spaces
;----------------------------------------------------------------------
	push		rsi
	mov			rsi, 0
	call		_traverse_white_spaces
	pop			rsi
	mov			r10, rax
;----------------------------------------------------------------------

;	traverse sign
;----------------------------------------------------------------------
	mov			rcx, r10
	call		_traverse_sign
;----------------------------------------------------------------------

;	start the conversion
;----------------------------------------------------------------------
	mov			r9, 0
	call		_convert_to_base
;----------------------------------------------------------------------

;	set the sign
;----------------------------------------------------------------------
	call		_manage_sign
;----------------------------------------------------------------------

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

; if r10 == -1 -> ret = -ret
;======================================================================
_manage_sign :
	cmp			r10, -1
	je			_set_sign
	ret

_set_sign :
	mov			rdx, rax
	mov			rax, 0
	sub			rax, rdx
	ret
;======================================================================

;set r10 to -1 if negative | 0 otherwise
;and increment rcx if there is a sign
;======================================================================
_traverse_sign :
	movzx		rdx, byte[rdi + r10]
	cmp			dl, 45
	je			_traverse_minus
	cmp			dl, 43
	je			_traverse_plus
	ret

_traverse_minus :
	inc			rcx
	mov			r10, -1
	ret

_traverse_plus :
	inc			rcx
	mov			r10, 0
	ret
;======================================================================


;convert c to the right index and add it to ret
;======================================================================
_convert_to_base:
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
	call			_convert_to_base
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
;	align the stack
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;----------------------------------------------------------------------
	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------

	call		___error

;	restore the stack state before adjustement
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	mov			qword[rax], 22
    mov         rax, -1
    ret
;----------------------------------------------------------------------
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
;----------------------------------------------------------------------
	inc			rcx
	mov			dl, byte[rdi + rcx]
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	cmp			dl, 0
	je			_check_base_size
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	cmp			dl, 43
	je			_invalid_base
	cmp			dl, 45
	je			_invalid_base
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	push		rdi
	mov			rdi, rdx
	call		_is_white_space
	pop			rdi
	cmp			rax, 1
	je			_invalid_base
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	push		rcx
	mov			rax, 0
	call		_check_repetitiveness
	pop			rcx
	cmp			rax, 1
	je			_invalid_base
;----------------------------------------------------------------------
	call		_check_base__body
	ret

_check_base_size :
	cmp			rcx, 2
	jl			_invalid_base
	mov			rax, rcx
	ret

_invalid_base :
;	align the stack
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;----------------------------------------------------------------------
	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------

	call		___error

;	restore the stack state before adjustement
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	mov			qword[rax], 22
	mov			rax, -1
	ret
;----------------------------------------------------------------------
;======================================================================


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
;======================================================================


;int	traverse_white_spaces(char *str, int start)
;returns (the index of the last white space) + 1
;======================================================================
_traverse_white_spaces :
	mov			rdx, 0
	mov			rcx, rsi
	dec			rcx
	call		_traverse_white_spaces__body
	ret

_traverse_white_spaces__body :
	inc			rcx
	push		rdi
	movzx		rdi, byte[rdi + rcx]
	call		_is_white_space
	pop			rdi
	cmp			rax, 0
	je			_return_counter
	call		_traverse_white_spaces__body
	ret

_return_counter :
	mov			rax, rcx
	ret
;======================================================================

;int	is_white_space(char c)
;======================================================================
_is_white_space :
	cmp			dil, 32
	je			_return_true
	cmp			dil, 8
	jg			_check_upper_bound

_return_false :
	mov			rax, 0
	ret

_check_upper_bound :
	cmp			dil, 13
	jg			_return_false


_return_true :
	mov			rax, 1
	ret
;======================================================================

;	8 if not aligned | 0 otherwise
;======================================================================
_get_alignment_offset :
;	store the rsp % 16 in rax
;----------------------------------------------------------------------
	mov			rdx, 0
	mov			rax, rsp
	mov			rcx, 16
	div			rcx
;----------------------------------------------------------------------

;	rax == 0 -> not aligned (return address of align_stack)
;----------------------------------------------------------------------
	cmp			rdx, 0
	je			_update_offset
	mov			rax, 0
	ret
;----------------------------------------------------------------------

_update_offset :
	mov			rax, 8
	ret
;======================================================================
