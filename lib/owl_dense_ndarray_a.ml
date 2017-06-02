(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common

type 'a arr = {
  mutable shape  : int array;
  mutable stride : int array;
  mutable data   : 'a array;
}

let _calc_numel_from_shape s = Array.fold_left (fun a b -> a * b) 1 s

let create d a =
  let n = _calc_numel_from_shape d in
  {
    shape  = d;
    stride = _calc_stride d;
    data   = Array.make n a
  }

let get x i = x.data.(_index_nd_1d i x.stride)

let set x i a = x.data.(_index_nd_1d i x.stride) <- a

let num_dims x = Array.length x.shape

let shape x = x.shape

let nth_dim x i = x.shape.(i)

let numel x = _calc_numel_from_shape x.shape

let sub_left = None

let slice_left = None

let copy src dst = None

let fill x a = x.data <- Array.(make (length x.data) a)

let reshape x d =
  let m = _calc_numel_from_shape x.shape in
  let n = _calc_numel_from_shape d in
  assert (m = n);
  x.shape <- d

let flatten x = x.shape <- [|Array.length x.data|]

let clone x = {
  shape  = Array.copy x.shape;
  stride = Array.copy x.stride;
  data   = Array.copy x.data;
}

let same_shape x y = x.shape = y.shape



(* ends here *)
