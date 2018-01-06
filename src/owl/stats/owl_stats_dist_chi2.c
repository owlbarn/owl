/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Chi-squared distribution **/

double chi2_rvs(double df) {
  return 2. * std_gamma_rvs(df / 2.);
}
