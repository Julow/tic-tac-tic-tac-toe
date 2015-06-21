(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:42 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 16:40:57 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(*
** width = height
** height = widht
*)
let cell_width = 5
let cell_height = 10

let add_player (x, y) i o sel =
	let x', y' = (i mod 3 * cell_width + x), (i / 3 * cell_height + y) in
	ignore (Curses.mvaddch x' y' (int_of_char o))

let init () = ignore (Curses.initscr ())

let rec draw_board pos i b sel =
	match b with
	| (Board.Owned head)::tail		->
		add_player pos i (Owner.char_of_owner head) sel;
		draw_board pos (i + 1) tail sel
	| _								-> ()

let rec draw_main_board b i sel =
	match b with
	| (Board.Playing (head))::tail  ->
		draw_board ((i mod 3 * 3 * cell_width), (i / 3 * 3 * cell_height)) 0 head sel;
		draw_main_board tail (i + 1) sel
	| (Board.Owned (head))::tail	-> ()
	| _								-> ()

let draw_sel b sel =
	Curses.erase () ;
	begin
		match b with
		| Board.Playing (lst)			-> draw_main_board lst 0 sel
		| _								-> ignore (Curses.mvaddstr 0 0 "lol")
	end;
	Curses.refresh (); ()

let draw b = draw_sel b (-1, -1)

let rec get_input b =
	match Curses.getch () with
	| c									-> Curses.erase () ; Curses.mvaddch 0 0 c ; Curses.refresh (); (0, 0)
