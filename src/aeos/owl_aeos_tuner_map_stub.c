/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"

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

#define BASE_FUN15 bl_float32_add
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X + *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_div
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = *X / *Y
#include "owl_aeos_tuner_map_impl.h"

#define BASE_FUN15 bl_float32_atan2
#define NUMBER float
#define NUMBER1 float
#define NUMBER2 float
#define MAPFN(X,Y,Z) *Z = atan2f(*X,*Y)
#include "owl_aeos_tuner_map_impl.h"
