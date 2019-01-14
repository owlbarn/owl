(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex dense matrix module ]  *)

open Bigarray

module M = Owl_dense_matrix_generic
include M

type elt = Complex.t
type mat = (Complex.t, Bigarray.complex64_elt) M.t
type cast_mat = (float, float64_elt) Owl_dense_matrix_generic.t


(* overload functions in Owl_dense_matrix_generic *)

let empty m n = M.empty Complex64 m n

let create m n a = M.create Complex64 m n a

let init m n f = M.init Complex64 m n f

let init_2d m n f = M.init_2d Complex64 m n f

let zeros m n = M.zeros Complex64 m n

let ones m n = M.ones Complex64 m n

let eye m = M.eye Complex64 m

let sequential ?a ?step m n = M.sequential Complex64 ?a ?step m n

let uniform ?a ?b m n = M.uniform Complex64 ?a ?b m n

let gaussian ?mu ?sigma m n = M.gaussian Complex64 ?mu ?sigma m n

(* let semidef m = M.semidef Complex64 m *)

let linspace a b n = M.linspace Complex64 a b n

let logspace ?base a b n = M.logspace Complex64 ?base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Complex64 xa xb ya yb xn yn

let bernoulli ?p d = M.bernoulli Complex64 ?p d

let hadamard n = M.hadamard Complex64 n

let magic n = M.magic Complex64 n

let of_array x m n = M.of_array Complex64 x m n

let of_arrays x = M.of_arrays Complex64 x

let load f = M.load Complex64 f

let load_txt ?sep f = M.load_txt Complex64 ?sep f

(* specific functions for complex64 matrix *)

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let vector_uniform n = uniform 1 n

let re x = re_z2d x

let im x = im_z2d x

let complex = complex Float64 Complex64

let polar = polar Float64 Complex64


(* ends here *)
