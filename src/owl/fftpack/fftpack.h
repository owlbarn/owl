/*
 * OWL - OCaml Scientific and Engineering Computing
 * Copyright (c) 2016-2019 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

/* Refer the doc on http://www.netlib.org/fftpack/doc */

#ifdef __cplusplus
extern "C" {
#endif

// Single precision FFT

extern void float32_fftpack_cffti(int N, const float wsave[]);
extern void float32_fftpack_cfftf(int N, float c[], const float wsave[]);
extern void float32_fftpack_cfftb(int N, float c[], const float wsave[]);

extern void float32_fftpack_rffti(int N, const float wsave[]);
extern void float32_fftpack_rfftf(int N, float r[], const float wsave[]);
extern void float32_fftpack_rfftb(int N, float r[], const float wsave[]);

// Double precision FFT

extern void float64_fftpack_cffti(int N, const double wsave[]);
extern void float64_fftpack_cfftf(int N, double c[], const double wsave[]);
extern void float64_fftpack_cfftb(int N, double c[], const double wsave[]);

extern void float64_fftpack_rffti(int N, const double wsave[]);
extern void float64_fftpack_rfftf(int N, double r[], const double wsave[]);
extern void float64_fftpack_rfftb(int N, double r[], const double wsave[]);

#ifdef __cplusplus
}
#endif
