/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** Gamma distribution **/

double std_gamma_rvs(double shape) {
  double b, c;
  double U, V, X, Y;

  if (shape == 1.0)
    return std_exponential_rvs();
  else if (shape < 1.0) {
    for ( ; ; ) {
      U = sfmt_f64_3;
      V = std_exponential_rvs();
      if (U <= 1.0 - shape) {
        X = pow(U, 1. / shape);
        if (X <= V)
          return X;
      }
      else {
        Y = -log((1 - U) / shape);
        X = pow(1.0 - shape + shape * Y, 1./ shape);
        if (X <= (V + Y))
          return X;
      }
    }
  }
  else {
    b = shape - 1. / 3.;
    c = 1. / sqrt(9 * b);
    for ( ; ; ) {
      do {
        X = f64_gaussian;
        V = 1.0 + c * X;
      } while (V <= 0.0);

      V = V*V*V;
      U = sfmt_f64_3;
      if (U < 1.0 - 0.0331*(X*X)*(X*X)) return (b*V);
      if (log(U) < 0.5*X*X + b*(1. - V + log(V))) return (b*V);
    }
  }
}

double gamma_rvs(double shape, double scale) {
  return scale * std_gamma_rvs(shape);
}

double gamma_pdf(double x, double shape, double scale) {
  if (x < 0)
    return 0;
  else if (x == 0)
    return (shape == 1 ? 1 / scale : 0);
  else if (shape == 1)
    return exp(-x / scale) / scale;
  else
    return exp((shape - 1) * log(x/scale) - x/scale - lgam(shape)) / scale;
}

double gamma_logpdf(double x, double shape, double scale) {
  return log(gamma_pdf(x, shape, scale));
}

double gamma_cdf(double x, double shape, double scale) {
  double y = x / scale;

  if (x <= 0.)
    return 0.;
  else
    return (y > shape ? (1. - igamc(shape, y)) : igam(shape, y));
}

double gamma_logcdf(double x, double shape, double scale) {
  return log(gamma_cdf(x, shape, scale));
}

double gamma_ppf(double q, double shape, double scale) {
  return scale * igami(shape, 1 - q);
}

double gamma_sf(double x, double shape, double scale) {
  return igamc(shape, (x / scale));
}

double gamma_logsf(double x, double shape, double scale) {
  return log(gamma_sf(x, shape, scale));
}

double gamma_isf(double q, double shape, double scale) {
  return scale * igami(shape, q);
}

double gamma_entropy(double shape, double scale) {
  return psi(shape) * (1 - shape) + shape + lgam(shape) + log(scale);
}
