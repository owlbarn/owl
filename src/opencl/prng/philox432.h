
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

/*  @file Philox432.h
*  @brief Specific interface for the Philox432 generator
*  @see clRNG_template.h
*/

#pragma once
#ifndef PHILOX432_H
#define PHILOX432_H

#include "clRNG.h"
#include <stdio.h>


/*  @brief State type of a Philox432 stream
*
*  The state is a seed consisting of a 128bits counter
*
*  @see clrngStreamState
*/

typedef struct clrngPhilox432SB_ {
	cl_uint msb, lsb;   //most significant bits, and the least significant bits
}clrngPhilox432SB;

typedef struct clrngPhilox432Counter_ {
	clrngPhilox432SB H, L;
} clrngPhilox432Counter;


typedef struct {
	clrngPhilox432Counter  ctr;  // 128 bits counter
	cl_uint  deck[4];            // this table hold the 4x32 generated uint from philox4x32(ctr,kry) function
	cl_uint deckIndex;           //the index of actual pregenerated integer to give to the user
} clrngPhilox432StreamState;


struct clrngPhilox432Stream_ {
	union {
		struct {
			clrngPhilox432StreamState states[3];
		};
		struct {
			clrngPhilox432StreamState current;
			clrngPhilox432StreamState initial;
			clrngPhilox432StreamState substream;
		};
	};
};

/*! @copybrief clrngStream
*  @see clrngStream
*/
typedef struct clrngPhilox432Stream_ clrngPhilox432Stream;

struct clrngPhilox432StreamCreator_;
/*! @copybrief clrngStreamCreator
*  @see clrngStreamCreator
*/
typedef struct clrngPhilox432StreamCreator_ clrngPhilox432StreamCreator;


#ifdef __cplusplus
extern "C" {
#endif

	/*! @copybrief clrngCopyStreamCreator()
	*  @see clrngCopyStreamCreator()
	*/
	CLRNGAPI clrngPhilox432StreamCreator* clrngPhilox432CopyStreamCreator(const clrngPhilox432StreamCreator* creator, clrngStatus* err);

	/*! @copybrief clrngDestroyStreamCreator()
	*  @see clrngDestroyStreamCreator()
	*/
	CLRNGAPI clrngStatus clrngPhilox432DestroyStreamCreator(clrngPhilox432StreamCreator* creator);

	/*! @copybrief clrngRewindStreamCreator()
	 *  @see clrngRewindStreamCreator()
	 */
	CLRNGAPI clrngStatus clrngPhilox432RewindStreamCreator(clrngPhilox432StreamCreator* creator);

	/*! @copybrief clrngSetBaseCreatorState()
	*  @see clrngSetBaseCreatorState()
	*/
	CLRNGAPI clrngStatus clrngPhilox432SetBaseCreatorState(clrngPhilox432StreamCreator* creator, const clrngPhilox432StreamState* baseState);

	/*! @copybrief clrngChangeStreamsSpacing()
	*  @see clrngChangeStreamsSpacing()
	*/
	CLRNGAPI clrngStatus clrngPhilox432ChangeStreamsSpacing(clrngPhilox432StreamCreator* creator, cl_int e, cl_int c);

	/*! @copybrief clrngAllocStreams()
	*  @see clrngAllocStreams()
	*/
	CLRNGAPI clrngPhilox432Stream* clrngPhilox432AllocStreams(size_t count, size_t* bufSize, clrngStatus* err);

	/*! @copybrief clrngDestroyStreams()
	*  @see clrngDestroyStreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432DestroyStreams(clrngPhilox432Stream* streams);

	/*! @copybrief clrngCreateOverStreams()
	*  @see clrngCreateOverStreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432CreateOverStreams(clrngPhilox432StreamCreator* creator, size_t count, clrngPhilox432Stream* streams);

	/*! @copybrief clrngCreateStreams()
	*  @see clrngCreateStreams()
	*/
	CLRNGAPI clrngPhilox432Stream* clrngPhilox432CreateStreams(clrngPhilox432StreamCreator* creator, size_t count, size_t* bufSize, clrngStatus* err);

	/*! @copybrief clrngCopyOverStreams()
	*  @see clrngCopyOverStreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432CopyOverStreams(size_t count, clrngPhilox432Stream* destStreams, const clrngPhilox432Stream* srcStreams);

	/*! @copybrief clrngCopyStreams()
	*  @see clrngCopyStreams()
	*/
	CLRNGAPI clrngPhilox432Stream* clrngPhilox432CopyStreams(size_t count, const clrngPhilox432Stream* streams, clrngStatus* err);

#define clrngPhilox432RandomU01          _CLRNG_TAG_FPTYPE(clrngPhilox432RandomU01)
#define clrngPhilox432RandomInteger      _CLRNG_TAG_FPTYPE(clrngPhilox432RandomInteger)
#define clrngPhilox432RandomU01Array     _CLRNG_TAG_FPTYPE(clrngPhilox432RandomU01Array)
#define clrngPhilox432RandomIntegerArray _CLRNG_TAG_FPTYPE(clrngPhilox432RandomIntegerArray)

	/*! @copybrief clrngRandomU01()
	*  @see clrngRandomU01()
	*/
	CLRNGAPI _CLRNG_FPTYPE clrngPhilox432RandomU01(clrngPhilox432Stream* stream);
	CLRNGAPI cl_float  clrngPhilox432RandomU01_cl_float (clrngPhilox432Stream* stream);
	CLRNGAPI cl_double clrngPhilox432RandomU01_cl_double(clrngPhilox432Stream* stream);

	/*! @copybrief clrngRandomInteger()
	*  @see clrngRandomInteger()
	*/
	CLRNGAPI cl_int clrngPhilox432RandomInteger(clrngPhilox432Stream* stream, cl_int i, cl_int j);
	CLRNGAPI cl_int clrngPhilox432RandomInteger_cl_float (clrngPhilox432Stream* stream, cl_int i, cl_int j);
	CLRNGAPI cl_int clrngPhilox432RandomInteger_cl_double(clrngPhilox432Stream* stream, cl_int i, cl_int j);

	/*! @copybrief clrngRandomU01Array()
	*  @see clrngRandomU01Array()
	*/
	CLRNGAPI clrngStatus clrngPhilox432RandomU01Array(clrngPhilox432Stream* stream, size_t count, _CLRNG_FPTYPE* buffer);
	CLRNGAPI clrngStatus clrngPhilox432RandomU01Array_cl_float (clrngPhilox432Stream* stream, size_t count, cl_float * buffer);
	CLRNGAPI clrngStatus clrngPhilox432RandomU01Array_cl_double(clrngPhilox432Stream* stream, size_t count, cl_double* buffer);

	/*! @copybrief clrngRandomIntegerArray()
	*  @see clrngRandomIntegerArray()
	*/
	CLRNGAPI clrngStatus clrngPhilox432RandomIntegerArray(clrngPhilox432Stream* stream, cl_int i, cl_int j, size_t count, cl_int* buffer);
	CLRNGAPI clrngStatus clrngPhilox432RandomIntegerArray_cl_float (clrngPhilox432Stream* stream, cl_int i, cl_int j, size_t count, cl_int* buffer);
	CLRNGAPI clrngStatus clrngPhilox432RandomIntegerArray_cl_double(clrngPhilox432Stream* stream, cl_int i, cl_int j, size_t count, cl_int* buffer);

	/*! @copybrief clrngRewindStreams()
	*  @see clrngRewindStreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432RewindStreams(size_t count, clrngPhilox432Stream* streams);

	/*! @copybrief clrngRewindSubstreams()
	*  @see clrngRewindSubstreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432RewindSubstreams(size_t count, clrngPhilox432Stream* streams);

	/*! @copybrief clrngForwardToNextSubstreams()
	*  @see clrngForwardToNextSubstreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432ForwardToNextSubstreams(size_t count, clrngPhilox432Stream* streams);

	/*! @copybrief clrngMakeSubstreams()
	*  @see clrngMakeSubstreams()
	*/
	CLRNGAPI clrngPhilox432Stream* clrngPhilox432MakeSubstreams(clrngPhilox432Stream* stream, size_t count, size_t* bufSize, clrngStatus* err);

	/*! @copybrief clrngMakeOverSubstreams()
	*  @see clrngMakeOverSubstreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432MakeOverSubstreams(clrngPhilox432Stream* stream, size_t count, clrngPhilox432Stream* substreams);

	/*! @copybrief clrngAdvanceStreams()
	*  @see clrngAdvanceStreams()
	*/
	CLRNGAPI clrngStatus clrngPhilox432AdvanceStreams(size_t count, clrngPhilox432Stream* streams, cl_int e, cl_int c);

	/*! @copybrief clrngDeviceRandomU01Array()
	*  @see clrngDeviceRandomU01Array()
	*/
#ifdef CLRNG_SINGLE_PRECISION
#define clrngPhilox432DeviceRandomU01Array(...) clrngPhilox432DeviceRandomU01Array_(__VA_ARGS__, CL_TRUE)
#else
#define clrngPhilox432DeviceRandomU01Array(...) clrngPhilox432DeviceRandomU01Array_(__VA_ARGS__, CL_FALSE)
#endif

	/** \internal
	 *  @brief Helper function for clrngPhilox432DeviceRandomU01Array()
	 */
	CLRNGAPI clrngStatus clrngPhilox432DeviceRandomU01Array_(size_t streamCount, cl_mem streams,
		size_t numberCount, cl_mem outBuffer, cl_uint numQueuesAndEvents,
		cl_command_queue* commQueues, cl_uint numWaitEvents,
		const cl_event* waitEvents, cl_event* outEvents, cl_bool singlePrecision);

	/*! @copybrief clrngWriteStreamInfo()
	*  @see clrngWriteStreamInfo()
	*/
	CLRNGAPI clrngStatus clrngPhilox432WriteStreamInfo(const clrngPhilox432Stream* stream, FILE *file);


#if 0
	CLRNGAPI clrngPhilox432Stream* clrngPhilox432GetStreamByIndex(clrngPhilox432Stream* stream, cl_uint index);
#endif


#ifdef __cplusplus
}
#endif



#endif
