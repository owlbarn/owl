/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Lomax distribution, i.e. Pareto Type II distribution **/

double lomax_rvs(double shape, double scale) {
  return scale * (expm1(std_exponential_rvs() / shape));
}

double lomax_pdf(double x, double shape, double scale) {
  return (x < scale) ? 0 : exp(lomax_logpdf(x, shape, scale));
}

double lomax_logpdf(double x, double shape, double scale) {
  return (x < scale) ? OWL_NEGINF : log(shape / scale) - xlogy(shape + 1, x / scale);
}

double lomax_cdf(double x, double shape, double scale) {
  return (x < scale) ? 0 : (1 - pow(scale / x, shape));
}

double lomax_logcdf(double x, double shape, double scale) {
  return (x < scale) ? OWL_NEGINF : log1p(-pow(scale / x, shape));
}

double lomax_ppf(double p, double shape, double scale) {
  if (p == 1.)
    return OWL_POSINF;
  else if (p == 0.)
    return scale;
  else
    return scale * exp(-log1p(-p) / shape);
}

double lomax_sf(double x, double shape, double scale) {
  return (x < scale) ? 1 : pow(scale / x, shape);;
}

double lomax_logsf(double x, double shape, double scale) {
  return (x < scale) ? 0 : xlogy(shape, scale / x);
}

double lomax_isf(double q, double shape, double scale) {
  if (q == 0.)
    return OWL_POSINF;
  else if (q == 1.)
    return scale;
  else
    return scale * exp(-log(q) / shape);
}

double lomax_entropy(double shape, double scale) {
  return (shape + 1) / shape - log(shape / scale);
}
