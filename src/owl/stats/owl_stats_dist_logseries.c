/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Log-Series distribution **/

long logseries_rvs(double p) {
  double q, r, U, V;
  long result;

  r = log(1. - p);

  while (1) {
    V = sfmt_f64_3;
    if (V >= p)
      return 1;
    U = sfmt_f64_3;
    q = 1. - exp(r * U);
    if (V <= q * q) {
      result = (long) floor(1 + log(V) / log(q));
      if (result < 1)
        continue;
      else
        return result;
    }
    if (V >= q) return 1;

    return 2;
  }
}
