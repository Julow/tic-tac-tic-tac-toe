(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Utils.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 14:34:01 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/20 14:35:14 by jaguillo         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

val str_is : (char -> bool) -> string -> bool

val str_is_int : string -> bool

val prompt_line : string -> bool -> string

val prompt_int : string -> int
