/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Gaussian distribution **/

#define _norm_pdf_C 2.5066282746310005024157652    // sqrt(2 * PI)

#define _norm_pdf_logC 0.9189385332046727417803297 // log(_norm_pdf_C);

double gaussian_pdf(double x, double mu, double sigma) {
  double y = (x - mu) / sigma;
  return exp(-y * y / 2.) / (_norm_pdf_C * sigma);
}

double gaussian_logpdf(double x, double mu, double sigma) {
  double y = (x - mu) / sigma;
  return (-y * y / 2.) - _norm_pdf_logC - log(sigma);
}

double gaussian_cdf(double x, double mu, double sigma) {
  double y = (x - mu) / sigma;
  return ndtr(y);
}

double gaussian_logcdf(double x, double mu, double sigma) {
  return log(gaussian_cdf(x, mu, sigma));
}

double gaussian_ppf(double q, double mu, double sigma) {
  return mu + sigma * ndtri(q);
}

double gaussian_sf(double x, double mu, double sigma) {
  double y = x - mu;
  return gaussian_cdf(-y, 0., sigma);
}

double gaussian_logsf(double x, double mu, double sigma) {
  double y = x - mu;
  return log(gaussian_cdf(-y, 0., sigma));
}

double gaussian_isf(double q, double mu, double sigma) {
  return mu - sigma * ndtri(q);
}

double gaussian_entropy(double sigma) {
  return 0.5 * (log(2 * OWL_PI) + 1) + log(sigma);
}
