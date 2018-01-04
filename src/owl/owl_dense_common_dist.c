/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"

//////////////////// function templates starts ////////////////////


// dist_uniform

#define FUN25 float32_dist_uniform
#define FUN25_IMPL float32_dist_uniform_impl
#define FUN25_CODE float32_dist_uniform_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X + (*Y - *X) * sfmt_f32_2
#include "owl_dense_common_map.c"

#define FUN25 float64_dist_uniform
#define FUN25_IMPL float64_dist_uniform_impl
#define FUN25_CODE float64_dist_uniform_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X + (*Y - *X) * sfmt_f64_2
#include "owl_dense_common_map.c"

// dist_gaussian

#define FUN25 float32_dist_gaussian
#define FUN25_IMPL float32_dist_gaussian_impl
#define FUN25_CODE float32_dist_gaussian_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = gaussian_rvs(*X, *Y)
#include "owl_dense_common_map.c"

#define FUN25 float64_dist_gaussian
#define FUN25_IMPL float64_dist_gaussian_impl
#define FUN25_CODE float64_dist_gaussian_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = gaussian_rvs(*X, *Y)
#include "owl_dense_common_map.c"



//////////////////// function templates ends ////////////////////
