(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Game.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:41 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 18:12:26 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let input_player board players (get_input, _, _) =
	if (Player.string_of_player players) = "" then
		IA.get_input board
	else
		get_input board

let win players owner =
	if (Player.type_of_player players) = owner then
		players
	else
		Player.next players

let rec game_loop board players ((_, print, draw) as ui) =
	print ((Player.string_of_player players) ^ " ("
		^ (String.make 1 (Player.char_of_player players)) ^ ") play");
	let move = input_player board players ui in
	let board = MainBoard.inject_input board move (Player.type_of_player players) in
	draw board;
	match board with
	| Board.Owned (p)	-> win players p
	| _					-> game_loop board (Player.next players) ui

let start player1 player2 ((_, print, draw) as ui) =
	print ("Game start with " ^ player1 ^ " and " ^ player2);
	let board = Board.emptyMain in
	draw board;
	game_loop board (Player.new_players player1 player2) ui
