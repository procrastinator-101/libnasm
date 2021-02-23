/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_lst.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: youness <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/18 15:41:10 by youness           #+#    #+#             */
/*   Updated: 2021/02/23 18:10:51 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

static int	compare(int *a, int *b)
{
	return (*a - *b);
}

static void	print_lst_str(t_list *tail)
{
	while (tail)
	{
		printf("lst = %s\n", (char *)tail->data);
		tail = tail->next;
	}
	printf("\n\n");
}

static void	test1_ft_list_functions(void)
{
	int		i;
	int		size;
	char	*str;
	t_list	*lst;

	i = -1;
	lst = 0;
	size = 10;
	while (++i < size)
	{
		str = ft_strdup("lst0");
		str[3] = i + '0';
		ft_list_push_front(&lst, str);
	}
	print_lst_str(lst);
	printf("lst_size = %d\n\n", ft_list_size(lst));
	ft_list_sort(&lst, ft_strcmp);
	print_lst_str(lst);
	i = -1;
	str = ft_strdup("lst0");
	while (++i < 3)
	{
		str[3] = i + '0';
		ft_list_remove_if(&lst, str, strcmp);
	}
	print_lst_str(lst);
}

static void	print_lst_num(t_list *tail)
{
	while (tail)
	{
		printf("num = %d\n", *((int *)tail->data));
		tail = tail->next;
	}
	printf("\n\n");
}

static void	test2_ft_list_functions(void)
{
	int		i;
	int		size;
	int		*num;
	t_list	*lst;

	i = -1;
	lst = 0;
	size = 10;
	while (++i < size)
	{
		num = malloc(sizeof(int));
		*num = i;
		ft_list_push_front(&lst, num);
	}
	print_lst_num(lst);
	printf("lst_size = %d\n\n", ft_list_size(lst));
	ft_list_sort(&lst, compare);
	print_lst_num(lst);
	i = -1;
	while (++i < size)
		ft_list_remove_if(&lst, &i, strcmp);
	print_lst_num(lst);
}

int			main(void)
{
	test1_ft_list_functions();
	test2_ft_list_functions();
	printf("%s\n", strerror(errno));
}
