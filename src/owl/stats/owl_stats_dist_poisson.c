/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2020 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Poisson distribution **/

long poisson_mult_rvs(double lam)
{
  long X = 0;
  double enlam = exp(-lam);
  double prod = 1.;
  while (1)
  {
    prod *= sfmt_f64_3;
    if (prod > enlam)
      X += 1;
    else
      return X;
  }
}

long poisson_ptrs_rvs(double lam)
{
  long k;
  double U, V, slam, loglam, a, b, invalpha, vr, us;

  slam = sqrt(lam);
  loglam = log(lam);
  b = 0.931 + 2.53 * slam;
  a = -0.059 + 0.02483 * b;
  invalpha = 1.1239 + 1.1328 / (b - 3.4);
  vr = 0.9277 - 3.6224 / (b - 2);

  while (1)
  {
    U = sfmt_f64_3 - 0.5;
    V = sfmt_f64_3;
    us = 0.5 - fabs(U);
    k = (long)floor((2 * a / us + b) * U + lam + 0.43);
    if ((us >= 0.07) && (V <= vr))
      return k;
    if ((k < 0) || ((us < 0.013) && (V > us)))
      continue;
    if ((log(V) + log(invalpha) - log(a / (us * us) + b)) <=
        (-lam + k * loglam - lgam(k + 1)))
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
