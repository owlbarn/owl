/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Gumbel distribution **/

double gumbel_rvs(double loc, double scale) {
  double U = 1. - sfmt_f64_3;
  return loc - scale * log(-log(U));
}
