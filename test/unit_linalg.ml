(** Unit test for Owl_linalg module *)

open Owl

module M = Owl.Linalg.D

(* some test input *)

(* a module with functions to test *)
module To_test = struct

  let rank () =
    let x = Mat.sequential 4 4 in
    M.rank x = 2

  let det () =
    let x = Mat.hadamard 4 in
    M.det x = 16.

  let inv () =
    let x = Mat.hadamard 4 in
    M.inv x |> Mat.sum' = 1.

end

(* the tests *)

let rank () =
  Alcotest.(check bool) "rank" true (To_test.rank ())

let det () =
  Alcotest.(check bool) "det" true (To_test.det ())

let inv () =
  Alcotest.(check bool) "inv" true (To_test.inv ())

let test_set = [
  "rank", `Slow, rank;
  "det", `Slow, det;
  "inv", `Slow, inv;
]
