/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define CLFUN01 owl_opencl_float32_erf
#define TYPE float
#define MAPFUN(X,Y) Y = erf(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_erfc
#define TYPE float
#define MAPFUN(X,Y) Y = erfc(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_abs
#define TYPE float
#define MAPFUN(X,Y) Y = fabs(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_neg
#define TYPE float
#define MAPFUN(X,Y) Y = -X
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sqr
#define TYPE float
#define MAPFUN(X,Y) Y = X * X
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sqrt
#define TYPE float
#define MAPFUN(X,Y) Y = sqrt(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_rsqrt
#define TYPE float
#define MAPFUN(X,Y) Y = rsqrt(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_cbrt
#define TYPE float
#define MAPFUN(X,Y) Y = cbrt(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_reci
#define TYPE float
#define MAPFUN(X,Y) Y = 1. / X
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sin
#define TYPE float
#define MAPFUN(X,Y) Y = sin(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_cos
#define TYPE float
#define MAPFUN(X,Y) Y = cos(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_tan
#define TYPE float
#define MAPFUN(X,Y) Y = tan(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_asin
#define TYPE float
#define MAPFUN(X,Y) Y = asin(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_acos
#define TYPE float
#define MAPFUN(X,Y) Y = acos(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_atan
#define TYPE float
#define MAPFUN(X,Y) Y = atan(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sinh
#define TYPE float
#define MAPFUN(X,Y) Y = sinh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_cosh
#define TYPE float
#define MAPFUN(X,Y) Y = cosh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_tanh
#define TYPE float
#define MAPFUN(X,Y) Y = tanh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_asinh
#define TYPE float
#define MAPFUN(X,Y) Y = asinh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_acosh
#define TYPE float
#define MAPFUN(X,Y) Y = acosh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_atanh
#define TYPE float
#define MAPFUN(X,Y) Y = atanh(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sinpi
#define TYPE float
#define MAPFUN(X,Y) Y = sinpi(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_cospi
#define TYPE float
#define MAPFUN(X,Y) Y = cospi(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_tanpi
#define TYPE float
#define MAPFUN(X,Y) Y = tanpi(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_floor
#define TYPE float
#define MAPFUN(X,Y) Y = floor(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_ceil
#define TYPE float
#define MAPFUN(X,Y) Y = ceil(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_round
#define TYPE float
#define MAPFUN(X,Y) Y = round(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_exp
#define TYPE float
#define MAPFUN(X,Y) Y = exp(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01

#define CLFUN01 owl_opencl_float32_exp2
#define TYPE float
#define MAPFUN(X,Y) Y = exp2(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_exp10
#define TYPE float
#define MAPFUN(X,Y) Y = exp10(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_expm1
#define TYPE float
#define MAPFUN(X,Y) Y = expm1(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_log
#define TYPE float
#define MAPFUN(X,Y) Y = log(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_log2
#define TYPE float
#define MAPFUN(X,Y) Y = log2(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_log10
#define TYPE float
#define MAPFUN(X,Y) Y = log10(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_log1p
#define TYPE float
#define MAPFUN(X,Y) Y = lop1p(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_logb
#define TYPE float
#define MAPFUN(X,Y) Y = logb(X)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_relu
#define TYPE float
#define MAPFUN(X,Y) Y = fmax(X, 0)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_signum
#define TYPE float
#define MAPFUN(X,Y) Y = (X > 0.) ? 1. : (X < 0.) ? -1. : 0.
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_sigmoid
#define TYPE float
#define MAPFUN(X,Y) Y = 1. / (1. + exp(-X))
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_softplus
#define TYPE float
#define MAPFUN(X,Y) Y = log1p(exp(X))
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN01 owl_opencl_float32_softsign
#define TYPE float
#define MAPFUN(X,Y) Y = X / (1. + fabs(X))
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN01


#define CLFUN02 owl_opencl_float32_add
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X + Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_sub
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X - Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_mul
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X * Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_div
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X / Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_pow
#define TYPE float
#define MAPFUN(X,Y,Z) Z = pow(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_min2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmin(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_max2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmax(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_fmod
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmod(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_hypot
#define TYPE float
#define MAPFUN(X,Y,Z) Z = hypot(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_atan2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_atan2pi
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2pi(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_equal
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X == Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_not_equal
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X != Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_less
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X < Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_greater
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X > Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_less_equal
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X <= Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN02 owl_opencl_float32_elt_greater_equal
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X >= Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN02


#define CLFUN03 owl_opencl_float32_add_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X + Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_sub_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X - Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_mul_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X * Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_div_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X / Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_pow_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = pow(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_fmod_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmod(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_atan2_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_atan2pi_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2pi(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_equal_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X == Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_not_equal_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X != Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_less_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X < Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_greater_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X > Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_less_equal_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X <= Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN03 owl_opencl_float32_elt_greater_equal_scalar
#define TYPE float
#define MAPFUN(X,Y,Z) Z = (X >= Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN03


#define CLFUN04 owl_opencl_float32_scalar_add
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X + Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_sub
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X - Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_mul
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X * Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_div
#define TYPE float
#define MAPFUN(X,Y,Z) Z = X / Y
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_pow
#define TYPE float
#define MAPFUN(X,Y,Z) Z = pow(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_fmod
#define TYPE float
#define MAPFUN(X,Y,Z) Z = fmod(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_atan2
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN04 owl_opencl_float32_scalar_atan2pi
#define TYPE float
#define MAPFUN(X,Y,Z) Z = atan2pi(X, Y)
#include "owl_opencl_kernel_map.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN04


#define CLFUN06 owl_opencl_float32_min_along
#define TYPE float
#define INITFUN(X,Y) Y = +INFINITY
#define MAPFUN(X,Y) Y = min(X, Y)
#include "owl_opencl_kernel_reduce.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN06


#define CLFUN06 owl_opencl_float32_max_along
#define TYPE float
#define INITFUN(X,Y) Y = -INFINITY
#define MAPFUN(X,Y) Y = max(X, Y)
#include "owl_opencl_kernel_reduce.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN06


#define CLFUN06 owl_opencl_float32_sum_along
#define TYPE float
#define INITFUN(X,Y) Y = 0.
#define MAPFUN(X,Y) Y += X
#include "owl_opencl_kernel_reduce.h"
#undef MAPFUN
#undef TYPE
#undef CLFUN06


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
