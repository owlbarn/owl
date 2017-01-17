(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ]
  The default format is compressed row storage (CRS).
 *)

open Bigarray

type mat = (Complex.t, Bigarray.complex64_elt) Owl_sparse_matrix.t

type elt = Complex.t

include Owl_sparse_matrix

(* overload functions in Owl_sparse_matrix *)

let zeros m n = Owl_sparse_matrix.zeros Complex64 m n

let ones m n = Owl_sparse_matrix.ones Complex64 m n

let eye m = Owl_sparse_matrix.eye Complex64 m

let binary m n = Owl_sparse_matrix.binary Complex64 m n

let uniform ?(scale=1.) m n = Owl_sparse_matrix.uniform ~scale Complex64 m n

let sequential m n = Owl_sparse_matrix.sequential Complex64 m n

let permutation_matrix m = Owl_sparse_matrix.permutation_matrix Complex64 m

let of_array m n x = Owl_sparse_matrix.of_array Complex64 m n x

let load f = Owl_sparse_matrix.load Complex64 f

(* specific functions for complex64 matrix *)

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = zeros m n in
  for k = 0 to c do
    let i = Owl_stats.Rnd.uniform_int ~a:0 ~b:(m-1) () in
    let j = Owl_stats.Rnd.uniform_int ~a:0 ~b:(n-1) () in
    set x i j (f ())
  done;
  x

let uniform_int ?(a=1) ?(b=99) m n =
  _random_basic (fun () ->
    let re = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    let im = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    Complex.({re; im})
  ) m n



(** ends here *)
