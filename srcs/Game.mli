val input_player :
  Board.board ->
  'a * string * 'b * 'c -> (Board.board -> int * int) * 'd -> int * int
val game_loop :
  Board.board ->
  Owner.t * string * Owner.t * string ->
  (Board.board -> int * int) * (Board.board -> 'a) -> unit
val start :
  string ->
  string -> (Board.board -> int * int) * (Board.board -> 'a) -> unit
