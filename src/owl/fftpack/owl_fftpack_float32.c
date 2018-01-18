/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 */

#include <stdlib.h>

#include "owl_core.h"


#define Treal float

#define REAL_COPY owl_float32_copy
#define COMPLEX_COPY owl_complex32_copy
#define FFTPACK_CFFTI float32_fftpack_cffti
#define FFTPACK_CFFTF float32_fftpack_cfftf
#define FFTPACK_CFFTB float32_fftpack_cfftb
#define FFTPACK_RFFTI float32_fftpack_rffti
#define FFTPACK_RFFTF float32_fftpack_rfftf
#define FFTPACK_RFFTB float32_fftpack_rfftb
#define STUB_CFFTF float32_cfftf
#define STUB_CFFTB float32_cfftb
#define STUB_RFFTF float32_rfftf
#define STUB_RFFTB float32_rfftb

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
