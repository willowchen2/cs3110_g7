(* Connects all the players, orders, score, timer, etc. *)

open Player

type t = {
  mutable players : player list;
  mutable current_orders : Order.order list;
  mutable score : int;
  mutable time_left : int; (* can implement time and score later *)
}

(** [init] initiates the game state with an empty player list, no current
    orders, score of 0 and 5 minutes left (300 seconds). *)
let init () = { players = []; current_orders = []; score = 0; time_left = 300 }

let add_player (game : t) (p : player) (key : string) =
  if List.length game.players >= 4 then false
  else begin
    game.players <- game.players @ [ p ];
    true
  end
(*whenever player enters keyboard input this function is called. The keyboard input and the player object is passed in*)
(*processing ensures that the player move is valid and then calls its task() as a result.
If invlaid mvoe then return false, if its valid, perform player.task?*)
