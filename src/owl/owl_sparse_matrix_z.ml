(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ]
  The default format is compressed row storage (CRS).
 *)

open Bigarray

module M = Owl_sparse_matrix_generic
include M

type elt = Complex.t
type mat = (Complex.t, Bigarray.complex64_elt) Owl_sparse_matrix_generic.t


(* overload functions in Owl_sparse_matrix *)

let zeros m n = M.zeros Complex64 m n

let ones m n = M.ones Complex64 m n

let eye m = M.eye Complex64 m

let binary m n = M.binary Complex64 m n

let uniform ?(scale=1.) m n = M.uniform ~scale Complex64 m n

let sequential m n = M.sequential Complex64 m n

let permutation_matrix m = M.permutation_matrix Complex64 m

let of_array m n x = M.of_array Complex64 m n x

let load f = M.load Complex64 f

(* specific functions for complex64 matrix *)

let _random_basic f m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.15) in
  let x = M.zeros ~density:0.2 Complex64 m n in
  let l = Owl_stats.choose (Array.init (m * n) (fun i -> i)) c in
  for k = 0 to c - 1 do
    let i = l.(k) / n in
    let j = l.(k) - (i * n) in
    insert x i j (f ())
  done;
  x

let uniform_int ?(a=1) ?(b=99) m n =
  _random_basic (fun () ->
    let re = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    let im = Owl_stats.Rnd.uniform_int ~a ~b () |> float_of_int in
    Complex.({re; im})
  ) m n



(** ends here *)
