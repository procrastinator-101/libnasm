extern	malloc

section .text

global ft_list_push_front

;void	ft_list_push_front(t_list **begin_list, void *data);
;======================================================================
ft_list_push_front :
;	check if begin_list is null
;----------------------------------------------------------------------
	cmp			rdi, 0
	je			_quit
;----------------------------------------------------------------------

;	create the new element
;----------------------------------------------------------------------
	push		rdi
	mov			rdi, rsi
	call		_ft_create_elem
	pop			rdi
	cmp			rax, 0
	je			_quit
;----------------------------------------------------------------------

;	add the new element at the front of lst
;----------------------------------------------------------------------
	mov			rdx, [rdi]
	mov			[rax + 8], rdx
	mov			[rdi], rax
;----------------------------------------------------------------------

_quit :
	ret
;======================================================================

;t_list	*ft_create_elem(void *data);
;======================================================================
_ft_create_elem :
	push		rdi
	mov			rdi, 16
	call		malloc
	pop			rdi
	cmp			rax, 0
	je			_allocation_failure
	mov			[rax], rdi
	mov			rdx, 0
	mov			[rax + 8], rdx
	ret

_allocation_failure :
	ret
;======================================================================
