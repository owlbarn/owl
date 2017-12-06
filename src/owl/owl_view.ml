(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Owl_types

module S = Pervasives


(* Functor of making a View module of given Ndarray module *)

module Make
  (A : NdarraySig)
  = struct

  type t = {
    mutable shape : int array;
    mutable slice : int array array;
    mutable data  : A.arr
  }


  let make_view shape slice data = {
    shape;
    slice;
    data;
  }


  (* adjust slice s1 according to s0 on one dimension *)
  let project_slice_dim s0 s1 =
    let start_0, stop_0, stride_0 = s0.(0), s0.(1), s0.(2) in
    let start_1, stop_1, stride_1 = s1.(0), s1.(1), s1.(2) in
    let start_2 = start_0 + start_1 * stride_0 in
    let stop_2 = start_0 + stop_1 * stride_0 in
    let stride_2 = stride_0 * stride_1 in
    [| start_2; stop_2; stride_2 |]


  (* project slice s1 to s0 on all dimensions *)
  let project_slice s0 s1 = Array.map2 project_slice_dim s0 s1


  let of_arr x =
    let shape = A.shape x in
    let s0 = Array.(make (length shape)) (R_ [||]) in
    let s1 = Owl_slicing.check_slice_definition s0 shape
      |> Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr")
    in
    make_view shape s1 x


  let to_arr x = ()


  let get x i = ()


  let set x i a = ()


  let get_slice_simple axis x =
    let s0 = Array.of_list axis |> Array.(map of_list) in
    let s1 = Array.map (fun a -> R_ a) s0 in
    let s1 = Owl_slicing.check_slice_definition s1 x.shape in
    let s2 = Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr") s1 in
    let slice = project_slice x.slice s2 in
    let shape = Owl_slicing.calc_slice_shape s1 in
    make_view shape slice x.data


  let set_slice_simple axis x y = ()


end
