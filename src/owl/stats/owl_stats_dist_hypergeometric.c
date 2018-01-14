/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_maths.h"
#include "owl_stats.h"
#include "owl_cdflib.h"


/** Hypergeometric distribution **/

#define D1 1.7155277699214135  /* D1 = 2*sqrt(2/e) */
#define D2 0.8989161620588988  /* D2 = 3 - 2*sqrt(3/e) */

long hypergeometric_hyp_rvs(long good, long bad, long sample) {
  long d1 = bad + good - sample;
  double d2 = good < bad ? good : bad;

  double Y = d2;
  long K = sample;
  while (Y > 0.0) {
    Y -= (long) floor(sfmt_f64_3 + Y / (d1 + K));
    K--;
    if (K == 0) break;
  }
  long Z = d2 - Y;
  if (good > bad) Z = sample - Z;
  return Z;
}

long hypergeometric_hrua_rvs(long good, long bad, long sample) {
  long mingoodbad, maxgoodbad, popsize, m, d9;
  double d4, d5, d6, d7, d8, d10, d11;
  long Z;
  double T, W, X, Y;

  mingoodbad = fmin(good, bad);
  popsize = good + bad;
  maxgoodbad = fmax(good, bad);
  m = fmin(sample, popsize - sample);
  d4 = ((double) mingoodbad) / popsize;
  d5 = 1. - d4;
  d6 = m * d4 + 0.5;
  d7 = sqrt((double) (popsize - m) * sample * d4 * d5 / (popsize - 1) + 0.5);
  d8 = D1 * d7 + D2;
  d9 = (long) floor((double) (m + 1) * (mingoodbad + 1) / (popsize + 2));
  d10 = (loggam(d9 + 1) + loggam(mingoodbad - d9 + 1) + loggam(m - d9 + 1) +
         loggam(maxgoodbad - m + d9 + 1));
  d11 = fmin(fmin(m, mingoodbad) + 1., floor(d6 + 16 * d7));

  while (1) {
    X = sfmt_f64_3;
    Y = sfmt_f64_3;
    W = d6 + d8 * (Y - 0.5) / X;

    if ((W < 0.) || (W >= d11)) continue;

    Z = (long) floor(W);
    T = d10 - (loggam(Z + 1) + loggam(mingoodbad - Z + 1) + loggam(m - Z + 1) +
               loggam(maxgoodbad - m + Z + 1));

    if ((X * (4. - X) - 3.) <= T) break;
    if (X * (X - T) >= 1) continue;
    if (2. * log(X) <= T) break;
  }

  /* this is a correction to HRUA* by Ivan Frohne in rv.py */
  if (good > bad) Z = m - Z;
  /* another fix from rv.py to allow sample to exceed popsize/2 */
  if (m < sample) Z = good - Z;

  return Z;
}
#undef D1
#undef D2

long hypergeometric_rvs(long good, long bad, long sample) {
  if (sample > 10)
    return hypergeometric_hrua_rvs(good, bad, sample);
  else
    return hypergeometric_hyp_rvs(good, bad, sample);
}

double hypergeometric_pdf(long k, long good, long bad, long sample) {
  return exp(hypergeometric_logpmf(k, good, bad, sample));
}

double hypergeometric_logpmf(long k, long good, long bad, long sample) {
  double tot = good + bad;
  double a0 = 1;
  double a1 = good + 1;
  double a2 = bad + 1;
  double a3 = tot - sample + 1;
  double a4 = sample + 1;
  double a5 = k + 1;
  double a6 = good - k + 1;
  double a7 = sample - k + 1;
  double a8 = bad - sample + k + 1;
  double a9 = tot + 1;

  double p = betaln(&a1, &a0) + betaln(&a2, &a0) + betaln(&a3, &a4)
    - betaln(&a5, &a6) - betaln(&a7, &a8) - betaln(&a9, &a0);

  return p;
}
