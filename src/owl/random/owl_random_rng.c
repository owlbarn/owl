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


long rng_poisson_mult(double lam) {
  long X;
  double prod, U, enlam;

  enlam = exp(-lam);
  X = 0;
  prod = 1.0;
  while (1) {
    U = sfmt_f64_3;
    prod *= U;
    if (prod > enlam)
      X += 1;
    else
      return X;
  }
}


static double loggam(double x) {
  double x0, x2, xp, gl, gl0;
  long k, n;

  static double a[10] = {
    8.333333333333333e-02,-2.777777777777778e-03,
    7.936507936507937e-04,-5.952380952380952e-04,
    8.417508417508418e-04,-1.917526917526918e-03,
    6.410256410256410e-03,-2.955065359477124e-02,
    1.796443723688307e-01,-1.39243221690590e+00 };
  x0 = x;
  n = 0;
  if ((x == 1.0) || (x == 2.0))
    return 0.0;
  else if (x <= 7.0) {
    n = (long) (7 - x);
    x0 = x + n;
  }
  x2 = 1. / (x0 * x0);
  xp = 2 * M_PI;
  gl0 = a[9];
  for (k = 8; k >= 0; k--) {
      gl0 *= x2;
      gl0 += a[k];
  }
  gl = gl0 / x0 + 0.5 * log(xp) + (x0 - 0.5) * log(x0) - x0;
  if (x <= 7.0) {
    for (k=1; k<=n; k++) {
      gl -= log(x0 - 1.0);
      x0 -= 1.0;
    }
  }
  return gl;
}


#define LS2PI 0.91893853320467267
#define TWELFTH 0.083333333333333333333333

long rng_poisson_ptrs(double lam) {
  long k;
  double U, V, slam, loglam, a, b, invalpha, vr, us;

  slam = sqrt(lam);
  loglam = log(lam);
  b = 0.931 + 2.53 * slam;
  a = -0.059 + 0.02483 * b;
  invalpha = 1.1239 + 1.1328 / (b - 3.4);
  vr = 0.9277 - 3.6224 / (b - 2);

  while (1) {
    U = sfmt_f64_3 - 0.5;
    V = sfmt_f64_3;
    us = 0.5 - fabs(U);
    k = (long) floor((2 * a / us + b) * U + lam + 0.43);
    if ((us >= 0.07) && (V <= vr))
      return k;
    if ((k < 0) || ((us < 0.013) && (V > us)))
      continue;
    if ((log(V) + log(invalpha) - log(a / (us * us) + b)) <=
        (-lam + k * loglam - loggam(k + 1)))
      return k;
  }
}


long rng_poisson(double lam)
{
  if (lam == 0)
    return 0;
  else if (lam >= 10)
    return rng_poisson_ptrs(lam);
  else
    return rng_poisson_mult(lam);
}


double rng_std_cauchy() {
  return rng_std_gaussian() / rng_std_gaussian();
}


double rng_std_t(double df) {
  double N, G, X;

  N = rng_std_gaussian();
  G = rng_std_gamma(df / 2);
  X = sqrt(df / 2) * N / sqrt(G);
  return X;
}

double rng_vonmises(double mu, double kappa) {
  double s;
  double U, V, W, Y, Z;
  double result, mod;
  int neg;

  if (kappa < 1e-8)
    return M_PI * (2 * sfmt_f64_3 - 1);
  else {
    /* with double precision rho is zero until 1.4e-8 */
    if (kappa < 1e-5)
      s = (1./kappa + kappa);
    else {
      double r = 1 + sqrt(1 + 4*kappa*kappa);
      double rho = (r - sqrt(2*r)) / (2*kappa);
      s = (1 + rho*rho)/(2*rho);
    }

    while (1) {
      U = sfmt_f64_3;
      Z = cos(M_PI * U);
      W = (1 + s * Z) / (s + Z);
      Y = kappa * (s - W);
      V = sfmt_f64_3;
      if ((Y * (2 - Y) - V >= 0) || (log(Y / V) + 1 - Y >= 0))
        break;
    }

    U = sfmt_f64_3;

    result = acos(W);
    if (U < 0.5)
      result = -result;
    result += mu;
    neg = (result < 0);
    mod = fabs(result);
    mod = (fmod(mod + M_PI, 2 * M_PI) - M_PI);
    if (neg)
      mod *= -1;

    return mod;
  }
}


double rng_pareto(double a) {
  return exp(rng_std_exp() / a) - 1.;
}


double rng_weibull(double a) {
  return pow(rng_std_exp(), 1. / a);
}


double rng_power(double a) {
  return pow(1. - exp(-rng_std_exp()), 1. / a);
}


double rng_laplace(double loc, double scale) {
  double U = sfmt_f64_3;

  if (U < 0.5)
    U = loc + scale * log(U + U);
  else
    U = loc - scale * log(2. - U - U);
  return U;
}


double rng_gumbel(double loc, double scale) {
  double U = 1. - sfmt_f64_3;
  return loc - scale * log(-log(U));
}


double rng_logistic(double loc, double scale) {
  double U = sfmt_f64_3;
  return loc + scale * log(U/(1. - U));
}


double rng_lognormal(double mu, double sigma) {
  return exp(rng_gaussian(mu, sigma));
}


double rng_rayleigh(double mode) {
  return mode * sqrt(-2. * log(1. - sfmt_f64_3));
}


double rng_wald(double mu, double lambda) {
  double U, X, Y;
  double mu_2l;

  mu_2l = mu / (2 * lambda);
  Y = rng_std_gaussian();
  Y = mu * Y * Y;
  X = mu + mu_2l * (Y - sqrt(4 * lambda * Y + Y * Y));
  U = sfmt_f64_3;
  if (U <= mu / (mu + X))
    return X;
  else
    return (mu * mu / X);
}


long rng_zipf(double a) {
  double am1 = a - 1.;
  double b = pow(2., am1);

  while (1) {
    double T, U, V, X;

    U = 1. - sfmt_f64_3;
    V = sfmt_f64_3;
    X = floor(pow(U, -1. / am1));

    if (X > LONG_MAX || X < 1.0)
      continue;

    T = pow(1. + 1. / X, am1);
    if (V * X * (T - 1.) / (b - 1.) <= T / b)
        return (long) X;
  }
}


// ends here
