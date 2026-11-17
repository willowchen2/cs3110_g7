(* Connects all the players, orders, score, timer, etc. *)

open Player

type t = {
  players : player list;
  current_orders : Order.order list;
  score : int;
  time_left : int; (* can implement time and score later *)
}

val init : unit -> t
val processing : player -> string -> bool
(*whenever player enters keyboard input this function is called. The keyboard input and the player object is passed in*)
(*processing ensures that the player move is valid and then calls its task() as a result.
If invlaid mvoe then return false, if its valid, perform player.task?*)

(*Is there a better way to create objects????? so far relying on player record
  object and player.mli*)
