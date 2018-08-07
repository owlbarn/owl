/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Noncentral Chi-squared distribution **/

double noncentral_chi2_rvs(double df, double nonc) {
  if (nonc == 0)
    return chi2_rvs(df);
  if (1 < df) {
    double Chi2 = chi2_rvs(df - 1);
    double N = std_gaussian_rvs() + sqrt(nonc);
    return Chi2 + N * N;
  }
  else {
    long i = poisson_rvs(nonc / 2);
    return chi2_rvs(df + 2 * i);
  }
}

/*
double noncentral_chi2_logpdf(double x, double df, double nonc) {
  double df2 = df / 2 - 1;
  double xs = sqrt(x);
  double ns = sqrt(nonc);
  double res = xlogy(df2 / 2, x / nonc) - 0.5 * (xs - ns) * (xs - ns);
  res += log(ive(df2, xs * ns) / 2);
  return res;
}
*/

/*
double noncentral_chi2_ppf(double q, double df, double nonc) {
  return chndtrix(q, df, nonc);
}
*/
