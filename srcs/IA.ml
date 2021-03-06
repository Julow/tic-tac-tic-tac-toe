(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   IA.ml                                              :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 09:20:57 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/21 18:24:57 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let triplets1 = [(0, 1, 2); (3, 4, 5); (6, 7, 8); (0, 3, 6);(1, 4, 7); (2, 5, 8)]
let triplets2 = [(0, 4, 8); (2, 4, 6)]

let sbindex = [0; 1; 2; 3; 4; 5; 6; 7; 8]

let empty_moves = [[]; []; []; []; []]

let pick_rand_subpos (l, sbi) =
  let rec helper l l' =
	match l with
	| []										-> l'
	| (Board.Owned Owner.No, i)::tl 			-> helper tl (i::l')
	| _::tl										-> helper tl l'
  in
  let cells = helper (List.combine l [0; 1; 2; 3; 4; 5; 6; 7; 8]) [] in
  let len = List.length cells in
  if len = 0 then
	failwith "unreachable ! ! !"
  else
	MainBoard.getcell_xy sbi (Utils.nth cells (Random.int len))

let pick_rand_pos l =
  let rec helper l l' =
	match l with
	| []										-> l'
	| (Board.Playing hd, i)::tl 				-> helper tl ((hd, i)::l')
	| _::tl										-> helper tl l'
  in
  let sb = helper (List.combine l [0; 1; 2; 3; 4; 5; 6; 7; 8]) [] in
  let len = List.length sb in
  if len = 0 then
	failwith "unreachable ! !"
  else
	pick_rand_subpos (Utils.nth sb (Random.int len))

(** sbi: subboard index
 ** ai,bi,ci: triplet indexes unpacked
 ** tv: triplet values*)
let any_no_coord sbi (ai, bi, ci) tv =
  match tv with
  | (_, _, Owner.No)			-> MainBoard.getcell_xy sbi ci
  | (Owner.No, _, _)			-> MainBoard.getcell_xy sbi ai
  | (_, Owner.No, _)			-> MainBoard.getcell_xy sbi bi
  | _							-> failwith "Unreachable!!"
											
(** lm: list matches
 ** lm: list matches index
 ** mcoo: match coordinates (int ^3) *)
let push_match lm lmi mcoo =
  let rec helper lm lmi' =
	match lm with
	| []							-> []
	| hd::tl when lmi' = lmi		-> (mcoo::hd)::(helper tl (lmi' + 1))
	| hd::tl						-> hd::(helper tl (lmi' + 1))
  in
  helper lm 0

(** ti: triplet indexes (int ^3)
 ** tv: triplet values (Owner.t ^3)
 ** nno,npi,np2: triplet values summed
 ** cl: cell list
 ** sbi: subboard index
 ** lm: list matches *)
let foreach_triplets ti cl sbi lm =
  let tv = Board.getTripletValues cl ti in
  let (nno, np1, np2) = Owner.sumOwners tv in
  if nno = 1 && np1 = 2 then
	push_match lm 0 (any_no_coord sbi ti tv)
  else if List.length (Utils.nth lm 0) = 0 then
	begin
	  if nno = 1 && np2 = 2 then
		push_match lm 1 (any_no_coord sbi ti tv)
	  else if List.length (Utils.nth lm 1) = 0 then
		begin
		  if nno = 2 && np2 = 1 then
			push_match lm 4 (any_no_coord sbi ti tv)
		  else
			lm
		end
	  else
		lm
	end
  else
	lm
let foreach_triplets_diag ti cl sbi lm =
  let tv = Board.getTripletValues cl ti in
  let (nno, np1, np2) = Owner.sumOwners tv in
  if nno = 1 && np1 = 2 then
	push_match lm 0 (any_no_coord sbi ti tv)
  else if List.length (Utils.nth lm 0) = 0 then
	begin
	  if nno = 1 && np2 = 2 then
		push_match lm 1 (any_no_coord sbi ti tv)
	  else if List.length (Utils.nth lm 1) = 0 then
		begin
		  if nno = 2 && np1 = 1 then
			push_match lm 2 (any_no_coord sbi ti tv)
		  else if List.length (Utils.nth lm 2) = 0 then
			begin
			  if nno = 2 && np2 = 1 then
				push_match lm 3 (any_no_coord sbi ti tv)
			  else
				lm
			end			
		  else
			lm
		end
	  else
		lm
	end
  else
	lm

(** cl: cell list
 ** sbi: subboard index
 ** lm: matches list
 ** tl: triplet list
 ** f: foreach_triplet[_diag] function *)
let check_triplets cl sbi lm =
  let rec helper tl f lm =
	match tl with
	| []							-> lm
	| hdt::tlt						-> helper tlt f (f hdt cl sbi lm)
  in
  let lm' = helper triplets1 foreach_triplets lm in
  let lm' = helper triplets2 foreach_triplets_diag lm' in
  lm'
	
(** l: subboards list
 ** li: subboards indexes list
 ** lm: matches list
 ** cl: cell list*)
let foreach_subboards l =
  let rec helper l li lm =
	match l, li with
	| _, _ when List.length (List.hd lm) > 0		-> lm
	| (Board.Playing cl)::tl, hdi::tli				->
	   helper tl tli (check_triplets cl hdi lm)
	| [], _	| _, []									-> lm
	| _::tl, _::tli									->
	   helper tl tli lm
  in
  helper l sbindex empty_moves

(** l: subboards list
 ** lm: list moves *)
let get_best_move l =
  let lm = foreach_subboards l in
  let rec helper = function
	| []											-> pick_rand_pos l
	| hd::tl when List.length hd > 0				-> List.hd hd
	| _::tl											-> helper tl
  in
  helper lm

(** b: board *)
let get_input b =
  match b with
  | Board.Playing l     -> get_best_move l
  | _                   -> failwith "Game is over"
