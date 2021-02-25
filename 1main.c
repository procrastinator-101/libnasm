/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/10 11:17:34 by yarroubi          #+#    #+#             */
/*   Updated: 2021/02/25 14:49:21 by yarroubi         ###   ########.fr       */
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

int main()
{
	char	str[] = "hello world!!!";
	char	str2[] = "HELLO world!!!";


	char	ptr[20];
	char	ptr2[20];
	
	

	//printf("ret = %llX\n", multi(0xffffffffffffffff, 0xffffffffffffffff));
	printf("error = %s\n", strerror(errno));
	return (0);
}
