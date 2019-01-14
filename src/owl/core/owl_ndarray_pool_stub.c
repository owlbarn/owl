/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "cblas.h"
#include <string.h>


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define OWL_NDARRAY_MAX
#define FUN_NATIVE(dim) stub_float32_ndarray_maxpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_maxpool ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define INITACC -INFINITY
#define ACCFN(a, b) if (a < b) a = b
#define UPDATEFN(a, b) a
#define PLT(a,b) a < b
#include "owl_ndarray_pool_impl.h"
#undef PLT
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
#define PLT(a,b) a < b
#include "owl_ndarray_pool_impl.h"
#undef PLT
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
#define PLT(a,b) a < b
#include "owl_ndarray_pool_impl.h"
#undef PLT
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
#define PLT(a,b) a < b
#include "owl_ndarray_pool_impl.h"
#undef PLT
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_AVG


#define OWL_NDARRAY_MAX
#define FUN_NATIVE(dim) stub_complex32_ndarray_maxpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex32_ndarray_maxpool ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex float
#define INITACC -INFINITY
#define ACCFN(a, b) if CLTF(a,b) a = b
#define UPDATEFN(a, b) a
#define PLT CLTF
#include "owl_ndarray_pool_impl.h"
#undef PLT
#undef UPDATEFN
#undef ACCFN
#undef INITACC
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_MAX


#define OWL_NDARRAY_AVG
#define FUN_NATIVE(dim) stub_complex32_ndarray_avgpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex32_ndarray_avgpool ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex float
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#define PLT CLTF
#include "owl_ndarray_pool_impl.h"
#undef PLT
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_AVG


#define OWL_NDARRAY_MAX
#define FUN_NATIVE(dim) stub_complex64_ndarray_maxpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex64_ndarray_maxpool ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex double
#define INITACC -INFINITY
#define ACCFN(a, b) if CLT(a,b) a = b
#define UPDATEFN(a, b) a
#define PLT CLT
#include "owl_ndarray_pool_impl.h"
#undef PLT
#undef UPDATEFN
#undef ACCFN
#undef INITACC
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_MAX


#define OWL_NDARRAY_AVG
#define FUN_NATIVE(dim) stub_complex64_ndarray_avgpool ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex64_ndarray_avgpool ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex double
#define INITACC 0.
#define ACCFN(a, b) a += b
#define UPDATEFN(a, b) a / b
#define PLT CLT
#include "owl_ndarray_pool_impl.h"
#undef PLT
#undef UPDATEFN
#undef ACCFN
#undef TYPE
#undef INITACC
#undef FUN_BYTE
#undef FUN_NATIVE
#undef OWL_NDARRAY_AVG


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
