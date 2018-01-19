/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Negative Binomial distribution **/

long negative_binomial_rvs(double n, double p) {
  double Y = gamma_rvs(n, (1 - p) / p);
  return poisson_rvs(Y);
}
