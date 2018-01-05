/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Rayleigh distribution **/

double rayleigh_rvs(double mode) {
  return mode * sqrt(-2. * log(1. - sfmt_f64_3));
}
