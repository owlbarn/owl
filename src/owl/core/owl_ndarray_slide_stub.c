/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_matrix ## _ ## name
#define TYPE float
#include "owl_ndarray_slide_impl.h"
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_matrix ## _ ## name
#define TYPE double
#include "owl_ndarray_slide_impl.h"
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_matrix ## _ ## name
#define TYPE _Complex float
#include "owl_ndarray_slide_impl.h"
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_matrix ## _ ## name
#define TYPE _Complex double
#include "owl_ndarray_slide_impl.h"
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
