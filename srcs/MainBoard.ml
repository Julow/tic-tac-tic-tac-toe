(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   MainBoard.ml                                       :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:47:58 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 15:15:03 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(** b: MainBoard; *)
let update_state b =
  match b with
  | Board.Playing l							->
	 Board.update_state (Board.Playing (List.map Board.update_state l))
  | _										-> b

(** b: MainBoard;
 ** (x, y) Coords (0-8);
 ** o: Owner *)
let inject_input b (x, y) o =
  let subboardcellid = x mod 3 + y mod 3 * 3 in
  let map_cells i c =
	if i = subboardcellid then
	  Board.Owned o
	else
	  c
  in
  let subboardid = x / 3 + y / 3 * 3 in
  let map_subboard i sb =
	match sb with
	| Board.Playing l when i = subboardid	->
	   Board.Playing (List.mapi map_cells l)
	| _										-> sb
  in
  match b with
  | Board.Playing l							->
	 let b' = Board.Playing (List.mapi map_subboard l) in
	 update_state b'
  | _										-> failwith "Already won"
