/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Negative Binomial distribution **/

long negative_binomial_rvs(double n, double p) {
  double Y = gamma_rvs(n, (1 - p) / p);
  return poisson_rvs(Y);
}
