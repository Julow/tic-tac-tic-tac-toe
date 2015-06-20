(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Owner.mli                                          :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 14:11:57 by ngoguey           #+#    #+#             *)
(*   Updated: 2015/06/20 17:11:47 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t = No | P1 | P2

val next : t -> t

val char_of_owner : t -> char
val string_of_owner : t -> string

val new_owner : char -> string -> Owner.t
