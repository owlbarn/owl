/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Gumbel Type-1 distribution **/
/** p(x) dx = a b exp(-(b exp(-ax) + ax)) dx **/

double gumbel1_rvs(double a, double b) {
  double x = sfmt_f64_3;
  return (log(b) - log(-log(x))) / a;
}

double gumbel1_pdf(double x, double a, double b) {
  return exp(gumbel1_logpdf(x, a, b));
}

double gumbel1_logpdf(double x, double a, double b) {
  return log(a) + log(b) - (b * exp(-a * x) + a * x);
}

double gumbel1_cdf(double x, double a, double b) {
  double y = a * x - log (b);
  return exp (-exp (-y));
}

double gumbel1_logcdf(double x, double a, double b) {
  double y = a * x - log (b);
  return -exp (-y);
}

double gumbel1_ppf(double p, double a, double b) {
  if (p == 1.)
    return OWL_POSINF;
  else if (p == 0.)
    return OWL_NEGINF;
  else
    return log(-b / log(p)) / a;
}

double gumbel1_sf(double x, double a, double b) {
  double y = a * x - log (b);
  double p = exp(-exp(-y));
  return (p < 0.5) ? (1 - p) : -expm1 (-exp(-y));
}

double gumbel1_logsf(double x, double a, double b) {
  return log(gumbel1_sf(x, a, b));
}

double gumbel1_isf(double q, double a, double b) {
  if (q == 0.)
    return OWL_POSINF;
  else if (q == 1.)
    return OWL_NEGINF;
  else
    return log(-b / log1p(-q)) / a;
}
