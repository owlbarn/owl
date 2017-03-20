(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Real dense matrix ]  *)

open Bigarray

type mat = (float, float64_elt) Owl_dense_matrix.t

type elt = float

include Owl_dense_matrix

(* overload functions in Owl_dense_matrix *)

let empty m n = Owl_dense_matrix.empty Float64 m n

let create m n a = Owl_dense_matrix.create Float64 m n a

let zeros m n = Owl_dense_matrix.zeros Float64 m n

let ones m n = Owl_dense_matrix.ones Float64 m n

let eye m = Owl_dense_matrix.eye Float64 m

let sequential m n = Owl_dense_matrix.sequential Float64 m n

let uniform ?(scale=1.) m n = Owl_dense_matrix.uniform Float64 ~scale m n

let gaussian ?(sigma=1.) m n = Owl_dense_matrix.gaussian Float64 ~sigma m n

let semidef m = Owl_dense_matrix.semidef Float64 m

let linspace a b n = Owl_dense_matrix.linspace Float64 a b n

let logspace ?(base=Owl_maths.e) a b n = Owl_dense_matrix.logspace Float64 ~base a b n

let meshgrid xa xb ya yb xn yn = Owl_dense_matrix.meshgrid Float64 xa xb ya yb xn yn

let of_array x m n = Owl_dense_matrix.of_array Float64 x m n

let of_arrays x = Owl_dense_matrix.of_arrays Float64 x

let load f = Owl_dense_matrix.load Float64 f

(* specific functions for float64 matrix *)

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let vector_uniform n = uniform 1 n

let uniform_int ?(a=0) ?(b=99) m n =
  let x = empty m n in
  iteri (fun i j _ -> x.{i,j} <-
    float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ())
  ) x; x
