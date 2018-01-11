/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "ctypes_cstubs_internals.h"
#include <stdio.h>

// FIXME
value owl_stub_sf_j0(value vX) {
  double x = Double_val(vX);
  double y = j0(x);
  printf("%f --> %f\n", x, y);
  return caml_copy_double(y);
}


value owl_stub_sf_gamma(value vX) {
  double x = Double_val(vX);
  double y = Gamma(x);
  return caml_copy_double(y);
}


value owl_stub_sf_loggamma(value vX) {
  double x = Double_val(vX);
  double y = lgam(x);
  return caml_copy_double(y);
}


value owl_stub_sf_gammainc(value vA, value vX) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double y = igam(a, x);
  return caml_copy_double(y);
}


value owl_stub_sf_gammaincinv(value vA, value vX) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double y = igami(a, 1. - x);
  return caml_copy_double(y);
}


value owl_stub_sf_gammaincc(value vA, value vX) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double y = igamc(a, x);
  return caml_copy_double(y);
}


value owl_stub_sf_gammainccinv(value vA, value vX) {
  double a = Double_val(vA);
  double x = Double_val(vX);
  double y = igami(a, x);
  return caml_copy_double(y);
}


value owl_stub_sf_beta(value vA, value vB) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = beta(a, b);
  return caml_copy_double(y);
}


value owl_stub_sf_betainc(value vA, value vB, value vX) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double y = incbet(a, b, x);
  return caml_copy_double(y);
}


value owl_stub_sf_betaincinv(value vA, value vB, value vY) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double y = Double_val(vY);
  double x = incbi(a, b, y);
  return caml_copy_double(x);
}


value owl_stub_sf_psi(value vX) {
  double x = Double_val(vX);
  double y = psi(x);
  return caml_copy_double(y);
}
