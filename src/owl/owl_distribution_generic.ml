(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_dense_common

open Owl_dense_ndarray_generic

open Owl_distribution_common


(* TODO: same as that in Owl_dense_ndarray_generic, need to combine soon. *)
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


(* broadcast for [f : x -> y -> z] *)
let broadcast_op0 op x0 x1 n =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let s2 = Array.(map2 Pervasives.max s0 s1 |> append [|n|]) in
  let t2 = _calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let y2 = empty (kind x0) s2 in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2


(* broadcast for [f : x -> y] *)
let broadcast_op1 op x n =
  let y = empty (kind x) (Array.append [|n|] (shape x)) in
  let x, y, sx, sy, tx, ty = broadcast_align_shape x y in
  (* call the specific map function *)
  op x tx y ty y ty;
  y


let uniform_rvs ~a ~b ~n = broadcast_op0 (_owl_uniform_rvs (kind a)) a b n




let gaussian_rvs ~mu ~sigma ~n = broadcast_op0 (_owl_gaussian_rvs (kind mu)) mu sigma n


let exponential_rvs ~lambda ~n = broadcast_op1 (_owl_exponential_rvs (kind lambda)) lambda n



(* ends here *)
