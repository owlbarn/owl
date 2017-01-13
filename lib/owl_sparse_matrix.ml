(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_sparse_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable m   : int;                             (* number of rows *)
  mutable n   : int;                             (* number of columns *)
  mutable k   : ('a, 'b) kind;                   (* type of sparse matrices *)
  mutable d   : int;                             (* point to eigen struct *)
}

let create k m n = Eigen.Sparse.D.create m n
