section .text

global _ft_atoi_base

;int	ft_atoi_base(char *num, char *base);
;=======================================================
_ft_atoi_base :
	;	preserve the necessary registers
	;---------------------------------------------------
	push		rdx			;used for camparisons
	push		rcx			;used as counter
	push		r8			;used to hold base
	push		r9			;used to hold the number to return
	push		r10			;used to hold the index of the sign if there is one
	;	check if str or base are null
	;---------------------------------------------------
	mov			rax, 0
	cmp			rdi, 0
	je			_quit
	cmp			rsi, 0
	je			_quit
	;	get base number and store it in r8
	;---------------------------------------------------
	push		rdi
	mov			rdi, rsi
	call		_ft_strlen
	pop			rdi
	mov			r8, rax
	;	initialising registers to be used in convert_base
	;---------------------------------------------------
	mov			rcx, -1
	mov			rdx, 0
	call		_traverse_white_spaces	;rcx initialised to the last white space
	mov			r10, 0
	call		_manage_sign			;rcx incremented the sign if there is one
	cmp			r10, -1
	je			_quit
	mov			r10, rcx
	mov			r9, 0
	call		_convert_to_base
	;	restore the used registers
	;---------------------------------------------------
	;call		_quit
	;ret
	pop			r10
	pop			r9
	pop			r8
	pop			rcx
	pop			rdx
	ret

_quit :
	pop			r10
	pop			r9
	pop			r8
	pop			rcx
	pop			rdx
	ret

;increment the counter to the last white space
;=======================================================
_traverse_white_spaces :
	inc			rcx
	mov			dl, byte[rdi + rcx]
	cmp			dl, 7
	jg			_check_tabs
	call		_traverse_white_spaces
	ret

_check_tabs :
	cmp			dl, 12
	jl			_traverse_white_spaces
	cmp			dl, 32
	jne			_return_counter
	call		_traverse_white_spaces
	ret

_return_counter :
	ret
;=======================================================

;store the sign in r10 : 1 ->positive || 0 ->negative | -1 ->error
;=======================================================
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
;=======================================================


;convert c to the right index and add it to ret
;=======================================================
_convert_to_base :
	;	preserve the necessary registers
	;---------------------------------------------------
	push		rdi
	push		rsi
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
	;---------------------------------------------------
	pop			rsi
	pop			rdi
	call		_convert_to_base
	ret

_return_result:
	pop			rsi
	pop			rdi
	mov			rax, r9
	ret
;=======================================================


;int	get_index(char *str, char c);
;=======================================================
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
;=======================================================


;	ft_strlen : to get the base
;=======================================================
_ft_strlen:
	mov			rax, -1
	push		rdx
	call		_check_end_str
	pop			rdx
	ret

_check_end_str:
	inc			rax
	mov			dl, byte[rdi + rax]
	cmp			dl, 0
	jne			_check_end_str
	ret
;=======================================================

