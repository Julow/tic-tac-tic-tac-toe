(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Owner.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:30:02 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/21 10:29:32 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

(** No: No owner;
 ** P1: Player1;
 ** P2: Player2 *)
type t = No | P1 | P2

let next = function
  | P1			-> P2
  | P2			-> P1
  | No			-> No

let char_of_owner = function
  | No					-> 'N'
  | P1					-> 'O'
  | P2					-> 'X'

let sumOwners (a, b, c) =
  let rec helper l ((sa, sb, sc) as t) =
	match l with
	| []					-> t
	| No::tl				-> helper tl (sa + 1, sb, sc)
	| P1::tl				-> helper tl (sa, sb + 1, sc)
	| P2::tl				-> helper tl (sa, sb, sc + 1)
  in
  helper [a; b; c] (0, 0, 0)
