/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/10 11:17:34 by yarroubi          #+#    #+#             */
/*   Updated: 2021/04/25 11:46:41 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <limits.h>
#include <unistd.h>

#include "libasm.h"

int			compare(int *a, int *b)
{
	int	ret;

	ret = 0;
	if (*a > *b)
		ret = 1;
	else if (*a < *b)
		ret = -1;
	return (ret);
}

void	print_lst(t_list *tail, char type)
{
	printf("\n=====================================================\n");
	while (tail)
	{
		if (type == 'i')
			printf("num = %d\n", *((int *)tail->data));
		else
			printf("str = %s\n", (char *)tail->data);
		tail = tail->next;
	}
	printf("=====================================================\n\n");
}

void test2_ft_list_functions(void)
{
	int     i;
	int     size;
	int     *num;
	t_list  *lst;

	i = -1;
	lst = 0;
	int	arr[] = {1, 5, -10, 59, 18, INT_MAX, 20, 17, -25698, 0, 5, 1, 59, 18};
	size = sizeof(arr) / sizeof(int);
	while (++i < size)
	{
		num = malloc(sizeof(int));
		//scanf("%d", num);
		*num = arr[i];
		ft_list_push_front(&lst, num);
	}
	print_lst(lst, 'i');
	printf("lst_size = %d\n\n", ft_list_size(lst));
	printf("size     = %d\n", size);

	ft_list_sort(&lst, compare);
	print_lst(lst, 'i');
	
	i = -1;
	while (++i < size)
	{
		if (i % 2)
			ft_list_remove_if(&lst, arr + i, compare);
	}
	print_lst(lst, 'i');
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
		str = ft_strdup("lst..");
		str[3] = i % 2 ? 'a' + i : 'A' + i;
		ft_list_push_front(&lst, str);
	}
	print_lst(lst, 'c');
	/*
	printf("lst_size = %d\n\n", ft_list_size(lst));
	ft_list_sort(&lst, ft_strcmp);
	print_lst(lst, 'c');
	*/
	i = -1;
	while (++i < size)
	{
		str = ft_strdup("lst..");
		str[3] = i % 2 ? 'a' + i : 'A' + i;
		printf("ref = %s\n", str);
		if (!(i % 2))
			ft_list_remove_if(&lst, str, ft_strcmp);
	}
	print_lst(lst, 'c');
	
}

int main()
{
	char	str[] = "hello world!!!\n";
	char	str2[] = "hello world!!!\n";



	int a = 10;
	int b = 15;
	//printf("ret = %d\n", my_cmp(&a, &b, compare));
	//str[ft_strlen(str)] = '0';
	//char ptr[] = "    \t\t\t\n\n\n  -125";


	test2_ft_list_functions();
	test1_ft_list_functions();

	//system("leaks test");
	//printf("ret = %llX\n", multi(0xffffffffffffffff, 0xffffffffffffffff));
	return (0);
}
