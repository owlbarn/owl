/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Weibull distribution **/

double weibull_rvs(double shape, double scale) {
  return scale * pow(-log(sfmt_f64_1), 1 / shape);
}

double weibull_pdf(double x, double shape, double scale) {
  return exp(weibull_logpdf(x, shape, scale));
}

double weibull_logpdf(double x, double shape, double scale) {
  if (x < 0)
    return OWL_NEGINF;
  else if (x == 0)
    return (shape == 1) ? -log(scale) : OWL_NEGINF;
  else if (shape == 1)
    return (-x / scale) - log(scale);
  else {
    x /= scale;
    return log(shape) - log(scale) - pow(x, shape) + xlogy(shape - 1, x);
  }
}

double weibull_cdf(double x, double shape, double scale) {
  return -expm1(-pow(x / scale, shape));
}

double weibull_logcdf(double x, double shape, double scale) {
  return log1mexp(-pow(x / scale, shape));
}

double weibull_ppf(double p, double shape, double scale) {
  if (p == 1.)
    return OWL_POSINF;
  else if (p == 0.)
    return 0.0;
  else
    return scale * pow(-log1p(-p), 1 / shape);
}

double weibull_sf(double x, double shape, double scale) {
  return exp(-pow(x / scale, shape));
}

double weibull_logsf(double x, double shape, double scale) {
  return -pow(x / scale, shape);
}

double weibull_isf(double q, double shape, double scale) {
  if (q == 0.)
    return OWL_POSINF;
  else if (q == 1.)
    return 0.;
  else
  return scale * pow(-log(q), 1 / shape);
}

double weibull_entropy(double shape, double scale) {
  return OWL_EULER * (shape - 1) / shape + log(scale / shape) + 1;
}
