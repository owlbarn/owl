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

let nnz x =
  let _stats = Hashtbl.stats x.h in
  Hashtbl.(_stats.num_bindings)

let _make_elt_array k n =
  let x = Array1.create k c_layout n in
  Array1.fill x (_zero k);
  x

let _allocate_more_space x =
  let c = nnz x in
  if  c < Array1.dim x.d then ()
  else (
    Log.debug "allocate space %i" c;
    x.d <- Owl_utils.array1_extend x.d c;
  )

let _remove_ith_item x i =
  Log.debug "_remove_ith_item";
  for j = i to (nnz x) - 2 do
    x.d.{j} <- x.d.{j + 1}
  done;
  Hashtbl.filter_map_inplace (fun k v ->
    if v = i then None
    else if v > i then Some (v - 1)
    else Some v
  ) x.h

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

let density x =
  let a = float_of_int (nnz x) in
  let b = float_of_int (numel x) in
  a /. b

let kind x = Array1.kind (x.d)

let get x i =
  try let j = Hashtbl.find x.h i in
    Array1.unsafe_get x.d j
  with exn -> _zero (kind x)

let set x i a =
  let _a0 = _zero (kind x) in
  if a = _a0 then (
    try let j = Hashtbl.find x.h i in
      Array1.unsafe_set x.d j _a0;
      _remove_ith_item x j;
    with exn -> ()
  )
  else (
    try let j = Hashtbl.find x.h i in
      Array1.unsafe_set x.d j a;
    with exn -> (
      let j = nnz x in
      Hashtbl.add x.h i j;
      Array1.unsafe_set x.d j a
    )
  )



(* ends here *)
