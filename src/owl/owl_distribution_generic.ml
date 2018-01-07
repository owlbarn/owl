(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_dense_common

open Owl_dense_ndarray_generic

open Owl_distribution_common


(* TODO: broadcast_* are most temp solutions atm. *)

(* TODO: same as that in Owl_dense_ndarray_generic, need to combine soon. *)
let broadcast_align_shape x0 x1 =
  (* align the rank of inputs *)
  let d0 = num_dims x0 in
  let d1 = num_dims x1 in
  let d3 = Pervasives.max d0 d1 in
  let y0 = expand x0 d3 in
  let y1 = expand x1 d3 in
  (* check whether the shape is valid *)
  let s0 = shape y0 in
  let s1 = shape y1 in
  Array.iter2 (fun a b ->
    assert (not(a <> 1 && b <> 1 && a <> b))
  ) s0 s1;
  (* calculate the strides *)
  let t0 = _calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = _calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* return aligned arrays, shapes, strides *)
  y0, y1, s0, s1, t0, t1


(* broadcast for [f : x -> y -> z] *)
let broadcast_op0 op x0 x1 n =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let s2 = Array.(map2 Pervasives.max s0 s1 |> append [|n|]) in
  let t2 = _calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let y2 = empty (kind x0) s2 in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2

let broadcast_op2 op x0 x1 y2 =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let y2 = copy y2 in
  let s2 = shape y2 in
  let t2 = _calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2

(* broadcast for [f : x -> y] *)
let broadcast_op1 op x n =
  let y = empty (kind x) (Array.append [|n|] (shape x)) in
  let x, y, sx, sy, tx, ty = broadcast_align_shape x y in
  (* call the specific map function *)
  op x tx y ty y ty;
  y

let broadcast_op3 op x y =
  let y = copy y in
  let x, y, sx, sy, tx, ty = broadcast_align_shape x y in
  (* call the specific map function *)
  op x tx y ty y ty;
  y


let uniform_rvs ~a ~b ~n = broadcast_op0 (_owl_uniform_rvs (kind a)) a b n

let uniform_pdf ~a ~b x = broadcast_op2 (_owl_uniform_pdf (kind x)) a b x

let uniform_logpdf ~a ~b x = broadcast_op2 (_owl_uniform_logpdf (kind x)) a b x

let uniform_cdf ~a ~b x = broadcast_op2 (_owl_uniform_cdf (kind x)) a b x

let uniform_logcdf ~a ~b x = broadcast_op2 (_owl_uniform_logcdf (kind x)) a b x

let uniform_ppf ~a ~b x = broadcast_op2 (_owl_uniform_ppf (kind x)) a b x

let uniform_sf ~a ~b x = broadcast_op2 (_owl_uniform_sf (kind x)) a b x

let uniform_logsf ~a ~b x = broadcast_op2 (_owl_uniform_logsf (kind x)) a b x

let uniform_isf ~a ~b x = broadcast_op2 (_owl_uniform_isf (kind x)) a b x


let gaussian_rvs ~mu ~sigma ~n = broadcast_op0 (_owl_gaussian_rvs (kind mu)) mu sigma n

let gaussian_pdf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_pdf (kind x)) mu sigma x

let gaussian_logpdf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_logpdf (kind x)) mu sigma x

let gaussian_cdf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_cdf (kind x)) mu sigma x

let gaussian_logcdf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_logcdf (kind x)) mu sigma x

let gaussian_ppf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_ppf (kind x)) mu sigma x

let gaussian_sf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_sf (kind x)) mu sigma x

let gaussian_logsf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_logsf (kind x)) mu sigma x

let gaussian_isf ~mu ~sigma x = broadcast_op2 (_owl_gaussian_isf (kind x)) mu sigma x


let exponential_rvs ~lambda ~n = broadcast_op1 (_owl_exponential_rvs (kind lambda)) lambda n

let exponential_pdf ~lambda x = broadcast_op2 (_owl_exponential_pdf (kind x)) lambda lambda x

let exponential_logpdf ~lambda x = broadcast_op2 (_owl_exponential_logpdf (kind x)) lambda lambda x

let exponential_cdf ~lambda x = broadcast_op2 (_owl_exponential_cdf (kind x)) lambda lambda x

let exponential_logcdf ~lambda x = broadcast_op2 (_owl_exponential_logcdf (kind x)) lambda lambda x

let exponential_ppf ~lambda x = broadcast_op2 (_owl_exponential_ppf (kind x)) lambda lambda x

let exponential_sf ~lambda x = broadcast_op2 (_owl_exponential_sf (kind x)) lambda lambda x

let exponential_logsf ~lambda x = broadcast_op2 (_owl_exponential_logsf (kind x)) lambda lambda x

let exponential_isf ~lambda x = broadcast_op2 (_owl_exponential_isf (kind x)) lambda lambda x


let gamma_rvs ~shape ~scale ~n = broadcast_op0 (_owl_gamma_rvs (kind shape)) shape scale n

let gamma_pdf ~shape ~scale x = broadcast_op2 (_owl_gamma_pdf (kind x)) shape scale x

let gamma_logpdf ~shape ~scale x = broadcast_op2 (_owl_gamma_logpdf (kind x)) shape scale x

let gamma_cdf ~shape ~scale x = broadcast_op2 (_owl_gamma_cdf (kind x)) shape scale x

let gamma_logcdf ~shape ~scale x = broadcast_op2 (_owl_gamma_logcdf (kind x)) shape scale x

let gamma_ppf ~shape ~scale x = broadcast_op2 (_owl_gamma_ppf (kind x)) shape scale x

let gamma_sf ~shape ~scale x = broadcast_op2 (_owl_gamma_sf (kind x)) shape scale x

let gamma_logsf ~shape ~scale x = broadcast_op2 (_owl_gamma_logsf (kind x)) shape scale x

let gamma_isf ~shape ~scale x = broadcast_op2 (_owl_gamma_isf (kind x)) shape scale x


let beta_rvs ~a ~b ~n = broadcast_op0 (_owl_beta_rvs (kind a)) a b n

let beta_pdf ~a ~b x = broadcast_op2 (_owl_beta_pdf (kind x)) a b x

let beta_logpdf ~a ~b x = broadcast_op2 (_owl_beta_logpdf (kind x)) a b x

let beta_cdf ~a ~b x = broadcast_op2 (_owl_beta_cdf (kind x)) a b x

let beta_logcdf ~a ~b x = broadcast_op2 (_owl_beta_logcdf (kind x)) a b x

let beta_ppf ~a ~b x = broadcast_op2 (_owl_beta_ppf (kind x)) a b x

let beta_sf ~a ~b x = broadcast_op2 (_owl_beta_sf (kind x)) a b x

let beta_logsf ~a ~b x = broadcast_op2 (_owl_beta_logsf (kind x)) a b x

let beta_isf ~a ~b x = broadcast_op2 (_owl_beta_isf (kind x)) a b x


let chi2_rvs ~df ~n = broadcast_op1 (_owl_chi2_rvs (kind df)) df n

let chi2_pdf ~df x = broadcast_op2 (_owl_chi2_pdf (kind x)) df df x

let chi2_logpdf ~df x = broadcast_op2 (_owl_chi2_logpdf (kind x)) df df x

let chi2_cdf ~df x = broadcast_op2 (_owl_chi2_cdf (kind x)) df df x

let chi2_logcdf ~df x = broadcast_op2 (_owl_chi2_logcdf (kind x)) df df x

let chi2_ppf ~df x = broadcast_op2 (_owl_chi2_ppf (kind x)) df df x

let chi2_sf ~df x = broadcast_op2 (_owl_chi2_sf (kind x)) df df x

let chi2_logsf ~df x = broadcast_op2 (_owl_chi2_logsf (kind x)) df df x

let chi2_isf ~df x = broadcast_op2 (_owl_chi2_isf (kind x)) df df x


let f_rvs ~dfnum ~dfden ~n = broadcast_op0 (_owl_f_rvs (kind dfnum)) dfnum dfden n

let f_pdf ~dfnum ~dfden x = broadcast_op2 (_owl_f_pdf (kind x)) dfnum dfden x

let f_logpdf ~dfnum ~dfden x = broadcast_op2 (_owl_f_logpdf (kind x)) dfnum dfden x

let f_cdf ~dfnum ~dfden x = broadcast_op2 (_owl_f_cdf (kind x)) dfnum dfden x

let f_logcdf ~dfnum ~dfden x = broadcast_op2 (_owl_f_logcdf (kind x)) dfnum dfden x

let f_ppf ~dfnum ~dfden x = broadcast_op2 (_owl_f_ppf (kind x)) dfnum dfden x

let f_sf ~dfnum ~dfden x = broadcast_op2 (_owl_f_sf (kind x)) dfnum dfden x

let f_logsf ~dfnum ~dfden x = broadcast_op2 (_owl_f_logsf (kind x)) dfnum dfden x

let f_isf ~dfnum ~dfden x = broadcast_op2 (_owl_f_isf (kind x)) dfnum dfden x


(* ends here *)
