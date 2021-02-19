section .text

global _ft_list_remove_if

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());
;======================================================================
_ft_list_remove_if :
;	check if begin_list and cmp are null
;----------------------------------------------------------------------
	cmp			rdi, 0
	je			_quit
	cmp			rdx, 0
	je			_quit
;----------------------------------------------------------------------

;
;----------------------------------------------------------------------
	mov			rcx, [rdi]
;----------------------------------------------------------------------
_quit :
	ret

;======================================================================

_find_and_remove :
;allocate memory to use as temporary regiter holder
;----------------------------------------------------------------------
	sub			rsp, 40
	mov			[rsp + 32], rdi
	mov			[rsp + 24], rsi
	mov			[rsp + 16], rdx
	mov			[rsp + 8], rcx
	mov			[rsp], r8
;----------------------------------------------------------------------

	mov			rdi, [rcx + 8]
	mov			rsi, [rsp + 24]
	call		[rsp + 16]
	cmp			rax, 1

