# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/20 11:16:05 by jaguillo          #+#    #+#              #
#    Updated: 2015/06/21 19:08:54 by jaguillo         ###   ########.fr        #
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
		Ncurses.ml IA.ml \
		Game.ml main.ml

BYT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmo))
OPT_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmx))
INC_OBJS := $(addprefix $(OBJS_DIR)/,$(SRCS:.ml=.cmi))

all: $(OBJS_DIR) $(NAME)

$(NAME): $(OBJS_DIR)/$(NAME).byt $(OBJS_DIR)/$(NAME).opt
	@ln -sf $(OBJS_DIR)/$(NAME).opt $@
	@echo "Done"

byt: $(OBJS_DIR)/$(NAME).byt
$(OBJS_DIR)/$(NAME).byt: $(INC_OBJS) $(BYT_OBJS)
	@ocamlc $(LIBS) -g -o $@ ~/.opam/system/lib/curses/curses.cma $(BYT_OBJS)
	@ln -sf $(OBJS_DIR)/$(NAME).byt $(NAME)
	@echo "$@"

opt: $(OBJS_DIR)/$(NAME).opt
$(OBJS_DIR)/$(NAME).opt: $(INC_OBJS) $(OPT_OBJS)
	@ocamlopt $(LIBS) -o $@ ~/.opam/system/lib/curses/curses.cmxa $(OPT_OBJS)
	@ln -sf $(OBJS_DIR)/$(NAME).opt $(NAME)
	@echo "$@"

.depend: Makefile
	@ocamldep -I $(SRCS_DIR) $(addprefix $(SRCS_DIR)/,$(SRCS)) | sed -E 's/$(SRCS_DIR)/$(OBJS_DIR)/g' > .depend

$(BYT_OBJS): $(OBJS_DIR)/%.cmo: $(SRCS_DIR)/%.ml
	@ocamlc -g $(FLAGS) -o $@ -c $<
	@echo "$<"

$(OPT_OBJS): $(OBJS_DIR)/%.cmx: $(SRCS_DIR)/%.ml
	@ocamlopt $(FLAGS) -o $@ -c $<
	@echo "$<"

$(INC_OBJS): $(OBJS_DIR)/%.cmi: $(SRCS_DIR)/%.mli
	@ocamlopt -I $(OBJS_DIR) -o $@ -c $<
	@echo "$<"

$(OBJS_DIR):
	@mkdir -p $@

clean:
	@rm -f $(BYT_OBJS) $(OPT_OBJS) $(INC_OBJS)

fclean: clean
	@rm -f $(NAME) $(OBJS_DIR)/$(NAME).opt $(OBJS_DIR)/$(NAME).byt

re: fclean all

.PHONY: all clean fclean re

-include .depend
