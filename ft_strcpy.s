section .text

global _ft_strcpy

_ft_strcpy:
	push		rcx
	mov			rcx, -1
	mov			rax, 0
	call		_copy
	pop			rcx
	;		put dst in the return reg
	mov			rax, rdi
	ret


_copy:
	inc			rcx
	mov			al, byte[rsi + rcx]
	mov			byte[rdi + rcx], al
	cmp			al, 0
	jne			_copy

_quit :
	ret
