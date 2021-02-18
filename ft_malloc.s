extern malloc

section .text

global ft_malloc

ft_malloc :
	push		rdi
	push		rdi
	call		malloc
	pop			rdi
	pop			rdi
	ret
