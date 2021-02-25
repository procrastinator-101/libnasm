/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_lst.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: youness <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/18 15:41:10 by youness           #+#    #+#             */
/*   Updated: 2021/02/25 17:41:26 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

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
		if (i == 5)
			str[3] = 2 + '0';
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
		ft_list_remove_if(&lst, str, ft_strcmp);
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
		*num = size - i;
		ft_list_push_front(&lst, num);
	}
	ft_list_push_front(&lst, &i);
	print_lst_num(lst);
	printf("lst_size = %d\n\n", ft_list_size(lst));
	ft_list_sort(&lst, compare);
	print_lst_num(lst);
	i = -1;
	while (++i < size)
		ft_list_remove_if(&lst, &i, compare);
	print_lst_num(lst);
}

int			main(void)
{
	size_t	ret;
	char	buffer[20];
	test1_ft_list_functions();
	test2_ft_list_functions();
	printf("len = %lu\n", ft_strlen("123456789"));
	printf("cmp = %d\n", ft_strcmp("abcdd", "abcde"));
	printf("buffer = %s\n", ft_strcpy(buffer, "hello world!!!"));
	
	ret = ft_read(0, buffer, 20);
	printf("%s\n", strerror(errno));
	printf("ret = %lu\n", ret);

	ret = ft_write(1, buffer, ret);
	printf("ret = %lu\n", ret);
	printf("%s\n", strerror(errno));
}
