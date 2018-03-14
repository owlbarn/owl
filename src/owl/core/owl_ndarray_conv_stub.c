/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "cblas.h"
#include <string.h>


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUN_NATIVE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define GEMM cblas_sgemm
#include "owl_ndarray_conv_impl.c"
#undef TYPE
#undef GEMM
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE


#define FUN_NATIVE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define GEMM cblas_dgemm
#include "owl_ndarray_conv_impl.c"
#undef TYPE
#undef GEMM
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
