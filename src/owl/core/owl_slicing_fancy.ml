(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types

open Owl_dense_common

open Owl_dense_common_types


(* Interface to the native c functions *)

external owl_float32_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_get_fancy"
external owl_float64_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_get_fancy"
external owl_complex32_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_get_fancy"
external owl_complex64_ndarray_get_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_get_fancy"

let _ndarray_get_fancy
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_get_fancy
  | Float64   -> owl_float64_ndarray_get_fancy
  | Complex32 -> owl_complex32_ndarray_get_fancy
  | Complex64 -> owl_complex64_ndarray_get_fancy
  | _         -> failwith "_ndarray_get_fancy: unsupported operation"


external owl_float32_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float32_ndarray_set_fancy"
external owl_float64_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_float64_ndarray_set_fancy"
external owl_complex32_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex32_ndarray_set_fancy"
external owl_complex64_ndarray_set_fancy : ('a, 'b) owl_arr -> ('a, 'b) owl_arr -> (int64, 'c) owl_arr -> (int64, 'c) owl_arr -> unit = "stub_complex64_ndarray_set_fancy"

let _ndarray_set_fancy
  : type a b c. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> (int64, c) owl_arr -> (int64, c) owl_arr -> unit
  = function
  | Float32   -> owl_float32_ndarray_set_fancy
  | Float64   -> owl_float64_ndarray_set_fancy
  | Complex32 -> owl_complex32_ndarray_set_fancy
  | Complex64 -> owl_complex64_ndarray_set_fancy
  | _         -> failwith "_ndarray_set_fancy: unsupported operation"


(* Core functions for fancy slicing *)


let _calc_total_list_len axis =
  Array.fold_left (fun a x ->
    match x with
    | L_ x -> a + Array.length x
    | _    -> a
  ) 0 axis


(* This function encodes the slice definition into the slice and index two
  fields in fancy pair c data strcture. The slice definition needs to be
  normalised by [check_slice_definition] function first.

  Refer to owl_slicing.h file for fancy pare structure.
 *)
let encode_slice_definition axis =
  let n0 = 3 * Array.length axis in
  let n1 = _calc_total_list_len axis in
  Printf.printf "==>%i\n" n1; flush_all();
  let slice = Genarray.create Int64 C_layout [|3 * n0|] in
  let index = Genarray.create Int64 C_layout [|n1|] in
  let k = ref 0 in
  Array.iteri (fun i a ->
    let j = 3 * i in
    match a with
    | L_ x -> (
        let l = Array.length x in
        Genarray.set slice [|j|]     (Int64.of_int (-1));
        Genarray.set slice [|j + 1|] (Int64.of_int !k);
        Genarray.set slice [|j + 2|] (Int64.of_int (!k + l - 1));
        Array.iteri (fun o y ->
          Genarray.set index [|!k + o|] (Int64.of_int y)
        ) x;
        k := !k + l;
      )
    | R_ x -> (
        Genarray.set slice [|j|]     (Int64.of_int x.(0));
        Genarray.set slice [|j + 1|] (Int64.of_int x.(1));
        Genarray.set slice [|j + 2|] (Int64.of_int x.(2));
      )
    | _    -> failwith "encode_slice_definition"
  ) axis;
  slice, index


let get kind axis x y =
  let slice, index = encode_slice_definition axis in
  _ndarray_get_fancy kind x y slice index


let set kind axis x y =
  let slice, index = encode_slice_definition axis in
  _ndarray_set_fancy kind x y slice index



(* ends here *)
