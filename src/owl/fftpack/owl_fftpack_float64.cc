/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include <stdlib.h>
#define Treal double

extern "C"
{
#include "owl_core.h"
}

#define REAL_COPY owl_float64_copy
#define COMPLEX_COPY owl_complex64_copy
#define STUB_CFFT float64_cfft
#define STUB_CFFT_bytecode float64_cfft_bytecode
#define STUB_RFFTF float64_rfftf
#define STUB_RFFTB float64_rfftb
#define STUB_RDCT float64_dct
#define STUB_RDCT_bytecode float64_dct_bytecode
#define STUB_RDST float64_dst
#define STUB_RDST_bytecode float64_dst_bytecode

#include "owl_fftpack_impl.h"

#undef REAL_COPY
#undef COMPLEX_COPY
#undef STUB_CFFT
#undef STUB_CFFT_bytecode
#undef STUB_RFFTF
#undef STUB_RFFTB
#undef STUB_RDCT
#undef STUB_RDCT_bytecode
#undef STUB_RDST
#undef STUB_RDST_bytecode

#undef Treal
