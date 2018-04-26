/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_ndarray ## _ ## name
#define TYPE float
#define CMPFN1 float32_cmp
#define CMPFN2 float32_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_ndarray ## _ ## name
#define TYPE double
#define CMPFN1 float64_cmp
#define CMPFN2 float64_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_ndarray ## _ ## name
#define TYPE _Complex float
#define CMPFN1 complex32_cmp
#define CMPFN2 complex32_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_ndarray ## _ ## name
#define TYPE _Complex double
#define CMPFN1 complex64_cmp
#define CMPFN2 complex64_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int8_ndarray ## _ ## name
#define TYPE int8_t
#define CMPFN1 int8_cmp
#define CMPFN2 int8_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## uint8_ndarray ## _ ## name
#define TYPE uint8_t
#define CMPFN1 uint8_cmp
#define CMPFN2 uint8_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int16_ndarray ## _ ## name
#define TYPE int16_t
#define CMPFN1 int16_cmp
#define CMPFN2 int16_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## uint16_ndarray ## _ ## name
#define TYPE uint16_t
#define CMPFN1 uint16_cmp
#define CMPFN2 uint16_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int32_ndarray ## _ ## name
#define TYPE int32_t
#define CMPFN1 int32_cmp
#define CMPFN2 int32_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## int64_ndarray ## _ ## name
#define TYPE int64_t
#define CMPFN1 int64_cmp
#define CMPFN2 int64_cmp_r
#include "owl_ndarray_sort_impl.h"
#undef CMPFN2
#undef CMPFN1
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
