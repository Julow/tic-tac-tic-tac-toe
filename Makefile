# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/20 16:54:15 by ngoguey          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := tic-tac-tic-tac-toe

OBJS_DIR := bin
SRCS_DIR := srcs
INCS_DIR := include

SRCS :=	Utils.ml \
		Owner.ml Board.ml MainBoard.ml \
		Debug.ml \
		Ncurses.ml IA.ml \
		Game.ml main.ml

BYT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmo))
OPT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmx))

all: $(NAME)

$(NAME): opt

byt: $(BYT_OBJS)
	ocamlc -o $(NAME) $^

opt: $(OPT_OBJS)
	ocamlopt -o $(NAME) $^

.depend: Makefile
	ocamldep -I $(INCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) | sed -E 's/$(SRCS_DIR)|$(INCS_DIR)/$(OBJS_DIR)/g' > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlc -I $(OBJS_DIR) -o $@ -c $<

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlopt -I $(OBJS_DIR) -o $@ -c $<

$(OBJS_DIR):
	mkdir -p $@

clean:
	rm -f $(BYT_OBJS) $(OPT_OBJS)

fclean: clean
	rm -f $(NAME) .depend

re: fclean all

.PHONY: all clean fclean re

-include .depend
