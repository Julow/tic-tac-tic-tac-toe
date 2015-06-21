(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Utils.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: jaguillo <jaguillo@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/20 13:48:52 by jaguillo          #+#    #+#             *)
(*   Updated: 2015/06/21 11:48:49 by ngoguey          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let str_is f str =
	let rec loop i =
		if (String.length str) <= i then
			true
		else if f (String.get str i) then
			loop (i + 1)
		else
			false
	in
	loop 0

let str_is_int = str_is (fun c -> (c >= '0') && (c <= '9'))

let rec prompt_line prompt no_empty =
	print_string prompt;
	print_string ": ";
	let line = read_line () in
	if no_empty && (String.length line) = 0 then begin
		print_endline "Cannot be empty. Please retry";
		prompt_line prompt no_empty
	end else
		line

let rec prompt_int prompt =
	let line = prompt_line prompt true in
	if str_is_int line then
		int_of_string line
	else begin
		print_endline "Bad number. Please retry";
		prompt_int prompt
	end

let nth l i =
  (* try *)
	List.nth l i
  (* with *)
  (* | _ -> *)
  (* 	 Printf.printf "lol i=%d\n%!" i; *)
  (* 	 failwith "rethrow" *)
			  
