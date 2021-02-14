section .text

global _handle_sign

_handle_sign :
	push		r10
	push		r8
	mov			r8, 2
	mov			r10, 0
	call		_manage_sign
	mov			rax, r10

_quit :
	pop			r8
	pop			r10
	ret
	
_manage_sign :
	mov		dl, byte[rdi]
	cmp		dl, 43
	je		_check_base
	cmp		dl, 45
	je		_check_base
	ret

_check_base :
	cmp		r8, 10
	je		_set_sign
	mov		rax, 0
	mov		r10, -1
	ret

_set_sign :
	ret
