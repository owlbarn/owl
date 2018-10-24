/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_aeos_macros.h"
#include <stdio.h>

#define BASE_FUN5 bl_float32_sum
#define INIT float r = 0.
#define NUMBER float
#define ACCFN(A,X) (A += X)
#define COPYNUM(X) (caml_copy_double(X))
#include "owl_aeos_tuner_fold_impl.h"

#define BASE_FUN26 bl_float32_prod_along
#define NUMBER float
#define NUMBER1 float
#define ACCFN(X,Y) *Y *= *X
#include "owl_aeos_tuner_fold_impl.h"
