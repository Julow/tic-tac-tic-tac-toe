(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Game.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:41:41 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 14:26:25 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(* let rec game_loop board p1 p2 ui = *)
	(* game_loop (MainBoard.inject_input (UI.get_input board)) p1 p2 ui *)

let start player1 player2 ui =
	print_endline ("Game start with " ^ player1 ^ " and " ^ player2 ^ " on UI " ^ ui)
	(* game_loop Boards.emptyMain player1 player2 ui *)
