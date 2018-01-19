/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"

/** von Mises distribution **/

double vonmises_rvs(double mu, double kappa) {
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
      double r = 1 + sqrt(1 + 4 * kappa * kappa);
      double rho = (r - sqrt(2 * r)) / (2 * kappa);
      s = (1 + rho * rho) / (2 * rho);
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

double vonmises_pdf(double x, double mu, double kappa) {
  return exp(kappa * cos(x)) / (2 * OWL_PI * i0(kappa));
}

double vonmises_logpdf(double x, double mu, double kappa) {
  return log(vonmises_pdf(x, mu, kappa));
}

double vonmises_entropy(double kappa) {
  return (-kappa * i1(kappa) / i0(kappa) + log(2 * OWL_PI * i0(kappa)));
}

double vonmises_cdf_series(double k, double x, double p) {
  double s = sin(x);
  double c = cos(x);
  double sn = sin(p * x);
  double cn = cos(p * x);
  double R = 0;
  double V = 0;

  for (int n = p - 1; n > 0; n--) {
    double _sn = sn * c - cn * s;
    cn = cn * c + sn * s;
    sn = _sn;
    R = 1. / (2 * n / k + R);
    V = R * (sn / n + V);
  }

  return 0.5 + x / (2 * OWL_PI) + V / OWL_PI;
}

double vonmises_cdf_normalapprox(double k, double x) {
  double b = sqrt(2 / OWL_PI) * exp(k) / i0(k);
  double z = b * sin(x / 2.);
  return ndtr(z);
}

double vonmises_cdf(double x, double mu, double kappa) {
  x = x - mu;
  double ix = 2 * OWL_PI * round(x / OWL_2PI);
  x = x - ix;

  double F = 0.;
  int CK = 50;
  static double a[] = {28., 0.5, 100., 5.0};

  if (kappa < CK) {
    double p = ceil(a[0] + a[1] * kappa - a[2] / (kappa + a[3]));
    F = vonmises_cdf_series(kappa, x, p);
    if (F < 0)
      F = 0.;
    else if (F > 1)
      F = 1.;
  }
  else
    F = vonmises_cdf_normalapprox(kappa, x);

  return F + ix;
}

double vonmises_logcdf(double x, double mu, double kappa) {
  return log(vonmises_cdf(x, mu, kappa));
}

double vonmises_sf(double x, double mu, double kappa) {
  return 1 - vonmises_cdf(x, mu, kappa);
}

double vonmises_logsf(double x, double mu, double kappa) {
  return log(vonmises_sf(x, mu, kappa));
}
