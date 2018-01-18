/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include "owl_core.h"


#define OWL_ENABLE_TEMPLATE

//////////////////// function templates starts ////////////////////


#define FUNCTION(b) owl_float32 ## _ ## a
#define TYPE float
#include "owl_core_swap_impl.c"
#undef TYPE
#undef FUNCTION


#define FUNCTION(b) owl_float64 ## _ ## a
#define TYPE double
#include "owl_core_swap_impl.c"
#undef TYPE
#undef FUNCTION


#define FUNCTION(b) owl_complex32 ## _ ## a
#define TYPE _Complex float
#include "owl_core_swap_impl.c"
#undef TYPE
#undef FUNCTION


#define FUNCTION(b) owl_complex64 ## _ ## a
#define TYPE _Complex double
#include "owl_core_swap_impl.c"
#undef TYPE
#undef FUNCTION


//////////////////// function templates ends ////////////////////

#undef OWL_ENABLE_TEMPLATE
