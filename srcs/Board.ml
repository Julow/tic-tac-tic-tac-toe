(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Board.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:22:31 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 15:41:17 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type board = Owned of Owner.t | Playing of board list

let emptySmall = Playing[Owned Owner.No; Owned Owner.No; Owned Owner.No;
						 Owned Owner.No; Owned Owner.No; Owned Owner.No;
						 Owned Owner.No; Owned Owner.No; Owned Owner.No;]

let emptyMain = Playing[emptySmall; emptySmall; emptySmall;
						emptySmall; emptySmall; emptySmall;
						emptySmall; emptySmall; emptySmall;]

(** Converts a 'Playing board' to a 'Owned board' if conditions are met *)
let update_state b =
  let helper = function
	| Owned o0 as o::Owned o1::Owned o2::_
		 when o0 <> Owner.No && o0 = o1 && o0 = o2 -> o
	| _::_::_::(Owned o3 as o')::Owned o4::Owned o5::_
		 when o3 <> Owner.No && o3 = o4 && o3 = o5 -> o'
	| _::_::_::_::_::_::(Owned o6 as o'')::Owned o7::Owned o8::_
		 when o6 <> Owner.No && o6 = o7 && o6 = o8 -> o''
	| Owned o0 as o::_::_::Owned o3::_::_::Owned o6::_
		 when o0 <> Owner.No && o0 = o3 && o0 = o6 -> o
	| _::Owned o1::_::_::(Owned o4 as o')::_::_::Owned o7::_
		 when o1 <> Owner.No && o1 = o4 && o1 = o7 -> o'
	| _::_::Owned o2::_::_::Owned o5::_::_::(Owned o8 as o'')::_
		 when o2 <> Owner.No && o2 = o5 && o2 = o8 -> o''
	| Owned o0 as o::_::_::_::Owned o4::_::_::_::Owned o8::_
		 when o0 <> Owner.No && o0 = o4 && o0 = o8 -> o
	| _::_::Owned o2::_::(Owned o4 as o')::_::Owned o6::_
		 when o2 <> Owner.No && o2 = o4 && o2 = o6 -> o'
	| _													-> b
  in
  match b with
  | Playing l											-> helper l
  | _													-> b
