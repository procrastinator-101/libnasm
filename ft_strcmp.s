section .text

global	_ft_strcmp

_ft_strcmp:
		mov			rcx, -1
		mov			rax, 0
		call		_compare
		ret

_compare:
		inc			rcx
		mov			al, byte[rdi + rcx]
		cmp			al, 0
		je			_return
		cmp			al, byte[rsi + rcx]
		je			_compare

_return:
		movzx		rcx, byte[rsi + rcx]
		sub			rax, rcx
		ret
