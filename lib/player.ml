(** A player in the game: a name, a role, and a position on the map. *)

type role =
  | Dishwasher
  | Chopper
  | Fryer
  | Assembler

type direction =
  | Up
  | Down
  | Left
  | Right

type t = {
  name : string;
  role : role;
  pos : int * int;
}

let create name role pos = { name; role; pos }
let name p = p.name
let role p = p.role
let position p = p.pos

let move p dir =
  let x, y = p.pos in
  let pos =
    match dir with
    | Up -> (x, y - 1)
    | Down -> (x, y + 1)
    | Left -> (x - 1, y)
    | Right -> (x + 1, y)
  in
  { p with pos }

let avatar p =
  match p.role with
  | Dishwasher -> 'D'
  | Chopper -> 'C'
  | Fryer -> 'F'
  | Assembler -> 'A'

let role_to_string = function
  | Dishwasher -> "Dishwasher"
  | Chopper -> "Chopper"
  | Fryer -> "Fryer"
  | Assembler -> "Assembler"

let next_role taken =
  if not (List.mem Dishwasher taken) then Some Dishwasher
  else if not (List.mem Chopper taken) then Some Chopper
  else if not (List.mem Fryer taken) then Some Fryer
  else if not (List.mem Assembler taken) then Some Assembler
  else None

(* let valid_move move = true (*is client-entered keyboard input expected? ex:
   if they are a chopper, did they enter 'c' instead of 'w'?*) (*also are they
   allowed to enter 'c' right now? Are the tasks depending on it completed?*)
   (*dont forget some players can mvoe around*)

   let task () = () (*task is only called when a player performs their task. Ex:
   when client enters 'c'*) (*when task is called, if input is valid (call
   valid_move), then increment count*) (*when the user completes the task (Ex:
   enters 'c' 5 times) then unlock other players Ex: wehen the chopper completes
   his task then unlock assembler and allow him to perform his task (his valid
   move should now only be dependent on whether the assembler entered the
   correct keyboard input)*) *)
