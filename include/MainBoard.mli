(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   MainBoard.mli                                      :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 14:13:02 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 17:05:32 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val inject_input : Board.board -> int * int -> Owner.t -> Board.board

val get : Board.t -> int * int -> Owner.t
