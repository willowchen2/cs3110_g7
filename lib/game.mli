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
    the end of the player list in the [game]. A player can't be added if [game]
    already has 4 players or a player with the same role as [p] already exists,
    in that case [game] is unchanged and it returns false. *)

val process_move : t -> player -> string -> bool
(** [process_move game p key] returns true if [key] is a valid keyboard
    character: "w","a","s","d" for movemment or "c","f","a","PLACEHOLDER" for
    the appropriate task based on the role of the [player]. If valid, the
    respective move (one square in the direction) or task of the player in the
    [game] is completed. Other keys are ignored and false is returned. Note
    their current position is read from game.plaers, not from [p] because of
    mutability complications. *)
