extern  ___error

section .text

global	_ft_write

_ft_write:
	mov			rax, 0x2000004
	syscall
	jc			_manage_error
	ret

_manage_error:
	push		rax
	call		___error
	;	set errno
	pop			r8
	mov			[rax], r8
	mov			rax, -1
	ret
