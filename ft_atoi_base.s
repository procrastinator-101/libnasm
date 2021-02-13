section .text

global _ft_atoi_base

_ft_atoi_base :
	;	preserve the necessary registers
	;---------------------------------------------------
	push		rdx
	push		rcx
	push		r8
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
	;	done storing base number in r8
	;---------------------------------------------------
	mov			rax, 0
	mov			rcx, -1
	mov			rdx, 0
	call		_convert_to_base
	;	restore the used registers
	;---------------------------------------------------
	pop			r8
	pop			rcx
	pop			rdx


_convert_to_base :
	inc			rcx
	mov			


;int	get_index(char *str, char c);
;=======================================================
_get_index :
	push		rcx
	push		rdx
	mov			rcx, -1
	mov			rdx, 0
	call		_find_char
	pop			rdx
	pop			rcx
	ret

_find_char :
	inc			rcx
	mov			dl, byte[rdi + rcx]
	cmp			dl, 0
	je			_return_index_error
	cmp			dl, byte[rsi]
	je			_return_index
	call		_find_char
	ret

_return_index :
	mov			rax, rcx
	ret

_return_index_error :
	mov			rax, -1
	ret
;=======================================================


;	subroutines for math calculations
;=======================================================
_ft_mul :
	mov		rax, rdi
	mul		rsi
	ret

_ft_add :
	mov		rax, rdi
	add		rax, rsi
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

_quit :
	pop			rcx
	pop			rdx
	pop			r8
	ret
