/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"


/** Binomial distribution **/

long binomial_rvs (double p, long n) {
  long a, b, k = 0;

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

  for (long i = 0; i < n; i++)
    if (sfmt_f64_2 < p) k++;

  return k;
}


double binomial_pdf (long k, double p, long n) {
  return exp (binomial_logpdf (k, p, n));
}


double binomial_logpdf (long k, double p, long n) {
  if (k > n)
    return OWL_NEGINF;
  else {
    if (p == 0)
      return (k == 0) ? 0. : OWL_NEGINF;
    else if (p == 1)
      return (k == n) ? 0. : OWL_NEGINF;
    else {
      double ln_cnk = sf_log_combination (n, k);
      return ln_cnk + k * log (p) + (n - k) * log1p (-p);
    }
  }
}


double binomial_cdf (long k, double p, long n) {
  if (k >= n)
    return 1.;
  else {
    double a = (double) k + 1.;
    double b = (double) n - k;
    return beta_sf(p, a, b);
  }
}


double binomial_logcdf (long k, double p, long n) {
  if (k >= n)
    return 0.;
  else {
    double a = (double) k + 1.;
    double b = (double) n - k;
    return beta_logsf(p, a, b);
  }
}


double binomial_sf (long k, double p, long n) {
  if (k >= n)
    return 0.;
  else {
    double a = (double) k + 1.;
    double b = (double) n - k;
    return beta_cdf (p, a, b);
  }
}


double binomial_logsf (long k, double p, long n) {
  return log (binomial_sf (k, p, n));
}
