/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

//////////////////// function templates starts ////////////////////


// uniform_rvs

#define FUN25 float32_uniform_rvs
#define FUN25_IMPL float32_uniform_rvs_impl
#define FUN25_CODE float32_uniform_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X + (*Y - *X) * sfmt_f32_2
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_rvs
#define FUN25_IMPL float64_uniform_rvs_impl
#define FUN25_CODE float64_uniform_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X + (*Y - *X) * sfmt_f64_2
#include "owl_dense_common_map.c"

// uniform_pdf

#define FUN25 float32_uniform_pdf
#define FUN25_IMPL float32_uniform_pdf_impl
#define FUN25_CODE float32_uniform_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_pdf
#define FUN25_IMPL float64_uniform_pdf_impl
#define FUN25_CODE float64_uniform_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_logpdf

#define FUN25 float32_uniform_logpdf
#define FUN25_IMPL float32_uniform_logpdf_impl
#define FUN25_CODE float32_uniform_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_logpdf
#define FUN25_IMPL float64_uniform_logpdf_impl
#define FUN25_CODE float64_uniform_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_cdf

#define FUN25 float32_uniform_cdf
#define FUN25_IMPL float32_uniform_cdf_impl
#define FUN25_CODE float32_uniform_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_cdf
#define FUN25_IMPL float64_uniform_cdf_impl
#define FUN25_CODE float64_uniform_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_logcdf

#define FUN25 float32_uniform_logcdf
#define FUN25_IMPL float32_uniform_logcdf_impl
#define FUN25_CODE float32_uniform_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_logcdf
#define FUN25_IMPL float64_uniform_logcdf_impl
#define FUN25_CODE float64_uniform_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_ppf

#define FUN25 float32_uniform_ppf
#define FUN25_IMPL float32_uniform_ppf_impl
#define FUN25_CODE float32_uniform_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_ppf
#define FUN25_IMPL float64_uniform_ppf_impl
#define FUN25_CODE float64_uniform_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_sf

#define FUN25 float32_uniform_sf
#define FUN25_IMPL float32_uniform_sf_impl
#define FUN25_CODE float32_uniform_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_sf
#define FUN25_IMPL float64_uniform_sf_impl
#define FUN25_CODE float64_uniform_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_logsf

#define FUN25 float32_uniform_logsf
#define FUN25_IMPL float32_uniform_logsf_impl
#define FUN25_CODE float32_uniform_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_logsf
#define FUN25_IMPL float64_uniform_logsf_impl
#define FUN25_CODE float64_uniform_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// uniform_isf

#define FUN25 float32_uniform_isf
#define FUN25_IMPL float32_uniform_isf_impl
#define FUN25_CODE float32_uniform_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = uniform_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_uniform_isf
#define FUN25_IMPL float64_uniform_isf_impl
#define FUN25_CODE float64_uniform_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = uniform_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_rvs

#define FUN25 float32_gaussian_rvs
#define FUN25_IMPL float32_gaussian_rvs_impl
#define FUN25_CODE float32_gaussian_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_rvs
#define FUN25_IMPL float64_gaussian_rvs_impl
#define FUN25_CODE float64_gaussian_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// gaussian_pdf

#define FUN25 float32_gaussian_pdf
#define FUN25_IMPL float32_gaussian_pdf_impl
#define FUN25_CODE float32_gaussian_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_pdf
#define FUN25_IMPL float64_gaussian_pdf_impl
#define FUN25_CODE float64_gaussian_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_logpdf

#define FUN25 float32_gaussian_logpdf
#define FUN25_IMPL float32_gaussian_logpdf_impl
#define FUN25_CODE float32_gaussian_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_logpdf
#define FUN25_IMPL float64_gaussian_logpdf_impl
#define FUN25_CODE float64_gaussian_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_cdf

#define FUN25 float32_gaussian_cdf
#define FUN25_IMPL float32_gaussian_cdf_impl
#define FUN25_CODE float32_gaussian_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_cdf
#define FUN25_IMPL float64_gaussian_cdf_impl
#define FUN25_CODE float64_gaussian_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_logcdf

#define FUN25 float32_gaussian_logcdf
#define FUN25_IMPL float32_gaussian_logcdf_impl
#define FUN25_CODE float32_gaussian_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_logcdf
#define FUN25_IMPL float64_gaussian_logcdf_impl
#define FUN25_CODE float64_gaussian_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_ppf

#define FUN25 float32_gaussian_ppf
#define FUN25_IMPL float32_gaussian_ppf_impl
#define FUN25_CODE float32_gaussian_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_ppf
#define FUN25_IMPL float64_gaussian_ppf_impl
#define FUN25_CODE float64_gaussian_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_sf

#define FUN25 float32_gaussian_sf
#define FUN25_IMPL float32_gaussian_sf_impl
#define FUN25_CODE float32_gaussian_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_sf
#define FUN25_IMPL float64_gaussian_sf_impl
#define FUN25_CODE float64_gaussian_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_logsf

#define FUN25 float32_gaussian_logsf
#define FUN25_IMPL float32_gaussian_logsf_impl
#define FUN25_CODE float32_gaussian_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_logsf
#define FUN25_IMPL float64_gaussian_logsf_impl
#define FUN25_CODE float64_gaussian_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gaussian_isf

#define FUN25 float32_gaussian_isf
#define FUN25_IMPL float32_gaussian_isf_impl
#define FUN25_CODE float32_gaussian_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gaussian_isf
#define FUN25_IMPL float64_gaussian_isf_impl
#define FUN25_CODE float64_gaussian_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// exponential_rvs

#define FUN24 float32_exponential_rvs
#define FUN24_IMPL float32_exponential_rvs_impl
#define FUN24_CODE float32_exponential_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_rvs(*X)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_rvs
#define FUN24_IMPL float64_exponential_rvs_impl
#define FUN24_CODE float64_exponential_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_rvs(*X)
#include "owl_dense_common_map.c"

// exponential_pdf

#define FUN24 float32_exponential_pdf
#define FUN24_IMPL float32_exponential_pdf_impl
#define FUN24_CODE float32_exponential_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_pdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_pdf
#define FUN24_IMPL float64_exponential_pdf_impl
#define FUN24_CODE float64_exponential_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_pdf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_logpdf

#define FUN24 float32_exponential_logpdf
#define FUN24_IMPL float32_exponential_logpdf_impl
#define FUN24_CODE float32_exponential_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_logpdf
#define FUN24_IMPL float64_exponential_logpdf_impl
#define FUN24_CODE float64_exponential_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_cdf

#define FUN24 float32_exponential_cdf
#define FUN24_IMPL float32_exponential_cdf_impl
#define FUN24_CODE float32_exponential_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_cdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_cdf
#define FUN24_IMPL float64_exponential_cdf_impl
#define FUN24_CODE float64_exponential_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_cdf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_logcdf

#define FUN24 float32_exponential_logcdf
#define FUN24_IMPL float32_exponential_logcdf_impl
#define FUN24_CODE float32_exponential_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_logcdf
#define FUN24_IMPL float64_exponential_logcdf_impl
#define FUN24_CODE float64_exponential_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_ppf

#define FUN24 float32_exponential_ppf
#define FUN24_IMPL float32_exponential_ppf_impl
#define FUN24_CODE float32_exponential_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_ppf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_ppf
#define FUN24_IMPL float64_exponential_ppf_impl
#define FUN24_CODE float64_exponential_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_ppf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_sf

#define FUN24 float32_exponential_sf
#define FUN24_IMPL float32_exponential_sf_impl
#define FUN24_CODE float32_exponential_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_sf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_sf
#define FUN24_IMPL float64_exponential_sf_impl
#define FUN24_CODE float64_exponential_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_sf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_logsf

#define FUN24 float32_exponential_logsf
#define FUN24_IMPL float32_exponential_logsf_impl
#define FUN24_CODE float32_exponential_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_logsf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_logsf
#define FUN24_IMPL float64_exponential_logsf_impl
#define FUN24_CODE float64_exponential_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_logsf(*X, *Y)
#include "owl_dense_common_map.c"

// exponential_isf

#define FUN24 float32_exponential_isf
#define FUN24_IMPL float32_exponential_isf_impl
#define FUN24_CODE float32_exponential_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exponential_isf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_isf
#define FUN24_IMPL float64_exponential_isf_impl
#define FUN24_CODE float64_exponential_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exponential_isf(*X, *Y)
#include "owl_dense_common_map.c"

// gamma_rvs

#define FUN25 float32_gamma_rvs
#define FUN25_IMPL float32_gamma_rvs_impl
#define FUN25_CODE float32_gamma_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_rvs
#define FUN25_IMPL float64_gamma_rvs_impl
#define FUN25_CODE float64_gamma_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// gamma_pdf

#define FUN25 float32_gamma_pdf
#define FUN25_IMPL float32_gamma_pdf_impl
#define FUN25_CODE float32_gamma_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_pdf
#define FUN25_IMPL float64_gamma_pdf_impl
#define FUN25_CODE float64_gamma_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_logpdf

#define FUN25 float32_gamma_logpdf
#define FUN25_IMPL float32_gamma_logpdf_impl
#define FUN25_CODE float32_gamma_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_logpdf
#define FUN25_IMPL float64_gamma_logpdf_impl
#define FUN25_CODE float64_gamma_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_cdf

#define FUN25 float32_gamma_cdf
#define FUN25_IMPL float32_gamma_cdf_impl
#define FUN25_CODE float32_gamma_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_cdf
#define FUN25_IMPL float64_gamma_cdf_impl
#define FUN25_CODE float64_gamma_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_logcdf

#define FUN25 float32_gamma_logcdf
#define FUN25_IMPL float32_gamma_logcdf_impl
#define FUN25_CODE float32_gamma_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_logcdf
#define FUN25_IMPL float64_gamma_logcdf_impl
#define FUN25_CODE float64_gamma_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_ppf

#define FUN25 float32_gamma_ppf
#define FUN25_IMPL float32_gamma_ppf_impl
#define FUN25_CODE float32_gamma_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_ppf
#define FUN25_IMPL float64_gamma_ppf_impl
#define FUN25_CODE float64_gamma_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_sf

#define FUN25 float32_gamma_sf
#define FUN25_IMPL float32_gamma_sf_impl
#define FUN25_CODE float32_gamma_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_sf
#define FUN25_IMPL float64_gamma_sf_impl
#define FUN25_CODE float64_gamma_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_logsf

#define FUN25 float32_gamma_logsf
#define FUN25_IMPL float32_gamma_logsf_impl
#define FUN25_CODE float32_gamma_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_logsf
#define FUN25_IMPL float64_gamma_logsf_impl
#define FUN25_CODE float64_gamma_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gamma_isf

#define FUN25 float32_gamma_isf
#define FUN25_IMPL float32_gamma_isf_impl
#define FUN25_CODE float32_gamma_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gamma_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gamma_isf
#define FUN25_IMPL float64_gamma_isf_impl
#define FUN25_CODE float64_gamma_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gamma_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_rvs

#define FUN25 float32_beta_rvs
#define FUN25_IMPL float32_beta_rvs_impl
#define FUN25_CODE float32_beta_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_rvs
#define FUN25_IMPL float64_beta_rvs_impl
#define FUN25_CODE float64_beta_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// beta_pdf

#define FUN25 float32_beta_pdf
#define FUN25_IMPL float32_beta_pdf_impl
#define FUN25_CODE float32_beta_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_pdf
#define FUN25_IMPL float64_beta_pdf_impl
#define FUN25_CODE float64_beta_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_logpdf

#define FUN25 float32_beta_logpdf
#define FUN25_IMPL float32_beta_logpdf_impl
#define FUN25_CODE float32_beta_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_logpdf
#define FUN25_IMPL float64_beta_logpdf_impl
#define FUN25_CODE float64_beta_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_cdf

#define FUN25 float32_beta_cdf
#define FUN25_IMPL float32_beta_cdf_impl
#define FUN25_CODE float32_beta_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_cdf
#define FUN25_IMPL float64_beta_cdf_impl
#define FUN25_CODE float64_beta_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_logcdf

#define FUN25 float32_beta_logcdf
#define FUN25_IMPL float32_beta_logcdf_impl
#define FUN25_CODE float32_beta_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_logcdf
#define FUN25_IMPL float64_beta_logcdf_impl
#define FUN25_CODE float64_beta_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_ppf

#define FUN25 float32_beta_ppf
#define FUN25_IMPL float32_beta_ppf_impl
#define FUN25_CODE float32_beta_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_ppf
#define FUN25_IMPL float64_beta_ppf_impl
#define FUN25_CODE float64_beta_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_sf

#define FUN25 float32_beta_sf
#define FUN25_IMPL float32_beta_sf_impl
#define FUN25_CODE float32_beta_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_sf
#define FUN25_IMPL float64_beta_sf_impl
#define FUN25_CODE float64_beta_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_logsf

#define FUN25 float32_beta_logsf
#define FUN25_IMPL float32_beta_logsf_impl
#define FUN25_CODE float32_beta_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_logsf
#define FUN25_IMPL float64_beta_logsf_impl
#define FUN25_CODE float64_beta_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// beta_isf

#define FUN25 float32_beta_isf
#define FUN25_IMPL float32_beta_isf_impl
#define FUN25_CODE float32_beta_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = beta_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_beta_isf
#define FUN25_IMPL float64_beta_isf_impl
#define FUN25_CODE float64_beta_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = beta_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// chi2_rvs

#define FUN24 float32_chi2_rvs
#define FUN24_IMPL float32_chi2_rvs_impl
#define FUN24_CODE float32_chi2_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_rvs(*X)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_rvs
#define FUN24_IMPL float64_chi2_rvs_impl
#define FUN24_CODE float64_chi2_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_rvs(*X)
#include "owl_dense_common_map.c"

// chi2_pdf

#define FUN24 float32_chi2_pdf
#define FUN24_IMPL float32_chi2_pdf_impl
#define FUN24_CODE float32_chi2_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_pdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_pdf
#define FUN24_IMPL float64_chi2_pdf_impl
#define FUN24_CODE float64_chi2_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_pdf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_logpdf

#define FUN24 float32_chi2_logpdf
#define FUN24_IMPL float32_chi2_logpdf_impl
#define FUN24_CODE float32_chi2_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_logpdf
#define FUN24_IMPL float64_chi2_logpdf_impl
#define FUN24_CODE float64_chi2_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_cdf

#define FUN24 float32_chi2_cdf
#define FUN24_IMPL float32_chi2_cdf_impl
#define FUN24_CODE float32_chi2_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_cdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_cdf
#define FUN24_IMPL float64_chi2_cdf_impl
#define FUN24_CODE float64_chi2_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_cdf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_logcdf

#define FUN24 float32_chi2_logcdf
#define FUN24_IMPL float32_chi2_logcdf_impl
#define FUN24_CODE float32_chi2_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_logcdf
#define FUN24_IMPL float64_chi2_logcdf_impl
#define FUN24_CODE float64_chi2_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_ppf

#define FUN24 float32_chi2_ppf
#define FUN24_IMPL float32_chi2_ppf_impl
#define FUN24_CODE float32_chi2_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_ppf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_ppf
#define FUN24_IMPL float64_chi2_ppf_impl
#define FUN24_CODE float64_chi2_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_ppf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_sf

#define FUN24 float32_chi2_sf
#define FUN24_IMPL float32_chi2_sf_impl
#define FUN24_CODE float32_chi2_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_sf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_sf
#define FUN24_IMPL float64_chi2_sf_impl
#define FUN24_CODE float64_chi2_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_sf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_logsf

#define FUN24 float32_chi2_logsf
#define FUN24_IMPL float32_chi2_logsf_impl
#define FUN24_CODE float32_chi2_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_logsf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_logsf
#define FUN24_IMPL float64_chi2_logsf_impl
#define FUN24_CODE float64_chi2_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_logsf(*X, *Y)
#include "owl_dense_common_map.c"

// chi2_isf

#define FUN24 float32_chi2_isf
#define FUN24_IMPL float32_chi2_isf_impl
#define FUN24_CODE float32_chi2_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = chi2_isf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_chi2_isf
#define FUN24_IMPL float64_chi2_isf_impl
#define FUN24_CODE float64_chi2_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = chi2_isf(*X, *Y)
#include "owl_dense_common_map.c"

// f_rvs

#define FUN25 float32_f_rvs
#define FUN25_IMPL float32_f_rvs_impl
#define FUN25_CODE float32_f_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_rvs
#define FUN25_IMPL float64_f_rvs_impl
#define FUN25_CODE float64_f_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// f_pdf

#define FUN25 float32_f_pdf
#define FUN25_IMPL float32_f_pdf_impl
#define FUN25_CODE float32_f_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_pdf
#define FUN25_IMPL float64_f_pdf_impl
#define FUN25_CODE float64_f_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_logpdf

#define FUN25 float32_f_logpdf
#define FUN25_IMPL float32_f_logpdf_impl
#define FUN25_CODE float32_f_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_logpdf
#define FUN25_IMPL float64_f_logpdf_impl
#define FUN25_CODE float64_f_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_cdf

#define FUN25 float32_f_cdf
#define FUN25_IMPL float32_f_cdf_impl
#define FUN25_CODE float32_f_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_cdf
#define FUN25_IMPL float64_f_cdf_impl
#define FUN25_CODE float64_f_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_logcdf

#define FUN25 float32_f_logcdf
#define FUN25_IMPL float32_f_logcdf_impl
#define FUN25_CODE float32_f_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_logcdf
#define FUN25_IMPL float64_f_logcdf_impl
#define FUN25_CODE float64_f_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_ppf

#define FUN25 float32_f_ppf
#define FUN25_IMPL float32_f_ppf_impl
#define FUN25_CODE float32_f_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_ppf
#define FUN25_IMPL float64_f_ppf_impl
#define FUN25_CODE float64_f_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_sf

#define FUN25 float32_f_sf
#define FUN25_IMPL float32_f_sf_impl
#define FUN25_CODE float32_f_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_sf
#define FUN25_IMPL float64_f_sf_impl
#define FUN25_CODE float64_f_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_logsf

#define FUN25 float32_f_logsf
#define FUN25_IMPL float32_f_logsf_impl
#define FUN25_CODE float32_f_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_logsf
#define FUN25_IMPL float64_f_logsf_impl
#define FUN25_CODE float64_f_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// f_isf

#define FUN25 float32_f_isf
#define FUN25_IMPL float32_f_isf_impl
#define FUN25_CODE float32_f_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = f_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_f_isf
#define FUN25_IMPL float64_f_isf_impl
#define FUN25_CODE float64_f_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = f_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_rvs

#define FUN25 float32_cauchy_rvs
#define FUN25_IMPL float32_cauchy_rvs_impl
#define FUN25_CODE float32_cauchy_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_rvs
#define FUN25_IMPL float64_cauchy_rvs_impl
#define FUN25_CODE float64_cauchy_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// cauchy_pdf

#define FUN25 float32_cauchy_pdf
#define FUN25_IMPL float32_cauchy_pdf_impl
#define FUN25_CODE float32_cauchy_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_pdf
#define FUN25_IMPL float64_cauchy_pdf_impl
#define FUN25_CODE float64_cauchy_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_logpdf

#define FUN25 float32_cauchy_logpdf
#define FUN25_IMPL float32_cauchy_logpdf_impl
#define FUN25_CODE float32_cauchy_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_logpdf
#define FUN25_IMPL float64_cauchy_logpdf_impl
#define FUN25_CODE float64_cauchy_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_cdf

#define FUN25 float32_cauchy_cdf
#define FUN25_IMPL float32_cauchy_cdf_impl
#define FUN25_CODE float32_cauchy_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_cdf
#define FUN25_IMPL float64_cauchy_cdf_impl
#define FUN25_CODE float64_cauchy_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_logcdf

#define FUN25 float32_cauchy_logcdf
#define FUN25_IMPL float32_cauchy_logcdf_impl
#define FUN25_CODE float32_cauchy_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_logcdf
#define FUN25_IMPL float64_cauchy_logcdf_impl
#define FUN25_CODE float64_cauchy_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_ppf

#define FUN25 float32_cauchy_ppf
#define FUN25_IMPL float32_cauchy_ppf_impl
#define FUN25_CODE float32_cauchy_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_ppf
#define FUN25_IMPL float64_cauchy_ppf_impl
#define FUN25_CODE float64_cauchy_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_sf

#define FUN25 float32_cauchy_sf
#define FUN25_IMPL float32_cauchy_sf_impl
#define FUN25_CODE float32_cauchy_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_sf
#define FUN25_IMPL float64_cauchy_sf_impl
#define FUN25_CODE float64_cauchy_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_logsf

#define FUN25 float32_cauchy_logsf
#define FUN25_IMPL float32_cauchy_logsf_impl
#define FUN25_CODE float32_cauchy_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_logsf
#define FUN25_IMPL float64_cauchy_logsf_impl
#define FUN25_CODE float64_cauchy_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// cauchy_isf

#define FUN25 float32_cauchy_isf
#define FUN25_IMPL float32_cauchy_isf_impl
#define FUN25_CODE float32_cauchy_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = cauchy_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_cauchy_isf
#define FUN25_IMPL float64_cauchy_isf_impl
#define FUN25_CODE float64_cauchy_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = cauchy_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_rvs

#define FUN25 float32_lomax_rvs
#define FUN25_IMPL float32_lomax_rvs_impl
#define FUN25_CODE float32_lomax_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_rvs
#define FUN25_IMPL float64_lomax_rvs_impl
#define FUN25_CODE float64_lomax_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// lomax_pdf

#define FUN25 float32_lomax_pdf
#define FUN25_IMPL float32_lomax_pdf_impl
#define FUN25_CODE float32_lomax_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_pdf
#define FUN25_IMPL float64_lomax_pdf_impl
#define FUN25_CODE float64_lomax_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_logpdf

#define FUN25 float32_lomax_logpdf
#define FUN25_IMPL float32_lomax_logpdf_impl
#define FUN25_CODE float32_lomax_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_logpdf
#define FUN25_IMPL float64_lomax_logpdf_impl
#define FUN25_CODE float64_lomax_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_cdf

#define FUN25 float32_lomax_cdf
#define FUN25_IMPL float32_lomax_cdf_impl
#define FUN25_CODE float32_lomax_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_cdf
#define FUN25_IMPL float64_lomax_cdf_impl
#define FUN25_CODE float64_lomax_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_logcdf

#define FUN25 float32_lomax_logcdf
#define FUN25_IMPL float32_lomax_logcdf_impl
#define FUN25_CODE float32_lomax_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_logcdf
#define FUN25_IMPL float64_lomax_logcdf_impl
#define FUN25_CODE float64_lomax_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_ppf

#define FUN25 float32_lomax_ppf
#define FUN25_IMPL float32_lomax_ppf_impl
#define FUN25_CODE float32_lomax_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_ppf
#define FUN25_IMPL float64_lomax_ppf_impl
#define FUN25_CODE float64_lomax_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_sf

#define FUN25 float32_lomax_sf
#define FUN25_IMPL float32_lomax_sf_impl
#define FUN25_CODE float32_lomax_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_sf
#define FUN25_IMPL float64_lomax_sf_impl
#define FUN25_CODE float64_lomax_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_logsf

#define FUN25 float32_lomax_logsf
#define FUN25_IMPL float32_lomax_logsf_impl
#define FUN25_CODE float32_lomax_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_logsf
#define FUN25_IMPL float64_lomax_logsf_impl
#define FUN25_CODE float64_lomax_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lomax_isf

#define FUN25 float32_lomax_isf
#define FUN25_IMPL float32_lomax_isf_impl
#define FUN25_CODE float32_lomax_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lomax_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lomax_isf
#define FUN25_IMPL float64_lomax_isf_impl
#define FUN25_CODE float64_lomax_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lomax_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_rvs

#define FUN25 float32_weibull_rvs
#define FUN25_IMPL float32_weibull_rvs_impl
#define FUN25_CODE float32_weibull_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_rvs
#define FUN25_IMPL float64_weibull_rvs_impl
#define FUN25_CODE float64_weibull_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// weibull_pdf

#define FUN25 float32_weibull_pdf
#define FUN25_IMPL float32_weibull_pdf_impl
#define FUN25_CODE float32_weibull_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_pdf
#define FUN25_IMPL float64_weibull_pdf_impl
#define FUN25_CODE float64_weibull_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_logpdf

#define FUN25 float32_weibull_logpdf
#define FUN25_IMPL float32_weibull_logpdf_impl
#define FUN25_CODE float32_weibull_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_logpdf
#define FUN25_IMPL float64_weibull_logpdf_impl
#define FUN25_CODE float64_weibull_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_cdf

#define FUN25 float32_weibull_cdf
#define FUN25_IMPL float32_weibull_cdf_impl
#define FUN25_CODE float32_weibull_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_cdf
#define FUN25_IMPL float64_weibull_cdf_impl
#define FUN25_CODE float64_weibull_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_logcdf

#define FUN25 float32_weibull_logcdf
#define FUN25_IMPL float32_weibull_logcdf_impl
#define FUN25_CODE float32_weibull_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_logcdf
#define FUN25_IMPL float64_weibull_logcdf_impl
#define FUN25_CODE float64_weibull_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_ppf

#define FUN25 float32_weibull_ppf
#define FUN25_IMPL float32_weibull_ppf_impl
#define FUN25_CODE float32_weibull_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_ppf
#define FUN25_IMPL float64_weibull_ppf_impl
#define FUN25_CODE float64_weibull_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_sf

#define FUN25 float32_weibull_sf
#define FUN25_IMPL float32_weibull_sf_impl
#define FUN25_CODE float32_weibull_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_sf
#define FUN25_IMPL float64_weibull_sf_impl
#define FUN25_CODE float64_weibull_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_logsf

#define FUN25 float32_weibull_logsf
#define FUN25_IMPL float32_weibull_logsf_impl
#define FUN25_CODE float32_weibull_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_logsf
#define FUN25_IMPL float64_weibull_logsf_impl
#define FUN25_CODE float64_weibull_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// weibull_isf

#define FUN25 float32_weibull_isf
#define FUN25_IMPL float32_weibull_isf_impl
#define FUN25_CODE float32_weibull_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = weibull_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_weibull_isf
#define FUN25_IMPL float64_weibull_isf_impl
#define FUN25_CODE float64_weibull_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = weibull_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_rvs

#define FUN25 float32_laplace_rvs
#define FUN25_IMPL float32_laplace_rvs_impl
#define FUN25_CODE float32_laplace_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_rvs
#define FUN25_IMPL float64_laplace_rvs_impl
#define FUN25_CODE float64_laplace_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// laplace_pdf

#define FUN25 float32_laplace_pdf
#define FUN25_IMPL float32_laplace_pdf_impl
#define FUN25_CODE float32_laplace_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_pdf
#define FUN25_IMPL float64_laplace_pdf_impl
#define FUN25_CODE float64_laplace_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_logpdf

#define FUN25 float32_laplace_logpdf
#define FUN25_IMPL float32_laplace_logpdf_impl
#define FUN25_CODE float32_laplace_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_logpdf
#define FUN25_IMPL float64_laplace_logpdf_impl
#define FUN25_CODE float64_laplace_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_cdf

#define FUN25 float32_laplace_cdf
#define FUN25_IMPL float32_laplace_cdf_impl
#define FUN25_CODE float32_laplace_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_cdf
#define FUN25_IMPL float64_laplace_cdf_impl
#define FUN25_CODE float64_laplace_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_logcdf

#define FUN25 float32_laplace_logcdf
#define FUN25_IMPL float32_laplace_logcdf_impl
#define FUN25_CODE float32_laplace_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_logcdf
#define FUN25_IMPL float64_laplace_logcdf_impl
#define FUN25_CODE float64_laplace_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_ppf

#define FUN25 float32_laplace_ppf
#define FUN25_IMPL float32_laplace_ppf_impl
#define FUN25_CODE float32_laplace_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_ppf
#define FUN25_IMPL float64_laplace_ppf_impl
#define FUN25_CODE float64_laplace_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_sf

#define FUN25 float32_laplace_sf
#define FUN25_IMPL float32_laplace_sf_impl
#define FUN25_CODE float32_laplace_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_sf
#define FUN25_IMPL float64_laplace_sf_impl
#define FUN25_CODE float64_laplace_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_logsf

#define FUN25 float32_laplace_logsf
#define FUN25_IMPL float32_laplace_logsf_impl
#define FUN25_CODE float32_laplace_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_logsf
#define FUN25_IMPL float64_laplace_logsf_impl
#define FUN25_CODE float64_laplace_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// laplace_isf

#define FUN25 float32_laplace_isf
#define FUN25_IMPL float32_laplace_isf_impl
#define FUN25_CODE float32_laplace_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = laplace_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_laplace_isf
#define FUN25_IMPL float64_laplace_isf_impl
#define FUN25_CODE float64_laplace_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = laplace_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_rvs

#define FUN25 float32_gumbel1_rvs
#define FUN25_IMPL float32_gumbel1_rvs_impl
#define FUN25_CODE float32_gumbel1_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_rvs
#define FUN25_IMPL float64_gumbel1_rvs_impl
#define FUN25_CODE float64_gumbel1_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_pdf

#define FUN25 float32_gumbel1_pdf
#define FUN25_IMPL float32_gumbel1_pdf_impl
#define FUN25_CODE float32_gumbel1_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_pdf
#define FUN25_IMPL float64_gumbel1_pdf_impl
#define FUN25_CODE float64_gumbel1_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_logpdf

#define FUN25 float32_gumbel1_logpdf
#define FUN25_IMPL float32_gumbel1_logpdf_impl
#define FUN25_CODE float32_gumbel1_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_logpdf
#define FUN25_IMPL float64_gumbel1_logpdf_impl
#define FUN25_CODE float64_gumbel1_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_cdf

#define FUN25 float32_gumbel1_cdf
#define FUN25_IMPL float32_gumbel1_cdf_impl
#define FUN25_CODE float32_gumbel1_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_cdf
#define FUN25_IMPL float64_gumbel1_cdf_impl
#define FUN25_CODE float64_gumbel1_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_logcdf

#define FUN25 float32_gumbel1_logcdf
#define FUN25_IMPL float32_gumbel1_logcdf_impl
#define FUN25_CODE float32_gumbel1_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_logcdf
#define FUN25_IMPL float64_gumbel1_logcdf_impl
#define FUN25_CODE float64_gumbel1_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_ppf

#define FUN25 float32_gumbel1_ppf
#define FUN25_IMPL float32_gumbel1_ppf_impl
#define FUN25_CODE float32_gumbel1_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_ppf
#define FUN25_IMPL float64_gumbel1_ppf_impl
#define FUN25_CODE float64_gumbel1_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_sf

#define FUN25 float32_gumbel1_sf
#define FUN25_IMPL float32_gumbel1_sf_impl
#define FUN25_CODE float32_gumbel1_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_sf
#define FUN25_IMPL float64_gumbel1_sf_impl
#define FUN25_CODE float64_gumbel1_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_logsf

#define FUN25 float32_gumbel1_logsf
#define FUN25_IMPL float32_gumbel1_logsf_impl
#define FUN25_CODE float32_gumbel1_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_logsf
#define FUN25_IMPL float64_gumbel1_logsf_impl
#define FUN25_CODE float64_gumbel1_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel1_isf

#define FUN25 float32_gumbel1_isf
#define FUN25_IMPL float32_gumbel1_isf_impl
#define FUN25_CODE float32_gumbel1_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel1_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel1_isf
#define FUN25_IMPL float64_gumbel1_isf_impl
#define FUN25_CODE float64_gumbel1_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel1_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_rvs

#define FUN25 float32_gumbel2_rvs
#define FUN25_IMPL float32_gumbel2_rvs_impl
#define FUN25_CODE float32_gumbel2_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_rvs
#define FUN25_IMPL float64_gumbel2_rvs_impl
#define FUN25_CODE float64_gumbel2_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_pdf

#define FUN25 float32_gumbel2_pdf
#define FUN25_IMPL float32_gumbel2_pdf_impl
#define FUN25_CODE float32_gumbel2_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_pdf
#define FUN25_IMPL float64_gumbel2_pdf_impl
#define FUN25_CODE float64_gumbel2_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_logpdf

#define FUN25 float32_gumbel2_logpdf
#define FUN25_IMPL float32_gumbel2_logpdf_impl
#define FUN25_CODE float32_gumbel2_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_logpdf
#define FUN25_IMPL float64_gumbel2_logpdf_impl
#define FUN25_CODE float64_gumbel2_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_cdf

#define FUN25 float32_gumbel2_cdf
#define FUN25_IMPL float32_gumbel2_cdf_impl
#define FUN25_CODE float32_gumbel2_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_cdf
#define FUN25_IMPL float64_gumbel2_cdf_impl
#define FUN25_CODE float64_gumbel2_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_logcdf

#define FUN25 float32_gumbel2_logcdf
#define FUN25_IMPL float32_gumbel2_logcdf_impl
#define FUN25_CODE float32_gumbel2_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_logcdf
#define FUN25_IMPL float64_gumbel2_logcdf_impl
#define FUN25_CODE float64_gumbel2_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_ppf

#define FUN25 float32_gumbel2_ppf
#define FUN25_IMPL float32_gumbel2_ppf_impl
#define FUN25_CODE float32_gumbel2_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_ppf
#define FUN25_IMPL float64_gumbel2_ppf_impl
#define FUN25_CODE float64_gumbel2_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_sf

#define FUN25 float32_gumbel2_sf
#define FUN25_IMPL float32_gumbel2_sf_impl
#define FUN25_CODE float32_gumbel2_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_sf
#define FUN25_IMPL float64_gumbel2_sf_impl
#define FUN25_CODE float64_gumbel2_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_logsf

#define FUN25 float32_gumbel2_logsf
#define FUN25_IMPL float32_gumbel2_logsf_impl
#define FUN25_CODE float32_gumbel2_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_logsf
#define FUN25_IMPL float64_gumbel2_logsf_impl
#define FUN25_CODE float64_gumbel2_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// gumbel2_isf

#define FUN25 float32_gumbel2_isf
#define FUN25_IMPL float32_gumbel2_isf_impl
#define FUN25_CODE float32_gumbel2_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gumbel2_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_gumbel2_isf
#define FUN25_IMPL float64_gumbel2_isf_impl
#define FUN25_CODE float64_gumbel2_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gumbel2_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_rvs

#define FUN25 float32_logistic_rvs
#define FUN25_IMPL float32_logistic_rvs_impl
#define FUN25_CODE float32_logistic_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_rvs
#define FUN25_IMPL float64_logistic_rvs_impl
#define FUN25_CODE float64_logistic_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// logistic_pdf

#define FUN25 float32_logistic_pdf
#define FUN25_IMPL float32_logistic_pdf_impl
#define FUN25_CODE float32_logistic_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_pdf
#define FUN25_IMPL float64_logistic_pdf_impl
#define FUN25_CODE float64_logistic_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_logpdf

#define FUN25 float32_logistic_logpdf
#define FUN25_IMPL float32_logistic_logpdf_impl
#define FUN25_CODE float32_logistic_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_logpdf
#define FUN25_IMPL float64_logistic_logpdf_impl
#define FUN25_CODE float64_logistic_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_cdf

#define FUN25 float32_logistic_cdf
#define FUN25_IMPL float32_logistic_cdf_impl
#define FUN25_CODE float32_logistic_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_cdf
#define FUN25_IMPL float64_logistic_cdf_impl
#define FUN25_CODE float64_logistic_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_logcdf

#define FUN25 float32_logistic_logcdf
#define FUN25_IMPL float32_logistic_logcdf_impl
#define FUN25_CODE float32_logistic_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_logcdf
#define FUN25_IMPL float64_logistic_logcdf_impl
#define FUN25_CODE float64_logistic_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_ppf

#define FUN25 float32_logistic_ppf
#define FUN25_IMPL float32_logistic_ppf_impl
#define FUN25_CODE float32_logistic_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_ppf
#define FUN25_IMPL float64_logistic_ppf_impl
#define FUN25_CODE float64_logistic_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_sf

#define FUN25 float32_logistic_sf
#define FUN25_IMPL float32_logistic_sf_impl
#define FUN25_CODE float32_logistic_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_sf
#define FUN25_IMPL float64_logistic_sf_impl
#define FUN25_CODE float64_logistic_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_logsf

#define FUN25 float32_logistic_logsf
#define FUN25_IMPL float32_logistic_logsf_impl
#define FUN25_CODE float32_logistic_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_logsf
#define FUN25_IMPL float64_logistic_logsf_impl
#define FUN25_CODE float64_logistic_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// logistic_isf

#define FUN25 float32_logistic_isf
#define FUN25_IMPL float32_logistic_isf_impl
#define FUN25_CODE float32_logistic_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = logistic_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_logistic_isf
#define FUN25_IMPL float64_logistic_isf_impl
#define FUN25_CODE float64_logistic_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = logistic_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_rvs

#define FUN25 float32_lognormal_rvs
#define FUN25_IMPL float32_lognormal_rvs_impl
#define FUN25_CODE float32_lognormal_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_rvs
#define FUN25_IMPL float64_lognormal_rvs_impl
#define FUN25_CODE float64_lognormal_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_rvs(*X, *Y)
#include "owl_dense_common_map.c"

// lognormal_pdf

#define FUN25 float32_lognormal_pdf
#define FUN25_IMPL float32_lognormal_pdf_impl
#define FUN25_CODE float32_lognormal_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_pdf
#define FUN25_IMPL float64_lognormal_pdf_impl
#define FUN25_CODE float64_lognormal_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_pdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_logpdf

#define FUN25 float32_lognormal_logpdf
#define FUN25_IMPL float32_lognormal_logpdf_impl
#define FUN25_CODE float32_lognormal_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_logpdf
#define FUN25_IMPL float64_lognormal_logpdf_impl
#define FUN25_CODE float64_lognormal_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_logpdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_cdf

#define FUN25 float32_lognormal_cdf
#define FUN25_IMPL float32_lognormal_cdf_impl
#define FUN25_CODE float32_lognormal_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_cdf
#define FUN25_IMPL float64_lognormal_cdf_impl
#define FUN25_CODE float64_lognormal_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_cdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_logcdf

#define FUN25 float32_lognormal_logcdf
#define FUN25_IMPL float32_lognormal_logcdf_impl
#define FUN25_CODE float32_lognormal_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_logcdf
#define FUN25_IMPL float64_lognormal_logcdf_impl
#define FUN25_CODE float64_lognormal_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_logcdf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_ppf

#define FUN25 float32_lognormal_ppf
#define FUN25_IMPL float32_lognormal_ppf_impl
#define FUN25_CODE float32_lognormal_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_ppf
#define FUN25_IMPL float64_lognormal_ppf_impl
#define FUN25_CODE float64_lognormal_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_ppf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_sf

#define FUN25 float32_lognormal_sf
#define FUN25_IMPL float32_lognormal_sf_impl
#define FUN25_CODE float32_lognormal_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_sf
#define FUN25_IMPL float64_lognormal_sf_impl
#define FUN25_CODE float64_lognormal_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_sf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_logsf

#define FUN25 float32_lognormal_logsf
#define FUN25_IMPL float32_lognormal_logsf_impl
#define FUN25_CODE float32_lognormal_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_logsf
#define FUN25_IMPL float64_lognormal_logsf_impl
#define FUN25_CODE float64_lognormal_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_logsf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// lognormal_isf

#define FUN25 float32_lognormal_isf
#define FUN25_IMPL float32_lognormal_isf_impl
#define FUN25_CODE float32_lognormal_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = lognormal_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_lognormal_isf
#define FUN25_IMPL float64_lognormal_isf_impl
#define FUN25_CODE float64_lognormal_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = lognormal_isf(*Z, *X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_rvs

#define FUN24 float32_rayleigh_rvs
#define FUN24_IMPL float32_rayleigh_rvs_impl
#define FUN24_CODE float32_rayleigh_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_rvs(*X)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_rvs
#define FUN24_IMPL float64_rayleigh_rvs_impl
#define FUN24_CODE float64_rayleigh_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_rvs(*X)
#include "owl_dense_common_map.c"

// rayleigh_pdf

#define FUN24 float32_rayleigh_pdf
#define FUN24_IMPL float32_rayleigh_pdf_impl
#define FUN24_CODE float32_rayleigh_pdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_pdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_pdf
#define FUN24_IMPL float64_rayleigh_pdf_impl
#define FUN24_CODE float64_rayleigh_pdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_pdf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_logpdf

#define FUN24 float32_rayleigh_logpdf
#define FUN24_IMPL float32_rayleigh_logpdf_impl
#define FUN24_CODE float32_rayleigh_logpdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_logpdf
#define FUN24_IMPL float64_rayleigh_logpdf_impl
#define FUN24_CODE float64_rayleigh_logpdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_logpdf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_cdf

#define FUN24 float32_rayleigh_cdf
#define FUN24_IMPL float32_rayleigh_cdf_impl
#define FUN24_CODE float32_rayleigh_cdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_cdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_cdf
#define FUN24_IMPL float64_rayleigh_cdf_impl
#define FUN24_CODE float64_rayleigh_cdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_cdf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_logcdf

#define FUN24 float32_rayleigh_logcdf
#define FUN24_IMPL float32_rayleigh_logcdf_impl
#define FUN24_CODE float32_rayleigh_logcdf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_logcdf
#define FUN24_IMPL float64_rayleigh_logcdf_impl
#define FUN24_CODE float64_rayleigh_logcdf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_logcdf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_ppf

#define FUN24 float32_rayleigh_ppf
#define FUN24_IMPL float32_rayleigh_ppf_impl
#define FUN24_CODE float32_rayleigh_ppf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_ppf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_ppf
#define FUN24_IMPL float64_rayleigh_ppf_impl
#define FUN24_CODE float64_rayleigh_ppf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_ppf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_sf

#define FUN24 float32_rayleigh_sf
#define FUN24_IMPL float32_rayleigh_sf_impl
#define FUN24_CODE float32_rayleigh_sf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_sf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_sf
#define FUN24_IMPL float64_rayleigh_sf_impl
#define FUN24_CODE float64_rayleigh_sf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_sf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_logsf

#define FUN24 float32_rayleigh_logsf
#define FUN24_IMPL float32_rayleigh_logsf_impl
#define FUN24_CODE float32_rayleigh_logsf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_logsf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_logsf
#define FUN24_IMPL float64_rayleigh_logsf_impl
#define FUN24_CODE float64_rayleigh_logsf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_logsf(*X, *Y)
#include "owl_dense_common_map.c"

// rayleigh_isf

#define FUN24 float32_rayleigh_isf
#define FUN24_IMPL float32_rayleigh_isf_impl
#define FUN24_CODE float32_rayleigh_isf_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = rayleigh_isf(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN24 float64_rayleigh_isf
#define FUN24_IMPL float64_rayleigh_isf_impl
#define FUN24_CODE float64_rayleigh_isf_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = rayleigh_isf(*X, *Y)
#include "owl_dense_common_map.c"

//////////////////// function templates ends ////////////////////
