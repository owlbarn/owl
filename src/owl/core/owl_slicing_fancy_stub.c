/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


// get_fancy function

#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray_get ## _ ## name
#define TYPE float
#define MAPFUN(x, y) y = x
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray_get ## _ ## name
#define TYPE double
#define MAPFUN(x, y) y = x
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray_get ## _ ## name
#define TYPE _Complex float
#define MAPFUN(x, y) y = x
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray_get ## _ ## name
#define TYPE _Complex double
#define MAPFUN(x, y) y = x
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


// set_fancy function

#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray_set ## _ ## name
#define TYPE float
#define MAPFUN(x, y) x = y
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray_set ## _ ## name
#define TYPE double
#define MAPFUN(x, y) x = y
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray_set ## _ ## name
#define TYPE _Complex float
#define MAPFUN(x, y) x = y
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray_set ## _ ## name
#define TYPE _Complex double
#define MAPFUN(x, y) x = y
#include "owl_slicing_fancy_impl.h"
#undef MAPFUN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
