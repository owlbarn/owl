(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_dense_common
open Owl_dense_ndarray_generic

type slice_range =
  | All
  | Index   of int
  | Range   of int * int
  | Step    of int * int * int
  | Indices of int array

type slice = slice_range array

let check_slice_definition axis s =
  if Array.length axis <> Array.length s then
    failwith "check_slice_definition: length does not match";
  Array.iteri (fun i a ->
    match a with
    | All   -> ()
    | Index a -> (
      if a < 0 || a >= s.(i) then
        failwith "check_slice_definition: index error"
      )
    | Range (a, b) -> (
      if a < 0 || b >= s.(i) || b > -s.(i) then
        failwith "check_slice_definition: range error"
      )
    | Step (a, b, c) -> (
      if a < 0 || b >= s.(i) || b > -s.(i) then
        failwith "check_slice_definition: step error"
      )
    | Indices l -> (
      if (Array.exists (fun x -> x < 0 && x >= s.(i)) l) then
        failwith "check_slice_definition: indices error"
      )
  ) axis

let calc_slice_shape axis shape0 stride0 = None
  

let calc_continuous_blksz shp axis =
  let stride = _calc_stride shp in
  let l = ref (Array.length shp - 1) in
  let ssz = ref 1 in
  while !l >= 0 && axis.(!l) = All do
    l := !l - 1
  done;
  if !l = (-1) then ssz := stride.(0) * shp.(0)
  else ssz := stride.(!l);
  !ssz

let copy_slice_1byte axis x =
  let s0 = shape x in
  let s1 = ref [||] in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> s1 := Array.append !s1 [|s0.(i)|]
  ) axis;
  let y = empty (kind x) !s1 in
  let k = Array.make (num_dims y) 0 in
  let t = ref 0 in
  Array.iteri (fun i a ->
    match a with
    | Some _ -> ()
    | None   -> (k.(!t) <- i; t := !t + 1)
  ) axis;
  let j = Array.make (num_dims y) 0 in
  iteri ~axis (fun i a ->
    Array.iteri (fun m m' -> j.(m) <- i.(m')) k;
    set y j a
  ) x;
  y

(* ends here *)
