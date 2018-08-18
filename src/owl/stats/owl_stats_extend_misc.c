/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

/** TODO recursive definiton of mean, etc., only need to traverse data once.
  Current implementation is very fast but may be subject to overflow.
 **/

#include <math.h>
// #include <fenv.h>
// #pragma STDC FENV_ACCESS ON
// const int OUFLOW = FE_OVERFLOW | FE_UNDERFLOW;


double owl_stats_sum (double* x, int n) {
  double t = 0;

  for (int i = 0; i < n; i++)
    t += *(x + i);

  return t;
}


double owl_stats_mean (double* x, int n) {
  double t = 0;

  for (int i = 0; i < n; i++)
    t += *(x + i);

  return t / n;
}


double owl_stats_mean_stable (double* x, int n) {
  double t = 0;

  for (int i = 0; i < n; i++)
    t += (*(x + i) - t) / (i + 1);

  return t;
}


double owl_stats_var (double* x, double mean, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double d = *(x + i) - mean;
    t += d * d;
  }

  double m = n == 1 ? 1 : n - 1;
  return t / m;
}


double owl_stats_var_stable (double* x, double mean, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double d = *(x + i) - mean;
    t += (d * d - t) / (i + 1);
  }

  double m = n == 1 ? 1 : (n / (n - 1));
  return t * m;
}


double owl_stats_std (double* x, double mean, int n) {
  return sqrt(owl_stats_var(x, mean, n));
}


double owl_stats_absdev (double* x, double mean, int n) {
  double t = 0;

  for (int i = 0; i < n; i++)
    t += fabs(*(x + i) - mean);

  return t / n;
}


double owl_stats_skew (double* x, double mean, double std, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double s = (*(x + i) - mean) / std;
    t += s * s * s;
  }

  return t / n;
}


double owl_stats_skew_stable (double* x, double mean, double std, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double d = (*(x + i) - mean) / std;
    t += (d * d * d - t) / (i + 1);
  }

  return t;
}


double owl_stats_kurtosis (double* x, double mean, double std, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double s = (*(x + i) - mean) / std;
    double u = s * s;
    t += u * u;
  }

  return t / n;
}


double owl_stats_kurtosis_stable (double* x, double mean, double std, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double d = (*(x + i) - mean) / std;
    double u = d * d;
    t += (u * u - t)/(i + 1);
  }

  return t;
}


double owl_stats_cov (double* x, double* y, double mean_x, double mean_y, int n) {
  double t = 0.;

  for (int i = 0; i < n; i++) {
    double d1 = (*(x + i) - mean_x);
    double d2 = (*(y + i) - mean_y);
    t += d1 * d2;
  }

  return t / n;
}


double owl_stats_cov_stable (double* x, double* y, double mean_x, double mean_y, int n) {
  double t = 0.;

  for (int i = 0; i < n; i++) {
    double d1 = (*(x + i) - mean_x);
    double d2 = (*(y + i) - mean_y);
    t += (d1 * d2 - t) / (i + 1);
  }

  return t;
}


double owl_stats_corrcoef (double* x, double* y, int n) {
  double sum_xsq = 0;
  double sum_ysq = 0;
  double sum_cross = 0;
  double mean_x = *x;
  double mean_y = *y;
  double delta_x, delta_y, ratio;

  for (int i = 1; i < n; ++i) {
    ratio = i / (i + 1.);
    delta_x = *(x + i) - mean_x;
    delta_y = *(y + i) - mean_y;
    sum_xsq += delta_x * delta_x * ratio;
    sum_ysq += delta_y * delta_y * ratio;
    sum_cross += delta_x * delta_y * ratio;
    mean_x += delta_x / (i + 1.);
    mean_y += delta_y / (i + 1.);
  }

  double r = sum_cross / (sqrt(sum_xsq) * sqrt(sum_ysq));
  return r;
}


// [x] must have been sorted from small to large
double owl_stats_quantile (double* x, double p, int n)
{
  double index = p * (n - 1);
  int lhs = (int) index;
  double delta = index - lhs;

  if (n == 0)
    return 0.;

  if (lhs == n - 1)
    return *(x + lhs);
  else
    return (1 - delta) * (*(x + lhs)) + delta * (*(x + lhs + 1));
}
