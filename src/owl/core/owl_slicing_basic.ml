(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_dense_common_types


(* Interface to the native c functions *)

external owl_float32_ndarray_get_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_get_slice"
external owl_float64_ndarray_get_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_get_slice"
external owl_complex32_ndarray_get_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_get_slice"
external owl_complex64_ndarray_get_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_get_slice"

let _ndarray_get_slice
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_get_slice
  | Float64   -> owl_float64_ndarray_get_slice
  | Complex32 -> owl_complex32_ndarray_get_slice
  | Complex64 -> owl_complex64_ndarray_get_slice
  | _         -> failwith "_ndarray_get_slice: unsupported operation"


external owl_float32_ndarray_set_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_set_slice"
external owl_float64_ndarray_set_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_set_slice"
external owl_complex32_ndarray_set_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_set_slice"
external owl_complex64_ndarray_set_slice : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_set_slice"

let _ndarray_set_slice
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_set_slice
  | Float64   -> owl_float64_ndarray_set_slice
  | Complex32 -> owl_complex32_ndarray_set_slice
  | Complex64 -> owl_complex64_ndarray_set_slice
  | _         -> failwith "_ndarray_set_slice: unsupported operation"


(* Core functions for fancy slicing *)


(* encode slice definition consisting only R_ to (start,stop,step) triplets *)
let encode_slice_definition s =
  let t = Genarray.create Int64 C_layout [|3 * Array.length s|] in
  Array.iteri (fun i a ->
    match a with
    | R_ x -> (
        let j = 3 * i in
        Genarray.set t [|j|]     (Int64.of_int x.(0));
        Genarray.set t [|j + 1|] (Int64.of_int x.(1));
        Genarray.set t [|j + 2|] (Int64.of_int x.(2));
      )
    | _    -> failwith "owl_slicing_basic:encode_slice_definition"
  ) s;
  t


let get kind axis x y =
  let triplets = encode_slice_definition axis in
  _ndarray_get_slice kind x y triplets


let set kind axis x y =
  let triplets = encode_slice_definition axis in
  _ndarray_set_slice kind x y triplets
