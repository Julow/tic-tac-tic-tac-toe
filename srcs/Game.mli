(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Game.mli                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 17:03:09 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 17:59:53 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val start : string -> string
		-> (Board.board -> int * int) * (string -> unit) * (Board.board -> 'a)
		-> Player.t
