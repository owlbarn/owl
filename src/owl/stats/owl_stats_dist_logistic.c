/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Logistic distribution **/

double logistic_rvs(double loc, double scale) {
  double U = sfmt_f64_3;
  return loc + scale * log(U / (1. - U));
}

double logistic_logpdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return -y - 2 * log1p(exp(-y)) - log(scale);
}

double logistic_pdf(double x, double loc, double scale) {
  return exp(logistic_logpdf(x, loc, scale));
}

double logistic_cdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return expit(y);
}

double logistic_logcdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return log(expit(y));
}

double logistic_ppf(double q, double loc, double scale) {
  return loc + scale * logit(q);
}

double logistic_sf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return expit(-y);
}

double logistic_logsf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return log(expit(-y));
}

double logistic_isf(double q, double loc, double scale) {
  return loc - scale * logit(q);
}

double logistic_entropy(double scale) {
  return log(scale) + 2;
}
