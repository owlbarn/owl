/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

// TODO: add mu ...

/** Rayleigh distribution **/

double rayleigh_rvs(double sigma) {
  return sigma * sqrt(-2. * log(1. - sfmt_f64_3));
}

double rayleigh_pdf(double x, double sigma) {
  return exp(rayleigh_logpdf(x, sigma));
}

double rayleigh_logpdf(double x, double sigma) {
  if (x < 0)
    return OWL_NEGINF;
  else {
    double y = x / sigma;
    return log(y) - log(sigma) - y * y / 2;
  }
}

double rayleigh_cdf(double x, double sigma) {
  double y = x / sigma;
  return -expm1 (-y * y / 2);
}

double rayleigh_logcdf(double x, double sigma) {
  double y = x / sigma;
  return log1mexp(-y * y / 2);
}

double rayleigh_ppf(double q, double sigma) {
  return sigma * OWL_SQRT2 * sqrt(-log1p(-q));
}

double rayleigh_sf(double x, double sigma) {
  double y = x / sigma;
  return exp(- y * y / 2);
}

double rayleigh_logsf(double x, double sigma) {
  double y = x / sigma;
  return -y * y / 2;
}

double rayleigh_isf(double q, double sigma) {
  return sigma * OWL_SQRT2 * sqrt(-log(q));
}

double rayleigh_entropy(double sigma) {
  return 0.5 * (OWL_EULER - OWL_LOGE2) + log(sigma) + 1;
}
