(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Ncurses.mli                                        :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 15:04:53 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 16:10:38 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val get_input : unit -> (int * int)

val draw : Board.t -> unit