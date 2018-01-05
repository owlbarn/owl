/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Noncentral F distribution **/

double noncentral_f_rvs(double dfnum, double dfden, double nonc) {
  double t = noncentral_chisquare_rvs(dfnum, nonc) * dfden;
  return t / (chisquare_rvs(dfden) * dfnum);
}
