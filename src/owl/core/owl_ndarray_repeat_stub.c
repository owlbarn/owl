/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray ## _ ## name
#define TYPE float
#define COPYFUN owl_float32_copy
#include "owl_ndarray_repeat_impl.h"
#undef COPYFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray ## _ ## name
#define TYPE double
#define COPYFUN owl_float64_copy
#include "owl_ndarray_repeat_impl.h"
#undef COPYFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray ## _ ## name
#define TYPE _Complex float
#define COPYFUN owl_complex32_copy
#include "owl_ndarray_repeat_impl.h"
#undef COPYFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray ## _ ## name
#define TYPE _Complex double
#define COPYFUN owl_complex64_copy
#include "owl_ndarray_repeat_impl.h"
#undef COPYFUN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
