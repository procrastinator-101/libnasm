extern	___error

section .text

global	_ft_read

_ft_read:
	mov			rax, 0x2000003
	syscall
	jc			_manage_error
	ret

_manage_error:
	push		rax
	call		___error
	pop			r8
	mov			[rax], r8
	mov			rax, -1
	ret
