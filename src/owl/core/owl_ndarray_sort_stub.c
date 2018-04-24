/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray ## _ ## name
#define TYPE float
#define MAPFN(X) qsort(X,N,sizeof(float),float32_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray ## _ ## name
#define TYPE double
#define MAPFN(X) qsort(X,N,sizeof(double),float64_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray ## _ ## name
#define TYPE _Complex float
#define MAPFN(X) qsort(X,N,sizeof(_Complex float),complex32_cmpf)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray ## _ ## name
#define TYPE _Complex double
#define MAPFN(X) qsort(X,N,sizeof(_Complex double),complex64_cmpf)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int8_ndarray ## _ ## name
#define TYPE int8_t
#define MAPFN(X) qsort(X,N,sizeof(int8_t),int8_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## uint8_ndarray ## _ ## name
#define TYPE uint8_t
#define MAPFN(X) qsort(X,N,sizeof(uint8_t),uint8_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int16_ndarray ## _ ## name
#define TYPE int16_t
#define MAPFN(X) qsort(X,N,sizeof(int16_t),int16_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## uint16_ndarray ## _ ## name
#define TYPE uint16_t
#define MAPFN(X) qsort(X,N,sizeof(uint16_t),uint16_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int32_ndarray ## _ ## name
#define TYPE int32_t
#define MAPFN(X) qsort(X,N,sizeof(int32_t),int32_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int64_ndarray ## _ ## name
#define TYPE int64_t
#define MAPFN(X) qsort(X,N,sizeof(int64_t),int64_cmp)
#include "owl_ndarray_sort_impl.h"
#undef MAPFN
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
