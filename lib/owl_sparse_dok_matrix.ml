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

let row_num x = x.m

let col_num x = x.n

let shape x = (x.m, x.n)

let numel x = x.m * x.n

let prune x r =
  Hashtbl.filter_map_inplace (fun _ v ->
    if v = r then None
    else Some v
  ) x.d

let nnz x =
  let _ = prune x (Owl_types._zero x.k) in
  Hashtbl.((stats x.d).num_bindings)

(* FIXME: check boundary in get and set *)

let set x i j a =
  let _a0 = Owl_types._zero x.k in
  match Hashtbl.mem x.d (i,j) with
  | true  -> (
    if a <> _a0 then Hashtbl.replace x.d (i,j) a
    else Hashtbl.remove x.d (i,j)
    )
  | false -> (
    if a <> _a0 then Hashtbl.add x.d (i,j) a
    )

let get x i j =
  match Hashtbl.mem x.d (i,j) with
  | true  -> Hashtbl.find x.d (i,j)
  | false -> Owl_types._zero (x.k)
