/*
 * OWL - OCaml Scientific and Engineering Computing
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

#if defined(__AVX__)
  #define OWL_AVX
  #include <immintrin.h>
#endif

#include "owl_aeos_params_generated.h"


// Define the structure for complex numbers

typedef struct { float r, i; } complex_float;

typedef struct { double r, i; } complex_double;


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


// CPUID macros

#if defined(__i386__) || defined(_M_IX86) || defined(_X86_) || defined(__i386)
  #define OWL_ARCH_i386 1
#else
  #define OWL_ARCH_i386 0
#endif

#if defined(__x86_64__) || defined(_M_X64) || defined(__amd64)
  #define OWL_ARCH_x86_64 1
#else
  #define OWL_ARCH_x86_64 0
#endif

#if defined(__PIC__) && OWL_ARCH_i386
  #define CPUID(cpuinfo,func,id) \
    __asm__ __volatile__ ("xchgl %%ebx, %k1; cpuid; xchgl %%ebx,%k1": "=a" (cpuinfo[0]), "=&r" (cpuinfo[1]), "=c" (cpuinfo[2]), "=d" (cpuinfo[3]) : "a" (func), "c" (id));
#elif defined(__PIC__) && OWL_ARCH_x86_64
  #define CPUID(cpuinfo,func,id) \
    __asm__ __volatile__ ("xchg{q}\t{%%}rbx, %q1; cpuid; xchg{q}\t{%%}rbx, %q1": "=a" (cpuinfo[0]), "=&r" (cpuinfo[1]), "=c" (cpuinfo[2]), "=d" (cpuinfo[3]) : "0" (func), "2" (id));
#else
  #define CPUID(cpuinfo,func,id) \
    __asm__ __volatile__ ("cpuid": "=a" (cpuinfo[0]), "=b" (cpuinfo[1]), "=c" (cpuinfo[2]), "=d" (cpuinfo[3]) : "0" (func), "2" (id) );
#endif


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


// Default tunable OpemMP paramters

#ifndef OWL_AEOS_PARAMS_H

#define OMP_THRESHOLD 10000

#define OWL_OMP_THRESHOLD_RECI OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ABS OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ABS2 OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SIGNUM OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SQR OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SQRT OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_CBRT OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_EXP OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_EXPM1 OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_LOG OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_LOG1P OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SIN OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_COS OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_TAN OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ASIN OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ACOS OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ATAN OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SINH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_COSH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_TANH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ASINH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ACOSH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ATANH OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ERF OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_ERFC OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_LOGISTIC OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_RELU OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SOFTPLUS OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SOFTSIGN OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_SIGMOID OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_CUMMAX OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_DIFF OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_CUMSUM OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_CUMPROD OMP_THRESHOLD

#define OWL_OMP_THRESHOLD_REPEAT OMP_THRESHOLD

#endif


#endif  /* OWL_MACROS_H */
