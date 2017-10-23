(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Real dense matrix ]  *)

open Bigarray

module M = Owl_dense_matrix_generic
include M

type elt = float
type mat = (float, float32_elt) M.t


(* overload functions in Owl_dense_matrix_generic *)

let empty m n = M.empty Float32 m n

let create m n a = M.create Float32 m n a

let init m n f = M.init Float32 m n f

let init_nd m n f = M.init_nd Float32 m n f

let zeros m n = M.zeros Float32 m n

let ones m n = M.ones Float32 m n

let eye m = M.eye Float32 m

let sequential ?a ?step m n = M.sequential Float32 ?a ?step m n

let uniform ?(scale=1.) m n = M.uniform Float32 ~scale m n

let gaussian ?(sigma=1.) m n = M.gaussian Float32 ~sigma m n

let semidef m = M.semidef Float32 m

let linspace a b n = M.linspace Float32 a b n

let logspace ?(base=Owl_maths.e) a b n = M.logspace Float32 ~base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Float32 xa xb ya yb xn yn

let bernoulli ?p ?seed d = M.bernoulli Float32 ?p ?seed d

let hadamard n = M.hadamard Float32 n

let magic n = M.magic Float32 n

let of_array x m n = M.of_array Float32 x m n

let of_arrays x = M.of_arrays Float32 x

let load f = M.load Float32 f

let load_txt f = M.load_txt Float32 f

(* specific functions for float64 matrix *)

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let vector_uniform n = uniform 1 n

let uniform_int ?(a=0) ?(b=99) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    M.set x i j
    (float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ()))
  ) x; x

let conj x = copy x
