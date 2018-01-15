/*
 * This file is part of tela the Tensor Language.
 * Copyright (c) 1994-1995 Pekka Janhunen
 */

#ifdef __cplusplus
extern "C" {
#endif

#define DOUBLE

#ifdef DOUBLE
#define Treal double
#else
#define Treal float
#endif

extern void owl_fftpack_cfftf(int N, Treal input[], const Treal output[]);
extern void owl_fftpack_cfftb(int N, Treal input[], const Treal output[]);

#ifdef __cplusplus
}
#endif
