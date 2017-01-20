(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Sparse matrix ] *)

open Bigarray

type mat = (float, Bigarray.float64_elt) Owl_sparse_matrix.t

type elt = float

include Owl_sparse_matrix

(* overload functions in Owl_sparse_matrix *)

let zeros m n = Owl_sparse_matrix.zeros Float64 m n

let ones m n = Owl_sparse_matrix.ones Float64 m n

let eye m = Owl_sparse_matrix.eye Float64 m

let binary m n = Owl_sparse_matrix.binary Float64 m n

let uniform ?(scale=1.) m n = Owl_sparse_matrix.uniform ~scale Float64 m n

let sequential m n = Owl_sparse_matrix.sequential Float64 m n

let permutation_matrix m = Owl_sparse_matrix.permutation_matrix Float64 m

let of_array m n x = Owl_sparse_matrix.of_array Float64 m n x

let load f = Owl_sparse_matrix.load Float64 f

(* specific functions for float64 matrix *)

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = Owl_sparse_matrix.zeros ~density:0.2 Float64 m n in
  let l = Owl_stats.choose (Array.init (m * n) (fun i -> i)) c in
  for k = 0 to c - 1 do
    let i = l.(k) / n in
    let j = l.(k) - (i * n) in
    insert x i j (f ())
  done;
  x

let uniform_int ?(a=0) ?(b=99) m n =
  _random_basic (fun () -> float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ())) m n

let linspace a b n = Owl_dense_matrix.linspace Float64 a b n |> of_dense

(** ends here *)
