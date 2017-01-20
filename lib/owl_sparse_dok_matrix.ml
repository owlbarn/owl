(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


open Bigarray
open Owl_sparse_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable m : int;                             (* number of rows *)
  mutable n : int;                             (* number of columns *)
  mutable k : ('a, 'b) kind;                   (* type of sparse matrices *)
  mutable d : (int * int, 'a) Hashtbl.t;       (* hashtbl for storing data *)
}

let zeros ?(density=0.01) k m n = {
  m = m;
  n = n;
  k = k;
  d = let c = int_of_float (float_of_int (m * n) *. density) in
  Hashtbl.create c;
}

(* FIXME: check boundary *)
let set x i j a =
  match Hashtbl.mem x.d (i,j) with
  | true  -> Hashtbl.replace x.d (i,j) a
  | false -> Hashtbl.add x.d (i,j) a

let get x i j =
  match Hashtbl.mem x.d (i,j) with
  | true  -> Hashtbl.find x.d (i,j)
  | false -> Owl_types._zero (x.k)


let nnz = None

let prune = None
