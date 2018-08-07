/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(prefix, name) prefix ## _ ## float32_matrix ## _ ## name
#define TYPE float
#define CHECK_CONJ(X,Y) (X != Y)
#include "owl_matrix_check_impl.h"
#undef CHECK_CONJ
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## float64_matrix ## _ ## name
#define TYPE double
#define CHECK_CONJ(X,Y) (X != Y)
#include "owl_matrix_check_impl.h"
#undef CHECK_CONJ
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex32_matrix ## _ ## name
#define TYPE _Complex float
#define CHECK_CONJ(X,Y) (X != conjf(Y))
#include "owl_matrix_check_impl.h"
#undef CHECK_CONJ
#undef TYPE
#undef FUNCTION


#define FUNCTION(prefix, name) prefix ## _ ## complex64_matrix ## _ ## name
#define TYPE _Complex double
#define CHECK_CONJ(X,Y) (X != conj(Y))
#include "owl_matrix_check_impl.h"
#undef CHECK_CONJ
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
