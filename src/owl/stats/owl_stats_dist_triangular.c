/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Triangular distribution **/

double triangular_rvs(double left, double mode, double right) {
  double base = right - left;
  double leftbase = mode - left;
  double ratio = leftbase / base;
  double leftprod = leftbase*base;
  double rightprod = (right - mode) * base;
  double U = sfmt_f64_3;

  if (U <= ratio)
    return left + sqrt(U * leftprod);
  else
    return right - sqrt((1. - U) * rightprod);
}
