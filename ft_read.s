extern	___error

section .text

global	_ft_read

_ft_read:
	mov			rax, 0x2000003
	syscall
	jc			_manage_error
	ret

_manage_error:
	push		r8
	mov			r8, rax
	call		___error
	mov			[rax], r8
	mov			rax, -1
	pop			r8
	ret
