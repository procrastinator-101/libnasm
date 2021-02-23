section .text

global _ft_list_sort

;void	ft_list_sort(t_list **begin_list, int (*cmp)());
;======================================================================
_ft_list_sort :
;check if the arguments are valid
;----------------------------------------------------------------------
	cmp			rdi, 0					;check if the begin_list is null
	je			_quit
	cmp			qword[rdi], 0			;check if the list is empty
	je			_quit
	cmp			rsi, 0					;check if cmp is null
	je			_quit
;----------------------------------------------------------------------
	
;preserve the neccessary registers
;----------------------------------------------------------------------
	push		r12
	push		r13
	push		r14
	push		r15
	push		rbx
;----------------------------------------------------------------------

;----------------------------------------------------------------------
	mov			r12, rdi			;hold the begin_list
	mov			r15, rsi			;hold the cmp pointer
	mov			rbx, 0				;initailise the bigining of the sorted list to null
;----------------------------------------------------------------------

;----------------------------------------------------------------------
	call		_ft_bubble_sort
;----------------------------------------------------------------------

;----------------------------------------------------------------------
	pop			rbx
	pop			r15
	pop			r14
	pop			r13
	pop			r12
;----------------------------------------------------------------------

_quit :
	ret
;======================================================================


;======================================================================
_ft_bubble_sort :
;update the start node
;----------------------------------------------------------------------
	mov			r14, 0				;initialise the previous elem to null
	mov			r13, [r12]			;initialise the current elem to the first elem
	cmp			r13, rbx
	je			_quit
	call		_ft_sort_layer
	call		_ft_bubble_sort
	ret

;======================================================================


;======================================================================
_ft_sort_layer :
;----------------------------------------------------------------------
	mov			rsi, [r13 + 8]		;get the next elem
	cmp			rsi, rbx			;check if the end of the unsorted list is reached
	je			_return				;update rbx and return
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	mov			rdi,[r13]			;store current elem.data in rdi
	push		rsi					;save the next elem on the stack
	mov			rsi, [rsi]			;store the next elem.data in rsi
;----------------------------------------------------------------------

;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
;	align the stack
;----------------------------------------------------------------------
	push		r12
	call		_get_alignment_offset
	mov			r12, rax
	sub			rsp, rax
;----------------------------------------------------------------------
	call		r15
;----------------------------------------------------------------------
	add			rsp, r12
	pop			r12
;----------------------------------------------------------------------
;IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

;----------------------------------------------------------------------
	pop			rdi					;get the next elem
	cmp			rax, 0
	jg			_ft_swap_elem
;----------------------------------------------------------------------

;----------------------------------------------------------------------
	mov			r14, r13			;update the previous elem
	mov			r13, [r13 + 8]		;update the current elem
;----------------------------------------------------------------------
	call		_ft_sort_layer
	ret

_return :
	mov			rbx, r13
	ret
;======================================================================


;======================================================================
_ft_swap_elem :
;----------------------------------------------------------------------
	cmp			r13, [r12]			;check if the current elem is the tail of the list
	je			_ft_swap_tail
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	mov			[r14 + 8], rdi		;update the previous elem'next
	mov			rdx, [rdi + 8]
	mov			[r13 + 8], rdx		;update the current elem'next
	mov			[rdi + 8], r13		;update the next elem'next
;----------------------------------------------------------------------
;----------------------------------------------------------------------
	mov			r14, rdi			;update the previous elem
;----------------------------------------------------------------------
	call		_ft_sort_layer
	ret
;======================================================================

_ft_swap_tail :
;======================================================================
	mov			[r12], rdi			;update the tail of the list
	mov			rdx, [rdi + 8]
	mov			[r13 + 8], rdx		;update the current elem'next
	mov			[rdi + 8], r13		;update the tail'next
	mov			r14, rdi			;update the previous elem
	call		_ft_sort_layer
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
