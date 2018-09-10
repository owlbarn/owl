/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Wald distribution **/

double wald_rvs(double mu, double lambda) {
  double mu_2l = mu / (2 * lambda);
  double Y = std_gaussian_rvs();
  Y = mu * Y * Y;
  double X = mu + mu_2l * (Y - sqrt(4 * lambda * Y + Y * Y));
  double U = sfmt_f64_3;
  if (U <= mu / (mu + X))
    return X;
  else
    return (mu * mu / X);
}

double wald_pdf(double x, double mu, double lambda) {
  return exp(wald_logpdf(x, mu, lambda));
}

double wald_logpdf(double x, double mu, double lambda) {
  double y = (x - mu) / mu;
  return 0.5 * (lambda - OWL_LOGE2 - OWL_LOGEPI - 3 * log(x)) - lambda * y * y / (2 * x);
}

double wald_cdf(double x, double mu, double lambda) {
  double fac = sqrt(lambda / x);
  double c1 = ndtr(fac * (x - mu) / mu);
  c1 += exp(2 * lambda / mu) * ndtr(-fac * (x + mu) / mu);
  return c1;
}

double wald_logcdf(double x, double mu, double lambda) {
  return log(wald_cdf(x, mu, lambda));
}

double wald_ppf(double p, double mu, double lambda) {
  // TODO
  return 0.;
}

double wald_sf(double x, double mu, double lambda) {
  return 1 - wald_cdf(x, mu, lambda);
}

double wald_logsf(double x, double mu, double lambda) {
  return log1p(-wald_cdf(x, mu, lambda));
}

double wald_isf(double q, double mu, double lambda) {
  // TODO
  return 0.;
}

double wald_entroy(double mu, double lambda) {
  // TODO
  return 0.;
}
