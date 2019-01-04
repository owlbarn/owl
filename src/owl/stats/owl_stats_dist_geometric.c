/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Geometric distribution **/

long geometric_search_rvs(double p) {
  long X = 1;
  double sum = p;
  double prod = p;
  double q = 1. - p;
  double U = sfmt_f64_3;
  while (U > sum) {
    prod *= q;
    sum += prod;
    X++;
  }
  return X;
}


long geometric_inversion_rvs(double p) {
  return (long) ceil(log(1. - sfmt_f64_3) / log(1. - p));
}


long geometric_rvs(double p) {
  if (p >= 0.333333333333333333333333)
    return geometric_search_rvs(p);
  else
    return geometric_inversion_rvs(p);
}
