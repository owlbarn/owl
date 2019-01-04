/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
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


#define CLFUN52 owl_opencl_float32_sequential
#define TYPE float
#define MAPFUN(X,START,STEP,I) X = START + I * STEP
#include "owl_opencl_kernel_create_impl.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN52


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
