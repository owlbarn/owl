/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "cblas.h"
#include <string.h>
#include <assert.h>

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
#ifdef OWL_AVX
  #define AVX_PSIZE 8
  #define AVX_TYPE __m256
  #define ACX_FUN_LOAD(prefix, dim) prefix ## _ ## float32 ## _ ## dim
  #define AVX_STORE _mm256_store_ps
  #define AVX_LOAD _mm256_load_ps
  #define AVX_ADD _mm256_add_ps
#endif
#include "owl_ndarray_conv_impl.h"
#undef GEMM
#undef BETA
#undef ALPHA
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#ifdef OWL_AVX
  #undef AVX_PSIZE
  #undef AVX_TYPE
  #undef ACX_FUN_LOAD
  #undef AVX_STORE
  #undef AVX_LOAD
  #undef AVX_ADD
#endif

#define FUN_NATIVE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_conv ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INIT
#ifdef OWL_AVX
  #define AVX_PSIZE 4
  #define AVX_TYPE __m256d
  #define ACX_FUN_LOAD(prefix, dim) prefix ## _ ## float64 ## _ ## dim
  #define AVX_STORE _mm256_store_pd
  #define AVX_LOAD _mm256_load_pd
  #define AVX_ADD _mm256_add_pd
#endif
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
#ifdef OWL_AVX
  #undef AVX_PSIZE
  #undef AVX_TYPE
  #undef ACX_FUN_LOAD
  #undef AVX_STORE
  #undef AVX_LOAD
  #undef AVX_ADD
#endif


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
