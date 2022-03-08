/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Noncentral F distribution **/

double noncentral_f_rvs(double dfnum, double dfden, double nonc) {
  double t = noncentral_chi2_rvs(dfnum, nonc) * dfden;
  return t / (chi2_rvs(dfden) * dfnum);
}
