/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Pareto distribution **/

double pareto_rvs(double a) {
  return exp(std_exp_rvs() / a) - 1.;
}
