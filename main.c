/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/10 11:17:34 by yarroubi          #+#    #+#             */
/*   Updated: 2021/02/12 16:41:17 by yarroubi         ###   ########.fr       */
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
char	*ft_strcpy(const char *dst, const char *src);
size_t	ft_strlen(char *str);

int main()
{
	char	str[] = "hello world!!!\n";
	char	str2[] = "HELLO world!!!\n";

	char	ptr[20];

	//printf("ret = %lu\n", read(1, ptr, 15));
	printf("ret = %lu\n", ft_read(0, ptr, 15));

	printf("error = %s\n", strerror(errno));

	return (0);
}
