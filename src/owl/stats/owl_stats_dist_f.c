/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** F distribution **/

double f_rvs(double dfnum, double dfden) {
  return ((chi2_rvs(dfnum) * dfden) / (chi2_rvs(dfden) * dfnum));
}

double f_pdf(double x, double dfnum, double dfden) {
  return exp(f_logpdf(x, dfnum, dfden));
}

double f_logpdf(double x, double dfnum, double dfden) {
  double lp = dfden / 2 * log(dfden) + dfnum / 2 * log(dfnum) + (dfnum / 2 - 1) * log(x);
  lp -= ((dfnum + dfden) / 2) * log(dfden + dfnum * x) + lbeta(dfnum / 2, dfden / 2);
  return lp;
}

double f_cdf(double x, double dfnum, double dfden) {
  return fdtr(dfnum, dfden, x);
}

double f_logcdf(double x, double dfnum, double dfden) {
  return log(fdtr(dfnum, dfden, x));
}

double f_ppf(double q, double dfnum, double dfden) {
  return fdtri(dfnum, dfden, q);
}

double f_sf(double x, double dfnum, double dfden) {
  return fdtrc(dfnum, dfden, x);
}

double f_logsf(double x, double dfnum, double dfden) {
  return log(fdtrc(dfnum, dfden, x));
}

double f_isf(double q, double dfnum, double dfden) {
  return fdtri(dfnum, dfden, 1 - q);
}

double f_entropy(double dfnum, double dfden) {
  double d1 = dfnum / 2;
  double d2 = dfden / 2;
  double h = log(d1 / d2) * lbeta(d1, d2) + (1 - d1) * psi(d1) - (1 + d2) * psi(d2) + (d1 + d2) * psi(d1 + d2);
  return h;
}
