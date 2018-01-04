/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"


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
