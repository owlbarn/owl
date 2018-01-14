/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

/** TODO recursive definiton of mean, etc., only need to traverse data once.
  Current implementation is very fast but may be subject to overflow.
 **/

#include <math.h>


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


double owl_stats_var (double* x, double mean, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double s = *(x + i) - mean;
    t += s * s;
  }

  double m = n == 1 ? 1 : n - 1;

  return t / m;
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


double owl_stats_kurtosis (double* x, double mean, double std, int n) {
  double t = 0;

  for (int i = 0; i < n; i++) {
    double s = (*(x + i) - mean) / std;
    double u = s * s;
    t += u * u;
  }

  return t / n;
}
