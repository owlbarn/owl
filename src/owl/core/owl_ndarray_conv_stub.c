/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "cblas.h"
#include <string.h>
#include <xmmintrin.h>
#include <immintrin.h>

#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUN_NATIVE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define INIT
#define ALPHA 1.
#define BETA 0.
#define GEMM cblas_sgemm
#define UTIL
#if defined(__AVX__)
  #define AVX_PSIZE 8
  #define ACX_FUN_LOAD(prefix, dim) prefix ## _ ## float32 ## _ ## dim
  #define AVX_SET(p, idx) \
    _mm256_set_ps(\
      p[idx + 7], p[idx + 6], p[idx + 5], p[idx + 4],\
      p[idx + 3], p[idx + 2], p[idx + 1], p[idx + 0])
  #define AVX_STORE _mm256_store_ps
#endif
#include "owl_ndarray_conv_impl.h"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#undef AVX_PSIZE
#undef ACX_FUN_LOAD
#undef AVX_SET
#undef AVX_STORE

#define FUN_NATIVE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INIT
/*#if defined(__AVX__)
  #define AVX_PSIZE 4
  #define ACX_FUN_LOAD(prefix, dim) prefix ## _ ## float64 ## _ ## dim
  #define AVX_SET(p, idx) \
    _mm256_set_pd(\
      p[idx + 3], p[idx + 2], p[idx + 1], p[idx + 0])
  #define AVX_STORE _mm256_store_pd
#endif */
#define ALPHA 1.
#define BETA 0.
#define GEMM cblas_dgemm
#include "owl_ndarray_conv_impl.h"
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
#include "owl_ndarray_conv_impl.h"
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
#include "owl_ndarray_conv_impl.h"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
