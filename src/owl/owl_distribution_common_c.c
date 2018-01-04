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

// exponential_rvs

#define FUN24 float32_exponential_rvs
#define FUN24_IMPL float32_exponential_rvs_impl
#define FUN24_CODE float32_exponential_rvs_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = exp_rvs(*X)
#include "owl_dense_common_map.c"

#define FUN24 float64_exponential_rvs
#define FUN24_IMPL float64_exponential_rvs_impl
#define FUN24_CODE float64_exponential_rvs_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = exp_rvs(*X)
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


//////////////////// function templates ends ////////////////////
