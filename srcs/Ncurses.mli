(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.mli                                        :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 16:37:29 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 17:41:48 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val init : unit -> unit
val deinit : unit -> unit
val get_input : Board.board -> int * int
val draw : Board.board -> unit
val print : string -> unit
