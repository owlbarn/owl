(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_sparse_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable m : int;                             (* number of rows *)
  mutable n : int;                             (* number of columns *)
  mutable k : ('a, 'b) kind;                   (* type of sparse matrices *)
  mutable d : ('a, 'b) eigen_mat;              (* point to eigen struct *)
}

let zeros k m n = {
  m = m;
  n = n;
  k = k;
  d = (_eigen_create) k m n;
}

let eye k m = {
  m = m;
  n = m;
  k = k;
  d = (_eigen_eye) k m;
}

let shape x = (x.m, x.n)

let row_num x = x.m

let col_num x = x.n

let numel x = x.m * x.n

let nnz x = _eigen_nnz x.d

let density x = (float_of_int (nnz x)) /. (float_of_int (numel x))

let kind x = x.k

let set x i j a = _eigen_set x.d i j a

let get x i j = _eigen_get x.d i j

let reset x = _eigen_reset x.d

let clone x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_clone x.d;
}

let transpose x = {
  m = x.m;
  n = x.n;
  k = x.k;
  d = _eigen_transpose x.d;
}

let diag x = {
  m = min x.m x.n;
  n = 1;
  k = x.k;
  d = _eigen_diagonal x.d;
}

let trace x = _eigen_trace x.d

let row x i = {
  m = 1;
  n = x.n;
  k = x.k;
  d = _eigen_row x.d i;
}

let col x j = {
  m = x.m;
  n = 1;
  k = x.k;
  d = _eigen_col x.d j;
}




(* ends here *)
