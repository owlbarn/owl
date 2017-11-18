(** Unit test for Owl_lazy module *)

open Bigarray
open Owl_types

module M = Owl.Lazy.Make (Owl.Arr)

(* make testable *)
let ndarray = Alcotest.testable (fun p (x : M.t) -> ()) M.equal
