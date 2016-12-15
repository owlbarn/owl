(* Build with `ocamlbuild -pkg alcotest simple.byte` *)

open Bigarray

(* type t = (float, float64_elt) Owl_dense_matrix.mat -> (float, float64_elt) Owl_dense_matrix.mat -> bool *)
let matrix = Alcotest.testable Owl_pretty.pp_fmat Owl_dense_matrix.is_equal

let x0 = Owl_dense_matrix.sequential Float64 3 4

(* A module with functions to test *)
module To_test = struct
  let random x = x
  let sum x = Owl_dense_matrix.sum x
end

(* The tests *)

let random () =
  Alcotest.(check matrix) "same ints" x0 (To_test.random x0)

let sum () =
  Alcotest.(check float) "sum" 79. (To_test.sum x0)

let test_set = [
  "random" , `Quick, random;
  "sum", `Quick , sum;
]

(* Run it *)
let () =
  Alcotest.run "My first test" [
    "test_set", test_set;
  ]
