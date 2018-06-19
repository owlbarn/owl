
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

/* @file clRNG.c
* @brief Implementation of functions defined in clRNG.h and private.h
*/

#include "clRNG.h"
#include "private.h"
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#ifdef _MSC_VER
#include <io.h>
#else
#include <unistd.h>
#endif

#define CASE_ERR_(code,msg) case code: base = msg; break
#define CASE_ERR(code)      CASE_ERR_(CLRNG_ ## code, MSG_ ## code)

extern char errorString[1024];

const char* clrngGetErrorString()
{
	return errorString;
}


static char lib_path_default1[] = "/usr";
static char lib_path_default1_check[] = "/usr/include/clRNG/clRNG.h";
static char lib_path_default2[] = ".";

const char* clrngGetLibraryRoot()
{
	const char* lib_path = getenv("CLRNG_ROOT");

	if (lib_path == NULL) {
		// check if lib_path_default1_check exists
		if (
#ifdef _MSC_VER
		_access(lib_path_default1_check, 0) != -1
#else
		access(lib_path_default1_check, F_OK) != -1
#endif
		)
			return lib_path_default1;
		// last resort
		return lib_path_default2;
	}
	else
		return lib_path;
}


static char lib_includes[1024];

const char* clrngGetLibraryDeviceIncludes(cl_int* err)
{
	if (err)
		*err = CLRNG_SUCCESS;

	int nbytes;
#ifdef _MSC_VER
	nbytes = sprintf_s(
#else
	nbytes = snprintf(
#endif
		lib_includes,
		sizeof(lib_includes),
		"-I\"%s/include\"",
		clrngGetLibraryRoot());

#ifdef _MSC_VER
	if (nbytes < 0) {
#else
	if (nbytes >= sizeof(lib_includes)) {
#endif
		if (err)
			*err = clrngSetErrorString(CLRNG_OUT_OF_RESOURCES, "value of CLRNG_ROOT too long (max = %u)", sizeof(lib_includes) - 16);
		return NULL;
	}
	return lib_includes;
	}
