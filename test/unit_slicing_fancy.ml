(** Unit test for Owl_stats module *)

open Owl

open Owl_types


(* some test input *)

let x0 = Arr.sequential [|10|]

let x1 = Arr.sequential [|10;10|]

let x2 = Arr.sequential [|10;10;10|]

let x3 = Arr.sequential [|5;5;5;5|]


(* a module with functions to test *)
module To_test = struct

  let test_01 () =
    let s = [R[]] in
    let y = Arr.get_slice s x0 in
    Arr.(y = x0)

end


(* the tests *)

let test_01 () =
  Alcotest.(check bool) "test 01" true (To_test.test_01 ())

let test_set = [
  "test 01", `Slow, test_01;
]
