extern _free

section .text

global _ft_list_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
;======================================================================
_ft_list_remove_if :
;	check if the arguments are valid
;----------------------------------------------------------------------
	cmp			rdi, 0						;check if begin_list is empty
	je			_quit
	cmp			qword[rdi], 0				;check if the list is empty
	je			_quit
	cmp			rdx, 0						; check if the cmp pointer is invalid
	je			_quit
;----------------------------------------------------------------------
	
;----------------------------------------------------------------------
	push		r12
	mov			r12, 0						;to hold the ofset to the stored region
	sub			rsp, 40						;reserve 40 bytes on the stack
	mov			[rsp + 32], rdi				;to hold the begin_list
	mov			[rsp + 24], rsi				;to hold the data_ref
	mov			[rsp + 16], rdx				;to hold the cmp pointer
	mov			qword[rsp + 8], 0			;to hold the previous elem
	mov			rdx, [rdi]
	mov			[rsp], rdx					;to hold the current elem
	call		_find_and_delete
	add			rsp, 40
	pop			r12
	ret
;----------------------------------------------------------------------
;======================================================================


;======================================================================
_find_and_delete :
;check if end of the list is reached
;----------------------------------------------------------------------
	add			r12, 8						;add the return address size to the offset
	mov			rdi, [rsp + r12]			;store the current elem in rdi
	cmp			rdi, 0
	je			_quit
;----------------------------------------------------------------------

;----------------------------------------------------------------------
	mov			rdi, [rdi]					;store the current elem.data in rdi
	mov			rsi, [rsp + r12 + 24]		;get the data ref
	mov			rdx, [rsp + r12 + 16]		;get the cmp pointer
;----------------------------------------------------------------------

;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;	align the stack
;----------------------------------------------------------------------
	push		r13
	mov			r13, rdx

	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------
	call		r13
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
	pop			r13
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	cmp			rax, 0
	je			_remove_elem
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	mov			rdx, [rsp + r12]
	mov			[rsp + r12 + 8], rdx		;update the previous elem
	mov			rcx, [rdx + 8]
	mov			[rsp + r12], rcx			;update the current elem
;----------------------------------------------------------------------
	call		_find_and_delete

_quit :
	ret
;======================================================================


;======================================================================
_remove_elem :
;check is current element is at the front if the list and remove it
;----------------------------------------------------------------------
	mov			rdi, [rsp + r12]			;get the current elem
	mov			rax, [rsp + r12 + 32]		;get the begin_list
	cmp			rdi, [rax]					;check if the current elem is at the front of the list
	je			_remove_at_front
;----------------------------------------------------------------------

;remove the elem if it is not at the front if the list
;----------------------------------------------------------------------
	mov			rax, [rdi + 8]				;get the next elem
	mov			[rsp + r12], rax			;update the current elem
	mov			rcx, [rsp + r12 + 8]		;get the previous elem
	mov			[rcx + 8], rax				;update the previous elem'next
;----------------------------------------------------------------------

;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;	align the stack
;----------------------------------------------------------------------
	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------
	call		_free
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	call		_find_and_delete
	ret

_remove_at_front :
;----------------------------------------------------------------------
	mov			rcx, [rdi + 8]
	mov			[rsp + r12], rcx			;update the current elem
	mov			[rax], rcx					;update the begin_list
;----------------------------------------------------------------------

;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;	align the stack
;----------------------------------------------------------------------
	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------
	call		_free
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	call		_find_and_delete
	ret
;======================================================================


;	8 if not aligned | 0 otherwise
;======================================================================
_get_alignment_offset :
;	store the rsp % 16 in rax
;----------------------------------------------------------------------
	mov			rdx, 0
	mov			rax, rsp
	mov			rcx, 16
	div			rcx
;----------------------------------------------------------------------

;	rax == 0 -> not aligned (return address of align_stack)
;----------------------------------------------------------------------
	cmp			rdx, 0
	je			_update_offset
	mov			rax, 0
	ret
;----------------------------------------------------------------------

_update_offset :
	mov			rax, 8
	ret
;======================================================================
