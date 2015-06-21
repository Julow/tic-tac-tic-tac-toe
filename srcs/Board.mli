type board = Owned of Owner.t | Playing of board list
val emptySmall : board
val emptyMain : board
val update_state : board -> board -> board
val owner : board -> int * int -> board
val getTripletValues :
  board list -> int * int * int -> Owner.t * Owner.t * Owner.t
