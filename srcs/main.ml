(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:53 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 18:13:05 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec get_gui () =
	match Utils.prompt_int "UI (1/1)" with
	| 1			->
		(Ncurses.init, Ncurses.get_input, Ncurses.print, Ncurses.draw, Ncurses.deinit)
	| _			->
		print_endline "Bad gui. Please retry"; get_gui ()

let rec start_game p1 p2 ((init, a, b, c, deinit) as ui) =
	init ();
	let winner = Game.start p1 p2 (a, b, c) in
	deinit ();
	print_endline ((Player.string_of_player winner) ^ " win the game");
	let re = Utils.prompt_int "Restart (0/1)" in
	if re = 0 then
		()
	else begin
		start_game p1 p2 ui;
	end

let () =
	let p1 = Utils.prompt_line "Player 1" true in
	let p2 = Utils.prompt_line "Player 2" false in
	if p1 = p2 then
		print_endline "Error player 1 and 2 have the same name"
	else
		start_game p1 p2 (get_gui ())
