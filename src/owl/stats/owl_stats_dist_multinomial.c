/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Multinomial distribution **/

void multinomial_rvs (const long K, const long N, const double p[], int32_t n[]) {
  double norm = 0.;
  double acc_p = 0.;
  long acc_n = 0;

  for (long k = 0; k < K; k++)
    norm += p[k];

  for (long k = 0; k < K; k++) {
    if (p[k] > 0.)
      n[k] = binomial_rvs (p[k] / (norm - acc_p), N - acc_n);
    else
      n[k] = 0;

    acc_p += p[k];
    acc_n += n[k];
  }

}


double multinomial_pdf (const long K, const double p[], const int32_t n[]) {
  return exp (multinomial_logpdf (K, p, n));
}


double multinomial_logpdf (const long K, const double p[], const int32_t n[]) {
  long N = 0;
  double log_pdf = 0.;
  double norm = 0.;

  for (long k = 0; k < K; k++)
    N += n[k];

  for (long k = 0; k < K; k++)
    norm += p[k];

  log_pdf = sf_log_fact (N);

  for (long k = 0; k < K; k++) {
    if (n[k] > 0)
      log_pdf += log (p[k] / norm) * n[k] - sf_log_fact (n[k]);
  }

  return log_pdf;
}
