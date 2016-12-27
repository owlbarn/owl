(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_dense_ndarray.native`
  *)

open Bigarray
module M = Owl_dense_ndarray

(* make testable *)
let ndarray = Alcotest.testable (fun p (x : (float, float64_elt) M.t) -> ()) M.is_equal
