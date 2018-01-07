/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Power distribution **/

double power_rvs(double a) {
  return pow(1. - exp(-std_exponential_rvs()), 1. / a);
}
