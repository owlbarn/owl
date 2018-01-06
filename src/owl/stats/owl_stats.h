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

/** Uniform distribution **/

/** Exponential distribution **/

extern double std_exp_rvs();

extern double exp_rvs(double lambda);

extern double exp_pdf(double x, double lambda);

extern double exp_logpdf(double x, double lambda);

extern double exp_cdf(double x, double lambda);

extern double exp_logcdf(double x, double lambda);

extern double exp_ppf(double q, double lambda);

extern double exp_sf(double x, double lambda);

extern double exp_logsf(double x, double lambda);

extern double exp_isf(double q, double lambda);

extern double exp_entropy(double lambda);

/** Gaussian distribution **/

extern double std_gaussian_rvs();

extern double gaussian_rvs(double mu, double sigma);

extern double gaussian_pdf(double x, double mu, double sigma);

extern double gaussian_logpdf(double x, double mu, double sigma);

extern double gaussian_cdf(double x, double mu, double sigma);

extern double gaussian_logcdf(double x, double mu, double sigma);

extern double gaussian_ppf(double q, double mu, double sigma);

extern double gaussian_sf(double x, double mu, double sigma);

extern double gaussian_logsf(double x, double mu, double sigma);

extern double gaussian_isf(double q, double mu, double sigma);

extern double gaussian_entropy(double sigma);

/** Gamma distribution **/

extern double std_gamma_rvs(double shape);

extern double gamma_rvs(double shape, double scale);

extern double gamma_pdf(double x, double shape, double scale);

extern double gamma_logpdf(double x, double shape, double scale);

extern double gamma_cdf(double x, double shape, double scale);

extern double gamma_logcdf(double x, double shape, double scale);

extern double gamma_ppl(double q, double shape, double scale);

extern double gamma_sf(double x, double shape, double scale);

extern double gamma_logsf(double x, double shape, double scale);

extern double gamma_isf(double q, double shape, double scale);

extern double gamma_entropy(double shape, double scale);

/** Beta distribution **/

extern double beta_rvs(double a, double b);

extern double beta_pdf(double x, double a, double b);

extern double beta_logpdf(double x, double a, double b);

extern double beta_cdf(double x, double a, double b);

extern double beta_logcdf(double x, double a, double b);

extern double beta_ppl(double q, double a, double b);

extern double beta_sf(double x, double a, double b);

extern double beta_logsf(double x, double a, double b);

extern double beta_isf(double q, double a, double b);

extern double beta_entropy(double a, double b);

/** Chi-squared distribution **/

extern double chi2_rvs(double);

extern double chi2_pdf(double x, double df);

extern double chi2_logpdf(double x, double df);

extern double chi2_cdf(double x, double df);

extern double chi2_logcdf(double x, double df);

extern double chi2_ppf(double q, double df);

extern double chi2_sf(double x, double df);

extern double chi2_logsf(double x, double df);

extern double chi2_isf(double q, double df);

extern double chi2_entropy(double df);

/** Noncentral Chi-squared distribution **/

extern double noncentral_chi2_rvs(double, double);

/** F distribution **/

extern double f_rvs(double, double);

extern double f_pdf(double x, double dfnum, double dfden);

extern double f_logpdf(double x, double dfnum, double dfden);

extern double f_cdf(double x, double dfnum, double dfden);

extern double f_logcdf(double x, double dfnum, double dfden);

extern double f_ppf(double q, double dfnum, double dfden);

extern double f_sf(double x, double dfnum, double dfden);

extern double f_logsf(double x, double dfnum, double dfden);

extern double f_isf(double q, double dfnum, double dfden);

extern double f_entropy(double dfnum, double dfden);

/** Noncentral F distribution **/

extern double noncentral_f_rvs(double, double, double);

/** Binomial distribution **/

// TODO

/** Negative Binomial distribution **/

extern long negative_binomial_rvs(double, double);

/** Poisson distribution **/

extern long poisson_rvs(double);

/** Cauchy distribution **/

extern double std_cauchy_rvs();

extern double cauchy_rvs(double loc, double scale);

extern double cauchy_pdf(double x, double loc, double scale);

extern double cauchy_logpdf(double x, double loc, double scale);

extern double cauchy_cdf(double x, double loc, double scale);

extern double cauchy_logcdf(double x, double loc, double scale);

extern double cauchy_ppl(double q, double loc, double scale);

extern double cauchy_sf(double x, double loc, double scale);

extern double cauchy_logsf(double x, double loc, double scale);

extern double cauchy_isf(double q, double loc, double scale);

extern double cauchy_entropy(double scale);

/** Student's t distribution **/

extern double std_t_rvs(double df);

extern double t_rvs(double df, double loc, double scale);

extern double t_pdf(double x, double df, double loc, double scale);

extern double t_logpdf(double x, double df, double loc, double scale);

extern double t_cdf(double x, double df, double loc, double scale);

extern double t_logcdf(double x, double df, double loc, double scale);

extern double t_ppl(double q, double df, double loc, double scale);

extern double t_sf(double x, double df, double loc, double scale);

extern double t_logsf(double x, double df, double loc, double scale);

extern double t_isf(double q, double df, double loc, double scale);

extern double t_entropy(double df);

/** von Mises distribution **/

extern double vonmises_rvs(double, double);

/** Pareto distribution **/

extern double pareto_rvs(double);

/** Weibull distribution **/

extern double weibull_rvs(double);

/** Power distribution **/

extern double power_rvs(double);

/** Laplace distribution **/

extern double laplace_rvs(double, double);

extern double laplace_pdf(double x, double loc, double scale);

extern double laplace_logpdf(double x, double loc, double scale);

extern double laplace_cdf(double x, double loc, double scale);

extern double laplace_logcdf(double x, double loc, double scale);

extern double laplace_ppl(double q, double loc, double scale);

extern double laplace_sf(double x, double loc, double scale);

extern double laplace_logsf(double x, double loc, double scale);

extern double laplace_isf(double q, double loc, double scale);

extern double laplace_entropy(double scale);

/** Gumbel distribution **/

extern double gumbel_rvs(double, double);

/** Logistic distribution **/

extern double logistic_rvs(double loc, double scale);

extern double logistic_pdf(double x, double loc, double scale);

extern double logistic_logpdf(double x, double loc, double scale);

extern double logistic_cdf(double x, double loc, double scale);

extern double logistic_logcdf(double x, double loc, double scale);

extern double logistic_ppl(double q, double loc, double scale);

extern double logistic_sf(double x, double loc, double scale);

extern double logistic_logsf(double x, double loc, double scale);

extern double logistic_isf(double q, double loc, double scale);

extern double logistic_entropy(double scale);

/** Log-normal distribution **/

extern double lognormal_rvs(double mu, double sigma);

extern double lognormal_pdf(double x, double mu, double sigma);

extern double lognormal_logpdf(double x, double mu, double sigma);

extern double lognormal_cdf(double x, double mu, double sigma);

extern double lognormal_logcdf(double x, double mu, double sigma);

extern double lognormal_ppf(double q, double mu, double sigma);

extern double lognormal_sf(double x, double mu, double sigma);

extern double lognormal_logsf(double x, double mu, double sigma);

extern double lognormal_isf(double q, double mu, double sigma);

extern double lognormal_entropy(double mu, double sigma);

/** Rayleigh distribution **/

extern double rayleigh_rvs(double);

extern double rayleigh_pdf(double x, double sigma);

extern double rayleigh_logpdf(double x, double sigma);

extern double rayleigh_cdf(double x, double sigma);

extern double rayleigh_logcdf(double x, double sigma);

extern double rayleigh_ppf(double q, double sigma);

extern double rayleigh_sf(double x, double sigma);

extern double rayleigh_logsf(double x, double sigma);

extern double rayleigh_isf(double q, double sigma);

extern double rayleigh_entropy(double sigma);

/** Wald distribution **/

extern double wald_rvs(double, double);

/** Zipf distribution **/

extern long zipf_rvs(double);

/** Geometric distribution **/

extern long geometric_rvs(double);

/** Hypergeometric distribution **/

extern long hypergeometric_rvs(long, long, long);

/** Triangular distribution **/

extern double triangular_rvs(double, double, double);

/** Log-Series distribution **/

extern long logseries_rvs(double);

/** Some helper functions **/

extern double loggam(double x);


#endif // OWL_STATS_H
