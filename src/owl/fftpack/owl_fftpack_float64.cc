/*
 * OWL - OCaml Scientific Computing
 * Copyright (c) 2016-2022 Liang Wang <liang@ocaml.xyz>
 */

#include <stdlib.h>
#include "owl_core.h"
#define Treal double

#define STUB_CFFT float64_cfft
#define STUB_CFFT_bytecode float64_cfft_bytecode
#define STUB_RFFTF float64_rfftf
#define STUB_RFFTB float64_rfftb
#define STUB_RDCT float64_dct
#define STUB_RDCT_bytecode float64_dct_bytecode
#define STUB_RDST float64_dst
#define STUB_RDST_bytecode float64_dst_bytecode

extern "C"
{
    value STUB_CFFT(value vForward, value vX, value vY, value vD, value vNorm, value vNthreads);
    value STUB_CFFT_bytecode(value *argv, int argn);
    value STUB_RFFTF(value vX, value vY, value vD, value vNorm, value vNthreads);
    value STUB_RFFTB(value vX, value vY, value vD, value vNorm, value vNthreads);
    value STUB_RDCT(value vX, value vY, value vD, value vType, value vNorm, value vOrtho, value vNthreads);
    value STUB_RDCT_bytecode(value *argv, int argn);
    value STUB_RDST(value vX, value vY, value vD, value vType, value vNorm, value vOrtho, value vNthreads);
    value STUB_RDST_bytecode(value *argv, int argn);
}

#include "owl_fftpack_impl.h"

#undef STUB_CFFT
#undef STUB_CFFT_bytecode
#undef STUB_RFFTF
#undef STUB_RFFTB
#undef STUB_RDCT
#undef STUB_RDCT_bytecode
#undef STUB_RDST
#undef STUB_RDST_bytecode

#undef Treal
