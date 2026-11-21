(* Demo: log connections, then close each client's
   connection. *)

let lo5000_address =
  Unix.ADDR_INET ("127.0.0.1", 5000)

let string_of_address = function
  | Unix.ADDR_INET (address, port) ->
      Printf.sprintf "%s:%d" (Unix.string_of_inet_addr address) port
  | Unix.ADDR_UNIX path -> path

let name_from_char = function
  | "d" -> "dishwasher"
  | "c" -> "chopper"
  | "f" -> "fryer"
  | "a" -> "assembler"

let init_pos_from_char = function
  | "d" -> Display.DISH_POS
  | "c" -> Display.CHOP_POS
  | "f" -> Display.FRY_POS
  | "a" -> Display.ASSEM.POS

(*TO-DO: assign each client (client-address) to a  player*)
let handle_client game_state (connected_clients: Lwt_io.output_channel list) client_address (_client_in, _client_out) =
  let%lwt () = Lwt_io.printlf "Connection from %s." (string_of_address client_address) in

  let all_roles = ["c";"a";"d"; "f"] in
  let occupied_roles = List.fold_left (fun acc player -> player.role::acc) [] game_state.players in (*check to see what cahracters are left.*)
  let remaining_roles = List.filter (fun role -> !(List.mem role occupied_roles)) all_roles in

  let rec loop () =
    let%lwt () = Lwt_io.write_line _client_out ("What role do you want to play?: "^(List.fold_left (fun acc role -> (name_from_char role)^"("^role^"),") remaining_roles ""))  in
    let%lwt requested_role = Lwt_io.(read_line_opt _client_in) in
    (*print update *)
    let all_roles = ["c";"a";"d"; "f"] in
    let occupied_roles = List.fold_left (fun acc player -> player.role::acc) [] game_state.players in (*check to see what cahracters are left.*)
    let remaining_roles = List.filter (fun role -> !(List.mem role occupied_roles)) all_roles in
    
    match requested_role with 
    | None -> Lwt.return_unit (*client disconnected cleanly?*)
    | Some line ->
      if List.mem line remaining_roles then 
        begin (*cleitn entered valid role, then add cleint to playes and start a  forevvr listneing loop for more keyboard input*)
          (*update other players that new role is taken*)
          List.iter_p (fun out -> Lwt_io.(write_line out) ("Role taken: "^line)) connected_clients;
          connected_clients:=_client_out::!connected_clients;

          game_state.players <- {role=line; pos= init_pos_from_char line; unlocked=(line="c")}::game_state.players;
          Display.update_map;
        end
      else 
        Lwt_io.write_line _client_out ("You entered an invalid role.");
        loop () (*ask for input again*)
  loop()


let valid_input input = 
  true

let p_main =
  let game_state = Game.init () in
  let rec loop () =
    print_endline "What role do you want to play?: dishwasher (d), chopper (c), fryer (f), assembler (a)";
    let%lwt role = Lwt_io.(read_line stdin) in
    if role = "d" || role = "c" || role = "f" || role = "a" then
      game_state.players <- [{role= role; pos= init_pos_from_char role; unlocked=(role="c")}]
    else
      let%lwt () = Lwt_io.printl "Invalid input. Please enter a valid role." in (*promsie cause there might eb lag??*)
      loop ()
  loop()

  let%lwt server = (*clines all send info to this server address, aka locl machie*)
    Lwt_io.establish_server_with_client_address
      lo5000_address (handle_client game_state []) 
  in
  let%lwt () =
    Lwt_io.printl "Listening. Press Enter to stop."
  in
  let%lwt _line = Lwt_io.(read_line stdin) in (*looks only for server input*)
  (*TO-DO: need ot pass-in keyboard input and its corresponding player to Game.ml processing function*)
  let%lwt () = Lwt_io.printl "Shutting down." in
  Lwt_io.shutdown_server server

let () = Lwt_main.run p_main
