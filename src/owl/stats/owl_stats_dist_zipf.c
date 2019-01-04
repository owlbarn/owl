/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Zipf distribution **/

long zipf_rvs(double a) {
  double am1 = a - 1.;
  double b = pow(2., am1);

  while (1) {
    double U = 1. - sfmt_f64_3;
    double V = sfmt_f64_3;
    double X = floor(pow(U, -1. / am1));

    if (X > LONG_MAX || X < 1.0)
      continue;

    double T = pow(1. + 1. / X, am1);
    if (V * X * (T - 1.) / (b - 1.) <= T / b)
        return (long) X;
  }
}
