(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   IA.ml                                              :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 09:20:57 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/21 10:13:44 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let triplets1 = [(0, 1, 2); (3, 4, 5); (6, 7, 8); (0, 3, 6);(1, 4, 7); (2, 5, 8)]
let triplets2 = [(0, 4, 8); (2, 4, 6)]

let sbindex = [0; 1; 2; 3; 4; 5; 6; 7; 8]

let empty_moves = [[]; []; []; []; []]


(** ti: triplet indexes (int * int * int)
 ** ai,bi,ci: tripled indexes unpacked
 ** cl: cell list
 ** sbi: subboard index
 ** lm: list matches
 **
 ** **)
let foreach_triplets ((ai, bi, ci) as ti) cl sbi lm =
  let (av, bv, cv) = Board.getTripletValues cl ti in
  lm


let check_triplets cl sbi lm =
  let rec helper tl f lm =
	match tl with
	| []							-> lm
	| hdt::tlt						-> helper tlt f (f hdt cl sbi lm)
  in
  let lm' = helper triplets1 foreach_triplets lm in
  let lm' = helper triplets2 foreach_triplets lm' in
  (* let lm' = helper triplets2 foreach_triplets_diag lm' in *)
  lm'
	
(** l: subboards list
 ** li: subboards indexes list
 ** lm: matches list
 ** cl: cell list*)
let foreach_subboards l =
  let rec helper l li lm =
	match l, li with
	| [], _
	| _, _ when List.length (List.hd lm) > 0		-> lm
	| (Board.Playing cl)::tl, hdi::tli				->
	   helper tl tli (check_triplets cl hdi lm)
	| _, _											-> lm
  in
  helper l sbindex empty_moves

(** l: subboards list
 ** lm: list moves *)
let get_best_move l =
  let helper = function
	| his3rd::my3rd::his2nddiag::my2nddiag::my2nd	-> (1, 1)
	| _												-> failwith "Unreachable"
  in
  let lm = foreach_subboards l in
  helper lm

(** b: board *)
let get_input b =
  match b with
  | Board.Playing l     -> get_best_move l
  | _                   -> failwith "Game is over"
