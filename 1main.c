/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/10 11:17:34 by yarroubi          #+#    #+#             */
/*   Updated: 2021/02/22 17:14:41 by yarroubi         ###   ########.fr       */
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


///int		foo(int a, int b, int c);
int		foo(char *str, int a);

int main()
{
	char	str[] = "hello world!!!\n";
	char	str2[] = "HELLO world!!!\n";


	char	ptr[20];
	//printf("ret = %lu\n", read(1, 0, -2));
	//printf("ret = %lu\n", ft_read(0, 0, -2));
	//printf("p = %s\n", ft_strdup(str));

	//printf("ret = %d\n", ft_atoi_base("        \v\t\n\r    15963", "123456789abcdefgrty"));

	//printf("ret = %d\n", convert_to_base("12459973", "0123456789"));
	
	//printf("ret = %p\n", ft_malloc(12));
	//printf("ret = %llu\n", (unsigned long long)ft_malloc(15));
	
	//printf("ret = %d\n", foo(1,2,3));
	foo("num = %d\n", 3);

	printf("error = %s\n", strerror(errno));
	return (0);
}
