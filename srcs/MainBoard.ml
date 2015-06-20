(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   MainBoard.ml                                       :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:47:58 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 13:08:36 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let update_state b =
  let rec helper = function
  	| []					-> []
  	| hd::tl				-> (Board.update_state hd)::(helper tl)
  in
  match b with
  | Board.Playing l			-> Board.update_state (Board.Playing (helper l))
  | _						-> b
