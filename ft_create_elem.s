extern malloc

section .text

global ft_create_elem

ft_create_elem :
	push		rdi
	mov			rdi, 16
	call		malloc
	pop			rdi
	cmp			rax, 0
	je			_quit
	mov			[rax], rdi
	mov			rdx, 0
	mov			[rax + 8], rdx

_quit :
	ret
