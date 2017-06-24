(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex dense matrix module ]  *)

open Bigarray

module M = Owl_dense_matrix_generic
include M

type elt = Complex.t
type mat = (Complex.t, Bigarray.complex32_elt) M.t
type cast_mat = (float, float32_elt) Owl_dense_matrix_generic.t


(* overload functions in Owl_dense_matrix_generic *)

let empty m n = M.empty Complex32 m n

let create m n a = M.create Complex32 m n a

let init m n f = M.init Complex32 m n f

let init_nd m n f = M.init_nd Complex32 m n f

let zeros m n = M.zeros Complex32 m n

let ones m n = M.ones Complex32 m n

let eye m = M.eye Complex32 m

let sequential ?a ?step m n = M.sequential Complex32 ?a ?step m n

let uniform ?(scale=1.) m n = M.uniform Complex32 ~scale m n

let gaussian ?(sigma=1.) m n = M.gaussian Complex32 ~sigma m n

(* let semidef m = M.semidef Complex32 m *)

let linspace a b n = M.linspace Complex32 a b n

let logspace ?(base=Owl_maths.e) a b n = M.logspace Complex32 ~base a b n

let meshgrid xa xb ya yb xn yn = M.meshgrid Complex32 xa xb ya yb xn yn

let bernoulli ?p ?seed d = M.bernoulli Complex32 ?p ?seed d

let hadamard n = M.hadamard Complex32 n

let of_array x m n = M.of_array Complex32 x m n

let of_arrays x = M.of_arrays Complex32 x

let load f = M.load Complex32 f

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

let abs x = abs_c2s x

let abs2 x = abs2_c2s x

let re x = re_c2s x

let im x = im_c2s x


(* ends here *)
