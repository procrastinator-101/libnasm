section .text

global _ft_list_size

_ft_list_size:
	mov		rax, 0
	call	_get_size
	ret

_get_size:
	cmp		rdi, 0
	je		_quit
	inc		rax
	mov		rsi, [rdi + 8]
	mov		rdi, rsi
	call	_get_size

_quit:
	ret
