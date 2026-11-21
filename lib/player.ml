(* Represents one player, including their role*)

(* ALL PLACEHOLDER IMPLEMENTATIONS SO IT CAN COMPILE*)

type player = {
  role : string;
  (*dishwasher, chopper, fryer, assembler*)
  pos : int * int;
  unlocked : bool;
}

let move player string = player
(* updates position based on string*)

let count = 0
(* placeholder *)

let valid_move move = true
(*is client-entered keyboard input expected?
ex: if they are a chopper, did they enter 'c' instead of 'w'?*)
(*also are they allowed to enter 'c' right now? Are the tasks depending on it completed?*)
(*dont forget some players can mvoe around*)

let task () = ()
(*task is only called when a  player performs their task. Ex: when client enters 'c'*)
(*when task is called, if input is valid (call valid_move), then increment count*)
(*when the user completes the task (Ex: enters 'c' 5 times) then unlock other players
Ex: wehen the chopper completes his task then unlock assembler and allow him to perform
 his task (his valid move should now only be dependent on whether the assembler entered the correct keyboard input)*)
