/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "ctypes_cstubs_internals.h"
#include <stdio.h>


value owl_stub_sf_j0(value vX) {
  double x = Double_val(vX);
  double y = j0(x);
  return caml_copy_double(y);
}


value owl_stub_sf_j1(value vX) {
  double x = Double_val(vX);
  double y = j1(x);
  return caml_copy_double(y);
}


value owl_stub_sf_jv(value vV, value vX) {
  double v = Double_val(vV);
  double x = Double_val(vX);
  double y = jv(v, x);
  return caml_copy_double(y);
}


value owl_stub_sf_y0(value vX) {
  double x = Double_val(vX);
  double y = y0(x);
  return caml_copy_double(y);
}


value owl_stub_sf_y1(value vX) {
  double x = Double_val(vX);
  double y = y1(x);
  return caml_copy_double(y);
}


value owl_stub_sf_yv(value vV, value vX) {
  double v = Double_val(vV);
  double x = Double_val(vX);
  double y = yv(v, x);
  return caml_copy_double(y);
}


value owl_stub_sf_yn(value vN, value vX) {
  double n = Int_val(vN);
  double x = Double_val(vX);
  double y = yn(n, x);
  return caml_copy_double(y);
}


value owl_stub_sf_i0(value vX) {
  double x = Double_val(vX);
  double y = i0(x);
  return caml_copy_double(y);
}


value owl_stub_sf_i0e(value vX) {
  double x = Double_val(vX);
  double y = i0e(x);
  return caml_copy_double(y);
}


value owl_stub_sf_i1(value vX) {
  double x = Double_val(vX);
  double y = i1(x);
  return caml_copy_double(y);
}


value owl_stub_sf_i1e(value vX) {
  double x = Double_val(vX);
  double y = i1e(x);
  return caml_copy_double(y);
}


value owl_stub_sf_k0(value vX) {
  double x = Double_val(vX);
  double y = k0(x);
  return caml_copy_double(y);
}


value owl_stub_sf_k0e(value vX) {
  double x = Double_val(vX);
  double y = k0e(x);
  return caml_copy_double(y);
}


value owl_stub_sf_k1(value vX) {
  double x = Double_val(vX);
  double y = k1(x);
  return caml_copy_double(y);
}


value owl_stub_sf_k1e(value vX) {
  double x = Double_val(vX);
  double y = k1e(x);
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


value owl_stub_sf_rgamma(value vX) {
  double x = Double_val(vX);
  double y = rgamma(x);
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
