(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:42 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 09:20:17 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec get_input b =
	let x = Utils.prompt_int "Position X" - 1 in
	let y = Utils.prompt_int "Position Y" - 1 in
	if x < 0 || x > 9 || y < 0 || y > 9 then begin
		print_endline "Bad position. Please try again"; get_input b
	end else begin
		if (Board.owner b (x, y)) <> (Board.Owned Owner.No) then begin
			print_endline "Already acccuupiiede. Please try again"; get_input b
		end else
			(x, y)
	end

let draw b = Debug.print_board b
