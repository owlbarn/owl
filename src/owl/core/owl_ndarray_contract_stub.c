/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray ## _ ## name
#define TYPE float
#define MAPFUN(x, y) y += x
#include "owl_ndarray_contract_impl.c"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray ## _ ## name
#define TYPE double
#define MAPFUN(x, y) y += x
#include "owl_ndarray_contract_impl.c"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray ## _ ## name
#define TYPE _Complex float
#define MAPFUN(x, y) y += x
#include "owl_ndarray_contract_impl.c"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray ## _ ## name
#define TYPE _Complex double
#define MAPFUN(x, y) y += x
#include "owl_ndarray_contract_impl.c"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
