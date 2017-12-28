/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#ifndef OWL_MACROS
#define OWL_MACROS

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>
#include <caml/signals.h>
#include <caml/threads.h>

typedef struct { float r, i; } complex_float;

typedef struct { double r, i; } complex_double;


// PRNG and its internal state
#include "SFMT.h"

sfmt_t sfmt_state;

#define sfmt_randf1 sfmt_genrand_real1(&sfmt_state)

#define sfmt_randf2 sfmt_genrand_real2(&sfmt_state)

#define sfmt_randf3 sfmt_genrand_real3(&sfmt_state)


#endif  /* OWL_MACROS */
