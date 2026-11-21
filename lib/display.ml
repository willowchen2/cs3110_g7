type pos = int * int

(*default map, will work on getting more (potentially seeded?) map generation
  boards later*)
let kitchen_map =
  [
    "####################";
    "#S S   F F   C C   #";
    "#                  #";
    "#                  D";
    "#                  #";
    "#W W      A A      #";
    "####################";
  ]

let height = List.length kitchen_map
let width = String.length (List.hd kitchen_map)

let gen_map () =
  kitchen_map
  |> List.map (fun row -> Array.init (String.length row) (String.get row))
  |> Array.of_list

(*helper function to check boundaries*)
let in_bounds (x, y) = x >= 0 && y >= 0 && x < width && y < height

let is_walkable ((x, y) as p) =
  in_bounds p && (List.nth kitchen_map y).[x] = ' '

let update_map avatars =
  let grid = gen_map () in
  List.iter
    (fun (c, ((x, y) as p)) -> if in_bounds p then grid.(y).(x) <- c)
    avatars;
  grid |> Array.to_list
  |> List.map (fun row -> String.init (Array.length row) (Array.get row))
  |> String.concat "\n"

let render_screen avatars =
  print_string "\027[H\027[2J\027[3J";
  print_string (update_map avatars);
  print_newline ();
  flush stdout

let enable_raw_mode () =
  let old = Unix.tcgetattr Unix.stdin in
  Unix.tcsetattr Unix.stdin Unix.TCSANOW
    { old with Unix.c_icanon = false; c_echo = false };
  at_exit (fun () -> Unix.tcsetattr Unix.stdin Unix.TCSANOW old)

let read_key () = input_char stdin
