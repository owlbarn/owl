(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray
open Owl_core_types


external owl_float32_rfftf : (float, float32_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> int -> unit = "float32_rfftf"
external owl_float64_rfftf : (float, float64_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> int -> unit = "float64_rfftf"

let _owl_rfftf
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) owl_arr -> (c, d) owl_arr -> int -> unit
  = fun ityp otyp x y axis ->
  match ityp, otyp with
  | Float32, Complex32 -> owl_float32_rfftf x y axis
  | Float64, Complex64 -> owl_float64_rfftf x y axis
  | _                  -> failwith "_owl_rfftf: unsupported operation"


external owl_float32_rfftb : (Complex.t, complex32_elt) owl_arr -> (float, float32_elt) owl_arr -> int -> unit = "float32_rfftb"
external owl_float64_rfftb : (Complex.t, complex64_elt) owl_arr -> (float, float64_elt) owl_arr -> int -> unit = "float64_rfftb"

let _owl_rfftb
  : type a b c d. (a, b) kind -> (c, d) kind -> (a, b) owl_arr -> (c, d) owl_arr -> int -> unit
  = fun ityp otyp x y axis ->
  match ityp, otyp with
  | Complex32, Float32 -> owl_float32_rfftb x y axis
  | Complex64, Float64 -> owl_float64_rfftb x y axis
  | _                  -> failwith "_owl_rfftb: unsupported operation"


external owl_complex32_cfftf : (Complex.t, complex32_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> int -> unit = "float32_cfftf"
external owl_complex64_cfftf : (Complex.t, complex64_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> int -> unit = "float64_cfftf"

let _owl_cfftf
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> unit
  = function
  | Complex32 -> owl_complex32_cfftf
  | Complex64 -> owl_complex64_cfftf
  | _         -> failwith "_owl_cfftf: unsupported operation"


external owl_complex32_cfftb : (Complex.t, complex32_elt) owl_arr -> (Complex.t, complex32_elt) owl_arr -> int -> unit = "float32_cfftb"
external owl_complex64_cfftb : (Complex.t, complex64_elt) owl_arr -> (Complex.t, complex64_elt) owl_arr -> int -> unit = "float64_cfftb"

let _owl_cfftb
  : type a b. (a, b) kind -> (a, b) owl_arr -> (a, b) owl_arr -> int -> unit
  = function
  | Complex32 -> owl_complex32_cfftb
  | Complex64 -> owl_complex64_cfftb
  | _         -> failwith "_owl_cfftf: unsupported operation"
