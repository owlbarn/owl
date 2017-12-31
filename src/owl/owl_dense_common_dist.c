/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_macros.h"


// dist_gaussian

#define FUN24 float32_dist_gaussian
#define FUN24_IMPL float32_dist_gaussian_impl
#define FUN24_CODE float32_dist_gaussian_code
#define NUMBER float
#define MAPFN(X,Y,Z) *Z = *X + *Y * f32_gaussian
#include "owl_dense_common_map.c"

#define FUN24 float64_dist_gaussian
#define FUN24_IMPL float64_dist_gaussian_impl
#define FUN24_CODE float64_dist_gaussian_code
#define NUMBER double
#define MAPFN(X,Y,Z) *Z = *X + *Y * f32_gaussian
#include "owl_dense_common_map.c"


//////////////////// function templates ends ////////////////////
