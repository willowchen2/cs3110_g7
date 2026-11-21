(* Outputs the ASCII char array of the map that will be later parsed to print to
   the terminal *)

type pos = int * int
(**pos tuple represents the grid position using (x,y) integer coordinates*)

val kitchen_map : string list
(**takes in a string per row representing the kitchet map*)

val width : int
(**width of the kitchet, exposed in mli to allow for bound checking*)

val height : int
(**height of the kitchet, exposed in mli to allow for bound checking*)

val gen_map : unit -> char array array
(**returns a fresh(!) 2d char array copied from kitchen_map*)

val is_walkable : pos -> bool
(**checks in-bounds invariant of player and returns bool*)

val update_map : (char * pos) list -> string
(**takes in a list of characters and their respective positions and updates it
   as a string of the kitchen map*)

val render_screen : (char * pos) list -> unit
(**clear terminal and print the string*)

val enable_raw_mode : unit -> unit
(**switch terminal for keypresses to be registered immediately and w/o pressing
   enter*)

val read_key : unit -> char
(**reads the next character typed*)
