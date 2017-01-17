(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex dense matrix module ]  *)

open Bigarray

type mat = (Complex.t, Bigarray.complex64_elt) Owl_dense_matrix.t

type elt = Complex.t

include Owl_dense_matrix

(* overload functions in Owl_dense_matrix *)

let empty m n = Owl_dense_matrix.empty Complex64 m n

let create m n a = Owl_dense_matrix.create Complex64 m n a

let zeros m n = Owl_dense_matrix.zeros Complex64 m n

let ones m n = Owl_dense_matrix.ones Complex64 m n

let eye m = Owl_dense_matrix.eye Complex64 m

let sequential m n = Owl_dense_matrix.sequential Complex64 m n

let uniform ?(scale=1.) m n = Owl_dense_matrix.uniform Complex64 ~scale m n

let gaussian ?(sigma=1.) m n = Owl_dense_matrix.gaussian Complex64 m n

(* let semidef m = Owl_dense_matrix.semidef Complex64 m *)

let linspace a b n = Owl_dense_matrix.linspace Complex64 a b n

let meshgrid xa xb ya yb xn yn = Owl_dense_matrix.meshgrid Complex64 xa xb ya yb xn yn

let of_array x m n = Owl_dense_matrix.of_array Complex64 x m n

let of_arrays x = Owl_dense_matrix.of_arrays Complex64 x

let load f = Owl_dense_matrix.load Complex64 f

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

let abs x = map (fun y -> Complex.({re = norm y; im = 0.})) x

let abs2 x = map (fun y -> Complex.({re = norm2 y; im = 0.})) x


(* ends here *)
