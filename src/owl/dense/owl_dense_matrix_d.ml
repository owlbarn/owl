(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Real dense matrix ]  *)

open Bigarray

module M = Owl_dense_matrix_generic
include M

type elt = float
type mat = (float, float64_elt) M.t
type arr = (float, float64_elt) Owl_dense_ndarray_generic.t


(* overload functions in Owl_dense_matrix_generic *)

let empty m n = M.empty Float64 m n

let create m n a = M.create Float64 m n a

let init m n f = M.init Float64 m n f

let init_2d m n f = M.init_2d Float64 m n f

let zeros m n = M.zeros Float64 m n

let ones m n = M.ones Float64 m n

let eye m = M.eye Float64 m

let sequential ?a ?step m n = M.sequential Float64 ?a ?step m n

let uniform ?a ?b m n = M.uniform Float64 ?a ?b m n

let gaussian ?mu ?sigma m n = M.gaussian Float64 ?mu ?sigma m n

let semidef m = M.semidef Float64 m

let linspace a b n = M.linspace Float64 a b n

let logspace ?base a b n = M.logspace Float64 ?base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Float64 xa xb ya yb xn yn

let bernoulli ?p d = M.bernoulli Float64 ?p d

let hadamard n = M.hadamard Float64 n

let magic n = M.magic Float64 n

let of_array x m n = M.of_array Float64 x m n

let of_arrays x = M.of_arrays Float64 x

let load f = M.load Float64 f

let load_txt ?sep f = M.load_txt Float64 ?sep f

(* specific functions for float64 matrix *)

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let vector_uniform n = uniform 1 n

let conj x = copy x
