
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

#include "philox432.h"

#include "private.h"
#include <stdlib.h>

#if defined ( WIN32 )
#define __func__ __FUNCTION__
#endif



struct clrngPhilox432StreamCreator_ {
	clrngPhilox432StreamState initialState;
	clrngPhilox432StreamState nextState;
	clrngPhilox432Counter JumpDistance;
};

// code that is common to host and device
#include "philox432.c.h"


/*! @brief Default initial seed of the first stream
*/

#define BASE_CREATOR_STATE { \
        {{ 0, 0},{ 0, 1}}, \
        { 0, 0, 0, 0 }, \
        0 }
/*! @brief Jump Struc for \f$2^{100}\f$ steps forward
*/
#define BASE_CREATOR_JUMP_DISTANCE {{ 16, 0},{ 0, 0 }}

/*! @brief Default stream creator (defaults to \f$2^{100}\f$ steps forward)
*
*  Contains the default seed;
*  adjacent streams are spaced nu steps apart.
*  The default is \f$nu = 2^{100}\f$.
*  The default seed is \f$({{0,0},{0,0}})\f$.
*/
static  clrngPhilox432StreamCreator defaultStreamCreator = { BASE_CREATOR_STATE, BASE_CREATOR_STATE, BASE_CREATOR_JUMP_DISTANCE };

/*! @brief Check the validity of a seed for Philox432
*/
static clrngStatus validateSeed(const clrngPhilox432StreamState* seed)
{
	return CLRNG_SUCCESS;
}

clrngPhilox432StreamCreator* clrngPhilox432CopyStreamCreator(const clrngPhilox432StreamCreator* creator, clrngStatus* err)
{
	clrngStatus err_ = CLRNG_SUCCESS;

	// allocate creator
	clrngPhilox432StreamCreator* newCreator = (clrngPhilox432StreamCreator*)malloc(sizeof(clrngPhilox432StreamCreator));

	if (newCreator == NULL)
		// allocation failed
		err_ = clrngSetErrorString(CLRNG_OUT_OF_RESOURCES, "%s(): could not allocate memory for stream creator", __func__);
	else {
		if (creator == NULL)
			creator = &defaultStreamCreator;
		// initialize creator
		*newCreator = *creator;
	}

	// set error status if needed
	if (err != NULL)
		*err = err_;

	return newCreator;
}

clrngStatus clrngPhilox432DestroyStreamCreator(clrngPhilox432StreamCreator* creator)
{
	if (creator != NULL)
		free(creator);
	return CLRNG_SUCCESS;
}

clrngStatus clrngPhilox432RewindStreamCreator(clrngPhilox432StreamCreator* creator)
{
	if (creator == NULL)
		creator = &defaultStreamCreator;
	creator->nextState = creator->initialState;
	return CLRNG_SUCCESS;
}

clrngStatus clrngPhilox432SetBaseCreatorState(clrngPhilox432StreamCreator* creator, const clrngPhilox432StreamState* baseState)
{
	//Check params
	if (creator == NULL)
		return clrngSetErrorString(CLRNG_INVALID_STREAM_CREATOR, "%s(): modifying the default stream creator is forbidden", __func__);
	if (baseState == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): baseState cannot be NULL", __func__);

	clrngStatus err = validateSeed(baseState);

	if (err == CLRNG_SUCCESS) {
		// initialize new creator
		creator->initialState = creator->nextState = *baseState;
	}

	return err;
}

clrngStatus clrngPhilox432ChangeStreamsSpacing(clrngPhilox432StreamCreator* creator, cl_int e, cl_int c)
{
	//Check params
	if (creator == NULL)
		return clrngSetErrorString(CLRNG_INVALID_STREAM_CREATOR, "%s(): modifying the default stream creator is forbidden", __func__);
	if (e < 2 && e != 0)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): e must be 0 or >= 2", __func__);
	if ((c % 4) != 0)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): c must be a multiple of 4", __func__);

	//Create Base Creator
	clrngPhilox432StreamCreator* baseCreator = clrngPhilox432CopyStreamCreator(NULL, NULL);
	clrngPhilox432StreamState baseState = { { { 0, 0 }, { 0, 0 } },	{ 0, 0, 0, 0 },	0 };
	clrngPhilox432SetBaseCreatorState(baseCreator, &baseState);

	//Create stream
	clrngPhilox432Stream* dumpStream = clrngPhilox432CreateStreams(baseCreator, 1, NULL, NULL);

	//Advance stream
	clrngPhilox432AdvanceStreams(1, dumpStream, e, c);
	creator->JumpDistance = dumpStream->current.ctr;

	//Free ressources
	clrngPhilox432DestroyStreamCreator(baseCreator);
	clrngPhilox432DestroyStreams(dumpStream);

	return CLRNG_SUCCESS;
}

clrngPhilox432Stream* clrngPhilox432AllocStreams(size_t count, size_t* bufSize, clrngStatus* err)
{
	clrngStatus err_ = CLRNG_SUCCESS;
	size_t bufSize_ = count * sizeof(clrngPhilox432Stream);

	// allocate streams
	clrngPhilox432Stream* buf = (clrngPhilox432Stream*)malloc(bufSize_);

	if (buf == NULL) {
		// allocation failed
		err_ = clrngSetErrorString(CLRNG_OUT_OF_RESOURCES, "%s(): could not allocate memory for streams", __func__);
		bufSize_ = 0;
	}

	// set buffer size if needed
	if (bufSize != NULL)
		*bufSize = bufSize_;

	// set error status if needed
	if (err != NULL)
		*err = err_;

	return buf;
}

clrngStatus clrngPhilox432DestroyStreams(clrngPhilox432Stream* streams)
{
	if (streams != NULL)
		free(streams);
	return CLRNG_SUCCESS;
}

static clrngStatus Philox432CreateStream(clrngPhilox432StreamCreator* creator, clrngPhilox432Stream* buffer)
{
	//Check params
	if (buffer == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): buffer cannot be NULL", __func__);

	// use default creator if not given
	if (creator == NULL)
		creator = &defaultStreamCreator;

	// initialize stream
	buffer->current = buffer->initial = buffer->substream = creator->nextState;

	//Advance next state in stream creator
	creator->nextState.ctr = clrngPhilox432Add(creator->nextState.ctr, creator->JumpDistance);

	return CLRNG_SUCCESS;
}

clrngStatus clrngPhilox432CreateOverStreams(clrngPhilox432StreamCreator* creator, size_t count, clrngPhilox432Stream* streams)
{
	// iterate over all individual stream buffers
	for (size_t i = 0; i < count; i++) {

		clrngStatus err = Philox432CreateStream(creator, &streams[i]);

		// abort on error
		if (err != CLRNG_SUCCESS)
			return err;
	}

	return CLRNG_SUCCESS;
}

clrngPhilox432Stream* clrngPhilox432CreateStreams(clrngPhilox432StreamCreator* creator, size_t count, size_t* bufSize, clrngStatus* err)
{
	clrngStatus err_;
	size_t bufSize_;
	clrngPhilox432Stream* streams = clrngPhilox432AllocStreams(count, &bufSize_, &err_);

	if (err_ == CLRNG_SUCCESS)
		err_ = clrngPhilox432CreateOverStreams(creator, count, streams);

	if (bufSize != NULL)
		*bufSize = bufSize_;

	if (err != NULL)
		*err = err_;

	return streams;
}

clrngPhilox432Stream* clrngPhilox432CopyStreams(size_t count, const clrngPhilox432Stream* streams, clrngStatus* err)
{
	clrngStatus err_ = CLRNG_SUCCESS;
	clrngPhilox432Stream* dest = NULL;

	//Check params
	if (streams == NULL)
		err_ = clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): stream cannot be NULL", __func__);

	if (err_ == CLRNG_SUCCESS)
		dest = clrngPhilox432AllocStreams(count, NULL, &err_);

	if (err_ == CLRNG_SUCCESS)
		err_ = clrngPhilox432CopyOverStreams(count, dest, streams);

	if (err != NULL)
		*err = err_;

	return dest;
}

clrngPhilox432Stream* clrngPhilox432MakeSubstreams(clrngPhilox432Stream* stream, size_t count, size_t* bufSize, clrngStatus* err)
{
	clrngStatus err_;
	size_t bufSize_;
	clrngPhilox432Stream* substreams = clrngPhilox432AllocStreams(count, &bufSize_, &err_);

	if (err_ == CLRNG_SUCCESS)
		err_ = clrngPhilox432MakeOverSubstreams(stream, count, substreams);

	if (bufSize != NULL)
		*bufSize = bufSize_;

	if (err != NULL)
		*err = err_;

	return substreams;
}

clrngStatus clrngPhilox432WriteStreamInfo(const clrngPhilox432Stream* stream, FILE *file)
{
	//Check params
	if (stream == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): stream cannot be NULL", __func__);
	if (file == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): file cannot be NULL", __func__);

	//The Initial state of the Stream
	//fprintf(file, "initial : (ctr, index)=( %u %u %u %u , [%u]) [deck = { %u %u %u %u}] \n\n",
	//	stream->initial.ctr.H.msb, stream->initial.ctr.H.lsb, stream->initial.ctr.L.msb, stream->initial.ctr.L.lsb, stream->initial.deckIndex,
	//	stream->initial.deck[3], stream->initial.deck[2], stream->initial.deck[1], stream->initial.deck[0]);

	//The Current state of the Stream
	fprintf(file, "Current : (ctr, index)=( %u %u %u %u , [%u])  [deck = { %u %u %u %u}] \n\n",
		stream->current.ctr.H.msb, stream->current.ctr.H.lsb, stream->current.ctr.L.msb, stream->current.ctr.L.lsb, stream->current.deckIndex
		, stream->current.deck[3], stream->current.deck[2], stream->current.deck[1], stream->current.deck[0]
		);


	return CLRNG_SUCCESS;
}

//clrngStatus clrngPhilox432AdvanceStreams(size_t count, clrngPhilox432Stream* streams, cl_int e, cl_int c)
//{
//
//
//	clrngPhilox432Counter Steps = { { 0, 0 }, { 0, 0 } };
//
//	//Calculate the Nbr of steps in 128bit counter
//	cl_uchar slotId = abs(e) / 32;
//	cl_uchar remider = abs(e) % 32;
//
//	if (e != 0)
//	{
//		cl_uint value = (1 << remider) + (e > 0 ? 1 : -1)*c;
//
//		if (slotId == 0)
//			Steps.L.lsb = value;
//		else if (slotId == 1)
//			Steps.L.msb = value;
//		else if (slotId == 2)
//			Steps.H.lsb = value;
//		else
//			Steps.H.msb = value;
//	}
//	else
//		Steps.L.lsb = c;
//
//	//Update the stream counter
//	for (size_t i = 0; i < count; i++)
//	{
//		if (e >= 0)
//			streams[i].current.ctr = clrngPhilox432Add(streams[i].current.ctr, Steps);
//		else streams[i].current.ctr = clrngPhilox432Substract(streams[i].current.ctr, Steps);
//	}
//
//	return CLRNG_SUCCESS;
//}

void clrngPhilox432AdvanceStream_(clrngPhilox432Stream* stream, cl_int e, cl_int c)
{
	cl_uchar slotId = 0, remider = 0;
	cl_int slide = 0, push = 0, pull = 0, c2 = 0;
	clrngPhilox432Counter Steps = { { 0, 0 }, { 0, 0 } };

	if (e >= 0)
	{
		//Slide the counter
		if (e < 2) {
			if (e == 1)	c += 2;
		}
		else{
			cl_int e2 = e - 2;

			slotId = e2 / 32;
			remider = e2 % 32;
			slide = 1 << remider;
		}

		//Push/Pull the counter
		c2 = stream->current.deckIndex + c;
		if (c >= 0){
			push = c2 / 4;
		}
		else{
			if (c2 < 0){
				pull = (c2 / 4) - 1;
				if ((c2 % 4) == 0) pull += 1;
			}
		}

		//Advance by counter value
		cl_uint ctr_value = abs(slide + push + pull);

		if (slotId == 0)
			Steps.L.lsb = ctr_value;
		else if (slotId == 1)
			Steps.L.msb = ctr_value;
		else if (slotId == 2)
			Steps.H.lsb = ctr_value;
		else
			Steps.H.msb = ctr_value;

		if ((slide + push) > abs(pull))
			stream->current.ctr = clrngPhilox432Add(stream->current.ctr, Steps);
		else stream->current.ctr = clrngPhilox432Substract(stream->current.ctr, Steps);

		//Adjusting the DeckIndex
		if (c >= 0)	stream->current.deckIndex = c2 % 4;
		else{
			if (c2 < 0){
				if ((abs(c2) % 4) == 0) stream->current.deckIndex = 0;
				else stream->current.deckIndex = 4 - (abs(c2) % 4);
			}
			else
				stream->current.deckIndex = c2;
		}
	}
	//negative e
	else{
		//Slide the counter
		if (e > -2) {
			if (e == -1) c -= 2;
		}
		else{
			cl_int e2 = abs(e) - 2;

			slotId = e2 / 32;
			remider = e2 % 32;
			slide = 1 << remider;
		}

		//Push/Pull the counter
		c2 = stream->current.deckIndex + c;

		if (c < 0){
			if (c2 < 0)	{
				push = -(c2 / 4) + 1;
				if ((c2 % 4) == 0) push -= 1;
			}
		}
		else
		{
			pull = c2 / 4;
		}

		//Advance by counter value
		cl_uint ctr_value = abs(slide + push - pull);

		if (slotId == 0)
			Steps.L.lsb = ctr_value;
		else if (slotId == 1)
			Steps.L.msb = ctr_value;
		else if (slotId == 2)
			Steps.H.lsb = ctr_value;
		else
			Steps.H.msb = ctr_value;

		if ((slide + push) > abs(pull))
			stream->current.ctr = clrngPhilox432Substract(stream->current.ctr, Steps);
		else stream->current.ctr = clrngPhilox432Add(stream->current.ctr, Steps);

		//Adjusting the DeckIndex
		if (c > 0) stream->current.deckIndex = abs(c2) % 4;
		else
		{
			if (c2 < 0)
			{
				if ((abs(c2) % 4) == 0) stream->current.deckIndex = 0;
				else stream->current.deckIndex = 4 - (abs(c2) % 4);
			}
			else
				stream->current.deckIndex = c2;
		}

	}

	clrngPhilox432GenerateDeck(&stream->current);
}

clrngStatus clrngPhilox432AdvanceStreams(size_t count, clrngPhilox432Stream* streams, cl_int e, cl_int c)
{
	//Check params
	if (streams == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): streams cannot be NULL", __func__);
	if (e > 127)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): 'e' can not exceed 127", __func__);

	//Advance streams
	for (size_t i = 0; i < count; i++)
	{
		clrngPhilox432AdvanceStream_(&streams[i], e, c);
	}

	return CLRNG_SUCCESS;
}
clrngStatus clrngPhilox432DeviceRandomU01Array_(size_t streamCount, cl_mem streams,
	size_t numberCount, cl_mem outBuffer, cl_uint numQueuesAndEvents,
	cl_command_queue* commQueues, cl_uint numWaitEvents, const cl_event* waitEvents, cl_event* outEvents, cl_bool singlePrecision)
{
	//Check params
	if (streamCount < 1)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): streamCount cannot be less than 1", __func__);
	if (streams == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): stream_array cannot be NULL", __func__);
	if (numberCount < 1)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): numberCount cannot be less than 1", __func__);
	if (outBuffer == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): buffer cannot be NULL", __func__);
	if (commQueues == NULL)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): commQueues cannot be NULL", __func__);
	if (numberCount % streamCount != 0)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): numberCount must be a multiple of streamCount", __func__);
	if (numQueuesAndEvents != 1)
		return clrngSetErrorString(CLRNG_INVALID_VALUE, "%s(): numQueuesAndEvents can only have the value '1'", __func__);

	//***************************************************************************************
	//Get the context
	cl_int err;

	cl_context ctx;
	err = clGetCommandQueueInfo(commQueues[0], CL_QUEUE_CONTEXT, sizeof(cl_context), &ctx, NULL);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot retrieve context", __func__);

	//Get the Device
	cl_device_id dev;
	err = clGetCommandQueueInfo(commQueues[0], CL_QUEUE_DEVICE, sizeof(cl_device_id), &dev, NULL);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot retrieve the device", __func__);

	//create the program
	const char *sources[4] = {
		singlePrecision ? "#define CLRNG_SINGLE_PRECISION\n" : "",
		"#include <clRNG/philox432.clh>\n"
		"__kernel void fillBufferU01(__global clrngPhilox432HostStream* streams, uint numberCount, __global ",
		singlePrecision ? "float" : "double",
		" * numbers) {\n"
		"	int gid = get_global_id(0);\n"
		"       int gsize = get_global_size(0);\n"
		"	//Copy a stream from global stream array to local stream struct\n"
		"	clrngPhilox432Stream local_stream;\n"
		"	clrngPhilox432CopyOverStreamsFromGlobal(1, &local_stream, &streams[gid]);\n"
		"	// wavefront-friendly ordering\n"
		"	for (int i = 0; i < numberCount; i++)\n"
		"		numbers[i * gsize + gid] = clrngPhilox432RandomU01(&local_stream);\n"
		"}\n"
	};

	cl_program program = clCreateProgramWithSource(ctx, 4, sources, NULL, &err);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot create program", __func__);

	// construct compiler options
	const char* includes = clrngGetLibraryDeviceIncludes(&err);
	if (err != CLRNG_SUCCESS)
		return (clrngStatus)err;

	err = clBuildProgram(program, 0, NULL, includes, NULL, NULL);
	if (err < 0) {
		// Find size of log and print to std output
		char *program_log;
		size_t log_size;
		clGetProgramBuildInfo(program, dev, CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
		program_log = (char *)malloc(log_size + 1);
		program_log[log_size] = '\0';
		clGetProgramBuildInfo(program, dev, CL_PROGRAM_BUILD_LOG, log_size + 1, program_log, NULL);
		printf("clBuildProgram fails:\n%s\n", program_log);
		free(program_log);
		exit(1);
	}

	// Create the kernel
	cl_kernel kernel = clCreateKernel(program, "fillBufferU01", &err);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot create kernel", __func__);

	//***************************************************************************************
	//Random numbers generated by each work-item
	cl_uint number_count_per_stream = numberCount / streamCount;

	//Work Group Size (local_size)
	size_t local_size;
	err = clGetDeviceInfo(dev, CL_DEVICE_MAX_WORK_GROUP_SIZE, sizeof(local_size), &local_size, NULL);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot read CL_DEVICE_MAX_WORK_GROUP_SIZE", __func__);

	if (local_size > streamCount)
		local_size = streamCount;

	// Set kernel arguments for kernel and enqueue that kernel.
	err = clSetKernelArg(kernel, 0, sizeof(streams), &streams);
	err |= clSetKernelArg(kernel, 1, sizeof(number_count_per_stream), &number_count_per_stream);
	err |= clSetKernelArg(kernel, 2, sizeof(outBuffer), &outBuffer);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot create kernel arguments", __func__);

	// Enqueue kernel
	err = clEnqueueNDRangeKernel(commQueues[0], kernel, 1, NULL, &streamCount, &local_size, numWaitEvents, waitEvents, outEvents);
	if (err != CLRNG_SUCCESS)
		return clrngSetErrorString(err, "%s(): cannot enqueue kernel", __func__);

	clReleaseKernel(kernel);
	clReleaseProgram(program);

	return(clrngStatus)EXIT_SUCCESS;
}

#if 0
clrngPhilox432Stream* Philox432GetStreamByIndex(clrngPhilox432Stream* stream, cl_uint index)
{

	return &stream[index];

}
#endif
