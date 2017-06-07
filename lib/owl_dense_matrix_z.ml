(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
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

let init_nd m n f = M.init_nd Complex64 m n f

let zeros m n = M.zeros Complex64 m n

let ones m n = M.ones Complex64 m n

let eye m = M.eye Complex64 m

let sequential ?a ?step m n = M.sequential Complex64 ?a ?step m n

let uniform ?(scale=1.) m n = M.uniform Complex64 ~scale m n

let gaussian ?(sigma=1.) m n = M.gaussian Complex64 ~sigma m n

(* let semidef m = M.semidef Complex64 m *)

let linspace a b n = M.linspace Complex64 a b n

let logspace ?(base=Owl_maths.e) a b n = M.logspace Complex64 ~base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Complex64 xa xb ya yb xn yn

let bernoulli ?p ?seed d = M.bernoulli Complex64 ?p ?seed d

let of_array x m n = M.of_array Complex64 x m n

let of_arrays x = M.of_arrays Complex64 x

let load f = M.load Complex64 f

(* specific functions for complex64 matrix *)

let vector n = empty 1 n

let vector_ones n = ones 1 n

let vector_zeros n = zeros 1 n

let vector_uniform n = uniform 1 n

let uniform_int ?(a=0) ?(b=99) m n =
  let x = empty m n in
  iteri (fun i j _ ->
    let re = float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ()) in
    let im = float_of_int (Owl_stats.Rnd.uniform_int ~a ~b ()) in
    x.{i,j} <- Complex.({re; im})
  ) x; x

let abs x = abs_z2d x

let abs2 x = abs2_z2d x

let re x = re_z2d x

let im x = im_z2d x


(* ends here *)
