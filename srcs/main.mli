val get_gui : unit -> (Board.board -> int * int) * (Board.board -> unit)
val start_game :
  string ->
  string -> (Board.board -> int * int) * (Board.board -> 'a) -> unit
