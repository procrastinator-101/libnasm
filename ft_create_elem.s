extern _malloc

section .text

global _ft_create_elem

_ft_create_elem :
	push		rdi
	mov			rdi, 16
	call		_malloc
	pop			rdi
	cmp			rax, 0
	je			_quit
	mov			[rax], rdi
	mov			rdx, 0
	mov			[rax + 8], rdx

_quit :
	ret
