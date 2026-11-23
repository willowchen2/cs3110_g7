(* test/test_player.ml *)
(* Test suite style and formatting done with the help of ClaudeAI *)

open OUnit2
open Cs3110_g7

(* A starting player: Chopper at (5, 5). *)
let p = Player.create "alice" Player.Chopper (5, 5)

(* Helper so failed tests print positions nicely. *)
let string_of_pos (x, y) = Printf.sprintf "(%d, %d)" x y

(* ---------- create and getters ---------- *)

let create_tests =
  [
    ("name" >:: fun _ -> assert_equal "alice" (Player.name p) ~printer:Fun.id);
    ("role" >:: fun _ -> assert_equal Player.Chopper (Player.role p));
    ( "position" >:: fun _ ->
      assert_equal (5, 5) (Player.position p) ~printer:string_of_pos );
  ]

(* ---------- move ---------- *)

let move_test name dir expected =
  name >:: fun _ ->
  assert_equal expected
    (Player.position (Player.move p dir))
    ~printer:string_of_pos

let move_tests =
  [
    move_test "up decreases y" Player.Up (5, 4);
    move_test "down increases y" Player.Down (5, 6);
    move_test "left decreases x" Player.Left (4, 5);
    move_test "right increases x" Player.Right (6, 5);
    ( "two moves in a row" >:: fun _ ->
      let p2 = Player.move (Player.move p Player.Right) Player.Down in
      assert_equal (6, 6) (Player.position p2) ~printer:string_of_pos );
    ( "move keeps name and role" >:: fun _ ->
      let p2 = Player.move p Player.Up in
      assert_equal "alice" (Player.name p2) ~printer:Fun.id;
      assert_equal Player.Chopper (Player.role p2) );
    ( "move does not change the original" >:: fun _ ->
      let _ = Player.move p Player.Up in
      assert_equal (5, 5) (Player.position p) ~printer:string_of_pos );
  ]

(* ---------- avatar ---------- *)

let avatar_test name role expected =
  name >:: fun _ ->
  let player = Player.create "x" role (0, 0) in
  assert_equal expected (Player.avatar player) ~printer:(String.make 1)

let avatar_tests =
  [
    avatar_test "dishwasher" Player.Dishwasher 'D';
    avatar_test "chopper" Player.Chopper 'C';
    avatar_test "fryer" Player.Fryer 'F';
    avatar_test "assembler" Player.Assembler 'A';
  ]

(* ---------- role_to_string ---------- *)

let role_string_tests =
  [
    ( "dishwasher" >:: fun _ ->
      assert_equal "Dishwasher"
        (Player.role_to_string Player.Dishwasher)
        ~printer:Fun.id );
    ( "chopper" >:: fun _ ->
      assert_equal "Chopper"
        (Player.role_to_string Player.Chopper)
        ~printer:Fun.id );
    ( "fryer" >:: fun _ ->
      assert_equal "Fryer" (Player.role_to_string Player.Fryer) ~printer:Fun.id
    );
    ( "assembler" >:: fun _ ->
      assert_equal "Assembler"
        (Player.role_to_string Player.Assembler)
        ~printer:Fun.id );
  ]

(* ---------- next_role ---------- *)

let next_role_tests =
  [
    ( "nobody has a role: first is Dishwasher" >:: fun _ ->
      assert_equal (Some Player.Dishwasher) (Player.next_role []) );
    ( "skips taken roles" >:: fun _ ->
      assert_equal (Some Player.Chopper)
        (Player.next_role [ Player.Dishwasher ]) );
    ( "finds a gap in the middle" >:: fun _ ->
      assert_equal (Some Player.Chopper)
        (Player.next_role [ Player.Dishwasher; Player.Fryer ]) );
    ( "order of taken list does not matter" >:: fun _ ->
      assert_equal (Some Player.Assembler)
        (Player.next_role [ Player.Fryer; Player.Chopper; Player.Dishwasher ])
    );
    ( "all four taken: None" >:: fun _ ->
      assert_equal None
        (Player.next_role
           [ Player.Dishwasher; Player.Chopper; Player.Fryer; Player.Assembler ])
    );
  ]

(* ---------- run everything ---------- *)

let suite =
  "player tests"
  >::: create_tests @ move_tests @ avatar_tests @ role_string_tests
       @ next_role_tests

let () = run_test_tt_main suite
