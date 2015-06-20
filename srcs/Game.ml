(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Game.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:41 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 17:27:14 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec game_loop board players ((get_input, draw) as ui) =
	print_string ((Player.string_of_player players) ^ " (");
	print_char (Player.char_of_player players);
	print_endline ") play";
	let board = MainBoard.inject_input board (get_input board) (Player.type_of_player players) in
	draw board;
	match board with
	| Board.Owned (_)	->
		print_endline "End of game";
		print_string ((Player.string_of_player players) ^ " (");
		print_char (Player.char_of_player players);
		print_endline ") win !!";
	| _					-> game_loop board (Player.next players) ui

let start player1 player2 ui =
	print_endline ("Game start with " ^ player1 ^ " and " ^ player2);
	game_loop Board.emptyMain (Player.new_players player1 player2) ui
