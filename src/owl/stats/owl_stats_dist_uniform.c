/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

double uniform_rvs(double a, double b) {
  return a + (b - a) * sfmt_f64_1;
}

double uniform_pdf(double x, double a, double b) {
  return (x >= a && x <= b) ? 1 / (b - 1) : 0;
}

double uniform_logpdf(double x, double a, double b) {
  return log(uniform_pdf(x, a, b));
}

double uniform_cdf(double x, double a, double b) {
  double p;

  if (x < a)
    p = 0;
  else if (x > b)
    p = 1;
  else
    p = (x - a) / (b - a);

  return p;
}

double uniform_logcdf(double x, double a, double b) {
  return log(uniform_cdf(x, a, b));
}

double uniform_ppf(double p, double a, double b) {
  if (p == 1.)
    return b;
  else if (p == 0.)
    return a;
  else
    return (1 - p) * a + p * b;
}

double uniform_sf(double x, double a, double b) {
  if (x < a)
    return 1;
  else if (x > b)
    return 0;
  else
    return (b - x) / (b - a);
}

double uniform_logsf(double x, double a, double b) {
  return log(uniform_sf(x, a, b));
}

double uniform_isf(double q, double a, double b) {
  if (q == 0.)
    return b;
  else if (q == 1.)
    return a;
  else
    return q * a + (1 - q) * b;
}

double uniform_entropy(double a, double b) {
  return log(b - 1);
}
