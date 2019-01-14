/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"


/* FUN20 */

#define FUN20
#define BASE_FUN20 bl_float32_cumsum
#define BASE_FUN20_IMPL bl_float32_cumsum_impl
#define OMP_FUN20 omp_float32_cumsum
#define OMP_FUN20_IMPL omp_float32_cumsum_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X + *Y
#include "owl_aeos_tuner_fold_impl.h"

#define FUN20
#define BASE_FUN20 bl_float32_cumprod
#define BASE_FUN20_IMPL bl_float32_cumprod_impl
#define OMP_FUN20 omp_float32_cumprod
#define OMP_FUN20_IMPL omp_float32_cumprod_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X * *Y
#include "owl_aeos_tuner_fold_impl.h"

#define FUN20
#define BASE_FUN20 bl_float32_cummax
#define BASE_FUN20_IMPL bl_float32_cummax_impl
#define OMP_FUN20 omp_float32_cummax
#define OMP_FUN20_IMPL omp_float32_cummax_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = fmaxf(*X,*Y)
#include "owl_aeos_tuner_fold_impl.h"

#define FUN20
#define BASE_FUN20 bl_float32_repeat
#define BASE_FUN20_IMPL bl_float32_repeat_impl
#define OMP_FUN20 omp_float32_repeat
#define OMP_FUN20_IMPL omp_float32_repeat_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X
#include "owl_aeos_tuner_fold_impl.h"

#define FUN20
#define BASE_FUN20 bl_float32_diff
#define BASE_FUN20_IMPL bl_float32_diff_impl
#define OMP_FUN20 omp_float32_diff
#define OMP_FUN20_IMPL omp_float32_diff_impl
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X,Y) *Y = *X - *(X - ofsx)
#include "owl_aeos_tuner_fold_impl.h"
