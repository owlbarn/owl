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
