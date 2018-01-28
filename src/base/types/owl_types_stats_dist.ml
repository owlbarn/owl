(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)


module type Sig = sig

  include Owl_types_ndarray_mutable.Sig
  

  val uniform_rvs : a:arr -> b:arr -> n:int -> arr

  val uniform_pdf : a:arr -> b:arr -> arr -> arr

  val uniform_logpdf : a:arr -> b:arr -> arr -> arr

  val uniform_cdf : a:arr -> b:arr -> arr -> arr

  val uniform_logcdf : a:arr -> b:arr -> arr -> arr

  val uniform_ppf : a:arr -> b:arr -> arr -> arr

  val uniform_sf : a:arr -> b:arr -> arr -> arr

  val uniform_logsf : a:arr -> b:arr -> arr -> arr

  val uniform_isf : a:arr -> b:arr -> arr -> arr

  val gaussian_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val gaussian_pdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_cdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_ppf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_sf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_logsf : mu:arr -> sigma:arr -> arr -> arr

  val gaussian_isf : mu:arr -> sigma:arr -> arr -> arr

  val exponential_rvs : lambda:arr -> n:int -> arr

  val exponential_pdf : lambda:arr -> arr -> arr

  val exponential_logpdf : lambda:arr -> arr -> arr

  val exponential_cdf : lambda:arr -> arr -> arr

  val exponential_logcdf : lambda:arr -> arr -> arr

  val exponential_ppf : lambda:arr -> arr -> arr

  val exponential_sf : lambda:arr -> arr -> arr

  val exponential_logsf : lambda:arr -> arr -> arr

  val exponential_isf : lambda:arr -> arr -> arr

  val gamma_rvs : shape:arr -> scale:arr -> n:int -> arr

  val gamma_pdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logpdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_cdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logcdf : shape:arr -> scale:arr -> arr -> arr

  val gamma_ppf : shape:arr -> scale:arr -> arr -> arr

  val gamma_sf : shape:arr -> scale:arr -> arr -> arr

  val gamma_logsf : shape:arr -> scale:arr -> arr -> arr

  val gamma_isf : shape:arr -> scale:arr -> arr -> arr

  val beta_rvs : a:arr -> b:arr -> n:int -> arr

  val beta_pdf : a:arr -> b:arr -> arr -> arr

  val beta_logpdf : a:arr -> b:arr -> arr -> arr

  val beta_cdf : a:arr -> b:arr -> arr -> arr

  val beta_logcdf : a:arr -> b:arr -> arr -> arr

  val beta_ppf : a:arr -> b:arr -> arr -> arr

  val beta_sf : a:arr -> b:arr -> arr -> arr

  val beta_logsf : a:arr -> b:arr -> arr -> arr

  val beta_isf : a:arr -> b:arr -> arr -> arr

  val chi2_rvs : df:arr -> n:int -> arr

  val chi2_pdf : df:arr -> arr -> arr

  val chi2_logpdf : df:arr -> arr -> arr

  val chi2_cdf : df:arr -> arr -> arr

  val chi2_logcdf : df:arr -> arr -> arr

  val chi2_ppf : df:arr -> arr -> arr

  val chi2_sf : df:arr -> arr -> arr

  val chi2_logsf : df:arr -> arr -> arr

  val chi2_isf : df:arr -> arr -> arr

  val f_rvs : dfnum:arr -> dfden:arr -> n:int -> arr

  val f_pdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logpdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_cdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logcdf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_ppf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_sf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_logsf : dfnum:arr -> dfden:arr -> arr -> arr

  val f_isf : dfnum:arr -> dfden:arr -> arr -> arr

  val cauchy_rvs : loc:arr -> scale:arr -> n:int -> arr

  val cauchy_pdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logpdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_cdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logcdf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_ppf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_sf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_logsf : loc:arr -> scale:arr -> arr -> arr

  val cauchy_isf : loc:arr -> scale:arr -> arr -> arr

  val lomax_rvs : shape:arr -> scale:arr -> n:int -> arr

  val lomax_pdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logpdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_cdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logcdf : shape:arr -> scale:arr -> arr -> arr

  val lomax_ppf : shape:arr -> scale:arr -> arr -> arr

  val lomax_sf : shape:arr -> scale:arr -> arr -> arr

  val lomax_logsf : shape:arr -> scale:arr -> arr -> arr

  val lomax_isf : shape:arr -> scale:arr -> arr -> arr

  val weibull_rvs : shape:arr -> scale:arr -> n:int -> arr

  val weibull_pdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logpdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_cdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logcdf : shape:arr -> scale:arr -> arr -> arr

  val weibull_ppf : shape:arr -> scale:arr -> arr -> arr

  val weibull_sf : shape:arr -> scale:arr -> arr -> arr

  val weibull_logsf : shape:arr -> scale:arr -> arr -> arr

  val weibull_isf : shape:arr -> scale:arr -> arr -> arr

  val laplace_rvs : loc:arr -> scale:arr -> n:int -> arr

  val laplace_pdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logpdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_cdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logcdf : loc:arr -> scale:arr -> arr -> arr

  val laplace_ppf : loc:arr -> scale:arr -> arr -> arr

  val laplace_sf : loc:arr -> scale:arr -> arr -> arr

  val laplace_logsf : loc:arr -> scale:arr -> arr -> arr

  val laplace_isf : loc:arr -> scale:arr -> arr -> arr

  val gumbel1_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel1_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel1_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel1_sf : a:arr -> b:arr -> arr -> arr

  val gumbel1_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel1_isf : a:arr -> b:arr -> arr -> arr

  val gumbel2_rvs : a:arr -> b:arr -> n:int -> arr

  val gumbel2_pdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logpdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_cdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logcdf : a:arr -> b:arr -> arr -> arr

  val gumbel2_ppf : a:arr -> b:arr -> arr -> arr

  val gumbel2_sf : a:arr -> b:arr -> arr -> arr

  val gumbel2_logsf : a:arr -> b:arr -> arr -> arr

  val gumbel2_isf : a:arr -> b:arr -> arr -> arr

  val logistic_rvs : loc:arr -> scale:arr -> n:int -> arr

  val logistic_pdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logpdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_cdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logcdf : loc:arr -> scale:arr -> arr -> arr

  val logistic_ppf : loc:arr -> scale:arr -> arr -> arr

  val logistic_sf : loc:arr -> scale:arr -> arr -> arr

  val logistic_logsf : loc:arr -> scale:arr -> arr -> arr

  val logistic_isf : loc:arr -> scale:arr -> arr -> arr

  val lognormal_rvs : mu:arr -> sigma:arr -> n:int -> arr

  val lognormal_pdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logpdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_cdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logcdf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_ppf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_sf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_logsf : mu:arr -> sigma:arr -> arr -> arr

  val lognormal_isf : mu:arr -> sigma:arr -> arr -> arr

  val rayleigh_rvs : sigma:arr -> n:int -> arr

  val rayleigh_pdf : sigma:arr -> arr -> arr

  val rayleigh_logpdf : sigma:arr -> arr -> arr

  val rayleigh_cdf : sigma:arr -> arr -> arr

  val rayleigh_logcdf : sigma:arr -> arr -> arr

  val rayleigh_ppf : sigma:arr -> arr -> arr

  val rayleigh_sf : sigma:arr -> arr -> arr

  val rayleigh_logsf : sigma:arr -> arr -> arr

  val rayleigh_isf : sigma:arr -> arr -> arr

end
