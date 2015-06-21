val update_state : Board.board -> Board.board -> Board.board
val inject_input : Board.board -> int * int -> Owner.t -> Board.board
val getLineTriplet : Board.board -> int -> int -> Board.board list
val getColTriplet : Board.board -> int -> int -> Board.board list
val getDiagTriplet : Board.board -> int -> int -> Board.board list
val getcell_xy : int -> int -> int * int
val getSbTriplet : Board.board -> int -> int * int * int -> Board.board list
