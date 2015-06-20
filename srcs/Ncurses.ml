(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:42 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 17:14:15 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let get_input b =
	let x = Utils.prompt_int "Position X" in
	let y = Utils.prompt_int "Position Y" in
	(x, y)

let draw b = Debug.print_board b
