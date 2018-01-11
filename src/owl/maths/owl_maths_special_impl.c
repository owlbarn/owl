/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"

/*
 * Implementation of some spefial functions which are not included in cephes
 * and CDFLIB. The implementation is double precision.
 */


double xlogy(double x, double y) {
  if (x == 0 && !owl_isnan(y))
    return 0.;
  else
    return x * log(y);
}


double xlog1py(double x, double y) {
  if (x == 0 && !owl_isnan(y))
    return 0.;
  else
    return x * log1p(y);
}


double expit(double x) {
  return 1 / (1 + exp(-x));
}


double logit(double x) {
  return log(1 / (1 - x));
}
