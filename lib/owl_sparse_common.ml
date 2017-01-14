(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Eigen_types

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) eigen_mat = ('a, 'b) spmat

let _eigen_create : type a b . (a, b) kind -> int -> int -> (a, b) eigen_mat =
  fun k m n -> match k with
  | Float32   -> SPMAT_S (Eigen.Sparse.S.create m n)
  | Float64   -> SPMAT_D (Eigen.Sparse.D.create m n)
  | Complex32 -> SPMAT_C (Eigen.Sparse.C.create m n)
  | Complex64 -> SPMAT_Z (Eigen.Sparse.Z.create m n)
  | _         -> failwith "_eigen_create: unsupported operation"
