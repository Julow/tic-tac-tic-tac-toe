(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:42 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 18:10:11 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let cell_width = 10
let cell_height = 5

let add_player (board_x, board_y) i o (x_sel, y_sel) =
	let x', y' = (i mod 3 + board_x), (i / 3 + board_y) in
	let x'', y'' = (x' * cell_width), (y' * cell_height) in
	if x_sel = x' && y_sel = y' then begin
		Curses.attron (Curses.A.color_pair 12);
		ignore (Curses.mvaddch y'' x'' (int_of_char o));
		Curses.attron (Curses.A.color_pair 13)
	end else
		ignore (Curses.mvaddch y'' x'' (int_of_char o))

let init () =
	ignore (Curses.initscr ());
	ignore (Curses.start_color ());
	ignore (Curses.noecho ());
	ignore (Curses.curs_set 0);
	ignore (Curses.init_color 21 1000 1000 1000);
	ignore (Curses.init_color 20 0 0 0);
	ignore (Curses.init_pair 12 20 21);
	ignore (Curses.init_pair 13 21 20)

let deinit () = ignore (Curses.endwin ())

let rec draw_board pos i b sel =
	match b with
	| (Board.Owned head)::tail		->
		add_player pos i (Owner.char_of_owner head) sel;
		draw_board pos (i + 1) tail sel
	| _								-> ()

let rec draw_main_board b i sel =
	match b with
	| (Board.Playing (head))::tail  ->
		draw_board ((i mod 3 * 3), (i / 3 * 3)) 0 head sel;
		draw_main_board tail (i + 1) sel
	| head::tail	->
		draw_board ((i mod 3 * 3), (i / 3 * 3)) 0 (Board.owned_to_playing head) sel;
		draw_main_board tail (i + 1) sel
	| _								-> ()

let draw_sel b sel =
	Curses.erase () ;
	begin
		match b with
		| Board.Playing (lst)			-> draw_main_board lst 0 sel
		| _								-> ()
	end;
	ignore (Curses.refresh ())

let draw b = draw_sel b (-1, -1)

let rec get_sel b ((x, y) as sel) =
	draw_sel b sel;
	match Curses.getch () with
	| 67 when x < 8											-> get_sel b ((x + 1), y)
	| 68 when x > 0											-> get_sel b ((x - 1), y)
	| 66 when y < 8											-> get_sel b (x, (y + 1))
	| 65 when y > 0											-> get_sel b (x, (y - 1))
	| 10 when (Board.owner b (x, y)) = Board.Owned Owner.No	-> sel
	| _														-> get_sel b sel

let get_input b = get_sel b (0, 0)

let print msg = ignore (Curses.mvaddstr 0 0 msg)
