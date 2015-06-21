(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   MainBoard.ml                                       :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:47:58 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/21 09:46:43 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(** b: MainBoard; *)
let update_state b =
	match b with
	| Board.Playing l						->
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

let getLineTriplet b sbid lid =
  let rec build_list l cid l' =
	match l with
	| []							-> l'
	| hd::tl when cid / 3 = lid		-> build_list tl (cid + 1) (hd::l')
	| hd::tl 						-> build_list tl (cid + 1) l'
  in
  let helper = function
	| Board.Playing l				-> build_list l 0 []
	| _								-> []
  in
  match b with
  | Board.Playing l					-> helper (List.nth l sbid)
  | _								-> failwith "Already won"

let getColTriplet b sbid lid =
  let rec build_coidt l cid l' =
	match l with
	| []							-> l'
	| hd::tl when cid mod 3 = lid	-> build_coidt tl (cid + 1) (hd::l')
	| hd::tl 						-> build_coidt tl (cid + 1) l'
  in
  let helper = function
	| Board.Playing l				-> build_coidt l 0 []
	| _								-> []
  in
  match b with
  | Board.Playing l					-> helper (List.nth l sbid)
  | _								-> failwith "Already won"

let getDiagTriplet b sbid did =
  let rec build_coidt l cid l' =
	match l with
	| []							-> l'
	| hd::tl when did = 0 && (cid = 0 || cid = 4 || cid = 8)
	  -> build_coidt tl (cid + 1) (hd::l')
	| hd::tl when did = 1 && (cid = 2 || cid = 4 || cid = 6)
	  -> build_coidt tl (cid + 1) (hd::l')
	| hd::tl 						-> build_coidt tl (cid + 1) l'
  in
  let helper = function
	| Board.Playing l				-> build_coidt l 0 []
	| _								-> []
  in
  match b with
  | Board.Playing l					-> helper (List.nth l sbid)
  | _								-> failwith "Already won"
												
let getcell_xy sbid cid =
  ((sbid mod 3) * 3 + cid mod 3, (sbid / 3) * 3 + cid / 3)

												
let getSbTriplet b sbid (v, v', v'') =
  let helper = function
	| Board.Playing l				->
	   [List.nth l v; List.nth l v'; List.nth l v'']
	| _								-> []
  in
  match b with
  | Board.Playing l					-> helper (List.nth l sbid)
  | _								-> failwith "Already won"
