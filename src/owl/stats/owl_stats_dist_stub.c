/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

// C stub for owl_stats_dist_ functions

#include <caml/alloc.h>
#include <caml/memory.h>

#include "owl_macros.h"
#include "owl_stats.h"


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
  double x = uniform_sf(q, a, b);
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
  double x = exponential_sf(q, a);
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
  double x = gaussian_sf(q, a, b);
  return caml_copy_double(x);
}
