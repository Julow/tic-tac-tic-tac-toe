(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   MainBoard.ml                                       :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 11:47:58 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 12:03:11 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let make () =
  let small_square = Board.empty in
  Board.new_square small_square

(* mb : MainBoard; bi : BoardIndex *)
let update_state mb bi =
  
