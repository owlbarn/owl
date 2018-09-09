/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
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
  return log(x / (1 - x));
}


double log1mexp(double x) {
  if (-x > OWL_LOGE2)
    return log1p(-exp(x));
  else
    return log(-expm1(x));
}


double log1pexp(double x) {
  if (x <= -37.)
    return exp(x);
  else if (x <= 18.)
    return log1p(exp(x));
  else if (x <= 33.3)
    return x + exp(-x);
  else
    return x;
}


double logabs(double x) {
  return log(fabs (x));
}


double sinc(double x) {
  return (x == 0) ? 1 : (sin(x) / x);
}


double erfinv(double x) {
  return ndtri((x + 1) / 2) / sqrt(2);
}


double erfcinv(double x) {
  return -ndtri(0.5 * x) / sqrt(2);
}
