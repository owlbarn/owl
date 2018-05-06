/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

// C stub for owl_stats_dist_ functions

#include <caml/alloc.h>
#include <caml/memory.h>

#include "owl_macros.h"
#include "owl_stats.h"


value owl_stub_std_uniform_rvs() {
  return caml_copy_double(sfmt_f64_1);
}


value owl_stub_uniform_int_rvs(value vA, value vB) {
  double a = Long_val(vA);
  double b = Long_val(vB);
  long y = sfmt_f64_2 * (b - a + 1) + a;
  return Val_long(y);
}


value owl_stub_uniform_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = uniform_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_uniform_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = uniform_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_uniform_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = uniform_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_uniform_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = uniform_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_exponential_rvs(value vA) {
  double a = Double_val(vA);
  double y = exponential_rvs(a);
  return caml_copy_double(y);
}


value owl_stub_exponential_pdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_pdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_logpdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_logpdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_cdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_cdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_logcdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_logcdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_ppf(value vP, value vA) {
  double a = Double_val(vA);
  double p = Double_val(vP);
  double x = exponential_ppf(p, a);
  return caml_copy_double(x);
}


value owl_stub_exponential_sf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_sf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_logsf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = exponential_logsf(x, a);
  return caml_copy_double(p);
}


value owl_stub_exponential_isf(value vQ, value vA) {
  double a = Double_val(vA);
  double q = Double_val(vQ);
  double x = exponential_isf(q, a);
  return caml_copy_double(x);
}


value owl_stub_gaussian_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = gaussian_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_gaussian_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = gaussian_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_gaussian_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gaussian_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gaussian_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = gaussian_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_gamma_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = gamma_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_gamma_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = gamma_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_gamma_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gamma_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gamma_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = gamma_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_beta_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = beta_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_beta_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = beta_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_beta_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = beta_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_beta_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = beta_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_chi2_rvs(value vA) {
  double a = Double_val(vA);
  double y = chi2_rvs(a);
  return caml_copy_double(y);
}


value owl_stub_chi2_pdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_pdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_logpdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_logpdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_cdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_cdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_logcdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_logcdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_ppf(value vP, value vA) {
  double a = Double_val(vA);
  double p = Double_val(vP);
  double x = chi2_ppf(p, a);
  return caml_copy_double(x);
}


value owl_stub_chi2_sf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_sf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_logsf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = chi2_logsf(x, a);
  return caml_copy_double(p);
}


value owl_stub_chi2_isf(value vQ, value vA) {
  double a = Double_val(vA);
  double q = Double_val(vQ);
  double x = chi2_isf(q, a);
  return caml_copy_double(x);
}


value owl_stub_f_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = f_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_f_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = f_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_f_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = f_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_f_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = f_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_cauchy_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = cauchy_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_cauchy_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = cauchy_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_cauchy_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = cauchy_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_cauchy_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = cauchy_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_t_rvs(value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double y = t_rvs(a, b, c);
  return caml_copy_double(y);
}


value owl_stub_t_pdf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_pdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_logpdf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_logpdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_cdf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_cdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_logcdf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_logcdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_ppf(value vP, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double p = Double_val(vP);
  double x = t_ppf(p, a, b, c);
  return caml_copy_double(x);
}


value owl_stub_t_sf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_sf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_logsf(value vX, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double x = Double_val(vX);
  double p = t_logsf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_t_isf(value vQ, value vA, value vB, value vC) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double c = Double_val(vC);
  double q = Double_val(vQ);
  double x = t_isf(q, a, b, c);
  return caml_copy_double(x);
}


value owl_stub_vonmises_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = vonmises_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_vonmises_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_vonmises_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_vonmises_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_vonmises_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_logcdf(x, a, b);
  return caml_copy_double(p);
}

/** FIXME
value owl_stub_vonmises_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = vonmises_ppf(p, a, b);
  return caml_copy_double(x);
}
**/

value owl_stub_vonmises_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_vonmises_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = vonmises_logsf(x, a, b);
  return caml_copy_double(p);
}

/** FIXME
value owl_stub_vonmises_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = vonmises_isf(q, a, b);
  return caml_copy_double(x);
}
**/

value owl_stub_lomax_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = lomax_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_lomax_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = lomax_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_lomax_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lomax_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lomax_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = lomax_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_weibull_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = weibull_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_weibull_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = weibull_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_weibull_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = weibull_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_weibull_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = weibull_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_laplace_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = laplace_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_laplace_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = laplace_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_laplace_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = laplace_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_laplace_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = laplace_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_gumbel1_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = gumbel1_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_gumbel1_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = gumbel1_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_gumbel1_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel1_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel1_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = gumbel1_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_gumbel2_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = gumbel2_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_gumbel2_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = gumbel2_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_gumbel2_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = gumbel2_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_gumbel2_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = gumbel2_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_logistic_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = logistic_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_logistic_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = logistic_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_logistic_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = logistic_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_logistic_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = logistic_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_lognormal_rvs(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = lognormal_rvs(a, b);
  return caml_copy_double(y);
}


value owl_stub_lognormal_pdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_pdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_logpdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_logpdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_cdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_cdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_logcdf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_logcdf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_ppf(value vP, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = lognormal_ppf(p, a, b);
  return caml_copy_double(x);
}


value owl_stub_lognormal_sf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_sf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_logsf(value vX, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double p = lognormal_logsf(x, a, b);
  return caml_copy_double(p);
}


value owl_stub_lognormal_isf(value vQ, value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double q = Double_val(vQ);
  double x = lognormal_isf(q, a, b);
  return caml_copy_double(x);
}


value owl_stub_rayleigh_rvs(value vA) {
  double a = Double_val(vA);
  double y = rayleigh_rvs(a);
  return caml_copy_double(y);
}


value owl_stub_rayleigh_pdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_pdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_logpdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_logpdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_cdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_cdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_logcdf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_logcdf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_ppf(value vP, value vA) {
  double a = Double_val(vA);
  double p = Double_val(vP);
  double x = rayleigh_ppf(p, a);
  return caml_copy_double(x);
}


value owl_stub_rayleigh_sf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_sf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_logsf(value vX, value vA) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double p = rayleigh_logsf(x, a);
  return caml_copy_double(p);
}


value owl_stub_rayleigh_isf(value vQ, value vA) {
  double a = Double_val(vA);
  double q = Double_val(vQ);
  double x = rayleigh_isf(q, a);
  return caml_copy_double(x);
}


value owl_stub_hypergeometric_rvs(value vA, value vB, value vC) {
  int a = Long_val(vA);
  int b = Long_val(vB);
  int c = Long_val(vC);
  double y = hypergeometric_rvs(a, b, c);
  return Val_long(y);
}


value owl_stub_hypergeometric_pdf(value vX, value vA, value vB, value vC) {
  int a = Long_val(vA);
  int b = Long_val(vB);
  int c = Long_val(vC);
  int x = Long_val(vX);
  double p = hypergeometric_pdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_hypergeometric_logpdf(value vX, value vA, value vB, value vC) {
  int a = Long_val(vA);
  int b = Long_val(vB);
  int c = Long_val(vC);
  int x = Long_val(vX);
  double p = hypergeometric_logpdf(x, a, b, c);
  return caml_copy_double(p);
}


value owl_stub_binomial_rvs(value vP, value vN) {
  double p = Double_val(vP);
  int n = Long_val(vN);
  int y = binomial_rvs(p, n);
  return Val_long(y);
}


value owl_stub_binomial_pdf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_pdf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_binomial_logpdf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_logpdf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_binomial_cdf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_cdf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_binomial_logcdf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_logcdf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_binomial_sf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_sf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_binomial_logsf(value vK, value vP, value vN) {
  int k = Long_val(vK);
  double p = Double_val(vP);
  int n = Long_val(vN);
  double y = binomial_logsf(k, p, n);
  return caml_copy_double(y);
}


value owl_stub_multinomial_rvs(value vK, value vN, value vP, value vS) {
  int k = Long_val(vK);
  int n = Long_val(vN);
  struct caml_ba_array *P = Caml_ba_array_val(vP);
  double *p = (double *) P->data;
  struct caml_ba_array *S = Caml_ba_array_val(vS);
  int32_t *s = (int32_t *) S->data;
  multinomial_rvs(k, n, p, s);
  return Val_unit;
}


value owl_stub_multinomial_pdf(value vK, value vP, value vS) {
  int k = Long_val(vK);
  struct caml_ba_array *P = Caml_ba_array_val(vP);
  double *p = (double *) P->data;
  struct caml_ba_array *S = Caml_ba_array_val(vS);
  int32_t *s = (int32_t *) S->data;
  double q = multinomial_pdf(k, p, s);
  return caml_copy_double(q);
}


value owl_stub_multinomial_logpdf(value vK, value vP, value vS) {
  int k = Long_val(vK);
  struct caml_ba_array *P = Caml_ba_array_val(vP);
  double *p = (double *) P->data;
  struct caml_ba_array *S = Caml_ba_array_val(vS);
  int32_t *s = (int32_t *) S->data;
  double q = multinomial_logpdf(k, p, s);
  return caml_copy_double(q);
}


value owl_stub_dirchlet_rvs(value vK, value vA, value vB) {
  int k = Long_val(vK);
  struct caml_ba_array *A = Caml_ba_array_val(vA);
  double *a = (double *) A->data;
  struct caml_ba_array *B = Caml_ba_array_val(vB);
  double *b = (double *) B->data;
  dirichlet_rvs(k, a, b);
  return Val_unit;
}


value owl_stub_dirchlet_pdf(value vK, value vA, value vB) {
  int k = Long_val(vK);
  struct caml_ba_array *A = Caml_ba_array_val(vA);
  double *a = (double *) A->data;
  struct caml_ba_array *B = Caml_ba_array_val(vB);
  double *b = (double *) B->data;
  double p = dirichlet_pdf(k, a, b);
  return caml_copy_double(p);
}


value owl_stub_dirchlet_logpdf(value vK, value vA, value vB) {
  int k = Long_val(vK);
  struct caml_ba_array *A = Caml_ba_array_val(vA);
  double *a = (double *) A->data;
  struct caml_ba_array *B = Caml_ba_array_val(vB);
  double *b = (double *) B->data;
  double p = dirichlet_logpdf(k, a, b);
  return caml_copy_double(p);
}
