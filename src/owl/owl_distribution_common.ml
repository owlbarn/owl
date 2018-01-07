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
