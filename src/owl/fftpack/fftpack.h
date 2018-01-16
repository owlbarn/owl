/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

/* Refer the doc on http://www.netlib.org/fftpack/doc */

#ifdef __cplusplus
extern "C" {
#endif

#define DOUBLE

#ifdef DOUBLE
#define Treal double
#else
#define Treal float
#endif

extern void owl_fftpack_cffti(int N, const Treal wsave[]);
extern void owl_fftpack_cfftf(int N, Treal c[], const Treal wsave[]);
extern void owl_fftpack_cfftb(int N, Treal c[], const Treal wsave[]);

extern void owl_fftpack_rffti(int N, const Treal wsave[]);
extern void owl_fftpack_rfftf(int N, Treal r[], const Treal wsave[]);
extern void owl_fftpack_rfftb(int N, Treal r[], const Treal wsave[]);

#ifdef __cplusplus
}
#endif
