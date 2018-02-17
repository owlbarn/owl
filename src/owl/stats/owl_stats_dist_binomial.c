/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"


/** Binomial distribution **/

int64_t binomial_rvs (double p, int64_t n) {
  int64_t a, b, k = 0;

  while (n > 10) {
    a = 1 + (n / 2);
    b = 1 + n - a;

    double x = beta_rvs ((double) a, (double) b);

    if (x >= p) {
      n = a - 1;
      p /= x;
    }
    else {
      k += a;
      n = b - 1;
      p = (p - x) / (1 - x);
    }
  }

  for (int64_t i = 0; i < n; i++)
    if (sfmt_f64_2 < p) k++;

  return k;
}


double binomial_pdf (int64_t k, double p, int64_t n) {
  if (k > n)
    return 0;
  else {
    if (p == 0)
      return (k == 0) ? 1 : 0;
    else if (p == 1)
      return (k == n) ? 1 : 0;
    else {
      double ln_cnk = sf_log_combination (n, k);
      double pp = ln_cnk + k * log (p) + (n - k) * log1p (-p);
      return exp (pp);
    }
  }
}


double binomial_logpdf (int64_t k, double p, int64_t n) {
  return log (binomial_pdf (k, p, n));
}


double binomial_cdf (int k, double p, int n) {
  if (k >= n)
    return 1.;
  else {
    double a = (double) k + 1.;
    double b = (double) n - k;
    return beta_sf(p, a, b);
  }
}


double binomial_logcdf (int k, double p, int n) {
  return log (binomial_cdf (k, p, n));
}


double binomial_sf (int k, double p, int n) {
  if (k >= n)
    return 0.;
  else {
    double a = (double) k + 1.;
    double b = (double) n - k;
    return beta_cdf (p, a, b);
  }
}


double binomial_logsf (int k, double p, int n) {
  return log (binomial_sf (k, p, n));
}
