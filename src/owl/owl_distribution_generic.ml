(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_dense_common

open Owl_dense_ndarray_generic

open Owl_distribution_common


(* align and calculate the output shape for broadcasting over [x0] and [x1] *)
let broadcast_align_shape x0 x1 =
  (* align the rank of inputs *)
  let d0 = num_dims x0 in
  let d1 = num_dims x1 in
  let d3 = Pervasives.max d0 d1 in
  let y0 = expand x0 d3 in
  let y1 = expand x1 d3 in
  (* check whether the shape is valid *)
  let s0 = shape y0 in
  let s1 = shape y1 in
  Array.iter2 (fun a b ->
    assert (not(a <> 1 && b <> 1 && a <> b))
  ) s0 s1;
  (* calculate the strides *)
  let t0 = _calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = _calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* return aligned arrays, shapes, strides *)
  y0, y1, s0, s1, t0, t1


(* general broadcast operation for add/sub/mul/div and etc.
  This function compares the dimension element-wise from the highest to the
  lowest with the following broadcast rules (same as numpy):
  1. equal; 2. either is 1.
 *)
let broadcast_op op x0 x1 n =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let s2 = Array.(map2 Pervasives.max s0 s1 |> append [|n|]) in
  let t2 = _calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let y2 = empty (kind x0) s2 in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2


let uniform_rvs ~a ~b ~n = broadcast_op (_owl_uniform_rvs (kind a)) a b n


let gaussian_rvs ~mu ~sigma ~n = broadcast_op (_owl_gaussian_rvs (kind mu)) mu sigma n


(* ends here *)
