(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   IA.ml                                              :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 16:25:38 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 19:11:31 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let triplets = [(0, 1, 2); (3, 4, 5); (6, 7, 8); (0, 3, 6);
				(1, 4, 7); (2, 5, 8); (0, 4, 8); (2, 4, 6)]
let owners = [Board.Owned Owner.P2; Board.Owned Owner.P1; Board.Owned Owner.No]
let sbindex = [0; 1; 2; 3; 4; 5; 6; 7; 8]

let get_input b =
  let foreach_subboards (x, y) sb sbi =
	let foreach_triplets (x, y) ((v, v', v'') as t) =
	  let best_cell = function
		(* | []					-> (-1, -1) *)
		| Board.Owned fst::Board.Owned sec::Board.Owned ter::_
			 when fst = Owner.No && sec <> Owner.No && sec = ter
		  -> MainBoard.getcell_xy sbi v
		| Board.Owned fst::Board.Owned sec::Board.Owned ter::_
			 when sec = Owner.No && fst <> Owner.No && fst = ter
		  -> MainBoard.getcell_xy sbi v'
		| Board.Owned fst::Board.Owned sec::Board.Owned ter::_
			 when ter = Owner.No && fst <> Owner.No && sec = fst
		  -> MainBoard.getcell_xy sbi v''
		| _					-> (-1, -1)							 
	  in
	  if (x > -1) then
		(x, y)
	  else
		best_cell (MainBoard.getSbTriplet b sbi t)
	in	
	if (x > -1) then
	  (x, y)
	else
	  List.fold_left foreach_triplets (-1, -1) triplets
  in
  let foreach_owners (x, y) o =
	if (x > -1) then
	  (x, y)
	else if o = Board.Owned Owner.No then
	  (3, 3) (* pick random *)
	else
	  match b with
	  | Board.Playing l	-> List.fold_left2 foreach_subboards (-1, -1) l sbindex
	  | _				-> failwith "Game is over"
  in
  match b with
  | Board.Playing _     -> List.fold_left foreach_owners (-1, -1) owners
  | _                   -> failwith "Game is over"
