/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Dirichlet distribution **/

static void ran_dirichlet_small (const int K, const double alpha[], double theta[]) {
  double norm = 0., umax = 0.;

  for (int i = 0; i < K; i++) {
    double u = log(sfmt_f64_3) / alpha[i];
    theta[i] = u;

    if (u > umax || i == 0)
      umax = u;
    }

  for (int i = 0; i < K; i++)
    theta[i] = exp(theta[i] - umax);

  for (int i = 0; i < K; i++)
    theta[i] = theta[i] * gamma_rvs (alpha[i] + 1.0, 1.0);

  for (int i = 0; i < K; i++)
    norm += theta[i];

  for (int i = 0; i < K; i++)
    theta[i] /= norm;

}


void dirichlet_rvs (const int K, const double alpha[], double theta[]) {
  double norm = 0.;

  for (int i = 0; i < K; i++)
    theta[i] = gamma_rvs (alpha[i], 1.);

  for (int i = 0; i < K; i++)
      norm += theta[i];

  if (norm < OWL_SQRT_DOUBLE_MIN) {
    ran_dirichlet_small (K, alpha, theta);
    return;
  }

  for (int i = 0; i < K; i++)
    theta[i] /= norm;

}


double dirichlet_pdf (const int K, const double alpha[], const double theta[]) {
  return exp (dirichlet_logpdf (K, alpha, theta));
}


double dirichlet_logpdf (const int K, const double alpha[], const double theta[]) {
  double log_p = 0.;
  double sum_alpha = 0.;

  for (int i = 0; i < K; i++)
    log_p += (alpha[i] - 1.0) * log (theta[i]);

  for (int i = 0; i < K; i++)
    sum_alpha += alpha[i];

  log_p += lgam (sum_alpha);

  for (int i = 0; i < K; i++)
    log_p -= lgam (alpha[i]);

  return log_p;
}
