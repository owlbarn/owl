/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_MACROS_H
#define OWL_MACROS_H

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>
#include <caml/signals.h>
#include <caml/threads.h>
#include <math.h>
#include "owl_stats.h"

// Define the structure for complex numbers

typedef struct { float r, i; } complex_float;

typedef struct { double r, i; } complex_double;

//  Other

#if defined(_MSC_VER)
  #define OWL_INLINE __inline
#elif defined(__GNUC__)
	#if defined(__STRICT_ANSI__)
		#define OWL_INLINE __inline__
	#else
		#define OWL_INLINE inline
	#endif
#else
  #define OWL_INLINE
#endif


#endif  /* OWL_MACROS_H */
