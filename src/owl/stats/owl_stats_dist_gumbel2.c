/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Gumbel Type-2 distribution **/
/** p(x) dx = b a x^-(a+1) exp(-b x^-a)) dx **/

double gumbel2_rvs(double a, double b) {
  double x = sfmt_f64_3;
  return pow(-b / log(x), 1 / a);
}

double gumbel2_pdf(double x, double a, double b) {
  return exp(gumbel2_logpdf(x, a, b));
}

double gumbel2_logpdf(double x, double a, double b) {
  if (x <= 0)
    return OWL_NEGINF;
  else
    return log(b) + log(a) - xlogy(a + 1, x) - b * pow(x, -a);
}

double gumbel2_cdf(double x, double a, double b) {
  return exp(gumbel2_logcdf(x, a, b));
}

double gumbel2_logcdf(double x, double a, double b) {
  return (x == 0) ? OWL_NEGINF : -b / pow(x, a);
}

double gumbel2_ppf(double p, double a, double b) {
  if (p == 1.)
    return OWL_POSINF;
  else if (p == 0.)
    return 0.;
  else
    return pow(b / (-log(p)), 1 / a);
}

double gumbel2_sf(double x, double a, double b) {
  return (x == 0) ? 1 : -expm1(-b / pow(x, a));
}

double gumbel2_logsf(double x, double a, double b) {
  return log(gumbel2_sf(x, a, b));
}

double gumbel2_isf(double q, double a, double b) {
  if (q == 0.)
    return OWL_POSINF;
  else if (q == 1.)
    return 0.0;
  else
    return pow(b / (-log1p(-q)), 1 / a);
}
