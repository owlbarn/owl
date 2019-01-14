/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Negative Binomial distribution **/

long negative_binomial_rvs(double n, double p) {
  double Y = gamma_rvs(n, (1 - p) / p);
  return poisson_rvs(Y);
}
