
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

/*! @file Philox432.c.h
*  @brief Code for the Philox432 generator common to the host and device
*/

#pragma once
#ifndef PRIVATE_PHILOX432_CH
#define PRIVATE_PHILOX432_CH

#include "philox.h" 

#define Philox432_NORM_cl_double    1.0 / 0x100000000L   // 1.0 /2^32
#define Philox432_NORM_cl_float     2.32830644e-010;

clrngPhilox432Counter clrngPhilox432Add(clrngPhilox432Counter a, clrngPhilox432Counter b)
{
	clrngPhilox432Counter c;

	c.L.lsb = a.L.lsb + b.L.lsb;
	c.L.msb = a.L.msb + b.L.msb + (c.L.lsb < a.L.lsb);

	c.H.lsb = a.H.lsb + b.H.lsb + (c.L.msb < a.L.msb);
	c.H.msb = a.H.msb + b.H.msb + (c.H.lsb < a.H.lsb);

	return c;
}

clrngPhilox432Counter clrngPhilox432Substract(clrngPhilox432Counter a, clrngPhilox432Counter b)
{
	clrngPhilox432Counter c;

	c.L.lsb = a.L.lsb - b.L.lsb;
	c.L.msb = a.L.msb - b.L.msb - (c.L.lsb > a.L.lsb);

	c.H.lsb = a.H.lsb - b.H.lsb - (c.L.msb > a.L.msb);
	c.H.msb = a.H.msb - b.H.msb - (c.H.lsb > a.H.lsb);

	return c;
}

clrngStatus clrngPhilox432CopyOverStreams(size_t count, clrngPhilox432Stream* destStreams, const clrngPhilox432Stream* srcStreams)
{
	//Check params
	if (!destStreams)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): destStreams cannot be NULL", __func__);
	if (!srcStreams)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): srcStreams cannot be NULL", __func__);

	for (size_t i = 0; i < count; i++)
		destStreams[i] = srcStreams[i];

	return CLRNG_SUCCESS;
}

void clrngPhilox432GenerateDeck(clrngPhilox432StreamState *currentState)
{
	//Default key
	philox4x32_key_t k = { { 0, 0 } };

	//get the currect state
	philox4x32_ctr_t c = { { 0 } };
	c.v[0] = currentState->ctr.L.lsb;
	c.v[1] = currentState->ctr.L.msb;
	c.v[2] = currentState->ctr.H.lsb;
	c.v[3] = currentState->ctr.H.msb;

	//Generate 4 uint and store them into the stream state
	philox4x32_ctr_t r = philox4x32(c, k);
	currentState->deck[3] = r.v[0];
	currentState->deck[2] = r.v[1];
	currentState->deck[1] = r.v[2];
	currentState->deck[0] = r.v[3];
}

/*! @brief Advance the rng one step
*/
static cl_uint clrngPhilox432NextState(clrngPhilox432StreamState *currentState) {

	if ((currentState->deckIndex == 0))
	{
		clrngPhilox432GenerateDeck(currentState);

	}

	cl_uint result = currentState->deck[currentState->deckIndex];

	currentState->deckIndex++;

	// Advance to the next Counter.
	if (currentState->deckIndex == 4) {

		clrngPhilox432Counter incBy1 = { { 0, 0 }, { 0, 1 } };
		currentState->ctr = clrngPhilox432Add(currentState->ctr, incBy1);

		currentState->deckIndex = 0;
		clrngPhilox432GenerateDeck(currentState);
	}

	return result;

}
// The following would be much cleaner with C++ templates instead of macros.

// We use an underscore on the r.h.s. to avoid potential recursion with certain
// preprocessors.
#define IMPLEMENT_GENERATE_FOR_TYPE(fptype) \
	\
	fptype clrngPhilox432RandomU01_##fptype(clrngPhilox432Stream* stream) { \
	    return (clrngPhilox432NextState(&stream->current) + 0.5) * Philox432_NORM_##fptype; \
	} \
	\
	cl_int clrngPhilox432RandomInteger_##fptype(clrngPhilox432Stream* stream, cl_int i, cl_int j) { \
	    return i + (cl_int)((j - i + 1) * clrngPhilox432RandomU01_##fptype(stream)); \
	} \
	\
	clrngStatus clrngPhilox432RandomU01Array_##fptype(clrngPhilox432Stream* stream, size_t count, fptype* buffer) { \
		if (!stream) \
			return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): stream cannot be NULL", __func__); \
		if (!buffer) \
			return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): buffer cannot be NULL", __func__); \
		for (size_t i = 0; i < count; i++)  \
			buffer[i] = clrngPhilox432RandomU01_##fptype(stream); \
		return CLRNG_SUCCESS; \
	} \
	\
	clrngStatus clrngPhilox432RandomIntegerArray_##fptype(clrngPhilox432Stream* stream, cl_int i, cl_int j, size_t count, cl_int* buffer) { \
		if (!stream) \
			return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): stream cannot be NULL", __func__); \
		if (!buffer) \
			return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): buffer cannot be NULL", __func__); \
		for (size_t k = 0; k < count; k++) \
			buffer[k] = clrngPhilox432RandomInteger_##fptype(stream, i, j); \
		return CLRNG_SUCCESS; \
	}

// On the host, implement everything.
// On the device, implement only what is required to avoid cluttering memory.
#if defined(CLRNG_SINGLE_PRECISION)  || !defined(__CLRNG_DEVICE_API)
IMPLEMENT_GENERATE_FOR_TYPE(cl_float)
#endif
#if !defined(CLRNG_SINGLE_PRECISION) || !defined(__CLRNG_DEVICE_API)
IMPLEMENT_GENERATE_FOR_TYPE(cl_double)
#endif

// Clean up macros, especially to avoid polluting device code.
#undef IMPLEMENT_GENERATE_FOR_TYPE



clrngStatus clrngPhilox432RewindStreams(size_t count, clrngPhilox432Stream* streams)
{
	//Check params
	if (!streams)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): streams cannot be NULL", __func__);
	//Reset current state to the stream initial state
	for (size_t j = 0; j < count; j++) {
#ifdef __CLRNG_DEVICE_API
#ifdef CLRNG_ENABLE_SUBSTREAMS
		streams[j].current = streams[j].substream = *streams[j].initial;
#else
		streams[j].current = *streams[j].initial;
#endif
#else
		streams[j].current = streams[j].substream = streams[j].initial;
#endif
}

	return CLRNG_SUCCESS;
}

#if defined(CLRNG_ENABLE_SUBSTREAMS) || !defined(__CLRNG_DEVICE_API)

clrngStatus clrngPhilox432RewindSubstreams(size_t count, clrngPhilox432Stream* streams)
{
	//Check params
	if (!streams)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): streams cannot be NULL", __func__);
	//Reset current state to the subStream initial state
	for (size_t j = 0; j < count; j++) {
		streams[j].current = streams[j].substream;
	}

	return CLRNG_SUCCESS;
}

void Philox432ResetNextSubStream(clrngPhilox432Stream* stream){

	//2^64 states
	clrngPhilox432Counter steps = { { 0, 1 }, { 0, 0 } };

	//move the substream counter 2^64 steps forward.
	stream->substream.ctr = clrngPhilox432Add(stream->substream.ctr, steps);

	clrngPhilox432RewindSubstreams(1, stream);
}

clrngStatus clrngPhilox432ForwardToNextSubstreams(size_t count, clrngPhilox432Stream* streams)
{
	//Check params
	if (!streams)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): streams cannot be NULL", __func__);

	for (size_t k = 0; k < count; k++) {

		Philox432ResetNextSubStream(&streams[k]);
	}

	return CLRNG_SUCCESS;
}

clrngStatus clrngPhilox432MakeOverSubstreams(clrngPhilox432Stream* stream, size_t count, clrngPhilox432Stream* substreams)
{
	for (size_t i = 0; i < count; i++) {
		clrngStatus err;
		// snapshot current stream into substreams[i]
		err = clrngPhilox432CopyOverStreams(1, &substreams[i], stream);
		if (err != CLRNG_SUCCESS)
			return err;
		// advance to next substream
		err = clrngPhilox432ForwardToNextSubstreams(1, stream);
		if (err != CLRNG_SUCCESS)
			return err;
	}
	return CLRNG_SUCCESS;
}

#endif

#endif // PRIVATE_Philox432_CH
