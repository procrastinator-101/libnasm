_traverse_white_spaces :
	inc			rcx
	mov			dl, byte[rdi + rcx]
	cmp			dl, 7
	jg			_check_tabs
	call		_traverse_white_spaces
	ret

_check_tabs :
	cmp			dl, 12
	jl			_traverse_white_spaces
	cmp			dl, 32
	jne			_return_counter
	call		_traverse_white_spaces
	ret

_return_counter :
	ret
