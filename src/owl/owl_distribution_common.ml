(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Interface to the C implementation of rvs, pdf, and cdf functions. *)

open Bigarray

open Owl_dense_common_types


external owl_float32_uniform_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_rvs" "float32_uniform_rvs_impl"
external owl_float64_uniform_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_rvs" "float64_uniform_rvs_impl"

let _owl_uniform_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_rvs
  | Float64        -> owl_float64_uniform_rvs
  | _              -> failwith "_owl_uniform_rvs: unsupported operation"

external owl_float32_gaussian_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_rvs" "float32_gaussian_rvs_impl"
external owl_float64_gaussian_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_rvs" "float64_gaussian_rvs_impl"

let _owl_gaussian_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_rvs
  | Float64        -> owl_float64_gaussian_rvs
  | _              -> failwith "_owl_gaussian_rvs: unsupported operation"

external owl_float32_exponential_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_rvs" "float32_exponential_rvs_impl"
external owl_float64_exponential_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_rvs" "float64_exponential_rvs_impl"

let _owl_exponential_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_rvs
  | Float64        -> owl_float64_exponential_rvs
  | _              -> failwith "_owl_exponential_rvs: unsupported operation"
