(* Connects all the players, orders, score, timer, etc. *)

open Player

type t = {
  mutable players : player list;
  mutable current_orders : Order.order list;
  mutable score : int;
  mutable time_left : int; (* can implement time and score later *)
}

val init : unit -> t
(** [init] initiates the game state with beginning states. *)

val add_player : t -> player -> string -> bool
(*whenever player enters keyboard input this function is called. The keyboard input and the player object is passed in*)
(*processing ensures that the player move is valid and then calls its task() as a result.
If invlaid mvoe then return false, if its valid, perform player.task?*)
