# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yarroubi <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/12 16:45:40 by yarroubi          #+#    #+#              #
#    Updated: 2021/04/24 13:58:36 by yarroubi         ###   ########.fr        #
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

SRC_BONUS = ft_atoi_base.s \
			ft_list_push_front.s \
			ft_list_remove_if.s \
			ft_list_size.s \
			ft_list_sort.s

ifdef	BONUS
	OBJ = $(SRC:.s=.o) $(SRC_BONUS:.s=.o)
else
	OBJ = $(SRC:.s=.o)
endif


.PHONY :  clean fclean re

all : $(NAME)

bonus :
	@$(MAKE) BONUS=1 all

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

clean_bonus :
	@$(MAKE) BONUS=1 clean


fclean_bonus :
	@$(MAKE) BONUS=1 fclean

re_bonus : fclean_bonus bonus
