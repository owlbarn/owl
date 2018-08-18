/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Cauchy distribution **/

double std_cauchy_rvs() {
  return std_gaussian_rvs() / std_gaussian_rvs();
}

double cauchy_rvs(double loc, double scale) {
  return loc + scale * std_cauchy_rvs();
}

double cauchy_pdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  double p = 1 / (OWL_PI * scale * (1 + y * y));
  return p;
}

double cauchy_logpdf(double x, double loc, double scale) {
  return log(cauchy_pdf(x, loc, scale));
}

double cauchy_cdf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return 0.5 + atan(y) / OWL_PI;
}

double cauchy_logcdf(double x, double loc, double scale) {
  return log(cauchy_cdf(x, loc, scale));
}

double cauchy_ppf(double q, double loc, double scale) {
  return loc + scale * tan(OWL_PI * (q - 0.5));
}

double cauchy_sf(double x, double loc, double scale) {
  double y = (x - loc) / scale;
  return 0.5 - atan(y) / OWL_PI;
}

double cauchy_logsf(double x, double loc, double scale) {
  return log(cauchy_sf(x, loc, scale));
}

double cauchy_isf(double q, double loc, double scale) {
  return loc + scale * tan(OWL_PI * (0.5 - q));
}

double cauchy_entropy(double scale) {
  return log(OWL_4PI * scale);
}
