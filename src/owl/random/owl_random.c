/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_random.h"

// FIXME: currently in owl_common_c.c file.
// Internal state of SFMT PRNG
// sfmt_t sfmt_state;


double rng_std_gamma(double shape) {
  double b, c;
  double U, V, X, Y;

  if (shape == 1.0)
    return rng_std_exp();
  else if (shape < 1.0) {
    for ( ; ; ) {
      U = sfmt_f64_3;
      V = rng_std_exp();
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


double rng_gamma(double shape, double scale) {
    return scale * rng_std_gamma(shape);
}


double rng_beta(double a, double b)
{
  double Ga, Gb;

  if ((a <= 1.) && (b <= 1.)) {
    double U, V, X, Y;

    while (1) {
      U = sfmt_f64_3;
      V = sfmt_f64_3;
      X = pow(U, 1. / a);
      Y = pow(V, 1. / b);

      if ((X + Y) <= 1.0) {
        if (X +Y > 0)
          return X / (X + Y);
        else {
          double logX = log(U) / a;
          double logY = log(V) / b;
          double logM = logX > logY ? logX : logY;
          logX -= logM;
          logY -= logM;
          return exp(logX - log(exp(logX) + exp(logY)));
        }
      }
    }
  }
  else {
    Ga = rng_std_gamma(a);
    Gb = rng_std_gamma(b);
    return Ga / (Ga + Gb);
  }
}


// ends here
