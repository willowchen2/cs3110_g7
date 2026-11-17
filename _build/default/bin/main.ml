(* Demo: log connections, then close each client's
   connection. *)

let lo5000_address =
  Unix.ADDR_INET (Unix.inet_addr_any, 5000)

let string_of_address = function
  | Unix.ADDR_INET (address, port) ->
      Printf.sprintf "%s:%d"
        (Unix.string_of_inet_addr address)
        port
  | Unix.ADDR_UNIX path -> path

(*TO-DO: assign each client (client-address) to a  player*)
let handle_client client_address (_client_in, _client_out) =
  Lwt_io.printlf "Connection from %s."
    (string_of_address client_address)

let p_main =
  let%lwt server = (*listens on the local address*)
    Lwt_io.establish_server_with_client_address
      lo5000_address handle_client
  in
  let%lwt () =
    Lwt_io.printl "Listening. Press Enter to stop."
  in
  let%lwt _line = Lwt_io.(read_line stdin) in
  (*TO-DO: need ot pass-in keyboard input and its corresponding player to Game.ml processing function*)
  let%lwt () = Lwt_io.printl "Shutting down." in
  Lwt_io.shutdown_server server

let () = Lwt_main.run p_main
