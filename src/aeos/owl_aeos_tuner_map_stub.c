/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"

#define BASE_FUN4 bl_float32_reci
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1. / X)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_abs
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_abs2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_signum
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_sqr
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_sqrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sqrtf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_cbrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cbrtf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_exp
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_expm1
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expm1f(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_log
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (logf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_log1p
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_tan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (coshf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acoshf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erff(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_erfc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erfcf(X))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_logistic
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmaxf(X,0))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(expf(X)))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_softsign
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X / (1 + fabsf(X)))
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN4 bl_float32_sigmoid
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_aeos_tuner_map_impl.h"

/* BASE_FUN15 */

// elt_equal, elt_not_equal, elt_less, elt_greater,
// elt_less_equal, elt_greater_equal
#define BASE_FUN15 bl_float32_approx_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (fabsf(*X - *Y) < *Z)
#include "owl_aeos_tuner_map_impl.h"

//sub
#define BASE_FUN15 bl_float32_add
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_mul
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_div
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_pow
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = powf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_hypot
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = hypotf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = atan2f(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

//min2
#define BASE_FUN15 bl_float32_max2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fminf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

//fmod_scalar
#define BASE_FUN15 bl_float32_fmod
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fmodf(*X, *Y)
#include "owl_aeos_tuner_map_impl.h"

/* BASE_FUN20 */

#define BASE_FUN20 bl_float32_cumsum
#define BASE_FUN20_IMPL bl_float32_cumsum_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN20 bl_float32_cumprod
#define BASE_FUN20_IMPL bl_float32_cumprod_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_aeos_tuner_map_impl.h"

// cummin
#define BASE_FUN20 bl_float32_cummax
#define BASE_FUN20_IMPL bl_float32_cummax_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN20 bl_float32_repeat
#define BASE_FUN20_IMPL bl_float32_repeat_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN20 bl_float32_diff
#define BASE_FUN20_IMPL bl_float32_diff_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X - *(X - ofsx)
#include "owl_aeos_tuner_map_impl.h"
