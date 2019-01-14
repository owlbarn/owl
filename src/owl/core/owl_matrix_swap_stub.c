/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"
#include "owl_core_engine.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_matrix ## _ ## name
#define TYPE float
#define CONJ_FUN(X) X
#include OWL_MATRIX_SWAP_IMPL
#undef CONJ_FUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_matrix ## _ ## name
#define TYPE double
#define CONJ_FUN(X) X
#include OWL_MATRIX_SWAP_IMPL
#undef CONJ_FUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_matrix ## _ ## name
#define TYPE _Complex float
#define CONJ_FUN(X) conjf(X)
#include OWL_MATRIX_SWAP_IMPL
#undef CONJ_FUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_matrix ## _ ## name
#define TYPE _Complex double
#define CONJ_FUN(X) conj(X)
#include OWL_MATRIX_SWAP_IMPL
#undef CONJ_FUN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
