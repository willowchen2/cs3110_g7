(* Outputs the ASCII string of the map to print to the terminal *)

val kitchen_map : string

type players_pos = {
  player1 : int * int;
  player2 : int * int;
  player3 : int * int;
}

val gen_map : players_pos -> string
val update_map : players_pos -> string
val render_screen : unit -> unit
