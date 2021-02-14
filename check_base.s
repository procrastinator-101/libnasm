section .text

global	_check_base

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
	;reserve rcx --> used unside check_repetitiveness
	push		rcx
	;initialising it to be used inside check_repetitiveness
	mov			rax, 0
	call		_check_repetitiveness
	;restore rcx
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
