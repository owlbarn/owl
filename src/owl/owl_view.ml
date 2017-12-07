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


  (* core functions *)


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


  (* project the index onto the slice on one dimension *)
  let project_index_dim s i =
    let start_, stop_, stride_ = s.(0), s.(1), s.(2) in
    start_ + i * stride_


  (* project indices onto the slice on all dimensions *)
  let project_index s i = Array.map2 project_index_dim s i


  let of_arr x =
    let shape = A.shape x in
    let s0 = Array.(make (length shape)) (R_ [||]) in
    let s1 = Owl_slicing.check_slice_definition s0 shape
      |> Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr")
    in
    make_view shape s1 x


  let to_arr x =
    let slice = Array.(map (fun a -> R (to_list a)) x.slice |> to_list) in
    A.get_slice slice x.data


  (* manipulation functions *)


  let num_dims x = Array.length x.shape


  let shape x = x.shape


  let get x i =
    let i' = project_index x.slice i in
    A.get x.data i'


  let set x i a =
    let i' = project_index x.slice i in
    A.set x.data i' a


  let get_slice_simple axis x =
    let s0 = Array.of_list axis |> Array.(map of_list) in
    let s1 = Array.map (fun a -> R_ a) s0 in
    let s1 = Owl_slicing.check_slice_definition s1 x.shape in
    let s2 = Array.map (function R_ a -> a | _ -> failwith "owl_view:of_arr") s1 in
    let slice = project_slice x.slice s2 in
    let shape = Owl_slicing.calc_slice_shape s1 in
    make_view shape slice x.data


  let set_slice_simple axis x y = ()


  (* iteration functions *)


  let rec _iteri f x i s dim =
    if dim = (Array.length i) - 1 then (
      for j = 0 to s.(dim) - 1 do
        i.(dim) <- j;
        f i (get x i)
      done
    )
    else (
      for j = 0 to s.(dim) - 1 do
        i.(dim) <- j;
        _iteri f x i s (dim + 1)
      done
    )


  let iteri f x =
    let i = Array.make (num_dims x) 0 in
    _iteri f x i x.shape 0


  let iter f x = iteri (fun _ a -> f a) x


  let mapi f x = iteri (fun i a -> set x i (f i a)) x


  let map f x = iteri (fun i a -> set x i (f a)) x


  let fold ?axis f x = ()


end
