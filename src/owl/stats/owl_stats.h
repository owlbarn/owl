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

#define sfmt_f32_1 sfmt_genrand_real4(&sfmt_state)  // [0, 1]

#define sfmt_f32_2 sfmt_genrand_real5(&sfmt_state)  // [0, 1)

#define sfmt_f32_3 sfmt_genrand_real6(&sfmt_state)  // (0, 1)

#define sfmt_f64_1 sfmt_genrand_real1(&sfmt_state)  // [0, 1]

#define sfmt_f64_2 sfmt_genrand_real2(&sfmt_state)  // [0, 1)

#define sfmt_f64_3 sfmt_genrand_real3(&sfmt_state)  // (0, 1)

// Various PRNG and functions

#define f32_exponential std_exponential_rvs()

#define f64_exponential std_exponential_rvs()

#define f32_gaussian std_gaussian_rvs()

#define f64_gaussian std_gaussian_rvs()

extern void ziggurat_init();

/** Uniform distribution **/

extern double uniform_rvs(double a, double b);

extern double uniform_pdf(double x, double a, double b);

extern double uniform_logpdf(double x, double a, double b);

extern double uniform_cdf(double x, double a, double b);

extern double uniform_logcdf(double x, double a, double b);

extern double uniform_ppf(double p, double a, double b);

extern double uniform_sf(double x, double a, double b);

extern double uniform_logsf(double x, double a, double b);

extern double uniform_isf(double q, double a, double b);

extern double uniform_entropy(double a, double b);

/** Exponential distribution **/

extern double std_exponential_rvs();

extern double exponential_rvs(double lambda);

extern double exponential_pdf(double x, double lambda);

extern double exponential_logpdf(double x, double lambda);

extern double exponential_cdf(double x, double lambda);

extern double exponential_logcdf(double x, double lambda);

extern double exponential_ppf(double q, double lambda);

extern double exponential_sf(double x, double lambda);

extern double exponential_logsf(double x, double lambda);

extern double exponential_isf(double q, double lambda);

extern double exponential_entropy(double lambda);

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

extern double gamma_ppf(double q, double shape, double scale);

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

extern double beta_ppf(double q, double a, double b);

extern double beta_sf(double x, double a, double b);

extern double beta_logsf(double x, double a, double b);

extern double beta_isf(double q, double a, double b);

extern double beta_entropy(double a, double b);

/** Chi-squared distribution **/

extern double chi2_rvs(double df);

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

extern double noncentral_chi2_rvs(double df, double nonc);

/** F distribution **/

extern double f_rvs(double dfnum, double dfden);

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

extern double noncentral_f_rvs(double dfnum, double dfden, double nonc);

/** Binomial distribution **/

// TODO

/** Negative Binomial distribution **/

extern long negative_binomial_rvs(double, double);

/** Poisson distribution **/

extern long poisson_rvs(double lambda);

/** Cauchy distribution **/

extern double std_cauchy_rvs();

extern double cauchy_rvs(double loc, double scale);

extern double cauchy_pdf(double x, double loc, double scale);

extern double cauchy_logpdf(double x, double loc, double scale);

extern double cauchy_cdf(double x, double loc, double scale);

extern double cauchy_logcdf(double x, double loc, double scale);

extern double cauchy_ppf(double q, double loc, double scale);

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

extern double t_ppf(double q, double df, double loc, double scale);

extern double t_sf(double x, double df, double loc, double scale);

extern double t_logsf(double x, double df, double loc, double scale);

extern double t_isf(double q, double df, double loc, double scale);

extern double t_entropy(double df);

/** von Mises distribution **/

extern double vonmises_rvs(double mu, double kappa);

extern double vonmises_pdf(double x, double mu, double kappa);

extern double vonmises_logpdf(double x, double mu, double kappa);

extern double vonmises_cdf(double x, double mu, double kappa);

extern double vonmises_logcdf(double x, double mu, double kappa);

extern double vonmises_sf(double x, double mu, double kappa);

extern double vonmises_logsf(double x, double mu, double kappa);

extern double vonmises_entropy(double kappa);

/** Lomax distribution, i.e. Pareto Type II distribution **/

extern double lomax_rvs(double shape, double scale);

extern double lomax_pdf(double x, double shape, double scale);

extern double lomax_logpdf(double x, double shape, double scale);

extern double lomax_cdf(double x, double shape, double scale);

extern double lomax_logcdf(double x, double shape, double scale);

extern double lomax_ppf(double q, double shape, double scale);

extern double lomax_sf(double x, double shape, double scale);

extern double lomax_logsf(double x, double shape, double scale);

extern double lomax_isf(double q, double shape, double scale);

extern double lomax_entropy(double shape, double scale);

/** Weibull distribution **/

extern double weibull_rvs(double shape, double scale);

extern double weibull_pdf(double x, double shape, double scale);

extern double weibull_logpdf(double x, double shape, double scale);

extern double weibull_cdf(double x, double shape, double scale);

extern double weibull_logcdf(double x, double shape, double scale);

extern double weibull_ppf(double p, double shape, double scale);

extern double weibull_sf(double x, double shape, double scale);

extern double weibull_logsf(double x, double shape, double scale);

extern double weibull_isf(double q, double shape, double scale);

extern double weibull_entropy(double shape, double scale);

/** Power distribution **/

extern double power_rvs(double);

/** Laplace distribution **/

extern double laplace_rvs(double loc, double scale);

extern double laplace_pdf(double x, double loc, double scale);

extern double laplace_logpdf(double x, double loc, double scale);

extern double laplace_cdf(double x, double loc, double scale);

extern double laplace_logcdf(double x, double loc, double scale);

extern double laplace_ppf(double q, double loc, double scale);

extern double laplace_sf(double x, double loc, double scale);

extern double laplace_logsf(double x, double loc, double scale);

extern double laplace_isf(double q, double loc, double scale);

extern double laplace_entropy(double scale);

/** Gumbel Type-1 distribution **/

extern double gumbel1_rvs(double a, double b);

extern double gumbel1_pdf(double x, double a, double b);

extern double gumbel1_logpdf(double x, double a, double b);

extern double gumbel1_cdf(double x, double a, double b);

extern double gumbel1_logcdf(double x, double a, double b);

extern double gumbel1_ppf(double q, double a, double b);

extern double gumbel1_sf(double x, double a, double b);

extern double gumbel1_logsf(double x, double a, double b);

extern double gumbel1_isf(double q, double a, double b);

/** Gumbel Type-2 distribution **/

extern double gumbel2_rvs(double a, double b);

extern double gumbel2_pdf(double x, double a, double b);

extern double gumbel2_logpdf(double x, double a, double b);

extern double gumbel2_cdf(double x, double a, double b);

extern double gumbel2_logcdf(double x, double a, double b);

extern double gumbel2_ppf(double q, double a, double b);

extern double gumbel2_sf(double x, double a, double b);

extern double gumbel2_logsf(double x, double a, double b);

extern double gumbel2_isf(double q, double a, double b);

/** Logistic distribution **/

extern double logistic_rvs(double loc, double scale);

extern double logistic_pdf(double x, double loc, double scale);

extern double logistic_logpdf(double x, double loc, double scale);

extern double logistic_cdf(double x, double loc, double scale);

extern double logistic_logcdf(double x, double loc, double scale);

extern double logistic_ppf(double q, double loc, double scale);

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

extern double rayleigh_rvs(double sigma);

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

extern double wald_rvs(double mu, double lambda);

extern double wald_pdf(double x, double mu, double lambda);

extern double wald_logpdf(double x, double mu, double lambda);

extern double wald_cdf(double x, double mu, double lambda);

extern double wald_logcdf(double x, double mu, double lambda);

//extern double wald_ppf(double q, double mu, double lambda);

extern double wald_sf(double x, double mu, double lambda);

extern double wald_logsf(double x, double mu, double lambda);

//extern double wald_isf(double q, double mu, double lambda);

//extern double wald_entropy(double mu, double lambda);

/** Zipf distribution **/

extern long zipf_rvs(double);

/** Geometric distribution **/

extern long geometric_rvs(double);

/** Hypergeometric distribution **/

extern long hypergeometric_rvs(long good, long bad, long sample);

extern double hypergeometric_pdf(long k, long good, long bad, long sample);

extern double hypergeometric_logpdf(long k, long good, long bad, long sample);

/** Triangular distribution **/

extern double triangular_rvs(double, double, double);

/** Log-Series distribution **/

extern long logseries_rvs(double);

/** Some helper functions **/

extern double loggam(double x);


/** Basic Statistic funcitons **/

extern void owl_stats_shuffle(void* base, int n, int size);

extern void owl_stats_choose(void* dst, int k, void* src, int n, int size);

extern void owl_stats_sample(void* dst, int k, void* src, int n, int size);

extern double owl_stats_sum(double* x, int n);

extern double owl_stats_mean(double* x, int n);

extern double owl_stats_var(double* x, double mean, int n);

extern double owl_stats_std(double* x, double mean, int n);

extern double owl_stats_absdev(double* x, double mean, int n);

extern double owl_stats_skew(double* x, double mean, double sd, int n);

extern double owl_stats_kurtosis(double* x, double mean, double sd, int n);

extern double owl_stats_cov(double* x, double* y, double mean_x, double mean_y, int n);

extern double owl_stats_corrcoef(double* x, double* y, int n);

extern double owl_stats_quantile(double* x, double p, int n);


#endif // OWL_STATS_H
