# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/20 14:11:18 by ngoguey          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := tic-tac-tic-tac-toe

OBJS_DIR := bin
SRCS_DIR := srcs
INCS_DIR := include

SRCS := $(shell ls -1 $(SRCS_DIR) | grep '.ml')

BYT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmo))
OPT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmx))

all: $(NAME)

$(NAME): $(NAME).byt $(NAME).opt

$(NAME).byt: $(BYT_OBJS)
	ocamlc -o $@ $^

$(NAME).opt: $(OPT_OBJS)
	ocamlopt -o $@ $^

.depend: Makefile
	ocamldep -I $(INCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml
	ocamlc -I $(INCS_DIR) -o $@ -c $<

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml
	ocamlopt -I $(INCS_DIR) -o $@ -c $<

$(INCS_DIR)/%.cmi: $(INCS_DIR)/%.mli
	ocamlopt -I $(INCS_DIR) -o $@ -c $<

clean:
	rm -f $(BYT_OBJS) $(OPT_OBJS)

fclean: clean
	rm -f $(NAME).byt $(NAME).opt .depend

re: fclean all

.PHONY: all clean fclean re

-include .depend
