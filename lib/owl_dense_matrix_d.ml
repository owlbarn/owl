(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Real dense matrix ]  *)

open Bigarray

module M = Owl_dense_matrix_generic
include M

type mat = (float, float64_elt) M.t

type elt = float

(* overload functions in Owl_dense_matrix_generic *)

let empty m n = M.empty Float64 m n

let create m n a = M.create Float64 m n a

let zeros m n = M.zeros Float64 m n

let ones m n = M.ones Float64 m n

let eye m = M.eye Float64 m

let sequential m n = M.sequential Float64 m n

let uniform ?(scale=1.) m n = M.uniform Float64 ~scale m n

let gaussian ?(sigma=1.) m n = M.gaussian Float64 ~sigma m n

let semidef m = M.semidef Float64 m

let linspace a b n = M.linspace Float64 a b n

let logspace ?(base=Owl_maths.e) a b n = M.logspace Float64 ~base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Float64 xa xb ya yb xn yn

let of_array x m n = M.of_array Float64 x m n

let of_arrays x = M.of_arrays Float64 x

let load f = M.load Float64 f

let load_txt f = M.load_txt Float64 f

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
