/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Exponential distribution **/

double exp_pdf(double x, double lambda) {
  return lambda * exp(-lambda * x);
}

double exp_logpdf(double x, double lambda) {
  return log(lambda) - lambda * x;
}

double exp_cdf(double x, double lambda) {
  return -expm1(-lambda * x);
}

double exp_logcdf(double x, double lambda) {
  return log(-expm1(-lambda * x));
}

double exp_ppf(double q, double lambda) {
  return -log1p(-q) / lambda;
}

double exp_sf(double x, double lambda) {
  return exp(-lambda * x);
}

double exp_logsf(double x, double lambda) {
  return -lambda * x;
}

double exp_isf(double q, double lambda) {
  return -log(q) / lambda;
}

double exp_entropy(double lambda) {
  return 1 - log(lambda);
}
