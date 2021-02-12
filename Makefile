# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/12 16:45:40 by yarroubi          #+#    #+#              #
#    Updated: 2021/02/12 17:52:02 by yarroubi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

AUTHOR		= yarroubi

NAME		= libasm.a

CC			= nasm

FLAGS		= -f macho64

SRC	= ft_read.s \
	  ft_strcmp.s \
	  ft_strcpy.s \
	  ft_strdup.s \
	  ft_strlen.s \
	  ft_write.s

OBJ = $(SRC:.s=.o)

.PHONY :  clean fclean re

all : $(NAME)

$(NAME) : $(OBJ)
	@ar rc $@ $^
	@ranlib $@

%.o:%.s
	$(CC) $(FLAGS) -o $@ $<

clean :
	@rm -rf $(OBJ)

fclean : clean
	@rm -rf $(NAME)

re : fclean all
