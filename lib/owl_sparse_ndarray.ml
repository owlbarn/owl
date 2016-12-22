(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_dense_common

type ('a, 'b) kind = ('a, 'b) Bigarray.kind

type ('a, 'b) t = {
  mutable s : int array;
  mutable h : (int array, int) Hashtbl.t;
  mutable d : ('a, 'b, c_layout) Array1.t;
}

let _make_elt_array k n =
  let x = Array1.create k c_layout n in
  Array1.fill x (_zero k);
  x

let empty k s =
  let n = Array.fold_right (fun c a -> c * a) s 1 in
  let c = max (n / 1000) 1024 in
  {
    s = Array.copy s;
    h = Hashtbl.create c;
    d = _make_elt_array k c;
  }

let shape x = Array.copy x.s

let num_dims x = Array.length x.s

let nth_dim x i = x.s.(i)

let numel x = Array.fold_right (fun c a -> c * a) x.s 1

let nnz x =
  let _stats = Hashtbl.stats x.h in
  Hashtbl.(_stats.num_bindings)
