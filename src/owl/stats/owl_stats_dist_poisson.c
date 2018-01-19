/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Poisson distribution **/

// FIXME: replace with lgam in cephes?
double loggam(double x) {
  static double a[10] = {
    8.333333333333333e-02,-2.777777777777778e-03,
    7.936507936507937e-04,-5.952380952380952e-04,
    8.417508417508418e-04,-1.917526917526918e-03,
    6.410256410256410e-03,-2.955065359477124e-02,
    1.796443723688307e-01,-1.39243221690590e+00 };
  double x0 = x;
  long n = 0;
  if ((x == 1.) || (x == 2.))
    return 0.;
  else if (x <= 7.) {
    n = (long) (7 - x);
    x0 = x + n;
  }
  double x2 = 1. / (x0 * x0);
  double xp = 2 * M_PI;
  double gl0 = a[9];
  for (long k = 8; k >= 0; k--) {
    gl0 *= x2;
    gl0 += a[k];
  }
  double gl = gl0 / x0 + 0.5 * log(xp) + (x0 - 0.5) * log(x0) - x0;
  if (x <= 7.0) {
    for (long k = 1; k <= n; k++) {
      gl -= log(x0 - 1.0);
      x0 -= 1.0;
    }
  }
  return gl;
}

long poisson_mult_rvs(double lam) {
  long X = 0;
  double enlam = exp(-lam);
  double prod = 1.;
  while (1) {
    prod *= sfmt_f64_3;
    if (prod > enlam)
      X += 1;
    else
      return X;
  }
}

long poisson_ptrs_rvs(double lam) {
  long k;
  double U, V, slam, loglam, a, b, invalpha, vr, us;

  slam = sqrt(lam);
  loglam = log(lam);
  b = 0.931 + 2.53 * slam;
  a = -0.059 + 0.02483 * b;
  invalpha = 1.1239 + 1.1328 / (b - 3.4);
  vr = 0.9277 - 3.6224 / (b - 2);

  while (1) {
    U = sfmt_f64_3 - 0.5;
    V = sfmt_f64_3;
    us = 0.5 - fabs(U);
    k = (long) floor((2 * a / us + b) * U + lam + 0.43);
    if ((us >= 0.07) && (V <= vr))
      return k;
    if ((k < 0) || ((us < 0.013) && (V > us)))
      continue;
    if ((log(V) + log(invalpha) - log(a / (us * us) + b)) <=
        (-lam + k * loglam - loggam(k + 1)))
      return k;
  }
}


long poisson_rvs(double lambda)
{
  if (lambda == 0)
    return 0;
  else if (lambda >= 10)
    return poisson_ptrs_rvs(lambda);
  else
    return poisson_mult_rvs(lambda);
}
