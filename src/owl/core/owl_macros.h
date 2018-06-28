/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_MACROS_H
#define OWL_MACROS_H

#include <math.h>
#include <complex.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>
#include <caml/signals.h>
#include <caml/threads.h>


// Define the structure for complex numbers

typedef struct { float r, i; } complex_float;

typedef struct { double r, i; } complex_double;


// Define the stack structure

typedef struct _BLOCK {
  int h;    // header index of a block
  int d;    // dimension
  int ofsx; // corresponding offset of x
  int tag;  // bool, whether this block still has unexplored children
} BLOCK;



// Define macros for interfacing to foreign code

#define Array_length(v)        (Wosize_val(v))

#define Double_array_length(v) (Wosize_val(v) / Double_wosize)

#define Double_array_val(v)    ((double *)v)


// Basic maths macros

#define OWL_TRUE  1

#define OWL_FALSE 0

#define OWL_MIN(a,b) ({        \
  __typeof__ (a) _a = (a);     \
  __typeof__ (b) _b = (b);     \
  _a < _b ? _a : _b;           \
})

#define OWL_MAX(a,b) ({        \
  __typeof__ (a) _a = (a);     \
  __typeof__ (b) _b = (b);     \
  _a > _b ? _a : _b;           \
})


// Operation macros

#define SWAPCODE(TYPE, a, b, n) {     \
  size_t i = (n) / sizeof (TYPE);     \
  TYPE *ai = (TYPE *)(void *)(a);     \
  TYPE *bi = (TYPE *)(void *)(b);     \
  do {                                \
    TYPE t = *ai;                     \
    *ai++ = *bi;                      \
    *bi++ = t;                        \
  } while (--i > 0);                  \
}


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
