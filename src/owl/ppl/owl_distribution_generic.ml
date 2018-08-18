(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_ndarray

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
  let t0 = Owl_utils.calc_stride s0 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let t1 = Owl_utils.calc_stride s1 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  (* return aligned arrays, shapes, strides *)
  y0, y1, s0, s1, t0, t1


(* broadcast for [f : x -> y -> z] *)
let broadcast_op0 op x0 x1 n =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let s2 = Array.(map2 Pervasives.max s0 s1 |> append [|n|]) in
  let t2 = Owl_utils.calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
  let y2 = empty (kind x0) s2 in
  (* call the specific map function *)
  op y0 t0 y1 t1 y2 t2;
  y2

let broadcast_op2 op x0 x1 y2 =
  (* align the input rank, calculate the output shape and stride *)
  let y0, y1, s0, s1, t0, t1 = broadcast_align_shape x0 x1 in
  let y2 = copy y2 in
  let s2 = shape y2 in
  let t2 = Owl_utils.calc_stride s2 |> Array.map Int64.of_int |> Array1.of_array int64 c_layout |> genarray_of_array1 in
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


let cauchy_rvs ~loc ~scale ~n = broadcast_op0 (_owl_cauchy_rvs (kind loc)) loc scale n

let cauchy_pdf ~loc ~scale x = broadcast_op2 (_owl_cauchy_pdf (kind x)) loc scale x

let cauchy_logpdf ~loc ~scale x = broadcast_op2 (_owl_cauchy_logpdf (kind x)) loc scale x

let cauchy_cdf ~loc ~scale x = broadcast_op2 (_owl_cauchy_cdf (kind x)) loc scale x

let cauchy_logcdf ~loc ~scale x = broadcast_op2 (_owl_cauchy_logcdf (kind x)) loc scale x

let cauchy_ppf ~loc ~scale x = broadcast_op2 (_owl_cauchy_ppf (kind x)) loc scale x

let cauchy_sf ~loc ~scale x = broadcast_op2 (_owl_cauchy_sf (kind x)) loc scale x

let cauchy_logsf ~loc ~scale x = broadcast_op2 (_owl_cauchy_logsf (kind x)) loc scale x

let cauchy_isf ~loc ~scale x = broadcast_op2 (_owl_cauchy_isf (kind x)) loc scale x


let lomax_rvs ~shape ~scale ~n = broadcast_op0 (_owl_lomax_rvs (kind shape)) shape scale n

let lomax_pdf ~shape ~scale x = broadcast_op2 (_owl_lomax_pdf (kind x)) shape scale x

let lomax_logpdf ~shape ~scale x = broadcast_op2 (_owl_lomax_logpdf (kind x)) shape scale x

let lomax_cdf ~shape ~scale x = broadcast_op2 (_owl_lomax_cdf (kind x)) shape scale x

let lomax_logcdf ~shape ~scale x = broadcast_op2 (_owl_lomax_logcdf (kind x)) shape scale x

let lomax_ppf ~shape ~scale x = broadcast_op2 (_owl_lomax_ppf (kind x)) shape scale x

let lomax_sf ~shape ~scale x = broadcast_op2 (_owl_lomax_sf (kind x)) shape scale x

let lomax_logsf ~shape ~scale x = broadcast_op2 (_owl_lomax_logsf (kind x)) shape scale x

let lomax_isf ~shape ~scale x = broadcast_op2 (_owl_lomax_isf (kind x)) shape scale x


let weibull_rvs ~shape ~scale ~n = broadcast_op0 (_owl_weibull_rvs (kind shape)) shape scale n

let weibull_pdf ~shape ~scale x = broadcast_op2 (_owl_weibull_pdf (kind x)) shape scale x

let weibull_logpdf ~shape ~scale x = broadcast_op2 (_owl_weibull_logpdf (kind x)) shape scale x

let weibull_cdf ~shape ~scale x = broadcast_op2 (_owl_weibull_cdf (kind x)) shape scale x

let weibull_logcdf ~shape ~scale x = broadcast_op2 (_owl_weibull_logcdf (kind x)) shape scale x

let weibull_ppf ~shape ~scale x = broadcast_op2 (_owl_weibull_ppf (kind x)) shape scale x

let weibull_sf ~shape ~scale x = broadcast_op2 (_owl_weibull_sf (kind x)) shape scale x

let weibull_logsf ~shape ~scale x = broadcast_op2 (_owl_weibull_logsf (kind x)) shape scale x

let weibull_isf ~shape ~scale x = broadcast_op2 (_owl_weibull_isf (kind x)) shape scale x


let laplace_rvs ~loc ~scale ~n = broadcast_op0 (_owl_laplace_rvs (kind loc)) loc scale n

let laplace_pdf ~loc ~scale x = broadcast_op2 (_owl_laplace_pdf (kind x)) loc scale x

let laplace_logpdf ~loc ~scale x = broadcast_op2 (_owl_laplace_logpdf (kind x)) loc scale x

let laplace_cdf ~loc ~scale x = broadcast_op2 (_owl_laplace_cdf (kind x)) loc scale x

let laplace_logcdf ~loc ~scale x = broadcast_op2 (_owl_laplace_logcdf (kind x)) loc scale x

let laplace_ppf ~loc ~scale x = broadcast_op2 (_owl_laplace_ppf (kind x)) loc scale x

let laplace_sf ~loc ~scale x = broadcast_op2 (_owl_laplace_sf (kind x)) loc scale x

let laplace_logsf ~loc ~scale x = broadcast_op2 (_owl_laplace_logsf (kind x)) loc scale x

let laplace_isf ~loc ~scale x = broadcast_op2 (_owl_laplace_isf (kind x)) loc scale x


let gumbel1_rvs ~a ~b ~n = broadcast_op0 (_owl_gumbel1_rvs (kind a)) a b n

let gumbel1_pdf ~a ~b x = broadcast_op2 (_owl_gumbel1_pdf (kind x)) a b x

let gumbel1_logpdf ~a ~b x = broadcast_op2 (_owl_gumbel1_logpdf (kind x)) a b x

let gumbel1_cdf ~a ~b x = broadcast_op2 (_owl_gumbel1_cdf (kind x)) a b x

let gumbel1_logcdf ~a ~b x = broadcast_op2 (_owl_gumbel1_logcdf (kind x)) a b x

let gumbel1_ppf ~a ~b x = broadcast_op2 (_owl_gumbel1_ppf (kind x)) a b x

let gumbel1_sf ~a ~b x = broadcast_op2 (_owl_gumbel1_sf (kind x)) a b x

let gumbel1_logsf ~a ~b x = broadcast_op2 (_owl_gumbel1_logsf (kind x)) a b x

let gumbel1_isf ~a ~b x = broadcast_op2 (_owl_gumbel1_isf (kind x)) a b x


let gumbel2_rvs ~a ~b ~n = broadcast_op0 (_owl_gumbel2_rvs (kind a)) a b n

let gumbel2_pdf ~a ~b x = broadcast_op2 (_owl_gumbel2_pdf (kind x)) a b x

let gumbel2_logpdf ~a ~b x = broadcast_op2 (_owl_gumbel2_logpdf (kind x)) a b x

let gumbel2_cdf ~a ~b x = broadcast_op2 (_owl_gumbel2_cdf (kind x)) a b x

let gumbel2_logcdf ~a ~b x = broadcast_op2 (_owl_gumbel2_logcdf (kind x)) a b x

let gumbel2_ppf ~a ~b x = broadcast_op2 (_owl_gumbel2_ppf (kind x)) a b x

let gumbel2_sf ~a ~b x = broadcast_op2 (_owl_gumbel2_sf (kind x)) a b x

let gumbel2_logsf ~a ~b x = broadcast_op2 (_owl_gumbel2_logsf (kind x)) a b x

let gumbel2_isf ~a ~b x = broadcast_op2 (_owl_gumbel2_isf (kind x)) a b x


let logistic_rvs ~loc ~scale ~n = broadcast_op0 (_owl_logistic_rvs (kind loc)) loc scale n

let logistic_pdf ~loc ~scale x = broadcast_op2 (_owl_logistic_pdf (kind x)) loc scale x

let logistic_logpdf ~loc ~scale x = broadcast_op2 (_owl_logistic_logpdf (kind x)) loc scale x

let logistic_cdf ~loc ~scale x = broadcast_op2 (_owl_logistic_cdf (kind x)) loc scale x

let logistic_logcdf ~loc ~scale x = broadcast_op2 (_owl_logistic_logcdf (kind x)) loc scale x

let logistic_ppf ~loc ~scale x = broadcast_op2 (_owl_logistic_ppf (kind x)) loc scale x

let logistic_sf ~loc ~scale x = broadcast_op2 (_owl_logistic_sf (kind x)) loc scale x

let logistic_logsf ~loc ~scale x = broadcast_op2 (_owl_logistic_logsf (kind x)) loc scale x

let logistic_isf ~loc ~scale x = broadcast_op2 (_owl_logistic_isf (kind x)) loc scale x


let lognormal_rvs ~mu ~sigma ~n = broadcast_op0 (_owl_lognormal_rvs (kind mu)) mu sigma n

let lognormal_pdf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_pdf (kind x)) mu sigma x

let lognormal_logpdf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_logpdf (kind x)) mu sigma x

let lognormal_cdf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_cdf (kind x)) mu sigma x

let lognormal_logcdf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_logcdf (kind x)) mu sigma x

let lognormal_ppf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_ppf (kind x)) mu sigma x

let lognormal_sf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_sf (kind x)) mu sigma x

let lognormal_logsf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_logsf (kind x)) mu sigma x

let lognormal_isf ~mu ~sigma x = broadcast_op2 (_owl_lognormal_isf (kind x)) mu sigma x


let rayleigh_rvs ~sigma ~n = broadcast_op1 (_owl_rayleigh_rvs (kind sigma)) sigma n

let rayleigh_pdf ~sigma x = broadcast_op2 (_owl_rayleigh_pdf (kind x)) sigma sigma x

let rayleigh_logpdf ~sigma x = broadcast_op2 (_owl_rayleigh_logpdf (kind x)) sigma sigma x

let rayleigh_cdf ~sigma x = broadcast_op2 (_owl_rayleigh_cdf (kind x)) sigma sigma x

let rayleigh_logcdf ~sigma x = broadcast_op2 (_owl_rayleigh_logcdf (kind x)) sigma sigma x

let rayleigh_ppf ~sigma x = broadcast_op2 (_owl_rayleigh_ppf (kind x)) sigma sigma x

let rayleigh_sf ~sigma x = broadcast_op2 (_owl_rayleigh_sf (kind x)) sigma sigma x

let rayleigh_logsf ~sigma x = broadcast_op2 (_owl_rayleigh_logsf (kind x)) sigma sigma x

let rayleigh_isf ~sigma x = broadcast_op2 (_owl_rayleigh_isf (kind x)) sigma sigma x


(* ends here *)
