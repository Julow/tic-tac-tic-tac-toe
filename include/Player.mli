(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Player.mli                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 17:15:34 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 17:27:12 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t

val new_players : string -> string -> t

val next : t -> t

val type_of_player : t -> Owner.t
val string_of_player : t -> string
val char_of_player : t -> char
