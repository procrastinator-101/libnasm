/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/23 17:19:12 by yarroubi          #+#    #+#             */
/*   Updated: 2021/02/25 15:02:05 by yarroubi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stdio.h>
# include <string.h>
# include <errno.h>
# include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

ssize_t				ft_read(int fildes, void *buf, size_t nbyte);
ssize_t				ft_write(int fildes, const void *buf, size_t nbyte);

int					ft_strcmp(char *s1, char *s2);
size_t				ft_strlen(char *str);

char				*ft_strdup(const char *s1);
char				*ft_strcpy(const char *dst, const char *src);

int					ft_atoi_base(char *str, char *base);

int					ft_list_size(t_list *begin_list);
void				ft_list_push_front(t_list **begin_list, void *data);
void				ft_list_remove_if(t_list **begin_list, void *data_ref, \
					int (*cmp)());
void				ft_list_sort(t_list **begin_list, int (*cmp)());

#endif
