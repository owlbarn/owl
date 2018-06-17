
 /*
 ***********************************************************************
 Copyright (c) 2015 Advanced Micro Devices, Inc.
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 1. Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 ***********************************************************************
 */

/* @file private.c
 * @brief Implementation of functions defined in clRNG.h and private.h
 */
#include "clRNG.h"
#include "private.h"

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>

#define CASE_ERR_(code,msg) case code: base = msg; break
#define CASE_ERR(code)      CASE_ERR_(CLRNG_ ## code, MSG_ ## code)

char errorString[1024]				= "";

static const char MSG_DEFAULT[]                 = "unknown status";
static const char MSG_SUCCESS[]                 = "success";
static const char MSG_OUT_OF_RESOURCES[]        = "out of resources";
static const char MSG_INVALID_VALUE[]           = "invalid value";
static const char MSG_INVALID_RNG_TYPE[]        = "invalid type of RNG";
static const char MSG_INVALID_STREAM_CREATOR[]  = "invalid stream creator";
static const char MSG_INVALID_SEED[]            = "invalid seed";


clrngStatus clrngSetErrorString(cl_int err, const char* msg, ...)
{
    char formatted[1024];
    const char* base;
    switch (err) {
        CASE_ERR(SUCCESS);
        CASE_ERR(OUT_OF_RESOURCES);
        CASE_ERR(INVALID_VALUE);
        CASE_ERR(INVALID_RNG_TYPE);
        CASE_ERR(INVALID_STREAM_CREATOR);
        CASE_ERR(INVALID_SEED);
        default: base = MSG_DEFAULT;
    }
    va_list args;
    va_start(args, msg);
    vsprintf(formatted, msg, args);
    sprintf(errorString, "[%s] %s", base, formatted);
    va_end(args);
	return (clrngStatus)err;
}
