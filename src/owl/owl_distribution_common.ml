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

external owl_float32_uniform_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_pdf" "float32_uniform_pdf_impl"
external owl_float64_uniform_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_pdf" "float64_uniform_pdf_impl"

let _owl_uniform_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_pdf
  | Float64        -> owl_float64_uniform_pdf
  | _              -> failwith "_owl_uniform_pdf: unsupported operation"

external owl_float32_uniform_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_logpdf" "float32_uniform_logpdf_impl"
external owl_float64_uniform_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_logpdf" "float64_uniform_logpdf_impl"

let _owl_uniform_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_logpdf
  | Float64        -> owl_float64_uniform_logpdf
  | _              -> failwith "_owl_uniform_logpdf: unsupported operation"

external owl_float32_uniform_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_cdf" "float32_uniform_cdf_impl"
external owl_float64_uniform_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_cdf" "float64_uniform_cdf_impl"

let _owl_uniform_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_cdf
  | Float64        -> owl_float64_uniform_cdf
  | _              -> failwith "_owl_uniform_cdf: unsupported operation"

external owl_float32_uniform_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_logcdf" "float32_uniform_logcdf_impl"
external owl_float64_uniform_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_logcdf" "float64_uniform_logcdf_impl"

let _owl_uniform_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_logcdf
  | Float64        -> owl_float64_uniform_logcdf
  | _              -> failwith "_owl_uniform_logcdf: unsupported operation"

external owl_float32_uniform_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_ppf" "float32_uniform_ppf_impl"
external owl_float64_uniform_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_ppf" "float64_uniform_ppf_impl"

let _owl_uniform_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_ppf
  | Float64        -> owl_float64_uniform_ppf
  | _              -> failwith "_owl_uniform_ppf: unsupported operation"

external owl_float32_uniform_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_sf" "float32_uniform_sf_impl"
external owl_float64_uniform_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_sf" "float64_uniform_sf_impl"

let _owl_uniform_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_sf
  | Float64        -> owl_float64_uniform_sf
  | _              -> failwith "_owl_uniform_sf: unsupported operation"

external owl_float32_uniform_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_logsf" "float32_uniform_logsf_impl"
external owl_float64_uniform_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_logsf" "float64_uniform_logsf_impl"

let _owl_uniform_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_logsf
  | Float64        -> owl_float64_uniform_logsf
  | _              -> failwith "_owl_uniform_logsf: unsupported operation"

external owl_float32_uniform_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_uniform_isf" "float32_uniform_isf_impl"
external owl_float64_uniform_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_uniform_isf" "float64_uniform_isf_impl"

let _owl_uniform_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_uniform_isf
  | Float64        -> owl_float64_uniform_isf
  | _              -> failwith "_owl_uniform_isf: unsupported operation"

external owl_float32_gaussian_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_rvs" "float32_gaussian_rvs_impl"
external owl_float64_gaussian_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_rvs" "float64_gaussian_rvs_impl"

let _owl_gaussian_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_rvs
  | Float64        -> owl_float64_gaussian_rvs
  | _              -> failwith "_owl_gaussian_rvs: unsupported operation"

external owl_float32_gaussian_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_pdf" "float32_gaussian_pdf_impl"
external owl_float64_gaussian_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_pdf" "float64_gaussian_pdf_impl"

let _owl_gaussian_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_pdf
  | Float64        -> owl_float64_gaussian_pdf
  | _              -> failwith "_owl_gaussian_pdf: unsupported operation"

external owl_float32_gaussian_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_logpdf" "float32_gaussian_logpdf_impl"
external owl_float64_gaussian_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_logpdf" "float64_gaussian_logpdf_impl"

let _owl_gaussian_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_logpdf
  | Float64        -> owl_float64_gaussian_logpdf
  | _              -> failwith "_owl_gaussian_logpdf: unsupported operation"

external owl_float32_gaussian_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_cdf" "float32_gaussian_cdf_impl"
external owl_float64_gaussian_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_cdf" "float64_gaussian_cdf_impl"

let _owl_gaussian_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_cdf
  | Float64        -> owl_float64_gaussian_cdf
  | _              -> failwith "_owl_gaussian_cdf: unsupported operation"

external owl_float32_gaussian_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_logcdf" "float32_gaussian_logcdf_impl"
external owl_float64_gaussian_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_logcdf" "float64_gaussian_logcdf_impl"

let _owl_gaussian_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_logcdf
  | Float64        -> owl_float64_gaussian_logcdf
  | _              -> failwith "_owl_gaussian_logcdf: unsupported operation"

external owl_float32_gaussian_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_ppf" "float32_gaussian_ppf_impl"
external owl_float64_gaussian_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_ppf" "float64_gaussian_ppf_impl"

let _owl_gaussian_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_ppf
  | Float64        -> owl_float64_gaussian_ppf
  | _              -> failwith "_owl_gaussian_ppf: unsupported operation"

external owl_float32_gaussian_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_sf" "float32_gaussian_sf_impl"
external owl_float64_gaussian_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_sf" "float64_gaussian_sf_impl"

let _owl_gaussian_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_sf
  | Float64        -> owl_float64_gaussian_sf
  | _              -> failwith "_owl_gaussian_sf: unsupported operation"

external owl_float32_gaussian_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_logsf" "float32_gaussian_logsf_impl"
external owl_float64_gaussian_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_logsf" "float64_gaussian_logsf_impl"

let _owl_gaussian_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_logsf
  | Float64        -> owl_float64_gaussian_logsf
  | _              -> failwith "_owl_gaussian_logsf: unsupported operation"

external owl_float32_gaussian_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gaussian_isf" "float32_gaussian_isf_impl"
external owl_float64_gaussian_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gaussian_isf" "float64_gaussian_isf_impl"

let _owl_gaussian_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gaussian_isf
  | Float64        -> owl_float64_gaussian_isf
  | _              -> failwith "_owl_gaussian_isf: unsupported operation"

external owl_float32_exponential_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_rvs" "float32_exponential_rvs_impl"
external owl_float64_exponential_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_rvs" "float64_exponential_rvs_impl"

let _owl_exponential_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_rvs
  | Float64        -> owl_float64_exponential_rvs
  | _              -> failwith "_owl_exponential_rvs: unsupported operation"

external owl_float32_exponential_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_pdf" "float32_exponential_pdf_impl"
external owl_float64_exponential_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_pdf" "float64_exponential_pdf_impl"

let _owl_exponential_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_pdf
  | Float64        -> owl_float64_exponential_pdf
  | _              -> failwith "_owl_exponential_pdf: unsupported operation"

external owl_float32_exponential_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_logpdf" "float32_exponential_logpdf_impl"
external owl_float64_exponential_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_logpdf" "float64_exponential_logpdf_impl"

let _owl_exponential_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_logpdf
  | Float64        -> owl_float64_exponential_logpdf
  | _              -> failwith "_owl_exponential_logpdf: unsupported operation"

external owl_float32_exponential_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_cdf" "float32_exponential_cdf_impl"
external owl_float64_exponential_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_cdf" "float64_exponential_cdf_impl"

let _owl_exponential_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_cdf
  | Float64        -> owl_float64_exponential_cdf
  | _              -> failwith "_owl_exponential_cdf: unsupported operation"

external owl_float32_exponential_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_logcdf" "float32_exponential_logcdf_impl"
external owl_float64_exponential_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_logcdf" "float64_exponential_logcdf_impl"

let _owl_exponential_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_logcdf
  | Float64        -> owl_float64_exponential_logcdf
  | _              -> failwith "_owl_exponential_logcdf: unsupported operation"

external owl_float32_exponential_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_ppf" "float32_exponential_ppf_impl"
external owl_float64_exponential_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_ppf" "float64_exponential_ppf_impl"

let _owl_exponential_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_ppf
  | Float64        -> owl_float64_exponential_ppf
  | _              -> failwith "_owl_exponential_ppf: unsupported operation"

external owl_float32_exponential_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_sf" "float32_exponential_sf_impl"
external owl_float64_exponential_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_sf" "float64_exponential_sf_impl"

let _owl_exponential_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_sf
  | Float64        -> owl_float64_exponential_sf
  | _              -> failwith "_owl_exponential_sf: unsupported operation"

external owl_float32_exponential_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_logsf" "float32_exponential_logsf_impl"
external owl_float64_exponential_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_logsf" "float64_exponential_logsf_impl"

let _owl_exponential_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_logsf
  | Float64        -> owl_float64_exponential_logsf
  | _              -> failwith "_owl_exponential_logsf: unsupported operation"

external owl_float32_exponential_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_exponential_isf" "float32_exponential_isf_impl"
external owl_float64_exponential_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_exponential_isf" "float64_exponential_isf_impl"

let _owl_exponential_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_exponential_isf
  | Float64        -> owl_float64_exponential_isf
  | _              -> failwith "_owl_exponential_isf: unsupported operation"

external owl_float32_gamma_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_rvs" "float32_gamma_rvs_impl"
external owl_float64_gamma_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_rvs" "float64_gamma_rvs_impl"

let _owl_gamma_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_rvs
  | Float64        -> owl_float64_gamma_rvs
  | _              -> failwith "_owl_gamma_rvs: unsupported operation"

external owl_float32_gamma_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_pdf" "float32_gamma_pdf_impl"
external owl_float64_gamma_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_pdf" "float64_gamma_pdf_impl"

let _owl_gamma_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_pdf
  | Float64        -> owl_float64_gamma_pdf
  | _              -> failwith "_owl_gamma_pdf: unsupported operation"

external owl_float32_gamma_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_logpdf" "float32_gamma_logpdf_impl"
external owl_float64_gamma_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_logpdf" "float64_gamma_logpdf_impl"

let _owl_gamma_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_logpdf
  | Float64        -> owl_float64_gamma_logpdf
  | _              -> failwith "_owl_gamma_logpdf: unsupported operation"

external owl_float32_gamma_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_cdf" "float32_gamma_cdf_impl"
external owl_float64_gamma_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_cdf" "float64_gamma_cdf_impl"

let _owl_gamma_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_cdf
  | Float64        -> owl_float64_gamma_cdf
  | _              -> failwith "_owl_gamma_cdf: unsupported operation"

external owl_float32_gamma_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_logcdf" "float32_gamma_logcdf_impl"
external owl_float64_gamma_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_logcdf" "float64_gamma_logcdf_impl"

let _owl_gamma_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_logcdf
  | Float64        -> owl_float64_gamma_logcdf
  | _              -> failwith "_owl_gamma_logcdf: unsupported operation"

external owl_float32_gamma_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_ppf" "float32_gamma_ppf_impl"
external owl_float64_gamma_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_ppf" "float64_gamma_ppf_impl"

let _owl_gamma_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_ppf
  | Float64        -> owl_float64_gamma_ppf
  | _              -> failwith "_owl_gamma_ppf: unsupported operation"

external owl_float32_gamma_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_sf" "float32_gamma_sf_impl"
external owl_float64_gamma_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_sf" "float64_gamma_sf_impl"

let _owl_gamma_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_sf
  | Float64        -> owl_float64_gamma_sf
  | _              -> failwith "_owl_gamma_sf: unsupported operation"

external owl_float32_gamma_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_logsf" "float32_gamma_logsf_impl"
external owl_float64_gamma_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_logsf" "float64_gamma_logsf_impl"

let _owl_gamma_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_logsf
  | Float64        -> owl_float64_gamma_logsf
  | _              -> failwith "_owl_gamma_logsf: unsupported operation"

external owl_float32_gamma_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gamma_isf" "float32_gamma_isf_impl"
external owl_float64_gamma_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gamma_isf" "float64_gamma_isf_impl"

let _owl_gamma_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gamma_isf
  | Float64        -> owl_float64_gamma_isf
  | _              -> failwith "_owl_gamma_isf: unsupported operation"

external owl_float32_beta_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_rvs" "float32_beta_rvs_impl"
external owl_float64_beta_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_rvs" "float64_beta_rvs_impl"

let _owl_beta_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_rvs
  | Float64        -> owl_float64_beta_rvs
  | _              -> failwith "_owl_beta_rvs: unsupported operation"

external owl_float32_beta_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_pdf" "float32_beta_pdf_impl"
external owl_float64_beta_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_pdf" "float64_beta_pdf_impl"

let _owl_beta_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_pdf
  | Float64        -> owl_float64_beta_pdf
  | _              -> failwith "_owl_beta_pdf: unsupported operation"

external owl_float32_beta_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_logpdf" "float32_beta_logpdf_impl"
external owl_float64_beta_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_logpdf" "float64_beta_logpdf_impl"

let _owl_beta_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_logpdf
  | Float64        -> owl_float64_beta_logpdf
  | _              -> failwith "_owl_beta_logpdf: unsupported operation"

external owl_float32_beta_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_cdf" "float32_beta_cdf_impl"
external owl_float64_beta_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_cdf" "float64_beta_cdf_impl"

let _owl_beta_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_cdf
  | Float64        -> owl_float64_beta_cdf
  | _              -> failwith "_owl_beta_cdf: unsupported operation"

external owl_float32_beta_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_logcdf" "float32_beta_logcdf_impl"
external owl_float64_beta_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_logcdf" "float64_beta_logcdf_impl"

let _owl_beta_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_logcdf
  | Float64        -> owl_float64_beta_logcdf
  | _              -> failwith "_owl_beta_logcdf: unsupported operation"

external owl_float32_beta_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_ppf" "float32_beta_ppf_impl"
external owl_float64_beta_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_ppf" "float64_beta_ppf_impl"

let _owl_beta_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_ppf
  | Float64        -> owl_float64_beta_ppf
  | _              -> failwith "_owl_beta_ppf: unsupported operation"

external owl_float32_beta_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_sf" "float32_beta_sf_impl"
external owl_float64_beta_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_sf" "float64_beta_sf_impl"

let _owl_beta_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_sf
  | Float64        -> owl_float64_beta_sf
  | _              -> failwith "_owl_beta_sf: unsupported operation"

external owl_float32_beta_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_logsf" "float32_beta_logsf_impl"
external owl_float64_beta_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_logsf" "float64_beta_logsf_impl"

let _owl_beta_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_logsf
  | Float64        -> owl_float64_beta_logsf
  | _              -> failwith "_owl_beta_logsf: unsupported operation"

external owl_float32_beta_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_beta_isf" "float32_beta_isf_impl"
external owl_float64_beta_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_beta_isf" "float64_beta_isf_impl"

let _owl_beta_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_beta_isf
  | Float64        -> owl_float64_beta_isf
  | _              -> failwith "_owl_beta_isf: unsupported operation"

external owl_float32_f_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_rvs" "float32_f_rvs_impl"
external owl_float64_f_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_rvs" "float64_f_rvs_impl"

external owl_float32_chi2_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_rvs" "float32_chi2_rvs_impl"
external owl_float64_chi2_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_rvs" "float64_chi2_rvs_impl"

let _owl_chi2_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_rvs
  | Float64        -> owl_float64_chi2_rvs
  | _              -> failwith "_owl_chi2_rvs: unsupported operation"

external owl_float32_chi2_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_pdf" "float32_chi2_pdf_impl"
external owl_float64_chi2_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_pdf" "float64_chi2_pdf_impl"

let _owl_chi2_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_pdf
  | Float64        -> owl_float64_chi2_pdf
  | _              -> failwith "_owl_chi2_pdf: unsupported operation"

external owl_float32_chi2_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_logpdf" "float32_chi2_logpdf_impl"
external owl_float64_chi2_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_logpdf" "float64_chi2_logpdf_impl"

let _owl_chi2_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_logpdf
  | Float64        -> owl_float64_chi2_logpdf
  | _              -> failwith "_owl_chi2_logpdf: unsupported operation"

external owl_float32_chi2_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_cdf" "float32_chi2_cdf_impl"
external owl_float64_chi2_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_cdf" "float64_chi2_cdf_impl"

let _owl_chi2_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_cdf
  | Float64        -> owl_float64_chi2_cdf
  | _              -> failwith "_owl_chi2_cdf: unsupported operation"

external owl_float32_chi2_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_logcdf" "float32_chi2_logcdf_impl"
external owl_float64_chi2_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_logcdf" "float64_chi2_logcdf_impl"

let _owl_chi2_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_logcdf
  | Float64        -> owl_float64_chi2_logcdf
  | _              -> failwith "_owl_chi2_logcdf: unsupported operation"

external owl_float32_chi2_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_ppf" "float32_chi2_ppf_impl"
external owl_float64_chi2_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_ppf" "float64_chi2_ppf_impl"

let _owl_chi2_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_ppf
  | Float64        -> owl_float64_chi2_ppf
  | _              -> failwith "_owl_chi2_ppf: unsupported operation"

external owl_float32_chi2_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_sf" "float32_chi2_sf_impl"
external owl_float64_chi2_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_sf" "float64_chi2_sf_impl"

let _owl_chi2_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_sf
  | Float64        -> owl_float64_chi2_sf
  | _              -> failwith "_owl_chi2_sf: unsupported operation"

external owl_float32_chi2_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_logsf" "float32_chi2_logsf_impl"
external owl_float64_chi2_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_logsf" "float64_chi2_logsf_impl"

let _owl_chi2_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_logsf
  | Float64        -> owl_float64_chi2_logsf
  | _              -> failwith "_owl_chi2_logsf: unsupported operation"

external owl_float32_chi2_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_chi2_isf" "float32_chi2_isf_impl"
external owl_float64_chi2_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_chi2_isf" "float64_chi2_isf_impl"

let _owl_chi2_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_chi2_isf
  | Float64        -> owl_float64_chi2_isf
  | _              -> failwith "_owl_chi2_isf: unsupported operation"

let _owl_f_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_rvs
  | Float64        -> owl_float64_f_rvs
  | _              -> failwith "_owl_f_rvs: unsupported operation"

external owl_float32_f_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_pdf" "float32_f_pdf_impl"
external owl_float64_f_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_pdf" "float64_f_pdf_impl"

let _owl_f_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_pdf
  | Float64        -> owl_float64_f_pdf
  | _              -> failwith "_owl_f_pdf: unsupported operation"

external owl_float32_f_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_logpdf" "float32_f_logpdf_impl"
external owl_float64_f_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_logpdf" "float64_f_logpdf_impl"

let _owl_f_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_logpdf
  | Float64        -> owl_float64_f_logpdf
  | _              -> failwith "_owl_f_logpdf: unsupported operation"

external owl_float32_f_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_cdf" "float32_f_cdf_impl"
external owl_float64_f_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_cdf" "float64_f_cdf_impl"

let _owl_f_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_cdf
  | Float64        -> owl_float64_f_cdf
  | _              -> failwith "_owl_f_cdf: unsupported operation"

external owl_float32_f_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_logcdf" "float32_f_logcdf_impl"
external owl_float64_f_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_logcdf" "float64_f_logcdf_impl"

let _owl_f_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_logcdf
  | Float64        -> owl_float64_f_logcdf
  | _              -> failwith "_owl_f_logcdf: unsupported operation"

external owl_float32_f_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_ppf" "float32_f_ppf_impl"
external owl_float64_f_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_ppf" "float64_f_ppf_impl"

let _owl_f_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_ppf
  | Float64        -> owl_float64_f_ppf
  | _              -> failwith "_owl_f_ppf: unsupported operation"

external owl_float32_f_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_sf" "float32_f_sf_impl"
external owl_float64_f_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_sf" "float64_f_sf_impl"

let _owl_f_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_sf
  | Float64        -> owl_float64_f_sf
  | _              -> failwith "_owl_f_sf: unsupported operation"

external owl_float32_f_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_logsf" "float32_f_logsf_impl"
external owl_float64_f_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_logsf" "float64_f_logsf_impl"

let _owl_f_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_logsf
  | Float64        -> owl_float64_f_logsf
  | _              -> failwith "_owl_f_logsf: unsupported operation"

external owl_float32_f_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_f_isf" "float32_f_isf_impl"
external owl_float64_f_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_f_isf" "float64_f_isf_impl"

let _owl_f_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_f_isf
  | Float64        -> owl_float64_f_isf
  | _              -> failwith "_owl_f_isf: unsupported operation"

external owl_float32_cauchy_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_rvs" "float32_cauchy_rvs_impl"
external owl_float64_cauchy_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_rvs" "float64_cauchy_rvs_impl"

let _owl_cauchy_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_rvs
  | Float64        -> owl_float64_cauchy_rvs
  | _              -> failwith "_owl_cauchy_rvs: unsupported operation"

external owl_float32_cauchy_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_pdf" "float32_cauchy_pdf_impl"
external owl_float64_cauchy_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_pdf" "float64_cauchy_pdf_impl"

let _owl_cauchy_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_pdf
  | Float64        -> owl_float64_cauchy_pdf
  | _              -> failwith "_owl_cauchy_pdf: unsupported operation"

external owl_float32_cauchy_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_logpdf" "float32_cauchy_logpdf_impl"
external owl_float64_cauchy_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_logpdf" "float64_cauchy_logpdf_impl"

let _owl_cauchy_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_logpdf
  | Float64        -> owl_float64_cauchy_logpdf
  | _              -> failwith "_owl_cauchy_logpdf: unsupported operation"

external owl_float32_cauchy_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_cdf" "float32_cauchy_cdf_impl"
external owl_float64_cauchy_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_cdf" "float64_cauchy_cdf_impl"

let _owl_cauchy_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_cdf
  | Float64        -> owl_float64_cauchy_cdf
  | _              -> failwith "_owl_cauchy_cdf: unsupported operation"

external owl_float32_cauchy_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_logcdf" "float32_cauchy_logcdf_impl"
external owl_float64_cauchy_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_logcdf" "float64_cauchy_logcdf_impl"

let _owl_cauchy_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_logcdf
  | Float64        -> owl_float64_cauchy_logcdf
  | _              -> failwith "_owl_cauchy_logcdf: unsupported operation"

external owl_float32_cauchy_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_ppf" "float32_cauchy_ppf_impl"
external owl_float64_cauchy_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_ppf" "float64_cauchy_ppf_impl"

let _owl_cauchy_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_ppf
  | Float64        -> owl_float64_cauchy_ppf
  | _              -> failwith "_owl_cauchy_ppf: unsupported operation"

external owl_float32_cauchy_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_sf" "float32_cauchy_sf_impl"
external owl_float64_cauchy_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_sf" "float64_cauchy_sf_impl"

let _owl_cauchy_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_sf
  | Float64        -> owl_float64_cauchy_sf
  | _              -> failwith "_owl_cauchy_sf: unsupported operation"

external owl_float32_cauchy_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_logsf" "float32_cauchy_logsf_impl"
external owl_float64_cauchy_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_logsf" "float64_cauchy_logsf_impl"

let _owl_cauchy_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_logsf
  | Float64        -> owl_float64_cauchy_logsf
  | _              -> failwith "_owl_cauchy_logsf: unsupported operation"

external owl_float32_cauchy_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_cauchy_isf" "float32_cauchy_isf_impl"
external owl_float64_cauchy_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_cauchy_isf" "float64_cauchy_isf_impl"

let _owl_cauchy_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_cauchy_isf
  | Float64        -> owl_float64_cauchy_isf
  | _              -> failwith "_owl_cauchy_isf: unsupported operation"

external owl_float32_lomax_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_rvs" "float32_lomax_rvs_impl"
external owl_float64_lomax_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_rvs" "float64_lomax_rvs_impl"

let _owl_lomax_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_rvs
  | Float64        -> owl_float64_lomax_rvs
  | _              -> failwith "_owl_lomax_rvs: unsupported operation"

external owl_float32_lomax_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_pdf" "float32_lomax_pdf_impl"
external owl_float64_lomax_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_pdf" "float64_lomax_pdf_impl"

let _owl_lomax_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_pdf
  | Float64        -> owl_float64_lomax_pdf
  | _              -> failwith "_owl_lomax_pdf: unsupported operation"

external owl_float32_lomax_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_logpdf" "float32_lomax_logpdf_impl"
external owl_float64_lomax_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_logpdf" "float64_lomax_logpdf_impl"

let _owl_lomax_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_logpdf
  | Float64        -> owl_float64_lomax_logpdf
  | _              -> failwith "_owl_lomax_logpdf: unsupported operation"

external owl_float32_lomax_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_cdf" "float32_lomax_cdf_impl"
external owl_float64_lomax_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_cdf" "float64_lomax_cdf_impl"

let _owl_lomax_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_cdf
  | Float64        -> owl_float64_lomax_cdf
  | _              -> failwith "_owl_lomax_cdf: unsupported operation"

external owl_float32_lomax_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_logcdf" "float32_lomax_logcdf_impl"
external owl_float64_lomax_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_logcdf" "float64_lomax_logcdf_impl"

let _owl_lomax_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_logcdf
  | Float64        -> owl_float64_lomax_logcdf
  | _              -> failwith "_owl_lomax_logcdf: unsupported operation"

external owl_float32_lomax_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_ppf" "float32_lomax_ppf_impl"
external owl_float64_lomax_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_ppf" "float64_lomax_ppf_impl"

let _owl_lomax_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_ppf
  | Float64        -> owl_float64_lomax_ppf
  | _              -> failwith "_owl_lomax_ppf: unsupported operation"

external owl_float32_lomax_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_sf" "float32_lomax_sf_impl"
external owl_float64_lomax_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_sf" "float64_lomax_sf_impl"

let _owl_lomax_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_sf
  | Float64        -> owl_float64_lomax_sf
  | _              -> failwith "_owl_lomax_sf: unsupported operation"

external owl_float32_lomax_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_logsf" "float32_lomax_logsf_impl"
external owl_float64_lomax_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_logsf" "float64_lomax_logsf_impl"

let _owl_lomax_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_logsf
  | Float64        -> owl_float64_lomax_logsf
  | _              -> failwith "_owl_lomax_logsf: unsupported operation"

external owl_float32_lomax_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lomax_isf" "float32_lomax_isf_impl"
external owl_float64_lomax_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lomax_isf" "float64_lomax_isf_impl"

let _owl_lomax_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lomax_isf
  | Float64        -> owl_float64_lomax_isf
  | _              -> failwith "_owl_lomax_isf: unsupported operation"

external owl_float32_weibull_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_rvs" "float32_weibull_rvs_impl"
external owl_float64_weibull_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_rvs" "float64_weibull_rvs_impl"

let _owl_weibull_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_rvs
  | Float64        -> owl_float64_weibull_rvs
  | _              -> failwith "_owl_weibull_rvs: unsupported operation"

external owl_float32_weibull_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_pdf" "float32_weibull_pdf_impl"
external owl_float64_weibull_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_pdf" "float64_weibull_pdf_impl"

let _owl_weibull_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_pdf
  | Float64        -> owl_float64_weibull_pdf
  | _              -> failwith "_owl_weibull_pdf: unsupported operation"

external owl_float32_weibull_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_logpdf" "float32_weibull_logpdf_impl"
external owl_float64_weibull_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_logpdf" "float64_weibull_logpdf_impl"

let _owl_weibull_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_logpdf
  | Float64        -> owl_float64_weibull_logpdf
  | _              -> failwith "_owl_weibull_logpdf: unsupported operation"

external owl_float32_weibull_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_cdf" "float32_weibull_cdf_impl"
external owl_float64_weibull_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_cdf" "float64_weibull_cdf_impl"

let _owl_weibull_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_cdf
  | Float64        -> owl_float64_weibull_cdf
  | _              -> failwith "_owl_weibull_cdf: unsupported operation"

external owl_float32_weibull_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_logcdf" "float32_weibull_logcdf_impl"
external owl_float64_weibull_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_logcdf" "float64_weibull_logcdf_impl"

let _owl_weibull_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_logcdf
  | Float64        -> owl_float64_weibull_logcdf
  | _              -> failwith "_owl_weibull_logcdf: unsupported operation"

external owl_float32_weibull_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_ppf" "float32_weibull_ppf_impl"
external owl_float64_weibull_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_ppf" "float64_weibull_ppf_impl"

let _owl_weibull_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_ppf
  | Float64        -> owl_float64_weibull_ppf
  | _              -> failwith "_owl_weibull_ppf: unsupported operation"

external owl_float32_weibull_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_sf" "float32_weibull_sf_impl"
external owl_float64_weibull_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_sf" "float64_weibull_sf_impl"

let _owl_weibull_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_sf
  | Float64        -> owl_float64_weibull_sf
  | _              -> failwith "_owl_weibull_sf: unsupported operation"

external owl_float32_weibull_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_logsf" "float32_weibull_logsf_impl"
external owl_float64_weibull_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_logsf" "float64_weibull_logsf_impl"

let _owl_weibull_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_logsf
  | Float64        -> owl_float64_weibull_logsf
  | _              -> failwith "_owl_weibull_logsf: unsupported operation"

external owl_float32_weibull_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_weibull_isf" "float32_weibull_isf_impl"
external owl_float64_weibull_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_weibull_isf" "float64_weibull_isf_impl"

let _owl_weibull_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_weibull_isf
  | Float64        -> owl_float64_weibull_isf
  | _              -> failwith "_owl_weibull_isf: unsupported operation"

external owl_float32_laplace_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_rvs" "float32_laplace_rvs_impl"
external owl_float64_laplace_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_rvs" "float64_laplace_rvs_impl"

let _owl_laplace_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_rvs
  | Float64        -> owl_float64_laplace_rvs
  | _              -> failwith "_owl_laplace_rvs: unsupported operation"

external owl_float32_laplace_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_pdf" "float32_laplace_pdf_impl"
external owl_float64_laplace_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_pdf" "float64_laplace_pdf_impl"

let _owl_laplace_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_pdf
  | Float64        -> owl_float64_laplace_pdf
  | _              -> failwith "_owl_laplace_pdf: unsupported operation"

external owl_float32_laplace_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_logpdf" "float32_laplace_logpdf_impl"
external owl_float64_laplace_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_logpdf" "float64_laplace_logpdf_impl"

let _owl_laplace_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_logpdf
  | Float64        -> owl_float64_laplace_logpdf
  | _              -> failwith "_owl_laplace_logpdf: unsupported operation"

external owl_float32_laplace_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_cdf" "float32_laplace_cdf_impl"
external owl_float64_laplace_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_cdf" "float64_laplace_cdf_impl"

let _owl_laplace_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_cdf
  | Float64        -> owl_float64_laplace_cdf
  | _              -> failwith "_owl_laplace_cdf: unsupported operation"

external owl_float32_laplace_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_logcdf" "float32_laplace_logcdf_impl"
external owl_float64_laplace_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_logcdf" "float64_laplace_logcdf_impl"

let _owl_laplace_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_logcdf
  | Float64        -> owl_float64_laplace_logcdf
  | _              -> failwith "_owl_laplace_logcdf: unsupported operation"

external owl_float32_laplace_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_ppf" "float32_laplace_ppf_impl"
external owl_float64_laplace_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_ppf" "float64_laplace_ppf_impl"

let _owl_laplace_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_ppf
  | Float64        -> owl_float64_laplace_ppf
  | _              -> failwith "_owl_laplace_ppf: unsupported operation"

external owl_float32_laplace_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_sf" "float32_laplace_sf_impl"
external owl_float64_laplace_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_sf" "float64_laplace_sf_impl"

let _owl_laplace_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_sf
  | Float64        -> owl_float64_laplace_sf
  | _              -> failwith "_owl_laplace_sf: unsupported operation"

external owl_float32_laplace_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_logsf" "float32_laplace_logsf_impl"
external owl_float64_laplace_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_logsf" "float64_laplace_logsf_impl"

let _owl_laplace_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_logsf
  | Float64        -> owl_float64_laplace_logsf
  | _              -> failwith "_owl_laplace_logsf: unsupported operation"

external owl_float32_laplace_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_laplace_isf" "float32_laplace_isf_impl"
external owl_float64_laplace_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_laplace_isf" "float64_laplace_isf_impl"

let _owl_laplace_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_laplace_isf
  | Float64        -> owl_float64_laplace_isf
  | _              -> failwith "_owl_laplace_isf: unsupported operation"

external owl_float32_gumbel1_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_rvs" "float32_gumbel1_rvs_impl"
external owl_float64_gumbel1_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_rvs" "float64_gumbel1_rvs_impl"

let _owl_gumbel1_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_rvs
  | Float64        -> owl_float64_gumbel1_rvs
  | _              -> failwith "_owl_gumbel1_rvs: unsupported operation"

external owl_float32_gumbel1_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_pdf" "float32_gumbel1_pdf_impl"
external owl_float64_gumbel1_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_pdf" "float64_gumbel1_pdf_impl"

let _owl_gumbel1_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_pdf
  | Float64        -> owl_float64_gumbel1_pdf
  | _              -> failwith "_owl_gumbel1_pdf: unsupported operation"

external owl_float32_gumbel1_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_logpdf" "float32_gumbel1_logpdf_impl"
external owl_float64_gumbel1_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_logpdf" "float64_gumbel1_logpdf_impl"

let _owl_gumbel1_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_logpdf
  | Float64        -> owl_float64_gumbel1_logpdf
  | _              -> failwith "_owl_gumbel1_logpdf: unsupported operation"

external owl_float32_gumbel1_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_cdf" "float32_gumbel1_cdf_impl"
external owl_float64_gumbel1_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_cdf" "float64_gumbel1_cdf_impl"

let _owl_gumbel1_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_cdf
  | Float64        -> owl_float64_gumbel1_cdf
  | _              -> failwith "_owl_gumbel1_cdf: unsupported operation"

external owl_float32_gumbel1_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_logcdf" "float32_gumbel1_logcdf_impl"
external owl_float64_gumbel1_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_logcdf" "float64_gumbel1_logcdf_impl"

let _owl_gumbel1_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_logcdf
  | Float64        -> owl_float64_gumbel1_logcdf
  | _              -> failwith "_owl_gumbel1_logcdf: unsupported operation"

external owl_float32_gumbel1_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_ppf" "float32_gumbel1_ppf_impl"
external owl_float64_gumbel1_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_ppf" "float64_gumbel1_ppf_impl"

let _owl_gumbel1_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_ppf
  | Float64        -> owl_float64_gumbel1_ppf
  | _              -> failwith "_owl_gumbel1_ppf: unsupported operation"

external owl_float32_gumbel1_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_sf" "float32_gumbel1_sf_impl"
external owl_float64_gumbel1_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_sf" "float64_gumbel1_sf_impl"

let _owl_gumbel1_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_sf
  | Float64        -> owl_float64_gumbel1_sf
  | _              -> failwith "_owl_gumbel1_sf: unsupported operation"

external owl_float32_gumbel1_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_logsf" "float32_gumbel1_logsf_impl"
external owl_float64_gumbel1_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_logsf" "float64_gumbel1_logsf_impl"

let _owl_gumbel1_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_logsf
  | Float64        -> owl_float64_gumbel1_logsf
  | _              -> failwith "_owl_gumbel1_logsf: unsupported operation"

external owl_float32_gumbel1_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel1_isf" "float32_gumbel1_isf_impl"
external owl_float64_gumbel1_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel1_isf" "float64_gumbel1_isf_impl"

let _owl_gumbel1_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel1_isf
  | Float64        -> owl_float64_gumbel1_isf
  | _              -> failwith "_owl_gumbel1_isf: unsupported operation"

external owl_float32_gumbel2_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_rvs" "float32_gumbel2_rvs_impl"
external owl_float64_gumbel2_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_rvs" "float64_gumbel2_rvs_impl"

let _owl_gumbel2_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_rvs
  | Float64        -> owl_float64_gumbel2_rvs
  | _              -> failwith "_owl_gumbel2_rvs: unsupported operation"

external owl_float32_gumbel2_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_pdf" "float32_gumbel2_pdf_impl"
external owl_float64_gumbel2_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_pdf" "float64_gumbel2_pdf_impl"

let _owl_gumbel2_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_pdf
  | Float64        -> owl_float64_gumbel2_pdf
  | _              -> failwith "_owl_gumbel2_pdf: unsupported operation"

external owl_float32_gumbel2_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_logpdf" "float32_gumbel2_logpdf_impl"
external owl_float64_gumbel2_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_logpdf" "float64_gumbel2_logpdf_impl"

let _owl_gumbel2_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_logpdf
  | Float64        -> owl_float64_gumbel2_logpdf
  | _              -> failwith "_owl_gumbel2_logpdf: unsupported operation"

external owl_float32_gumbel2_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_cdf" "float32_gumbel2_cdf_impl"
external owl_float64_gumbel2_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_cdf" "float64_gumbel2_cdf_impl"

let _owl_gumbel2_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_cdf
  | Float64        -> owl_float64_gumbel2_cdf
  | _              -> failwith "_owl_gumbel2_cdf: unsupported operation"

external owl_float32_gumbel2_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_logcdf" "float32_gumbel2_logcdf_impl"
external owl_float64_gumbel2_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_logcdf" "float64_gumbel2_logcdf_impl"

let _owl_gumbel2_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_logcdf
  | Float64        -> owl_float64_gumbel2_logcdf
  | _              -> failwith "_owl_gumbel2_logcdf: unsupported operation"

external owl_float32_gumbel2_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_ppf" "float32_gumbel2_ppf_impl"
external owl_float64_gumbel2_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_ppf" "float64_gumbel2_ppf_impl"

let _owl_gumbel2_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_ppf
  | Float64        -> owl_float64_gumbel2_ppf
  | _              -> failwith "_owl_gumbel2_ppf: unsupported operation"

external owl_float32_gumbel2_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_sf" "float32_gumbel2_sf_impl"
external owl_float64_gumbel2_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_sf" "float64_gumbel2_sf_impl"

let _owl_gumbel2_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_sf
  | Float64        -> owl_float64_gumbel2_sf
  | _              -> failwith "_owl_gumbel2_sf: unsupported operation"

external owl_float32_gumbel2_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_logsf" "float32_gumbel2_logsf_impl"
external owl_float64_gumbel2_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_logsf" "float64_gumbel2_logsf_impl"

let _owl_gumbel2_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_logsf
  | Float64        -> owl_float64_gumbel2_logsf
  | _              -> failwith "_owl_gumbel2_logsf: unsupported operation"

external owl_float32_gumbel2_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_gumbel2_isf" "float32_gumbel2_isf_impl"
external owl_float64_gumbel2_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_gumbel2_isf" "float64_gumbel2_isf_impl"

let _owl_gumbel2_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_gumbel2_isf
  | Float64        -> owl_float64_gumbel2_isf
  | _              -> failwith "_owl_gumbel2_isf: unsupported operation"

external owl_float32_logistic_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_rvs" "float32_logistic_rvs_impl"
external owl_float64_logistic_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_rvs" "float64_logistic_rvs_impl"

let _owl_logistic_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_rvs
  | Float64        -> owl_float64_logistic_rvs
  | _              -> failwith "_owl_logistic_rvs: unsupported operation"

external owl_float32_logistic_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_pdf" "float32_logistic_pdf_impl"
external owl_float64_logistic_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_pdf" "float64_logistic_pdf_impl"

let _owl_logistic_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_pdf
  | Float64        -> owl_float64_logistic_pdf
  | _              -> failwith "_owl_logistic_pdf: unsupported operation"

external owl_float32_logistic_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_logpdf" "float32_logistic_logpdf_impl"
external owl_float64_logistic_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_logpdf" "float64_logistic_logpdf_impl"

let _owl_logistic_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_logpdf
  | Float64        -> owl_float64_logistic_logpdf
  | _              -> failwith "_owl_logistic_logpdf: unsupported operation"

external owl_float32_logistic_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_cdf" "float32_logistic_cdf_impl"
external owl_float64_logistic_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_cdf" "float64_logistic_cdf_impl"

let _owl_logistic_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_cdf
  | Float64        -> owl_float64_logistic_cdf
  | _              -> failwith "_owl_logistic_cdf: unsupported operation"

external owl_float32_logistic_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_logcdf" "float32_logistic_logcdf_impl"
external owl_float64_logistic_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_logcdf" "float64_logistic_logcdf_impl"

let _owl_logistic_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_logcdf
  | Float64        -> owl_float64_logistic_logcdf
  | _              -> failwith "_owl_logistic_logcdf: unsupported operation"

external owl_float32_logistic_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_ppf" "float32_logistic_ppf_impl"
external owl_float64_logistic_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_ppf" "float64_logistic_ppf_impl"

let _owl_logistic_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_ppf
  | Float64        -> owl_float64_logistic_ppf
  | _              -> failwith "_owl_logistic_ppf: unsupported operation"

external owl_float32_logistic_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_sf" "float32_logistic_sf_impl"
external owl_float64_logistic_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_sf" "float64_logistic_sf_impl"

let _owl_logistic_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_sf
  | Float64        -> owl_float64_logistic_sf
  | _              -> failwith "_owl_logistic_sf: unsupported operation"

external owl_float32_logistic_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_logsf" "float32_logistic_logsf_impl"
external owl_float64_logistic_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_logsf" "float64_logistic_logsf_impl"

let _owl_logistic_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_logsf
  | Float64        -> owl_float64_logistic_logsf
  | _              -> failwith "_owl_logistic_logsf: unsupported operation"

external owl_float32_logistic_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_logistic_isf" "float32_logistic_isf_impl"
external owl_float64_logistic_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_logistic_isf" "float64_logistic_isf_impl"

let _owl_logistic_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_logistic_isf
  | Float64        -> owl_float64_logistic_isf
  | _              -> failwith "_owl_logistic_isf: unsupported operation"

external owl_float32_lognormal_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_rvs" "float32_lognormal_rvs_impl"
external owl_float64_lognormal_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_rvs" "float64_lognormal_rvs_impl"

let _owl_lognormal_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_rvs
  | Float64        -> owl_float64_lognormal_rvs
  | _              -> failwith "_owl_lognormal_rvs: unsupported operation"

external owl_float32_lognormal_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_pdf" "float32_lognormal_pdf_impl"
external owl_float64_lognormal_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_pdf" "float64_lognormal_pdf_impl"

let _owl_lognormal_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_pdf
  | Float64        -> owl_float64_lognormal_pdf
  | _              -> failwith "_owl_lognormal_pdf: unsupported operation"

external owl_float32_lognormal_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_logpdf" "float32_lognormal_logpdf_impl"
external owl_float64_lognormal_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_logpdf" "float64_lognormal_logpdf_impl"

let _owl_lognormal_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_logpdf
  | Float64        -> owl_float64_lognormal_logpdf
  | _              -> failwith "_owl_lognormal_logpdf: unsupported operation"

external owl_float32_lognormal_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_cdf" "float32_lognormal_cdf_impl"
external owl_float64_lognormal_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_cdf" "float64_lognormal_cdf_impl"

let _owl_lognormal_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_cdf
  | Float64        -> owl_float64_lognormal_cdf
  | _              -> failwith "_owl_lognormal_cdf: unsupported operation"

external owl_float32_lognormal_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_logcdf" "float32_lognormal_logcdf_impl"
external owl_float64_lognormal_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_logcdf" "float64_lognormal_logcdf_impl"

let _owl_lognormal_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_logcdf
  | Float64        -> owl_float64_lognormal_logcdf
  | _              -> failwith "_owl_lognormal_logcdf: unsupported operation"

external owl_float32_lognormal_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_ppf" "float32_lognormal_ppf_impl"
external owl_float64_lognormal_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_ppf" "float64_lognormal_ppf_impl"

let _owl_lognormal_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_ppf
  | Float64        -> owl_float64_lognormal_ppf
  | _              -> failwith "_owl_lognormal_ppf: unsupported operation"

external owl_float32_lognormal_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_sf" "float32_lognormal_sf_impl"
external owl_float64_lognormal_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_sf" "float64_lognormal_sf_impl"

let _owl_lognormal_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_sf
  | Float64        -> owl_float64_lognormal_sf
  | _              -> failwith "_owl_lognormal_sf: unsupported operation"

external owl_float32_lognormal_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_logsf" "float32_lognormal_logsf_impl"
external owl_float64_lognormal_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_logsf" "float64_lognormal_logsf_impl"

let _owl_lognormal_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_logsf
  | Float64        -> owl_float64_lognormal_logsf
  | _              -> failwith "_owl_lognormal_logsf: unsupported operation"

external owl_float32_lognormal_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_lognormal_isf" "float32_lognormal_isf_impl"
external owl_float64_lognormal_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_lognormal_isf" "float64_lognormal_isf_impl"

let _owl_lognormal_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_lognormal_isf
  | Float64        -> owl_float64_lognormal_isf
  | _              -> failwith "_owl_lognormal_isf: unsupported operation"

external owl_float32_rayleigh_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_rvs" "float32_rayleigh_rvs_impl"
external owl_float64_rayleigh_rvs : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_rvs" "float64_rayleigh_rvs_impl"

let _owl_rayleigh_rvs : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_rvs
  | Float64        -> owl_float64_rayleigh_rvs
  | _              -> failwith "_owl_rayleigh_rvs: unsupported operation"

external owl_float32_rayleigh_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_pdf" "float32_rayleigh_pdf_impl"
external owl_float64_rayleigh_pdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_pdf" "float64_rayleigh_pdf_impl"

let _owl_rayleigh_pdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_pdf
  | Float64        -> owl_float64_rayleigh_pdf
  | _              -> failwith "_owl_rayleigh_pdf: unsupported operation"

external owl_float32_rayleigh_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_logpdf" "float32_rayleigh_logpdf_impl"
external owl_float64_rayleigh_logpdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_logpdf" "float64_rayleigh_logpdf_impl"

let _owl_rayleigh_logpdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_logpdf
  | Float64        -> owl_float64_rayleigh_logpdf
  | _              -> failwith "_owl_rayleigh_logpdf: unsupported operation"

external owl_float32_rayleigh_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_cdf" "float32_rayleigh_cdf_impl"
external owl_float64_rayleigh_cdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_cdf" "float64_rayleigh_cdf_impl"

let _owl_rayleigh_cdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_cdf
  | Float64        -> owl_float64_rayleigh_cdf
  | _              -> failwith "_owl_rayleigh_cdf: unsupported operation"

external owl_float32_rayleigh_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_logcdf" "float32_rayleigh_logcdf_impl"
external owl_float64_rayleigh_logcdf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_logcdf" "float64_rayleigh_logcdf_impl"

let _owl_rayleigh_logcdf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_logcdf
  | Float64        -> owl_float64_rayleigh_logcdf
  | _              -> failwith "_owl_rayleigh_logcdf: unsupported operation"

external owl_float32_rayleigh_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_ppf" "float32_rayleigh_ppf_impl"
external owl_float64_rayleigh_ppf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_ppf" "float64_rayleigh_ppf_impl"

let _owl_rayleigh_ppf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_ppf
  | Float64        -> owl_float64_rayleigh_ppf
  | _              -> failwith "_owl_rayleigh_ppf: unsupported operation"

external owl_float32_rayleigh_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_sf" "float32_rayleigh_sf_impl"
external owl_float64_rayleigh_sf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_sf" "float64_rayleigh_sf_impl"

let _owl_rayleigh_sf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_sf
  | Float64        -> owl_float64_rayleigh_sf
  | _              -> failwith "_owl_rayleigh_sf: unsupported operation"

external owl_float32_rayleigh_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_logsf" "float32_rayleigh_logsf_impl"
external owl_float64_rayleigh_logsf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_logsf" "float64_rayleigh_logsf_impl"

let _owl_rayleigh_logsf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_logsf
  | Float64        -> owl_float64_rayleigh_logsf
  | _              -> failwith "_owl_rayleigh_logsf: unsupported operation"

external owl_float32_rayleigh_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float32_rayleigh_isf" "float32_rayleigh_isf_impl"
external owl_float64_rayleigh_isf : ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> ('a, 'b) owl_arr -> (int64, int64_elt) owl_arr -> unit = "float64_rayleigh_isf" "float64_rayleigh_isf_impl"

let _owl_rayleigh_isf : type a b. (a, b) kind -> (a, b) owl_arr_op17 = function
  | Float32        -> owl_float32_rayleigh_isf
  | Float64        -> owl_float64_rayleigh_isf
  | _              -> failwith "_owl_rayleigh_isf: unsupported operation"
