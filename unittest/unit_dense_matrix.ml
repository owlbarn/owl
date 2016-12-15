(* Build with `ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_matrix.native` *)

open Bigarray

(* make testable *)
let matrix = Alcotest.testable Owl_pretty.pp_fmat Owl_dense_matrix.is_equal

(* a module with functions to test *)
module To_test = struct
  let sequential () = Owl_dense_matrix.sequential Float64 3 4
  let row_num x = Owl_dense_matrix.row_num x
  let col_num x = Owl_dense_matrix.col_num x
  let sum x = Owl_dense_matrix.sum x
end

(* some test input *)
let x0 = Owl_dense_matrix.zeros Float64 3 4
let x1 = Owl_dense_matrix.ones Float64 3 4
let x2 = Owl_dense_matrix.sequential Float64 3 4


(* the tests *)

let sequential () =
  Alcotest.(check matrix) "sequential" x2 (To_test.sequential ())

let row_num () =
  Alcotest.(check int) "row_num" 3 (To_test.row_num x2)

let col_num () =
  Alcotest.(check int) "col_num" 4 (To_test.col_num x0)

let sum () =
  Alcotest.(check float) "sum" 78. (To_test.sum x2)

let test_set = [
  "sequential", `Quick, sequential;
  "row_num", `Quick , row_num;
  "col_num", `Quick , col_num;
  "sum", `Quick , sum;
]

(* Run it *)
let () =
  Alcotest.run "Test Owl_dense_matrix" [ "test_set", test_set; ]
