# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/21 14:39:55 by jaguillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME := tic-tac-tic-tac-toe

OBJS_DIR := bin
SRCS_DIR := srcs
INCS_DIR := include

FLAGS := -I $(OBJS_DIR) -I ~/.opam/system/lib/curses
LIBS := -cclib -L/nfs/zfs-student-3/users/2014/jaguillo/.opam/system/lib/curses

SRCS := \
		Utils.ml Owner.ml Player.ml \
		Board.ml MainBoard.ml \
		Debug.ml \
		Ncurses.ml IA.ml \
		Game.ml main.ml

BYT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmo))
OPT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmx))

all: $(NAME)

$(NAME): opt

byt: $(BYT_OBJS)
	ocamlc ~/.opam/system/lib/curses/curses.cma $(LIBS) -o $(NAME) $^

opt: $(OPT_OBJS)
	ocamlopt ~/.opam/system/lib/curses/curses.cmxa $(LIBS) -o $(NAME) $^

.depend: Makefile
	ocamldep -I $(INCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) | sed -E 's/$(SRCS_DIR)|$(INCS_DIR)/$(OBJS_DIR)/g' > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlc $(FLAGS) -o $@ -c $<

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml $(OBJS_DIR)
	ocamlopt $(FLAGS) -o $@ -c $<

$(OBJS_DIR):
	mkdir -p $@

clean:
	rm -f $(BYT_OBJS) $(OPT_OBJS)

fclean: clean
	rm -f $(NAME) .depend

re: fclean all

.PHONY: all clean fclean re

-include .depend
