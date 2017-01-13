(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_sparse_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) tt = ('a, 'b) Eigen_types.spmat

type ('a, 'b) t = {
  mutable m   : int;                             (* number of rows *)
  mutable n   : int;                             (* number of columns *)
  mutable k   : ('a, 'b) kind;                   (* type of sparse matrices *)
  mutable d   : int;                             (* point to eigen struct *)
}

let create : type a b . (a, b) kind -> int -> int -> (a, b) tt  = fun k m n ->
  match k with
  | Float32   -> SPMAT_S (Eigen.Sparse.S.create m n)
  | Float64   -> SPMAT_D (Eigen.Sparse.D.create m n)
  | Complex32 -> SPMAT_C (Eigen.Sparse.C.create m n)
  | Complex64 -> SPMAT_Z (Eigen.Sparse.Z.create m n)
