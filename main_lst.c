/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_lst.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: youness <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/18 15:41:10 by youness           #+#    #+#             */
/*   Updated: 2021/02/21 19:00:41 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;	
}					t_list;


t_list	*ft_create_elem(void *data);
void   ft_list_push_front(t_list **begin_list, void *data);
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());


int main()
{
	char	str[] = "lst1";
	char	str1[] = "lst2";
	char	str2[] = "lst3";
	char	str3[] = "lst4";
	t_list	*lst = 0;

	ft_list_push_front(&lst, str);

	ft_list_push_front(&lst, str1);
	ft_list_push_front(&lst, str2);
	ft_list_push_front(&lst, str3);
	
	for (t_list *ptr = lst; ptr; ptr = ptr->next)
		printf("lst = %s\n", (char *)ptr->data);

	printf("\n\n\n");
	ft_list_remove_if(&lst, "lst2", strcmp);
	for (t_list *ptr = lst; ptr; ptr = ptr->next)
		printf("lst = %s\n", (char *)ptr->data);
	printf("%s\n", strerror(errno));
}
