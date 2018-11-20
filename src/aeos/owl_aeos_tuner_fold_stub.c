/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"
//#include <stdio.h>

#define FUN5
#define BASE_FUN5 bl_float32_sum
#define OMP_FUN5 omp_float32_sum
#define OMP_OP +
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_aeos_tuner_fold_impl.h"

#define FUN5
#define BASE_FUN5 bl_float32_prod
#define OMP_FUN5 omp_float32_prod
#define OMP_OP *
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A *= X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_aeos_tuner_fold_impl.h"

/* BASE_FUN20 */

#define BASE_FUN20 bl_float32_cumsum
#define BASE_FUN20_IMPL bl_float32_cumsum_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_aeos_tuner_fold_impl.h"

#define BASE_FUN20 bl_float32_cumprod
#define BASE_FUN20_IMPL bl_float32_cumprod_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_aeos_tuner_fold_impl.h"

// cummin
#define BASE_FUN20 bl_float32_cummax
#define BASE_FUN20_IMPL bl_float32_cummax_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_aeos_tuner_fold_impl.h"

#define BASE_FUN20 bl_float32_repeat
#define BASE_FUN20_IMPL bl_float32_repeat_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X
#include "owl_aeos_tuner_fold_impl.h"

#define BASE_FUN20 bl_float32_diff
#define BASE_FUN20_IMPL bl_float32_diff_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X - *(X - ofsx)
#include "owl_aeos_tuner_fold_impl.h"
