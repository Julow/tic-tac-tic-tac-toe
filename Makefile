# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/21 16:46:08 by jaguillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := tic-tac-tic-tac-toe

OBJS_DIR := bin
SRCS_DIR := srcs

FLAGS := -I $(OBJS_DIR) -I ~/.opam/system/lib/curses
LIBS := -cclib -L$$HOME/.opam/system/lib/curses

SRCS := \
		Utils.ml Owner.ml Player.ml \
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
	ocamlc $(LIBS) -g -o $(NAME) ~/.opam/system/lib/curses/curses.cma $(BYT_OBJS)

opt: $(INC_OBJS) $(OPT_OBJS)
	ocamlopt $(LIBS) -o $(NAME) ~/.opam/system/lib/curses/curses.cmxa $(OPT_OBJS)

.depend: Makefile
	ocamldep -I $(SRCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) | sed -E 's/$(SRCS_DIR)|$(SRCS_DIR)/$(OBJS_DIR)/g' > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml $(SRCS_DIR)/%.mli $(OBJS_DIR)
	ocamlc -g $(FLAGS) -o $@ -c $<

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml $(SRCS_DIR)/%.mli $(OBJS_DIR)
	ocamlopt $(FLAGS) -o $@ -c $<

$(INC_OBJS): $(OBJS_DIR)/%.cmi: $(SRCS_DIR)/%.mli $(OBJS_DIR)
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
