/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"

#define FUN4
#define BASE_FUN4 bl_float32_reci
#define OMP_FUN4 omp_float32_reci
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1. / X)
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_abs
#define OMP_FUN4 omp_float32_abs
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fabsf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_abs2
#define OMP_FUN4 omp_float32_abs2
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_signum
#define OMP_FUN4 omp_float32_signum
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) ((X > 0.0) ? 1.0 : (X < 0.0) ? -1.0 : X)
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_sqr
#define OMP_FUN4 omp_float32_sqr
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X * X)
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_sqrt
#define OMP_FUN4 omp_float32_sqrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sqrtf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_cbrt
#define OMP_FUN4 omp_float32_cbrt
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cbrtf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_exp
#define OMP_FUN4 omp_float32_exp
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_expm1
#define OMP_FUN4 omp_float32_expm1
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (expm1f(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_log
#define OMP_FUN4 omp_float32_log
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (logf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_log1p
#define OMP_FUN4 omp_float32_log1p
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_sin
#define OMP_FUN4 omp_float32_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_cos
#define OMP_FUN4 omp_float32_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_tan
#define OMP_FUN4 omp_float32_tan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_asin
#define OMP_FUN4 omp_float32_asin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_acos
#define OMP_FUN4 omp_float32_acos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acosf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_atan
#define OMP_FUN4 omp_float32_atan
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_sinh
#define OMP_FUN4 omp_float32_sinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_cosh
#define OMP_FUN4 omp_float32_cosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (coshf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_tanh
#define OMP_FUN4 omp_float32_tanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (tanhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_asinh
#define OMP_FUN4 omp_float32_asinh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (asinhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_acosh
#define OMP_FUN4 omp_float32_acosh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (acoshf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_atanh
#define OMP_FUN4 omp_float32_atanh
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (atanhf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_erf
#define OMP_FUN4 omp_float32_erf
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erff(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_erfc
#define OMP_FUN4 omp_float32_erfc
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (erfcf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_logistic
#define OMP_FUN4 omp_float32_logistic
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_relu
#define OMP_FUN4 omp_float32_relu
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (fmaxf(X,0))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_softplus
#define OMP_FUN4 omp_float32_softplus
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (log1pf(expf(X)))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_softsign
#define OMP_FUN4 omp_float32_softsign
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (X / (1 + fabsf(X)))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4
#define BASE_FUN4 bl_float32_sigmoid
#define OMP_FUN4 omp_float32_sigmoid
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (1 / (1 + expf(-X)))
#include "owl_aeos_tuner_map_impl.h"

/* BASE_FUN15 */

// share with: approx_elt_equal, elt_not_equal, elt_less, elt_greater,
// elt_less_equal, elt_greater_equal
#define FUN15
#define BASE_FUN15 bl_float32_elt_equal
#define OMP_FUN15 omp_float32_elt_equal
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = (*X == *Y)
#include "owl_aeos_tuner_map_impl.h"

// share with sub
#define FUN15
#define BASE_FUN15 bl_float32_add
#define OMP_FUN15 omp_float32_add
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_aeos_tuner_map_impl.h"

#define FUN15
#define BASE_FUN15 bl_float32_mul
#define OMP_FUN15 omp_float32_mul
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X * *Y
#include "owl_aeos_tuner_map_impl.h"

#define FUN15
#define BASE_FUN15 bl_float32_div
#define OMP_FUN15 omp_float32_div
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_aeos_tuner_map_impl.h"

#define FUN15
#define BASE_FUN15 bl_float32_pow
#define OMP_FUN15 omp_float32_pow
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = powf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

#define FUN15
#define BASE_FUN15 bl_float32_hypot
#define OMP_FUN15 omp_float32_hypot
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = hypotf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

#define FUN15
#define BASE_FUN15 bl_float32_atan2
#define OMP_FUN15 omp_float32_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = atan2f(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

// share with min2
#define FUN15
#define BASE_FUN15 bl_float32_max2
#define OMP_FUN15 omp_float32_max2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fminf(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"

// share with fmod_scalar
#define FUN15
#define BASE_FUN15 bl_float32_fmod
#define OMP_FUN15 omp_float32_fmod
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = fmodf(*X, *Y)
#include "owl_aeos_tuner_map_impl.h"
