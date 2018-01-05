/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Logistic distribution **/

double logistic_rvs(double loc, double scale) {
  double U = sfmt_f64_3;
  return loc + scale * log(U/(1. - U));
}
