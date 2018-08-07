/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Exponential distribution **/

double exponential_pdf(double x, double lambda) {
  return lambda * exp(-lambda * x);
}

double exponential_logpdf(double x, double lambda) {
  return log(lambda) - lambda * x;
}

double exponential_cdf(double x, double lambda) {
  return -expm1(-lambda * x);
}

double exponential_logcdf(double x, double lambda) {
  return log(-expm1(-lambda * x));
}

double exponential_ppf(double q, double lambda) {
  return -log1p(-q) / lambda;
}

double exponential_sf(double x, double lambda) {
  return exp(-lambda * x);
}

double exponential_logsf(double x, double lambda) {
  return -lambda * x;
}

double exponential_isf(double q, double lambda) {
  return -log(q) / lambda;
}

double exponential_entropy(double lambda) {
  return 1 - log(lambda);
}
