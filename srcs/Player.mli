(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Player.mli                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 16:38:07 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 16:38:15 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t = Owner.t * string * Owner.t * string

val new_players : 'a -> 'b -> Owner.t * 'a * Owner.t * 'b

val next : 'a * 'b * 'c * 'd -> 'c * 'd * 'a * 'b

val type_of_player : 'a * 'b * 'c * 'd -> 'a
val string_of_player : 'a * 'b * 'c * 'd -> 'b
val char_of_player : Owner.t * 'a * 'b * 'c -> char
