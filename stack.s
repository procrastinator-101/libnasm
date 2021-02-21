section .text

global _foo

_foo :
	push	r12
	mov		r12, 0
	sub		rsp, 24
	mov		[rsp + 16], rdx
	mov		[rsp + 8], rsi
	mov		[rsp], rdi
	call	_bar
	add		rsp, 24
	pop		r12
	ret

_bar :
	add		r12, 8
	cmp		r12, 40
	mov		rax, [rsp + r12]
	je		_quit
	call	_bar

_quit :
	ret
