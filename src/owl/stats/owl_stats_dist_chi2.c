/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Chi-squared distribution **/

double chi2_rvs(double df) {
  return 2. * std_gamma_rvs(df / 2.);
}

double chi2_pdf(double x, double df) {
  return exp(chi2_logpdf(x, df));
}

double chi2_logpdf(double x, double df) {
  if (x < 0)
    return OWL_NEGINF;
  else {
    if (df == 2.0)
      return -x / 2 - OWL_LOGE2;
    else
      return xlogy(df / 2 - 1, x / 2) - x / 2 - lgam (df / 2) - OWL_LOGE2;
  }
}

double chi2_cdf(double x, double df) {
  return chdtr(df, x);
}

double chi2_logcdf(double x, double df) {
  return log(chdtr(df, x));
}

double chi2_ppf(double q, double df) {
  return chi2_isf(1 - q, df);
}

double chi2_sf(double x, double df) {
  return chdtrc(df, x);
}

double chi2_logsf(double x, double df) {
  return log(chdtrc(df, x));
}

double chi2_isf(double q, double df) {
  return chdtri(df, q);
}

double chi2_entropy(double df) {
  double d = df / 2;
  return OWL_LOGE2 + lgam(d) - (1 - d) * psi(d) + d;
}
