/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/10 11:17:34 by yarroubi          #+#    #+#             */
/*   Updated: 2021/02/26 12:24:13 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);

int		ft_strcmp(char *s1, char *s2);
size_t	ft_strlen(char *str);

char	*ft_strcpy(const char *dst, const char *src);
char	*ft_strdup(const char *s1);

int		ft_atoi_base(char *str, char *base);

unsigned long long	multi(unsigned long long a, unsigned long long b);

int	my_cmp(int *a, int *b, int (*cmp)(int *, int *));


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

int main()
{
	char	str[] = "hello world!!!";
	char	str2[] = "HELLO world!!!";


	char	ptr[20];
	char	ptr2[20];

	int a = 10;
	int b = 15;
	//printf("ret = %d\n", my_cmp(&a, &b, compare));
	printf("ret = %d\n", ft_atoi_base("      -125f", "0123456789abcdef"));
	
	

	//printf("ret = %llX\n", multi(0xffffffffffffffff, 0xffffffffffffffff));
	printf("error = %s\n", strerror(errno));
	return (0);
}
