(*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Bigarray

open Owl_types


(* OCaml stub for owl_stats_dist_ functions *)

external std_uniform_rvs : unit -> float = "owl_stub_std_uniform_rvs"

external uniform_int_rvs : a:int -> b:int -> int = "owl_stub_uniform_int_rvs"

external uniform_rvs : a:float -> b:float -> float = "owl_stub_uniform_rvs"

external uniform_pdf : float -> a:float -> b:float -> float = "owl_stub_uniform_pdf"

external uniform_logpdf : float -> a:float -> b:float -> float = "owl_stub_uniform_logpdf"

external uniform_cdf : float -> a:float -> b:float -> float = "owl_stub_uniform_cdf"

external uniform_logcdf : float -> a:float -> b:float -> float = "owl_stub_uniform_logcdf"

external uniform_ppf : float -> a:float -> b:float -> float = "owl_stub_uniform_ppf"

external uniform_sf : float -> a:float -> b:float -> float = "owl_stub_uniform_sf"

external uniform_logsf : float -> a:float -> b:float -> float = "owl_stub_uniform_logsf"

external uniform_isf : float -> a:float -> b:float -> float = "owl_stub_uniform_isf"

external exponential_rvs : lambda:float -> float = "owl_stub_exponential_rvs"

external exponential_pdf : float -> lambda:float -> float = "owl_stub_exponential_pdf"

external exponential_logpdf : float -> lambda:float -> float = "owl_stub_exponential_logpdf"

external exponential_cdf : float -> lambda:float -> float = "owl_stub_exponential_cdf"

external exponential_logcdf : float -> lambda:float -> float = "owl_stub_exponential_logcdf"

external exponential_ppf : float -> lambda:float -> float = "owl_stub_exponential_ppf"

external exponential_sf : float -> lambda:float -> float = "owl_stub_exponential_sf"

external exponential_logsf : float -> lambda:float -> float = "owl_stub_exponential_logsf"

external exponential_isf : float -> lambda:float -> float = "owl_stub_exponential_isf"

external exponpow_rvs : a:float -> b:float -> float = "owl_stub_exponpow_rvs"

external exponpow_pdf : float -> a:float -> b:float -> float = "owl_stub_exponpow_pdf"

external exponpow_logpdf : float -> a:float -> b:float -> float = "owl_stub_exponpow_logpdf"

external exponpow_cdf : float -> a:float -> b:float -> float = "owl_stub_exponpow_cdf"

external exponpow_logcdf : float -> a:float -> b:float -> float = "owl_stub_exponpow_logcdf"

external exponpow_sf : float -> a:float -> b:float -> float = "owl_stub_exponpow_sf"

external exponpow_logsf : float -> a:float -> b:float -> float = "owl_stub_exponpow_logsf"

external gaussian_rvs : mu:float -> sigma:float -> float = "owl_stub_gaussian_rvs"

external gaussian_pdf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_pdf"

external gaussian_logpdf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_logpdf"

external gaussian_cdf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_cdf"

external gaussian_logcdf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_logcdf"

external gaussian_ppf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_ppf"

external gaussian_sf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_sf"

external gaussian_logsf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_logsf"

external gaussian_isf : float -> mu:float -> sigma:float -> float = "owl_stub_gaussian_isf"

external gamma_rvs : shape:float -> scale:float -> float = "owl_stub_gamma_rvs"

external gamma_pdf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_pdf"

external gamma_logpdf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_logpdf"

external gamma_cdf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_cdf"

external gamma_logcdf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_logcdf"

external gamma_ppf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_ppf"

external gamma_sf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_sf"

external gamma_logsf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_logsf"

external gamma_isf : float -> shape:float -> scale:float -> float = "owl_stub_gamma_isf"

external beta_rvs : a:float -> b:float -> float = "owl_stub_beta_rvs"

external beta_pdf : float -> a:float -> b:float -> float = "owl_stub_beta_pdf"

external beta_logpdf : float -> a:float -> b:float -> float = "owl_stub_beta_logpdf"

external beta_cdf : float -> a:float -> b:float -> float = "owl_stub_beta_cdf"

external beta_logcdf : float -> a:float -> b:float -> float = "owl_stub_beta_logcdf"

external beta_ppf : float -> a:float -> b:float -> float = "owl_stub_beta_ppf"

external beta_sf : float -> a:float -> b:float -> float = "owl_stub_beta_sf"

external beta_logsf : float -> a:float -> b:float -> float = "owl_stub_beta_logsf"

external beta_isf : float -> a:float -> b:float -> float = "owl_stub_beta_isf"

external chi2_rvs : df:float -> float = "owl_stub_chi2_rvs"

external chi2_pdf : float -> df:float -> float = "owl_stub_chi2_pdf"

external chi2_logpdf : float -> df:float -> float = "owl_stub_chi2_logpdf"

external chi2_cdf : float -> df:float -> float = "owl_stub_chi2_cdf"

external chi2_logcdf : float -> df:float -> float = "owl_stub_chi2_logcdf"

external chi2_ppf : float -> df:float -> float = "owl_stub_chi2_ppf"

external chi2_sf : float -> df:float -> float = "owl_stub_chi2_sf"

external chi2_logsf : float -> df:float -> float = "owl_stub_chi2_logsf"

external chi2_isf : float -> df:float -> float = "owl_stub_chi2_isf"

external f_rvs : dfnum:float -> dfden:float -> float = "owl_stub_f_rvs"

external f_pdf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_pdf"

external f_logpdf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_logpdf"

external f_cdf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_cdf"

external f_logcdf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_logcdf"

external f_ppf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_ppf"

external f_sf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_sf"

external f_logsf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_logsf"

external f_isf : float -> dfnum:float -> dfden:float -> float = "owl_stub_f_isf"

external cauchy_rvs : loc:float -> scale:float -> float = "owl_stub_cauchy_rvs"

external cauchy_pdf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_pdf"

external cauchy_logpdf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_logpdf"

external cauchy_cdf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_cdf"

external cauchy_logcdf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_logcdf"

external cauchy_ppf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_ppf"

external cauchy_sf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_sf"

external cauchy_logsf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_logsf"

external cauchy_isf : float -> loc:float -> scale:float -> float = "owl_stub_cauchy_isf"

external t_rvs : df:float -> loc:float -> scale:float -> float = "owl_stub_t_rvs"

external t_pdf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_pdf"

external t_logpdf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_logpdf"

external t_cdf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_cdf"

external t_logcdf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_logcdf"

external t_ppf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_ppf"

external t_sf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_sf"

external t_logsf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_logsf"

external t_isf : float -> df:float -> loc:float -> scale:float -> float = "owl_stub_t_isf"

external vonmises_rvs : mu:float -> kappa:float -> float = "owl_stub_vonmises_rvs"

external vonmises_pdf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_pdf"

external vonmises_logpdf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_logpdf"

external vonmises_cdf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_cdf"

external vonmises_logcdf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_logcdf"

(* FIXME external vonmises_ppf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_ppf" *)

external vonmises_sf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_sf"

external vonmises_logsf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_logsf"

(* FIXME external vonmises_isf : float -> mu:float -> kappa:float -> float = "owl_stub_vonmises_isf" *)

external lomax_rvs : shape:float -> scale:float -> float = "owl_stub_lomax_rvs"

external lomax_pdf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_pdf"

external lomax_logpdf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_logpdf"

external lomax_cdf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_cdf"

external lomax_logcdf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_logcdf"

external lomax_ppf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_ppf"

external lomax_sf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_sf"

external lomax_logsf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_logsf"

external lomax_isf : float -> shape:float -> scale:float -> float = "owl_stub_lomax_isf"

external weibull_rvs : shape:float -> scale:float -> float = "owl_stub_weibull_rvs"

external weibull_pdf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_pdf"

external weibull_logpdf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_logpdf"

external weibull_cdf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_cdf"

external weibull_logcdf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_logcdf"

external weibull_ppf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_ppf"

external weibull_sf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_sf"

external weibull_logsf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_logsf"

external weibull_isf : float -> shape:float -> scale:float -> float = "owl_stub_weibull_isf"

external laplace_rvs : loc:float -> scale:float -> float = "owl_stub_laplace_rvs"

external laplace_pdf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_pdf"

external laplace_logpdf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_logpdf"

external laplace_cdf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_cdf"

external laplace_logcdf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_logcdf"

external laplace_ppf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_ppf"

external laplace_sf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_sf"

external laplace_logsf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_logsf"

external laplace_isf : float -> loc:float -> scale:float -> float = "owl_stub_laplace_isf"

external gumbel1_rvs : a:float -> b:float -> float = "owl_stub_gumbel1_rvs"

external gumbel1_pdf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_pdf"

external gumbel1_logpdf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_logpdf"

external gumbel1_cdf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_cdf"

external gumbel1_logcdf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_logcdf"

external gumbel1_ppf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_ppf"

external gumbel1_sf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_sf"

external gumbel1_logsf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_logsf"

external gumbel1_isf : float -> a:float -> b:float -> float = "owl_stub_gumbel1_isf"

external gumbel2_rvs : a:float -> b:float -> float = "owl_stub_gumbel2_rvs"

external gumbel2_pdf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_pdf"

external gumbel2_logpdf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_logpdf"

external gumbel2_cdf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_cdf"

external gumbel2_logcdf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_logcdf"

external gumbel2_ppf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_ppf"

external gumbel2_sf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_sf"

external gumbel2_logsf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_logsf"

external gumbel2_isf : float -> a:float -> b:float -> float = "owl_stub_gumbel2_isf"

external logistic_rvs : loc:float -> scale:float -> float = "owl_stub_logistic_rvs"

external logistic_pdf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_pdf"

external logistic_logpdf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_logpdf"

external logistic_cdf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_cdf"

external logistic_logcdf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_logcdf"

external logistic_ppf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_ppf"

external logistic_sf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_sf"

external logistic_logsf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_logsf"

external logistic_isf : float -> loc:float -> scale:float -> float = "owl_stub_logistic_isf"

external lognormal_rvs : mu:float -> sigma:float -> float = "owl_stub_lognormal_rvs"

external lognormal_pdf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_pdf"

external lognormal_logpdf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_logpdf"

external lognormal_cdf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_cdf"

external lognormal_logcdf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_logcdf"

external lognormal_ppf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_ppf"

external lognormal_sf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_sf"

external lognormal_logsf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_logsf"

external lognormal_isf : float -> mu:float -> sigma:float -> float = "owl_stub_lognormal_isf"

external rayleigh_rvs : sigma:float -> float = "owl_stub_rayleigh_rvs"

external rayleigh_pdf : float -> sigma:float -> float = "owl_stub_rayleigh_pdf"

external rayleigh_logpdf : float -> sigma:float -> float = "owl_stub_rayleigh_logpdf"

external rayleigh_cdf : float -> sigma:float -> float = "owl_stub_rayleigh_cdf"

external rayleigh_logcdf : float -> sigma:float -> float = "owl_stub_rayleigh_logcdf"

external rayleigh_ppf : float -> sigma:float -> float = "owl_stub_rayleigh_ppf"

external rayleigh_sf : float -> sigma:float -> float = "owl_stub_rayleigh_sf"

external rayleigh_logsf : float -> sigma:float -> float = "owl_stub_rayleigh_logsf"

external rayleigh_isf : float -> sigma:float -> float = "owl_stub_rayleigh_isf"

external hypergeometric_rvs : good:int -> bad:int -> sample:int -> int = "owl_stub_hypergeometric_rvs"

external hypergeometric_pdf : int -> good:int -> bad:int -> sample:int -> float = "owl_stub_hypergeometric_pdf"

external hypergeometric_logpdf : int -> good:int -> bad:int -> sample:int -> float = "owl_stub_hypergeometric_logpdf"

external binomial_rvs : p:float -> n:int -> int = "owl_stub_binomial_rvs"

external binomial_pdf : int -> p:float -> n:int -> float = "owl_stub_binomial_pdf"

external binomial_logpdf : int -> p:float -> n:int -> float = "owl_stub_binomial_logpdf"

external binomial_cdf : int -> p:float -> n:int -> float = "owl_stub_binomial_cdf"

external binomial_logcdf : int -> p:float -> n:int -> float = "owl_stub_binomial_logcdf"

external binomial_sf : int -> p:float -> n:int -> float = "owl_stub_binomial_sf"

external binomial_logsf : int -> p:float -> n:int -> float = "owl_stub_binomial_logsf"

external _multinomial_rvs : k:int -> n:int -> p:(float, float64_elt) owl_arr -> (int32, int32_elt) owl_arr -> unit = "owl_stub_multinomial_rvs"

let multinomial_rvs n ~p =
  let k = Array.length p in
  let _p = Genarray.create float64 c_layout [|k|] in
  let _s = Genarray.create int32 c_layout [|k|] in
  Owl_utils.Array.balance_last 1. p |>
  Array.iteri (fun i a -> Genarray.set _p [|i|] a);
  _multinomial_rvs ~k ~n ~p:_p _s;
  Array.init k (fun i -> Genarray.get _s [|i|] |> Int32.to_int)

external _multinomial_pdf : k:int -> p:(float, float64_elt) owl_arr -> (int32, int32_elt) owl_arr -> float = "owl_stub_multinomial_pdf"

let multinomial_pdf x ~p =
  let k = Array.length x in
  assert (k = Array.length p);
  let _p = Genarray.create float64 c_layout [|k|] in
  let _s = Genarray.create int32 c_layout [|k|] in
  Owl_utils.Array.balance_last 1. p |>
  Array.iteri (fun i a -> Genarray.set _p [|i|] a);
  Array.iteri (fun i a -> Genarray.set _s [|i|] (Int32.of_int a)) x;
  _multinomial_pdf ~k ~p:_p _s

external _multinomial_logpdf : k:int -> p:(float, float64_elt) owl_arr -> (int32, int32_elt) owl_arr -> float = "owl_stub_multinomial_logpdf"

let multinomial_logpdf x ~p =
  let k = Array.length x in
  assert (k = Array.length p);
  let _p = Genarray.create float64 c_layout [|k|] in
  let _s = Genarray.create int32 c_layout [|k|] in
  Owl_utils.Array.balance_last 1. p |>
  Array.iteri (fun i a -> Genarray.set _p [|i|] a);
  Array.iteri (fun i a -> Genarray.set _s [|i|] (Int32.of_int a)) x;
  _multinomial_logpdf ~k ~p:_p _s

let categorical_rvs p =
  let x = multinomial_rvs 1 ~p in
  Owl_utils.Array.index_of x 1

external _dirichlet_rvs : k:int -> alpha:(float, float64_elt) owl_arr -> theta:(float, float64_elt) owl_arr -> unit = "owl_stub_dirchlet_rvs"

let dirichlet_rvs ~alpha =
  let k = Array.length alpha in
  let _a = Genarray.create float64 c_layout [|k|] in
  let _b = Genarray.create float64 c_layout [|k|] in
  Array.iteri (fun i c -> Genarray.set _a [|i|] c) alpha;
  _dirichlet_rvs ~k ~alpha:_a ~theta:_b;
  Array.init k (fun i -> Genarray.get _b [|i|])

external _dirichlet_pdf : k:int -> alpha:(float, float64_elt) owl_arr -> theta:(float, float64_elt) owl_arr -> float = "owl_stub_dirchlet_pdf"

let dirichlet_pdf x ~alpha =
  if Owl_base_maths.is_simplex x = false then
    raise Owl_exception.NOT_SIMPLEX;
  let k = Array.length alpha in
  let _a = Genarray.create float64 c_layout [|k|] in
  let _x = Genarray.create float64 c_layout [|k|] in
  Array.iteri (fun i c -> Genarray.set _a [|i|] c) alpha;
  Array.iteri (fun i c -> Genarray.set _x [|i|] c) x;
  _dirichlet_pdf ~k ~alpha:_a ~theta:_x

external _dirichlet_logpdf : k:int -> alpha:(float, float64_elt) owl_arr -> theta:(float, float64_elt) owl_arr -> float = "owl_stub_dirchlet_logpdf"

let dirichlet_logpdf x ~alpha =
  if Owl_base_maths.is_simplex x = false then
    raise Owl_exception.NOT_SIMPLEX;
  let k = Array.length alpha in
  let _a = Genarray.create float64 c_layout [|k|] in
  let _x = Genarray.create float64 c_layout [|k|] in
  Array.iteri (fun i c -> Genarray.set _a [|i|] c) alpha;
  Array.iteri (fun i c -> Genarray.set _x [|i|] c) x;
  _dirichlet_logpdf ~k ~alpha:_a ~theta:_x
