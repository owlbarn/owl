/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Laplace distribution **/

double laplace_rvs(double loc, double scale) {
  double U = sfmt_f64_3;

  if (U < 0.5)
    U = loc + scale * log(U + U);
  else
    U = loc - scale * log(2. - U - U);
  return U;
}

double laplace_pdf(double x, double loc, double scale) {
  double y = fabs(x - loc) / scale;
  return exp(-y) / (2 * scale);
}

double laplace_logpdf(double x, double loc, double scale) {
  double y = fabs(x - loc) / scale;
  return -y - OWL_LOGE2 - log(scale);
}

double laplace_cdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return (y < 0) ? (exp(y) / 2) : (1 - exp(-y) / 2);
}

double laplace_logcdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return (y < 0) ? (y - OWL_LOGE2) : log(1 - exp(-y) / 2);
}

double laplace_ppf(double q, double loc, double scale) {
  return (q > 0.5) ? (loc - scale * log(2 * (1 - q))) : (loc + scale * log(2 * q));
}

double laplace_sf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return (y < 0) ? (1 - exp(y) / 2) : (exp(-y) / 2);
}

double laplace_logsf(double x, double loc, double scale) {
  return log(laplace_sf(x, loc, scale));
}

double laplace_isf(double q, double loc, double scale) {
  return laplace_ppf(1 - q, loc, scale);
}

double laplace_entropy(double scale) {
  return 1 + log(2 * scale);
}
