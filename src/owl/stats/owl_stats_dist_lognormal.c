/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Log-normal distribution **/

double lognormal_rvs(double mu, double sigma) {
  return exp(gaussian_rvs(mu, sigma));
}
