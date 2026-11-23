(* Connects all the players, orders, score, timer, etc. *)

type t = {
  mutable players : Player.t list;
  mutable current_orders : Order.order list;
  mutable score : int;
  mutable time_left : int; (* can implement time and score later *)
}

(** [direction_of_key key] returns the one square change in position as (dx, dy)
    for a movement key, or [None] if [key] isn't a movement key. *)
let direction_of_key = function
  | "w" -> Some Player.Up
  | "s" -> Some Player.Down
  | "a" -> Some Player.Left
  | "d" -> Some Player.Right
  | _ -> None

(** [same_player p q] is true if [p] and [q] have the same role, i.e. they are
    the same player in the game. *)
let same_player p q = Player.role p = Player.role q

(** [occupied game pos] returns true if the given [pos] coordinates are already
    occupied by a different player in the [game].*)
let occupied game pos =
  List.exists (fun q -> Player.position q = pos) game.players

(** [init ()] initiates a new game state with an empty player list, no current
    orders, score of 0, and 300 seconds left in the game. *)
let init () = { players = []; current_orders = []; score = 0; time_left = 300 }

(** [add_player game p] returns true if the player [p] was added successful to
    the end of the player list in the [game]. A player can't be added if [game]
    already has 4 players or a player with the same role as [p] already exists,
    in that case [game] is unchanged and it returns false. *)
let add_player (game : t) (p : Player.t) =
  if List.length game.players >= 4 then false
  else if List.exists (same_player p) game.players then false
  else begin
    game.players <- game.players @ [ p ];
    true
  end

(** [perform_task game p] helper method that performs the task for [p]'s role in
    [game] and returns whether the task action was valid. TODO: NOT IMPLEMENTED
    YET. Always returns true for now. *)
let perform_task (_game : t) (_p : Player.t) = true

(** [process_move game p key] returns true if [key] is a valid keyboard
    character: "w","a","s","d" for movemment or "q" for performing the task of
    the role of the [player] (TASK PERFORMANCE NOT IMPLEMENTED YET). If valid,
    the respective move (one square in the direction) or task of the player in
    the [game] is completed. Other keys are ignored and false is returned. Note:
    their current position is read from game.plaers, not from [p] because of
    mutability complications. *)
let process_move (game : t) (p : Player.t) (key : string) =
  match List.find_opt (same_player p) game.players with
  (* gets the current player based on game.players rather because mutability may
     mess it up. identifies the player within game.players based on the role. *)
  | None -> false
  | Some cur -> (
      match String.trim key with
      | "q" -> perform_task game cur
      | k -> (
          match direction_of_key k with
          | None -> false
          | Some dir ->
              let moved = Player.move cur dir in
              let target = Player.position moved in
              if Display.is_walkable target && not (occupied game target) then begin
                (* records are immutable, so replace this player's record in
                   game.players with an updated copy *)
                game.players <-
                  List.map
                    (fun q -> if same_player q p then moved else q)
                    game.players;
                true
                (* note a newly created player must be added to game.players
                   because records are immutable. *)
              end
              else false))
