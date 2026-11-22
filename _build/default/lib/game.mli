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

val add_player : t -> player -> bool
(** [add_player game p] returns true if the player [p] was added successful to
    the game state [game]. *)

val process_move : t -> player -> string -> bool
(** [process_move game player keyboard]*)
(* check if string is a valid move? and change player's state. *)
(*whenever player enters keyboard input this function is called. The keyboard input and the player object is passed in*)
(*processing ensures that the player move is valid. 
If invlaid mvoe then return false, if its valid, move the player to the position if valid. *)
