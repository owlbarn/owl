/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Exponential power distribution **/

double exponpow_rvs (const double a, const double b) {
  if (b < 1 || b > 4) {
    double u = sfmt_f64_2;
    double v = gamma_rvs (1 / b, 1.0);
    double z = a * pow (v, 1 / b);

    return (u > 0.5) ? z : (-z);
  }
  else if (b == 1) {
    return laplace_rvs (0, a);
  }
  else if (b < 2) {
    double x, h, u;
    double B = pow (1 / b, 1 / b);

    do {
      x = laplace_rvs (0, B);
      u = sfmt_f64_3;
      h = -pow (fabs (x), b) + fabs (x) / B - 1 + (1 / b);
    }
    while (log (u) > h);

    return a * x;
  }
  else if (b == 2) {
      return std_gaussian_rvs (a / sqrt (2.0));
  }
  else {
    double x, h, u;
    double B = pow (1 / b, 1 / b);

    do {
      x = std_gaussian_rvs (B);
      u = sfmt_f64_3;
      h = -pow (fabs (x), b) + (x * x) / (2 * B * B) + (1 / b) - 0.5;
    }
    while (log (u) > h);

    return a * x;
  }
}


double exponpow_pdf (const double x, const double a, const double b) {
  return exp (exponpow_logpdf (x, a, b));
}


double exponpow_logpdf (const double x, const double a, const double b) {
  double l = lgam (1 + 1 / b);
  double p = -log (2 * a) - pow (fabs (x / a), b) - l;
  return p;
}


double exponpow_cdf (const double x, const double a, const double b) {
  double u = x / a;
  double p;

  if (u < 0)
    p = 0.5 * igamc (1. / b, pow (-u, b));
  else
    p = 0.5 * (1. + igam (1. / b, pow (u, b)));

  return p;
}


double exponpow_logcdf (const double x, const double a, const double b) {
  return log (exponpow_cdf (x, a, b));
}


double exponpow_sf (const double x, const double a, const double b) {
  double u = x / a;
  double q;

  if (u < 0)
    q = 0.5 * (1.0 + igam (1. / b, pow (-u, b)));
  else
    q = 0.5 * igamc (1. / b, pow (u, b));

  return q;
}


double exponpow_logsf (const double x, const double a, const double b) {
  return log (exponpow_sf (x, a, b));
}
