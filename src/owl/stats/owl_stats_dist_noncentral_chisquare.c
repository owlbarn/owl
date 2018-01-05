/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Noncentral Chi-squared distribution **/

double noncentral_chisquare_rvs(double df, double nonc) {
  if (nonc == 0)
    return chisquare_rvs(df);
  if (1 < df) {
    double Chi2 = chisquare_rvs(df - 1);
    double N = std_gaussian_rvs() + sqrt(nonc);
    return Chi2 + N * N;
  }
  else {
    long i = poisson_rvs(nonc / 2);
    return chisquare_rvs(df + 2 * i);
  }
}
