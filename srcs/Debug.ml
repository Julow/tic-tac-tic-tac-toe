(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Debug.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 14:26:48 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 15:39:08 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let getOwnerChar sb i =
  match sb with
  | Board.Owned o						-> Owner.char_of_owner o
  | Board.Playing l						->
	 let ow = List.nth l i in
	 match ow with
	 | Board.Owned o					-> Owner.char_of_owner o
	 | _								-> Owner.char_of_owner  Owner.No
																
let print_3lines hd sec ter =
  Printf.printf
	"%c %c %c | %c %c %c | %c %c %c\n%!"
	(getOwnerChar hd 0) (getOwnerChar hd 1) (getOwnerChar hd 2)
	(getOwnerChar sec 0) (getOwnerChar sec 1) (getOwnerChar sec 2)
	(getOwnerChar ter 0) (getOwnerChar ter 1) (getOwnerChar ter 2);
  Printf.printf
	"%c %c %c | %c %c %c | %c %c %c\n%!"
	(getOwnerChar hd 3) (getOwnerChar hd 4) (getOwnerChar hd 5)
	(getOwnerChar sec 3) (getOwnerChar sec 4) (getOwnerChar sec 5)
	(getOwnerChar ter 3) (getOwnerChar ter 4) (getOwnerChar ter 5);
  Printf.printf
	"%c %c %c | %c %c %c | %c %c %c\n%!"
	(getOwnerChar hd 6) (getOwnerChar hd 7) (getOwnerChar hd 8)
	(getOwnerChar sec 6) (getOwnerChar sec 7) (getOwnerChar sec 8)
	(getOwnerChar ter 6) (getOwnerChar ter 7) (getOwnerChar ter 8)
	
let print_board b =
  let rec helper = function
	| hd::sec::ter::tl	->
	   print_3lines hd sec ter;
	   Printf.printf "----- | ----- | -----\n%!";
	   helper tl
	| _					-> ()
  in
  match b with
  | Board.Playing l		-> helper l;
						   Printf.printf "\n%!"
  | _					-> ()

let () =
  let b = Board.emptyMain in
  (* print_board b; *)
  let b = MainBoard.inject_input b (0, 0) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (0, 1) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (0, 2) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 0) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 1) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 2) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 3) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 4) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 5) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (3, 8) Owner.P1 in
  (* print_board b; *)
  let b = MainBoard.inject_input b (4, 8) Owner.P1 in
  print_board b;
  let b = MainBoard.inject_input b (5, 8) Owner.P1 in
  print_board b;
