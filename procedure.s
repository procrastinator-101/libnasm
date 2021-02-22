extern 	_printf

section .text

global _foo

_foo :
	mov		rax, [rel _printf]
	call	rax
	ret
