section .text

global _multi

_multi :
	mov		rax, rdi
	imul		rsi
	mov		rax, rdx
	ret
