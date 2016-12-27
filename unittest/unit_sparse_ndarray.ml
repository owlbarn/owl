(* Build with the following command
  `ocamlbuild -use-ocamlfind -package alcotest,owl unit_sparse_ndarray.native`
  *)

open Bigarray
module M = Owl_sparse_ndarray

(* make testable *)
(* let matrix = Alcotest.testable Owl_pretty.pp_fmat M.is_equal *)
