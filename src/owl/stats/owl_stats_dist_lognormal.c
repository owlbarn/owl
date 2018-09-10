/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Log-normal distribution **/

double lognormal_rvs(double mu, double sigma) {
  return exp(gaussian_rvs(mu, sigma));
}

double lognormal_pdf(double x, double mu, double sigma) {
  return exp(lognormal_logpdf(x, mu, sigma));
}

double lognormal_logpdf(double x, double mu, double sigma) {
  if (x <= 0)
    return OWL_NEGINF;
  else {
    double y = (log(x) - mu) / sigma;
    return -log(x) - logabs(sigma) - 0.5 * log(OWL_2PI) - y * y / 2;
  }
}

double lognormal_cdf(double x, double mu, double sigma) {
  double y = (log(x) - mu) / sigma;
  return ndtr(y);
}

double lognormal_logcdf(double x, double mu, double sigma) {
  double y = (log(x) - mu) / sigma;
  return log_ndtr(y);
}

double lognormal_ppf(double q, double mu, double sigma) {
  return exp(mu + sigma * ndtri(q));
}

double lognormal_sf(double x, double mu, double sigma) {
  double y = (log(x) - mu) / sigma;
  return 1 - ndtr(y);
}

double lognormal_logsf(double x, double mu, double sigma) {
  double y = (log(x) - mu) / sigma;
  return log1p(-ndtr(y));
}

double lognormal_isf(double q, double mu, double sigma) {
  return exp(mu + sigma * ndtri(1 - q));
}

double lognormal_entropy(double mu, double sigma) {
  return mu + log(sigma) + 0.5 * (1 + OWL_LOGE2 + OWL_LOGEPI);
}
