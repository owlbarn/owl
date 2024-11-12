/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include <stdlib.h>

#define Treal float

extern "C"
{
#include "owl_core.h"
}

#define REAL_COPY owl_float32_copy
#define COMPLEX_COPY owl_complex32_copy
#define STUB_CFFT float32_cfft
#define STUB_CFFT_bytecode float32_cfft_bytecode
#define STUB_RFFTF float32_rfftf
#define STUB_RFFTB float32_rfftb
#define STUB_RDCT float32_dct
#define STUB_RDCT_bytecode float32_dct_bytecode
#define STUB_RDST float32_dst
#define STUB_RDST_bytecode float32_dst_bytecode

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
