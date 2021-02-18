extern malloc

section .text

global	ft_strdup

;======================================================================
ft_strdup:
;	reserve registers
;----------------------------------------------------------------------
	push		r8
	push		r9
;----------------------------------------------------------------------
;	get the size of str and store it in r8
;----------------------------------------------------------------------
	call		_ft_strlen
	inc			rax
	mov			r8, rax
;----------------------------------------------------------------------

;	allocate size bytes and store the pointer in r9
;----------------------------------------------------------------------
	push		rdi
	mov			rdi, r8
	call		malloc
	pop			rdi
	jc			_manage_allocation_failure
	mov			r9, rax
;----------------------------------------------------------------------

;	copy str in the allocated region
;----------------------------------------------------------------------
	mov			rsi, rdi
	mov			rdi, r9
	call		_ft_strcpy
;----------------------------------------------------------------------

;	restore the reserved registers and return
;----------------------------------------------------------------------
	pop			r9
	pop			r8
	ret
;----------------------------------------------------------------------

_manage_allocation_failure :
	mov			rax, 0
	pop			r9
	pop			r8
	ret
;======================================================================
	
;======================================================================
_ft_strlen:
	mov			rax, -1
	mov			rdx, 0
	call		_check_end_str
	ret

_check_end_str:
	inc			rax
	mov			dl, byte[rdi + rax]
	cmp			dl, 0
	jne			_check_end_str
	ret
;======================================================================

;======================================================================
_ft_strcpy:
	mov			rcx, -1
	mov			rax, 0
	call		_copy
	mov			rax, rdi
	ret

_copy:
	inc			rcx
	mov			al, byte[rsi + rcx]
	mov			byte[rdi + rcx], al
	cmp			al, 0
	jne			_copy
	ret
;======================================================================
