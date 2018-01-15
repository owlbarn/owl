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

extern void owl_fftpack_cfftf(int N, Treal data[], const Treal wrk[]);
extern void owl_fftpack_cfftb(int N, Treal data[], const Treal wrk[]);
extern void owl_fftpack_cffti(int N, Treal wrk[]);

extern void owl_fftpack_rfftf(int N, Treal data[], const Treal wrk[]);
extern void owl_fftpack_rfftb(int N, Treal data[], const Treal wrk[]);
extern void owl_fftpack_rffti(int N, Treal wrk[]);

#ifdef __cplusplus
}
#endif
