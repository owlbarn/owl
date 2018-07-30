/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define CLFUN50 owl_opencl_float32_zeros
#define TYPE float
#define MAPFUN(X) X = 0.
#include "owl_opencl_kernel_create_impl.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN50


#define CLFUN50 owl_opencl_float32_ones
#define TYPE float
#define MAPFUN(X) X = 1.
#include "owl_opencl_kernel_create_impl.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN50


#define CLFUN51 owl_opencl_float32_create
#define TYPE float
#define MAPFUN(X,Y) Y = X
#include "owl_opencl_kernel_create_impl.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN51


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
