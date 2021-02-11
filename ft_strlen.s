section .text

global _ft_strlen

_ft_strlen:
	mov		rax, -1
	call	_check_end_str
	ret

_check_end_str:
	inc		rax
	mov		dl, byte[rdi + rax]
	cmp		dl, 0
	jne		_check_end_str
	ret
