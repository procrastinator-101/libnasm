section .text

global _ft_strcpy

_ft_strcpy:
	mov			rax, rdi
	mov			rdx, 0
	mov			rcx, -1
	call		_copy
	ret

_copy:
	inc			rcx
	mov			dl, byte[rsi + rcx]
	mov			byte[rdi + rcx], dl
	cmp			dl, 0
	jne			_copy
	ret
