(** A player in the game: a name, a role, and a position on the map. *)

type role = Dishwasher | Chopper | Fryer | Assembler

type direction = Up | Down | Left | Right

type t

(** [create name role pos] is a new player called [name] with role [role],
    standing at position [pos] = (x, y). *)
val create : string -> role -> int*int -> t

(** [name p] is the name of player [p]. *)
val name : t -> string

(** [role p] is the role of player [p]. *)
val role : t -> role

(** [position p] is the (x,y) position of player [p]. *)
val position : t -> int * int

(** [move p dir] is [p] moved one tile in direction [dir]. It does not check 
    for walls or other players. *)
val move : t -> direction -> t

(** [avatar p] is the character drawn on screen for [p], based on its role:
    'D', 'C', 'F', or 'A'. *)
val avatar : t -> char

(** [role_to_string r] is the name of role [r] as a string, e.g. "Chopper". *)
val role_to_string : role -> string

(** [next_role taken] is [Some r] where [r] is the first role not in [taken],
    or [None] if all four roles are taken. *)
val next_role : role list -> role option

(* val valid_move : string -> bool
(*is client-entered keyboard input expected?
ex: if they are a chopper, did they enter 'c' instead of 'w'?*)
(*also are they allowed to enter 'c' right now? Are the tasks depending on it completed?*)
(*dont forget some players can mvoe around*)

val task : unit -> unit
(*task is only called when a  player performs their task. Ex: when client enters 'c'*)
(*when task is called, if input is valid (call valid_move), then increment count*)
(*when the user completes the task (Ex: enters 'c' 5 times) then unlock other players
Ex: wehen the chopper completes his task then unlock assembler and allow him to perform
 his task (his valid move should now only be dependent on whether the assembler entered the correct keyboard input)*) *)
