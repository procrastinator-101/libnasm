extern _free

section .text

global _ft_list_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
;======================================================================
_ft_list_remove_if :
;	check if begin_list and cmp are null and if the list is empty
;----------------------------------------------------------------------
	cmp			rdi, 0
	je			_quit
	cmp			qword[rdi], 0
	je			_quit
	cmp			rdx, 0
	je			_quit
;----------------------------------------------------------------------
	
	push		r12
	mov			r12, 0						;to hold the ofset to the stored region
	sub			rsp, 40						;reserve 32 bytes on the stack
	mov			[rsp + 32], rdi				;to hold the begin_list
	mov			[rsp + 24], rsi				;to hold the data_ref
	mov			[rsp + 16], rdx				;to hold the cmp pointer
	mov			qword[rsp + 8], 0			;to hold the previous elem
	mov			rdx, [rdi]
	mov			[rsp], rdx					;to hold the current elem
	call		_find_and_delete


_find_and_delete :
	add			r12, 8						;add the return address size to the offset
	mov			rdi, [rsp + r12]			;store the current elem.data in rdi
	cmp			rdi, 0
	je			_quit
	mov			rdi, [rdi]
	mov			rdx, [rsp + r12 + 16]		;get the data_ref
	call		rdx
	cmp			rax, 0
	je			_remove_elem
	mov			rdx, [rsp + r12]
	mov			[rsp + r12 + 8], rdx		;update the previous elem
	mov			rcx, [rdx + 8]
	mov			[rsp + r12], rcx			;update the current elem
	call		_find_and_delete

_quit :
	ret
;======================================================================

;======================================================================
_remove_elem :
	mov			rdx, [rsp + r12]			;get the current elem
	mov			rax, [rsp + r12 + 32]		;get the begin_list
	cmp			rdx, [rax]					;check if the current elem is at the front of the list
	je			_remove_at_front
	mov			rcx, [rsp + r12 + 8]		;get the previous elem
	mov			rax, [rdx + 8]				;get the next elem
	mov			[rsp + r12], rax			;update the current elem
	mov			[rcx + 8], rax				;update the previous elem'next
	mov			rdi, rdx
	call		_free
	call		_find_and_delete
	ret

_remove_at_front :
	mov			rdi, [rsp + r12]
	mov			rcx, [rsp + r12 + 32]
	mov			rax, [rdi + 8]
	mov			[rcx], rax
	call		_free
	ret
;======================================================================
