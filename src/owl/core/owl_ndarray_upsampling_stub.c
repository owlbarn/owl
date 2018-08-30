/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include <string.h>


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUN_NATIVE(dim) stub_float32_ndarray_upsampling ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float32_ndarray_upsampling ## _ ## dim  ## _ ## bytecode
#define TYPE float
#define INIT
#include "owl_ndarray_upsampling_impl.h"
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE

#define FUN_NATIVE(dim) stub_float64_ndarray_upsampling ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_float64_ndarray_upsampling ## _ ## dim  ## _ ## bytecode
#define TYPE double
#define INIT
#include "owl_ndarray_upsampling_impl.h"
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE

#define FUN_NATIVE(dim) stub_complex32_ndarray_upsampling ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex32_ndarray_upsampling ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex float
#define INIT
#include "owl_ndarray_upsampling_impl.h"
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE

#define FUN_NATIVE(dim) stub_complex64_ndarray_upsampling ## _ ## dim  ## _ ## native
#define FUN_BYTE(dim) stub_complex64_ndarray_upsampling ## _ ## dim  ## _ ## bytecode
#define TYPE _Complex double
#define INIT
#include "owl_ndarray_upsampling_impl.h"
#undef INIT
#undef TYPE
#undef FUN_BYTE
#undef FUN_NATIVE


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
