/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Wald distribution **/

double wald_rvs(double mu, double lambda) {
  double mu_2l = mu / (2 * lambda);
  double Y = std_gaussian_rvs();
  Y = mu * Y * Y;
  double X = mu + mu_2l * (Y - sqrt(4 * lambda * Y + Y * Y));
  double U = sfmt_f64_3;
  if (U <= mu / (mu + X))
    return X;
  else
    return (mu * mu / X);
}
