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


/* Default tunable OpemMP paramters */

#ifndef OWL_AEOS_PARAMS

#define OWL_OMP_THRESHOLD_RECI 0

#define OWL_OMP_THRESHOLD_ABS 100000

#define OWL_OMP_THRESHOLD_ABS2 28358

#define OWL_OMP_THRESHOLD_SIGNUM 100000

#define OWL_OMP_THRESHOLD_SQR 18227

#define OWL_OMP_THRESHOLD_SQRT 100000

#define OWL_OMP_THRESHOLD_CBRT 884

#define OWL_OMP_THRESHOLD_EXP 1698

#define OWL_OMP_THRESHOLD_EXPM1 0

#define OWL_OMP_THRESHOLD_LOG 0

#define OWL_OMP_THRESHOLD_LOG1P 0

#define OWL_OMP_THRESHOLD_SIN 159

#define OWL_OMP_THRESHOLD_COS 81

#define OWL_OMP_THRESHOLD_TAN 0

#define OWL_OMP_THRESHOLD_ASIN 0

#define OWL_OMP_THRESHOLD_ACOS 123

#define OWL_OMP_THRESHOLD_ATAN 0

#define OWL_OMP_THRESHOLD_SINH 0

#define OWL_OMP_THRESHOLD_COSH 0

#define OWL_OMP_THRESHOLD_TANH 166

#define OWL_OMP_THRESHOLD_ASINH 0

#define OWL_OMP_THRESHOLD_ACOSH 0

#define OWL_OMP_THRESHOLD_ATANH 466

#define OWL_OMP_THRESHOLD_ERF 47

#define OWL_OMP_THRESHOLD_ERFC 660

#define OWL_OMP_THRESHOLD_LOGISTIC 1980

#define OWL_OMP_THRESHOLD_RELU 85193

#define OWL_OMP_THRESHOLD_SOFTPLUS 0

#define OWL_OMP_THRESHOLD_SOFTSIGN 100000

#define OWL_OMP_THRESHOLD_SIGMOID 22711

#define OWL_OMP_THRESHOLD_CUMMAX 20000

#define OWL_OMP_THRESHOLD_DIFF 1000

#define OWL_OMP_THRESHOLD_CUMSUM 1000

#define OWL_OMP_THRESHOLD_CUMPROD 1000

#endif


#endif  /* OWL_MACROS_H */
