/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Power distribution **/

double power_rvs(double a) {
  return pow(1. - exp(-std_exponential_rvs()), 1. / a);
}
