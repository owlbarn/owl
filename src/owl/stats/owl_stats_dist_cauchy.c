/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Cauchy distribution **/

double std_cauchy_rvs() {
  return std_gaussian_rvs() / std_gaussian_rvs();
}

double cauchy_rvs(double a) {
  return a * std_cauchy_rvs();
}

double cauchy_pdf(double x, double a) {
  double u = x / a;
  double p = (1 / (OWL_PI * a)) / (1 + u * u);
  return p;
}

double cauchy_logpdf(double x, double a) {
  return log(cauchy_pdf(x, a));
}

double cauchy_cdf(double x, double a) {
  double p;
  double u = x / a;

  if (u > -1)
    p = 0.5 + atan(u) / OWL_PI;
  else
    p = atan(-1 / u) / OWL_PI;

  return p;
}

double cauchy_logcdf(double x, double a) {
  return log(cauchy_cdf(x, a));
}

double cauchy_ppf(double p, double a) {
  return a * tan(OWL_PI * (p - 0.5));
}
