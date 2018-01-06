/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** F distribution **/

double f_rvs(double dfnum, double dfden) {
  return ((chi2_rvs(dfnum) * dfden) / (chi2_rvs(dfden) * dfnum));
}
