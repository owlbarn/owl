/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Student's t distribution **/

double std_t_rvs(double df) {
  double N = std_gaussian_rvs();
  double G = std_gamma_rvs(df / 2);
  return (sqrt(df / 2) * N / sqrt(G));
}

double t_rvs(double df, double loc, double scale) {
  return loc + scale * std_t_rvs(df);
}

double t_pdf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  double p = exp(lgam((df + 1) / 2) - lgam(df / 2));
  p /= sqrt(OWL_PI * df) * pow(1 + u * u / df, (df + 1) / 2);
  return p;
}

double t_logpdf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  double lp = lgam((df + 1) / 2) - lgam(df / 2);
  lp -= 0.5 * log(OWL_PI * df) + (df + 1) / 2 * log(1 + u * u / df);
  return lp;
}

double t_cdf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  return stdtr(df, u);
}

double t_logcdf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  return log(stdtr(df, u));
}

double t_ppf(double q, double df, double loc, double scale) {
  return loc + scale * stdtri(df, q); // TODO: CDFT in CDFLIB
}

double t_sf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  return stdtr(df, -u);
}

double t_logsf(double x, double df, double loc, double scale) {
  double u = (x - loc) / scale;
  return log(stdtr(df, -u));
}

double t_isf(double q, double df, double loc, double scale) {
  return loc - scale * stdtri(df, q); // TODO: CDFT in CDFLIB
}

double t_entropy(double df) {
  double d1 = df / 2;
  double d2 = (df + 1) / 2;
  return d2 * (psi(d2) - psi(d1)) + log(sqrt(df) * beta(d1, 0.5));
}
