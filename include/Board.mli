(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Board.mli                                          :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 14:12:38 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 19:18:14 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type board = Owned of Owner.t | Playing of board list
val emptyMain : board
val update_state : board -> board
val owner : board -> int * int -> Owner.t
