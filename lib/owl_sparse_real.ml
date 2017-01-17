(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Sparse matrix ] *)

open Bigarray

type spmat = (float, Bigarray.float64_elt) Owl_sparse_matrix.t

include Owl_sparse_matrix

(* overload functions in Owl_sparse_matrix *)

let zeros m n = Owl_sparse_matrix.zeros Float64 m n

let ones m n = Owl_sparse_matrix.ones Float64 m n

let eye m = Owl_sparse_matrix.eye Float64 m

let binary m n = Owl_sparse_matrix.binary Float64 m n

let uniform ?(scale=1.) m n = Owl_sparse_matrix.uniform ~scale Float64 m n

let permutation_matrix m = Owl_sparse_matrix.permutation_matrix Float64 m

let load f = Owl_sparse_matrix.load Float64 f

(* specific functions for float64 matrix *)

let minmax x = min x, max x

let power x c = map_nz (fun y -> y ** c) x

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = zeros m n in
  for k = 0 to c do
    let i = Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) () in
    let j = Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) () in
    set x i j (f ())
  done;
  x

let uniform_int ?(a=0) ?(b=99) m n =
  _random_basic (fun () -> float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ())) m n

let linspace a b n = Owl_dense_matrix.linspace Float64 a b n |> of_dense

(** ends here *)
