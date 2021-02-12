section .text

global _ft_strlen

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
