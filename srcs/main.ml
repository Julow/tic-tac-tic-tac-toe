(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:53 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 18:45:17 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec get_gui () =
	match Utils.prompt_int "UI (1/2)" with
	| 1			-> (Ncurses.get_input, Ncurses.draw)
	| 2			-> ((fun b -> (0, 0)), (fun b -> ()))
	| _			-> print_endline "Bad gui. Please retry"; get_gui ()

let rec start_game p1 p2 ui =
	Game.start p1 p2 ui;
	let re = Utils.prompt_int "Restart (0/1)" in
	if re = 0 then
		()
	else
		start_game p1 p2 ui

let () =
	let p1 = Utils.prompt_line "Player 1" true in
	let p2 = Utils.prompt_line "Player 2" true in
	if p1 = p2 then
		print_endline "Error player 1 and 2 have the same name"
	else
		start_game p1 p2 (get_gui ())
