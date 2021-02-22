/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_lst.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: youness <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/18 15:41:10 by youness           #+#    #+#             */
/*   Updated: 2021/02/22 18:41:12 by yarroubi         ###   ########.fr       */
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
void	ft_list_push_front(t_list **begin_list, void *data);
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());


int main()
{
	char	strings[9][10];
	char	str[] = "lst0";

	for (int i = 0; i < 9; i++)
	{
		strcpy(strings[i], str);
		strings[i][3] = i + '0';
	}
	t_list	*lst = 0;

	int size = 5;
	for (int i = 0; i < size; i++)
		ft_list_push_front(&lst, strings[size - i]);
		

	for (t_list *ptr = lst; ptr; ptr = ptr->next)
		printf("lst = %s\t|\t%p\n", (char *)ptr->data, ptr);

	printf("\n\n\n");
	for (int i = 0; i < size; i++)
		ft_list_remove_if(&lst, strings[i + 1], strcmp);
	for (t_list *ptr = lst; ptr; ptr = ptr->next)
		printf("lst = %s\n", (char *)ptr->data);
	printf("%s\n", strerror(errno));
}
