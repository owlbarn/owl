/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include <string.h>


//////////////////// function templates starts ////////////////////

#define OWL_ENABLE_TEMPLATE

#define OWL_NDARRAY_MAX
#define FUN_NATIVE(dim) stub_float32_ndarray_maxpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_maxpool ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define INITACC -INFINITY
#define ACCFN(a, b) if (a < b) a = b
#define UPDATEFN(a, b) a
#include "owl_ndarray_pool_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef INITACC
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_MAX


#define OWL_NDARRAY_AVG
#define FUN_NATIVE(dim) stub_float32_ndarray_avgpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_avgpool ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#include "owl_ndarray_pool_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_AVG


#define OWL_NDARRAY_MAX
#define FUN_NATIVE(dim) stub_float64_ndarray_maxpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_maxpool ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INITACC -INFINITY
#define ACCFN(a, b) if (a < b) a = b
#define UPDATEFN(a, b) a
#include "owl_ndarray_pool_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef INITACC
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_MAX


#define OWL_NDARRAY_AVG
#define FUN_NATIVE(dim) stub_float64_ndarray_avgpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_avgpool ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#include "owl_ndarray_pool_impl.c"
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_AVG


#define FUN_NATIVE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define GEMM cblas_sgemm
#include "owl_ndarray_conv.c"
#undef TYPE
#undef GEMM
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE

#define FUN_NATIVE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define GEMM cblas_dgemm
#include "owl_ndarray_conv.c"
#undef TYPE
#undef GEMM
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE

//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
