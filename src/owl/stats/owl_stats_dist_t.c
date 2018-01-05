/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Student's t distribution **/

double std_t_rvs(double df) {
  double N = std_gaussian_rvs();
  double G = std_gamma_rvs(df / 2);
  return (sqrt(df / 2) * N / sqrt(G));
}
