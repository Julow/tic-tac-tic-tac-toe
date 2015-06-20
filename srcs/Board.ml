(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Board.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:22:31 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 12:48:05 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type board = Owned of Owner.t | Playing of board list

let emptySmall = Playing[Owned Owner.No; Owned Owner.No; Owned Owner.No;
						 Owned Owner.No; Owned Owner.No; Owned Owner.No;
						 Owned Owner.No; Owned Owner.No; Owned Owner.No;]

let emptyMain = Playing[emptySmall; emptySmall; emptySmall;
						emptySmall; emptySmall; emptySmall;
						emptySmall; emptySmall; emptySmall;]

let update_state b =
  let helper = function
	| ((Owned o0) as o)::(Owned o1)::(Owned o2)
	  ::(Owned o3)::((Owned o4) as o')::(Owned o5)
	  ::(Owned o6)::(Owned o7)::((Owned o8) as o'')::_	->
	   if o0 <> Owner.No && o0 = o1 && o0 = o2 then o
	   else if o3 <> Owner.No && o3 = o4 && o3 = o5 then o'
	   else if o6 <> Owner.No && o6 = o7 && o6 = o8 then o''
	   else if o0 <> Owner.No && o0 = o3 && o0 = o6 then o
	   else if o1 <> Owner.No && o1 = o4 && o1 = o7 then o'
	   else if o2 <> Owner.No && o2 = o5 && o2 = o8 then o''
	   else if o0 <> Owner.No && o0 = o4 && o0 = o8 then o
	   else if o2 <> Owner.No && o2 = o4 && o2 = o6 then o'
	   else b
	| _													-> b
  in
  match b with
  | Playing l	-> helper l
  | _			-> b
