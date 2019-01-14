/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION owl_opencl_float32_broadcast_add
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X + Y
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_sub
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X - Y
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_mul
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X * Y
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_div
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X / Y
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_pow
#define TYPE float
#define MAPFUN(X,Y,Z) Z = pow(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_min2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmin(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_max2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmax(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_fmod
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmod(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_hypot
#define TYPE float
#define MAPFUN(X,Y,Z) Z = hypot(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION owl_opencl_float32_broadcast_atan2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2(X, Y)
#include "owl_opencl_kernel_broadcast_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
