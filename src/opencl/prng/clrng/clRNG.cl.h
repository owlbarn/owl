
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

/*! @file clRNG.clh
 *  @brief Common definitions for the device-side API of clRNG
 *
 *  The definitions defined in this file are not documented here.  Refer to the
 *  documentation of clRNG.h.
 */

#pragma once
#ifndef CLRNG_CLH
#define CLRNG_CLH

#ifndef __OPENCL_C_VERSION__
#error "clRNG.clh can be included in device code only"
#endif

#define __CLRNG_DEVICE_API

#ifdef CLRNG_SINGLE_PRECISION
#define _CLRNG_FPTYPE cl_float
#else
#define _CLRNG_FPTYPE cl_double
#pragma OPENCL EXTENSION cl_amd_fp64 : enable
#endif

typedef double cl_double;
typedef float  cl_float;
typedef int    cl_int;
typedef uint   cl_uint;
typedef long   cl_long;
typedef ulong  cl_ulong;


#define _CLRNG_TAG_FPTYPE(name)           _CLRNG_TAG_FPTYPE_(name,_CLRNG_FPTYPE)
#define _CLRNG_TAG_FPTYPE_(name,fptype)   _CLRNG_TAG_FPTYPE__(name,fptype)
#define _CLRNG_TAG_FPTYPE__(name,fptype)  name##_##fptype



typedef enum clrngStatus_ {
    CLRNG_SUCCESS              = 0,
    CLRNG_INVALID_VALUE        = -1
} clrngStatus;

/*! This macro does nothing.
 *  It is defined for convenience when adapting host code for the device.
 */
#define clrngSetErrorString(err, ...) (err)


#endif

/*
    vim: ft=c sw=4
*/
