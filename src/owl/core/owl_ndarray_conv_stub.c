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
#define INIT
#define ALPHA 1.
#define BETA 0.
#define GEMM cblas_sgemm
#include "owl_ndarray_conv_impl.c"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


#define FUN_NATIVE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INIT
#define ALPHA 1.
#define BETA 0.
#define GEMM cblas_dgemm
#include "owl_ndarray_conv_impl.c"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


#define FUN_NATIVE(dim) stub_complex32_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex32_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex float
#define INIT _Complex float alpha = 1., beta = 0.
#define ALPHA &alpha
#define BETA &beta
#define GEMM cblas_cgemm
#include "owl_ndarray_conv_impl.c"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


#define FUN_NATIVE(dim) stub_complex64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex double
#define INIT _Complex double alpha = 1., beta = 0.
#define ALPHA &alpha
#define BETA &beta
#define GEMM cblas_zgemm
#include "owl_ndarray_conv_impl.c"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
