type t = No | P1 | P2
val next : t -> t
val char_of_owner : t -> char
val sumOwners : t * t * t -> int * int * int
