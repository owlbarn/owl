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


// SFMT PRNG and its internal state

#include "SFMT.h"

extern sfmt_t sfmt_state;

#define sfmt_rand32 sfmt_genrand_uint32(&sfmt_state)

#define sfmt_rand64 sfmt_genrand_uint64(&sfmt_state)

#define sfmt_f32_1 sfmt_genrand_real4(&sfmt_state)

#define sfmt_f32_2 sfmt_genrand_real5(&sfmt_state)

#define sfmt_f32_3 sfmt_genrand_real6(&sfmt_state)

#define sfmt_f64_1 sfmt_genrand_real1(&sfmt_state)

#define sfmt_f64_2 sfmt_genrand_real2(&sfmt_state)

#define sfmt_f64_3 sfmt_genrand_real3(&sfmt_state)


// Ziggurat PRNG and functions

extern float r4_exp ( uint32_t *jsr );
extern void r4_exp_setup ( );
extern float ziggurat_gaussian ( );
extern void ziggurat_init ( );
extern float r4_uni ( uint32_t *jsr );
extern uint32_t shr3_seeded ( uint32_t *jsr );


#endif  /* OWL_MACROS */
