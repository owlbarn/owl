/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <stdlib.h>

#include "owl_core.h"


#define Treal double

#define REAL_COPY owl_float64_copy
#define COMPLEX_COPY owl_complex64_copy
#define FFTPACK_CFFTI float64_fftpack_cffti
#define FFTPACK_CFFTF float64_fftpack_cfftf
#define FFTPACK_CFFTB float64_fftpack_cfftb
#define FFTPACK_RFFTI float64_fftpack_rffti
#define FFTPACK_RFFTF float64_fftpack_rfftf
#define FFTPACK_RFFTB float64_fftpack_rfftb
#define STUB_CFFTF float64_cfftf
#define STUB_CFFTB float64_cfftb
#define STUB_RFFTF float64_rfftf
#define STUB_RFFTB float64_rfftb

#include "owl_fftpack_stub.c"

#undef REAL_COPY
#undef COMPLEX_COPY
#undef FFTPACK_CFFTI
#undef FFTPACK_CFFTF
#undef FFTPACK_CFFTB
#undef FFTPACK_RFFTI
#undef FFTPACK_RFFTF
#undef FFTPACK_RFFTB
#undef STUB_CFFTF
#undef STUB_CFFTB
#undef STUB_RFFTF
#undef STUB_RFFTB

#undef Treal
