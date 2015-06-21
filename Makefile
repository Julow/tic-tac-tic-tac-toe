# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/21 16:32:10 by ngoguey          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := tic-tac-tic-tac-toe

OBJS_DIR := bin
SRCS_DIR := srcs
INCS_DIR := srcs

SRCS :=	Utils.ml Owner.ml Player.ml \
		Board.ml MainBoard.ml \
		Debug.ml \
		Ncurses.ml IA.ml \
		Game.ml main.ml

BYT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmo))
OPT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmx))
INC_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmi))

all: $(NAME)

$(NAME): opt

byt: $(INC_OBJS) $(BYT_OBJS)
	ocamlc -g -o $(NAME) $(BYT_OBJS)

opt: $(INC_OBJS) $(OPT_OBJS)
	ocamlopt -o $(NAME) $(OPT_OBJS)

.depend: Makefile
	ocamldep -I $(INCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) | sed -E 's/$(SRCS_DIR)|$(INCS_DIR)/$(OBJS_DIR)/g' > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlc -g -I $(OBJS_DIR) -o $@ -c $<

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlopt -I $(OBJS_DIR) -o $@ -c $<

$(INC_OBJS): $(OBJS_DIR)/%.cmi: $(INCS_DIR)/%.mli $(OBJS_DIR)
	ocamlopt -I $(OBJS_DIR) -o $@ -c $<

$(OBJS_DIR):
	mkdir -p $@

clean:
	rm -f $(BYT_OBJS) $(OPT_OBJS) $(INC_OBJS)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re

-include .depend
