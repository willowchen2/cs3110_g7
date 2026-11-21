(* Rules and details for what makes a meal. *)

(*To-do: define/refine types*)
type prep =
  | Raw
  | Chopped
  | Cooked

type patty =
  | Grass of prep
  | Tomato of prep

type fries =
  | NoFries
  | Twig of prep

type order = {
  patty : patty;
  fries : fries;
  assembled : bool;
}

(*To-do: define functions that advance the order like cook patty*)
