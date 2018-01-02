/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#ifndef OWL_STATS_H
#define OWL_STATS_H

#include <math.h>
#include <limits.h>


// SFMT PRNG and its internal state

#include "SFMT.h"

extern sfmt_t sfmt_state;

#define sfmt_rand32 sfmt_genrand_uint32(&sfmt_state)

#define sfmt_rand64 sfmt_genrand_uint64(&sfmt_state)

#define sfmt_f32_1 sfmt_genrand_real4(&sfmt_state)

#define sfmt_f32_2 sfmt_genrand_real5(&sfmt_state)

#define sfmt_f32_3 sfmt_genrand_real6(&sfmt_state)

#define sfmt_f64_1 sfmt_genrand_real1(&sfmt_state)

#define sfmt_f64_2 sfmt_genrand_real2(&sfmt_state)

#define sfmt_f64_3 sfmt_genrand_real3(&sfmt_state)


// Various PRNG and functions

#define f32_exponential std_exp_rvs()

#define f64_exponential std_exp_rvs()

#define f32_gaussian std_gaussian_rvs()

#define f64_gaussian std_gaussian_rvs()

extern void ziggurat_init();

extern float std_exp_rvs();

extern float exp_rvs(float);

extern float std_gaussian_rvs();

extern float gaussian_rvs(float, float);

extern double std_gamma_rvs();

extern double gamma_rvs(double, double);

extern double beta_rvs(double, double);

extern long poisson_rvs(double);

extern double std_cauchy_rvs();

extern double std_t_rvs(double);

extern double vonmises_rvs(double, double);

extern double pareto_rvs(double);

extern double weibull_rvs(double);

extern double power_rvs(double);

extern double laplace_rvs(double, double);

extern double gumbel_rvs(double, double);

extern double logistic_rvs(double, double);

extern double lognormal_rvs(double, double);

extern double rayleigh_rvs(double);

extern double wald_rvs(double, double);

extern long zipf_rvs(double);

extern long geometric_rvs(double);

extern long rng_hypergeometric(long, long, long);

extern double triangular_rvs(double, double, double);

extern long logseries_rvs(double);


#endif // OWL_STATS_H
