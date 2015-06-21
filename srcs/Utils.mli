(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Utils.mli                                          :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/21 16:37:58 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 16:37:59 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val str_is : (char -> bool) -> string -> bool
val str_is_int : string -> bool
val prompt_line : string -> bool -> string
val prompt_int : string -> int
val nth : 'a list -> int -> 'a
