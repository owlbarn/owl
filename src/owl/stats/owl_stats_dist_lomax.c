/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Lomax distribution, i.e. Pareto Type II distribution **/

double lomax_rvs(double shape, double scale) {
  return scale * (exp(std_exp_rvs() / shape) - 1.);
}

double pareto_pdf(double x, double shape, double scale) {
  return (x < scale) ? 0 : ( (shape / scale) / pow(x / scale, shape + 1) );
}

double pareto_logpdf(double x, double shape, double scale) {
  return log(pareto_pdf(x, shape, scale));
}

double pareto_cdf(double x, double shape, double scale) {
  return (x < scale) ? 0 : (1 - pow(scale / x, shape));
}

double pareto_logcdf(double x, double shape, double scale) {
  return log(pareto_cdf(x, shape, scale));
}

double pareto_ppf(double p, double shape, double scale) {
  if (p == 1.)
    return OWL_POSINF;
  else if (p == 0.)
    return scale;
  else
    return scale * exp(-log1p(-p) / shape);
}

double pareto_sf(double x, double shape, double scale) {
  return (x < scale) ? 1 : pow(scale / x, shape);;
}

double pareto_logsf(double x, double shape, double scale) {
  return log(pareto_sf(x, shape, scale));
}

double pareto_isf(double q, double shape, double scale) {
  if (q == 0.)
    return OWL_POSINF;
  else if (q == 1.)
    return scale;
  else
    return scale * exp(-log(q) / shape);
}

double pareto_entropy(double shape, double scale) {
  return (shape + 1) / shape - log(shape / scale);
}
