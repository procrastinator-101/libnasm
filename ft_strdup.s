extern _malloc

section .text

global	_ft_strdup

_ft_strdup:
	;	push to stack to preserve their values
	;push		rcx
	;push		rsi
	;push		rdi
	;call		_ft_strlen
	;	size = len + 1
	inc			rax
	;	store the size in rcx to use it in copy subroutine
	;mov			rcx, rax
	;	pass the size to the first argument of malloc
	;mov			rdi, rax
	;call		_malloc
	;pop			rdi
	;jc			_manage_error
	ret

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

_manage_error:
	ret
