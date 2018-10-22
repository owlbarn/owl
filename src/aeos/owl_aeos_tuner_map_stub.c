/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <owl_macros.h>

#define FUN4 float32_sin
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (sinf(X))
#include "owl_aeos_tuner_map_impl.h"

#define FUN4 float32_cos
#define NUMBER float
#define NUMBER1 float
#define MAPFN(X) (cosf(X))
#include "owl_aeos_tuner_map_impl.h"
