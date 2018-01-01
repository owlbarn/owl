/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


#ifndef OWL_RANDOM_H
#define OWL_RANDOM_H

#include <math.h>


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

#define f32_exponential rng_std_exp()

#define f64_exponential rng_std_exp()

#define f32_gaussian rng_std_gaussian()

#define f64_gaussian rng_std_gaussian()

extern void ziggurat_init();

extern float rng_std_exp();

extern float rng_exp(float);

extern float rng_std_gaussian();

extern float rng_gaussian(float, float);

extern double rng_std_gamma();

extern double rng_gamma(double, double);

extern double rng_beta(double, double);



#endif // OWL_RANDOM_H
