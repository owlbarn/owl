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


//////////////////// function templates ends ////////////////////
