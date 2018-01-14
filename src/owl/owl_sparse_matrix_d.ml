(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Sparse matrix ] *)

open Bigarray

module M = Owl_sparse_matrix_generic
include M

type elt = float
type mat = (float, Bigarray.float64_elt) Owl_sparse_matrix_generic.t


(* overload functions in Owl_sparse_matrix_generic *)

let zeros m n = M.zeros Float64 m n

let ones m n = M.ones Float64 m n

let eye m = M.eye Float64 m

let binary m n = M.binary Float64 m n

let uniform ?(scale=1.) m n = M.uniform ~scale Float64 m n

let sequential m n = M.sequential Float64 m n

let permutation_matrix m = M.permutation_matrix Float64 m

let of_array m n x = M.of_array Float64 m n x

let load f = M.load Float64 f

(* specific functions for float64 matrix *)

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = M.zeros ~density:0.2 Float64 m n in
  let l = Owl_stats.choose (Array.init (m * n) (fun i -> i)) c in
  for k = 0 to c - 1 do
    let i = l.(k) / n in
    let j = l.(k) - (i * n) in
    insert x i j (f ())
  done;
  x

let uniform_int ?(a=0) ?(b=99) m n =
  _random_basic (fun () -> float_of_int (Owl_stats.uniform_int_rvs ~a ~b)) m n

let linspace a b n = Owl_dense_matrix_generic.linspace Float64 a b n |> of_dense

(** ends here *)
