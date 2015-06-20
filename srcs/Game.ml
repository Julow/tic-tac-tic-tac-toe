(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Game.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:41 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 16:05:18 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec game_loop board player ((get_input, draw) as ui) =
	let board = MainBoard.inject_input board (get_input ()) player in
	match board with
	| Board.Owned (_)	-> print_string "end of game"
	| _					->
		draw board;
		game_loop board (Owner.next player) ui

let start player1 player2 ui =
	print_endline ("Game start with " ^ player1 ^ " and " ^ player2);
	game_loop Board.emptyMain Owner.P1 ui
