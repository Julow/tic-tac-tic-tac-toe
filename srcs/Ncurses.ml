(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:42 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 16:18:32 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let get_input () =
	let x = Utils.prompt_int "x" in
	let y = Utils.prompt_int "y" in
	(x, y)

let draw b = Debug.print_board b
