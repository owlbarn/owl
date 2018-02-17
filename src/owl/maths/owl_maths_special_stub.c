/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "ctypes_cstubs_internals.h"
#include <stdio.h>


value stub_sf_airy(value vX, value Ai, value Aip, value Bi, value Bip) {
  double x = Double_val(vX);
  double* ai = CTYPES_ADDR_OF_FATPTR(Ai);
  double* aip = CTYPES_ADDR_OF_FATPTR(Aip);
  double* bi = CTYPES_ADDR_OF_FATPTR(Bi);
  double* bip = CTYPES_ADDR_OF_FATPTR(Bip);
  int r = airy(x, ai, aip, bi, bip);
  return Val_long(r);
}


value stub_sf_ellipj(value vU, value vM, value Sn, value Cn, value Dn, value Phi) {
  double u = Double_val(vU);
  double m = Double_val(vM);
  double* sn = CTYPES_ADDR_OF_FATPTR(Sn);
  double* cn = CTYPES_ADDR_OF_FATPTR(Cn);
  double* dn = CTYPES_ADDR_OF_FATPTR(Dn);
  double* phi = CTYPES_ADDR_OF_FATPTR(Phi);
  int r = ellpj(u, m, sn, cn, dn, phi);
  return Val_long(r);
}


value stub_sf_ellipj_byte6(value* argv, int argc) {
  value phi = argv[5];
  value dn = argv[4];
  value cn = argv[3];
  value sn = argv[2];
  value m = argv[1];
  value u = argv[0];
  return stub_sf_ellipj(u, m, sn, cn, dn, phi);
}


value owl_stub_sf_ellipk(value vM) {
  double m = Double_val(vM);
  double y = ellpk(1 - m);
  return caml_copy_double(y);
}


value owl_stub_sf_ellipkm1(value vM) {
  double m = Double_val(vM);
  double y = ellpk(m);
  return caml_copy_double(y);
}


value owl_stub_sf_ellipkinc(value vPhi, value vM) {
  double phi = Double_val(vPhi);
  double m = Double_val(vM);
  double y = ellik(phi, m);
  return caml_copy_double(y);
}


value owl_stub_sf_ellipe(value vM) {
  double m = Double_val(vM);
  double y = ellpe(m);
  return caml_copy_double(y);
}


value owl_stub_sf_ellipeinc(value vPhi, value vM) {
  double phi = Double_val(vPhi);
  double m = Double_val(vM);
  double y = ellie(phi, m);
  return caml_copy_double(y);
}


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
  double n = Long_val(vN);
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


value owl_stub_sf_iv(value vV, value vX) {
  double v = Double_val(vV);
  double x = Double_val(vX);
  double y = iv(v, x);
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


value owl_stub_sf_expn(value vN, value vX) {
  int n = Long_val(vN);
  double x = Double_val(vX);
  double y = expn(n, x);
  return caml_copy_double(y);
}


value owl_stub_sf_shichi(value vX, value vSi, value vCi) {
  double x = Double_val(vX);
  double* si = CTYPES_ADDR_OF_FATPTR(vSi);
  double* ci = CTYPES_ADDR_OF_FATPTR(vCi);
  int r = shichi(x, si, ci);
  return Val_long(r);
}


value owl_stub_sf_sici(value vX, value vSi, value vCi) {
  double x = Double_val(vX);
  double* si = CTYPES_ADDR_OF_FATPTR(vSi);
  double* ci = CTYPES_ADDR_OF_FATPTR(vCi);
  int r = sici(x, si, ci);
  return Val_long(r);
}


value owl_stub_sf_zeta(value vX, value vQ) {
  double x = Double_val(vX);
  double q = Double_val(vQ);
  double y = zeta(x, q);
  return caml_copy_double(y);
}


value owl_stub_sf_zetac(value vX) {
  double x = Double_val(vX);
  double y = zetac(x);
  return caml_copy_double(y);
}


value owl_stub_sf_erf(value vX) {
  double x = Double_val(vX);
  double y = erf(x);
  return caml_copy_double(y);
}


value owl_stub_sf_erfinv(value vX) {
  double x = Double_val(vX);
  double y = erfinv(x);
  return caml_copy_double(y);
}


value owl_stub_sf_erfc(value vX) {
  double x = Double_val(vX);
  double y = erfc(x);
  return caml_copy_double(y);
}


value owl_stub_sf_erfcinv(value vX) {
  double x = Double_val(vX);
  double y = erfcinv(x);
  return caml_copy_double(y);
}


value owl_stub_sf_erfcx(value vX) {
  double x = Double_val(vX);
  double y = exp(x * x) * erfc(x);
  return caml_copy_double(y);
}


value owl_stub_sf_dawsn(value vX) {
  double x = Double_val(vX);
  double y = dawsn(x);
  return caml_copy_double(y);
}


value owl_stub_sf_fresnel(value vX, value vSsa, value vCsa) {
  double x = Double_val(vX);
  double* ssa = CTYPES_ADDR_OF_FATPTR(vSsa);
  double* csa = CTYPES_ADDR_OF_FATPTR(vCsa);
  int r = fresnl(x, ssa, csa);
  return Val_long(r);
}


value owl_stub_sf_struve(value vV, value vX) {
  double v = Double_val(vV);
  double x = Double_val(vX);
  double y = struve(v, x);
  return caml_copy_double(y);
}


/* From owl_maths_special_impl.c file */

value owl_stub_sf_xlogy(value vX, value vY) {
  double x = Double_val(vX);
  double y = Double_val(vY);
  double z = xlogy(x, y);
  return caml_copy_double(z);
}


value owl_stub_sf_xlog1py(value vX, value vY) {
  double x = Double_val(vX);
  double y = Double_val(vY);
  double z = xlog1py(x, y);
  return caml_copy_double(z);
}


value owl_stub_sf_logit(value vX) {
  double x = Double_val(vX);
  double y = logit(x);
  return caml_copy_double(y);
}


value owl_stub_sf_expit(value vX) {
  double x = Double_val(vX);
  double y = expit(x);
  return caml_copy_double(y);
}


value owl_stub_sf_logabs(value vX) {
  double x = Double_val(vX);
  double y = logabs(x);
  return caml_copy_double(y);
}


value owl_stub_sf_asinh(value vX) {
  double x = Double_val(vX);
  double y = asinh(x);
  return caml_copy_double(y);
}


value owl_stub_sf_acosh(value vX) {
  double x = Double_val(vX);
  double y = acosh(x);
  return caml_copy_double(y);
}


value owl_stub_sf_atanh(value vX) {
  double x = Double_val(vX);
  double y = atanh(x);
  return caml_copy_double(y);
}


value owl_stub_sf_hypot(value vX, value vY) {
  double x = Double_val(vX);
  double y = Double_val(vY);
  double z = hypot(x, y);
  return caml_copy_double(z);
}


value owl_stub_sf_sinc(value vX) {
  double x = Double_val(vX);
  double y = sinc(x);
  return caml_copy_double(y);
}


value owl_stub_sf_sindg(value vX) {
  double x = Double_val(vX);
  double y = sindg(x);
  return caml_copy_double(y);
}


value owl_stub_sf_cosdg(value vX) {
  double x = Double_val(vX);
  double y = cosdg(x);
  return caml_copy_double(y);
}


value owl_stub_sf_tandg(value vX) {
  double x = Double_val(vX);
  double y = tandg(x);
  return caml_copy_double(y);
}


value owl_stub_sf_cotdg(value vX) {
  double x = Double_val(vX);
  double y = cotdg(x);
  return caml_copy_double(y);
}


value stub_sf_nextafter(value vX, value vY) {
  double from = Double_val(vX);
  double to = Double_val(vY);
  double next = nextafter(from, to);
  return caml_copy_double(next);
}


value stub_sf_nextafterf(value vX, value vY) {
  float from = Double_val(vX);
  float to = Double_val(vY);
  float next = nextafterf(from, to);
  return caml_copy_double(next);
}


value owl_stub_sf_bdtr(value vK, value vN, value vP) {
  long k = Long_val(vK);
  long n = Long_val(vN);
  double p = Double_val(vP);
  double y = bdtr(k, n, p);
  return caml_copy_double(y);
}


value owl_stub_sf_bdtrc(value vK, value vN, value vP) {
  long k = Long_val(vK);
  long n = Long_val(vN);
  double p = Double_val(vP);
  double y = bdtrc(k, n, p);
  return caml_copy_double(y);
}


value owl_stub_sf_bdtri(value vK, value vN, value vY) {
  long k = Long_val(vK);
  long n = Long_val(vN);
  double y = Double_val(vY);
  double p = bdtri(k, n, y);
  return caml_copy_double(p);
}


value owl_stub_sf_btdtr(value vA, value vB, value vX) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double x = Double_val(vX);
  double y = btdtr(a, b, x);
  return caml_copy_double(y);
}


value owl_stub_sf_btdtri(value vA, value vB, value vP) {
  double a = Double_val(vA);
  double b = Double_val(vB);
  double p = Double_val(vP);
  double x = incbi(a, b, p);
  return caml_copy_double(x);
}


value owl_stub_sf_fact(value vN) {
  long n = Long_val(vN);
  double y = sf_fact(n);
  return caml_copy_double(y);
}


value owl_stub_sf_log_fact(value vN) {
  long n = Long_val(vN);
  double y = sf_log_fact(n);
  return caml_copy_double(y);
}


value owl_stub_sf_doublefact(value vN) {
  long n = Long_val(vN);
  double y = sf_doublefact(n);
  return caml_copy_double(y);
}


value owl_stub_sf_log_doublefact(value vN) {
  long n = Long_val(vN);
  double y = sf_log_doublefact(n);
  return caml_copy_double(y);
}
