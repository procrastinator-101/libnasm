section .text

global _traverse_white_spaces

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
	mov			dl, byte[rdi + rcx]
	cmp			dl, 0
	je			_return_counter
	cmp			dl, 32
	jne			_check_other_white_spaces
	call		_traverse_white_spaces__body
	ret

_check_other_white_spaces :
	cmp			dl, 8
	jg			_check_upper_bound
	call		_return_counter
	ret

_check_upper_bound :
	cmp			dl, 13
	jg			_return_counter
	call		_traverse_white_spaces__body
	ret

_return_counter :
	mov			rax, rcx
	ret
;======================================================================
