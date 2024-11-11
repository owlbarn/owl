(*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 *)

open Bigarray
open Owl_core_types

(* Forward Real FFT *)
external owl_float32_rfftf
  :  (float, float32_elt) owl_arr
  -> (Complex.t, complex32_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float32_rfftf"

external owl_float64_rfftf
  :  (float, float64_elt) owl_arr
  -> (Complex.t, complex64_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float64_rfftf"

let _owl_rfftf
  : type a b c d.
    (a, b) kind
    -> (c, d) kind
    -> (a, b) owl_arr
    -> (c, d) owl_arr
    -> int
    -> int
    -> int
    -> unit
  =
  fun ityp otyp x y axis norm nthreads ->
  match ityp, otyp with
  | Float32, Complex32 -> owl_float32_rfftf x y axis norm nthreads
  | Float64, Complex64 -> owl_float64_rfftf x y axis norm nthreads
  | _ -> failwith "_owl_rfftf: unsupported operation"


(* Backward Real FFT *)

external owl_float32_rfftb
  :  (Complex.t, complex32_elt) owl_arr
  -> (float, float32_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float32_rfftb"

external owl_float64_rfftb
  :  (Complex.t, complex64_elt) owl_arr
  -> (float, float64_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float64_rfftb"

let _owl_rfftb
  : type a b c d.
    (a, b) kind
    -> (c, d) kind
    -> (a, b) owl_arr
    -> (c, d) owl_arr
    -> int
    -> int
    -> int
    -> unit
  =
  fun ityp otyp x y axis norm nthreads ->
  match ityp, otyp with
  | Complex32, Float32 -> owl_float32_rfftb x y axis norm nthreads
  | Complex64, Float64 -> owl_float64_rfftb x y axis norm nthreads
  | _ -> failwith "_owl_rfftb: unsupported operation"


external owl_complex32_cfft
  :  bool
  -> (Complex.t, complex32_elt) owl_arr
  -> (Complex.t, complex32_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float64_cfft_bytecode" "float32_cfft"

external owl_complex64_cfft
  :  bool
  -> (Complex.t, complex64_elt) owl_arr
  -> (Complex.t, complex64_elt) owl_arr
  -> int
  -> int
  -> int
  -> unit
  = "float64_cfft_bytecode" "float64_cfft"

let _owl_cfftf
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> int -> unit
  = function
  | Complex32 -> true |> owl_complex32_cfft
  | Complex64 -> true |> owl_complex64_cfft
  | _ -> failwith "_owl_cfftf: unsupported operation"


let _owl_cfftb
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> int -> int -> unit
  = function
  | Complex32 -> false |> owl_complex32_cfft
  | Complex64 -> false |> owl_complex64_cfft
  | _ -> failwith "_owl_cfftb: unsupported operation"


(* DCT and DST *)

(* little helper to get the inverse type of DSTs and DCTs *)
let inverse_map = function
  | 1 -> 1
  | 2 -> 3
  | 3 -> 2
  | 4 -> 4
  | _ -> failwith "unknown transform type"


(* DCT *)

external owl_float32_dct
  :  (float, float32_elt) owl_arr
  -> (float, float32_elt) owl_arr
  -> int
  -> int
  -> int
  -> bool
  -> int
  -> unit
  = "float32_dct_bytecode" "float32_dct"

external owl_float64_dct
  :  (float, float64_elt) owl_arr
  -> (float, float64_elt) owl_arr
  -> int
  -> int
  -> int
  -> bool
  -> int
  -> unit
  = "float64_dct_bytecode" "float64_dct"

let _owl_dctf
  : type a b.
    (a, b) kind
    -> (a, b) owl_arr
    -> (a, b) owl_arr
    -> int
    -> int
    -> int
    -> bool
    -> int
    -> unit
  = function
  | Float32 -> owl_float32_dct
  | Float64 -> owl_float64_dct
  | _ -> failwith "_owl_dctf: unsupported operation"


let _owl_dctb
  : type a b.
    (a, b) kind
    -> (a, b) owl_arr
    -> (a, b) owl_arr
    -> int
    -> int
    -> int
    -> bool
    -> int
    -> unit
  =
  fun ityp x y ttype axis norm ortho nthreads ->
  match ityp with
  | Float32 -> owl_float32_dct x y (inverse_map ttype) axis norm ortho nthreads
  | Float64 -> owl_float64_dct x y (inverse_map ttype) axis norm ortho nthreads
  | _ -> failwith "_owl_dctb: unsupported operation"


(* DST *)

external owl_float32_dst
  :  (float, float32_elt) owl_arr
  -> (float, float32_elt) owl_arr
  -> int
  -> int
  -> int
  -> bool
  -> int
  -> unit
  = "float32_dst_bytecode" "float32_dst"

external owl_float64_dst
  :  (float, float64_elt) owl_arr
  -> (float, float64_elt) owl_arr
  -> int
  -> int
  -> int
  -> bool
  -> int
  -> unit
  = "float64_dst_bytecode" "float64_dst"

let _owl_dstf
  : type a b.
    (a, b) kind
    -> (a, b) owl_arr
    -> (a, b) owl_arr
    -> int
    -> int
    -> int
    -> bool
    -> int
    -> unit
  = function
  | Float32 -> owl_float32_dst
  | Float64 -> owl_float64_dst
  | _ -> failwith "_owl_dstf: unsupported operation"


let _owl_dstb
  : type a b.
    (a, b) kind
    -> (a, b) owl_arr
    -> (a, b) owl_arr
    -> int
    -> int
    -> int
    -> bool
    -> int
    -> unit
  =
  fun ityp x y ttype axis norm ortho nthreads ->
  match ityp with
  | Float32 -> owl_float32_dst x y (inverse_map ttype) axis norm ortho nthreads
  | Float64 -> owl_float64_dst x y (inverse_map ttype) axis norm ortho nthreads
  | _ -> failwith "_owl_dstb: unsupported operation"
