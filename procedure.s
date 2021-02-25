section .text

global _my_cmp

_my_cmp :
	push	rdi
	call	rdx
	pop		rdi
	cmp		eax, 0
	jl		_return_g
	mov		rax, 1
	ret

_return_g :
	mov		rax, -1
	ret
