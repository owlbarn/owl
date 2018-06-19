
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

/*! @mainpage Introduction
 *
 *  We introduce clRNG, an OpenCL library for generating uniform random numbers.
 *  It provides multiple streams that are created on the host computer 
 *  and used to generate random numbers either on the host or on computing devices by work items.
 *  Such multiple streams are essential for parallel simulation \cite rLEC14p
 *  and are often useful as well for simulation on a single processing element  
 *  (or within a single work item), for example when comparing similar systems 
 *  via simulation with common random numbers \cite sLAW14a, \cite vLEC07e,
 *  \cite iLEC08j, \cite rLEC02a .
 *  Streams can also be divided into segments of equal length called substreams,
 *  as in \cite rLEC91a, \cite rLEC02a, \cite iLEC08j .
 *  Currently, the library implements the following three generators: 
 *  MRG31k3p \cite rLEC00b, MRG32k3a \cite rLEC99b, LFSR113 \cite rLEC99a and
 *  Philox-4×32-10 \cite rSAL11a .
 *  
 *
 *  ### Generators and prefixes
 *
 *  The API is, in large part, the same for every generator, with only the
 *  prefix of the type and function names that changes across generators.
 *  For example, to use the MRG31k3p generator, one needs to include the
 *  corresponding header file (which is normally the lowercase name of the
 *  generator with a \c .h extension on the host, or a \c .clh extension on
 *  the device) and use type and function names that start with \c clrngMrg31k3p:
 *  \code
 *  #include <clRNG/mrg31k3p.h>
 *
 *  cl_double foo(clrngMrg31k3pStream* stream) {
 *    return clrngMrg31k3pRandomU01(stream);
 *  }
 *  \endcode
 *  (The above function just returns a number uniformly distributed in
 *  \f$(0,1)\f$ generated using the stream passed as its argument.)
 *  To use the LFSR113 generator instead of MRG31k3p, one must change the
 *  include directive and use type and function names that start with \c clrngLfsr113:
 *  \code
 *  #include <clRNG/lfsr113.h>
 *
 *  cl_double foo(clrngLfsr113Stream* stream) {
 *    return clrngLfsr113RandomU01(stream);
 *  }
 *  \endcode
 *
 *  In the generator API reference (given in \ref clRNG_template.h), the
 *  generator-specific part of the prefix is not shown.
 *  The \ref clRNG.h header file declares common function across different
 *  generators and also utility library functions.
 *
 *  Future versions of the library will support more generic
 *  interfaces that work across generators.
 *
 *
 *  ### Environment variables
 *
 *  For all features of the library to work properly, the \c CLRNG_ROOT
 *  environment variable must be set to point to the installation path of the 
 *  clRNG package, that is, the directory under which lies the \c include/clRNG
 *  subdirectory.
 *  Means of setting an environment variable depend on the operating system 
 *  used.
 *
 *
 *  \section small_examples Small examples
 *
 *  In the examples given below, we use the MRG31k3p from \cite rLEC00b . 
 *  In general, a stream object contains three states:
 *  the initial state of the stream (or seed), 
 *  the initial state of the current substream (by default it is equal to the seed),
 *  and the current state.  With MRG31k3p, each state is comprised of six 31-bit integers.
 *  Each time a random number is generated, the current state advances by one position.
 *  There are also functions to reset the state to the initial one, 
 *  or to the beginning of the current substream, or to the start of the next substream.
 *  Streams can be created and manipulated in arrays of arbitrary sizes.
 *  For a single stream, one uses an array of size 1.
 *  One can separately declare and allocate memory for an array of streams,
 *  create (initialize) the streams, clone them, copy them to preallocated space, etc. 
 *
 *  
 *  \subsection small_examples_host Using streams on the host
 *
 *  We start with a small example in which we just create a few streams,
 *  then use them to generate numbers on the host computer and compute some quantity.
 *  This could be done as well by using only a single stream, but we use more 
 *  just for the purpose of illustration.
 *  
 *  The code includes the header for the MRG31k3p RNG.
 *  \snippet HostOnly/hostonly.c clRNG header
 *  We create an array of two streams named \c streams
 *  and a single stream named \c single.
 *  \snippet HostOnly/hostonly.c create streams
 *  Then we repeat the following 100 times:
 *  we generate a uniform random number in \f$(0,1)\f$ and an integer in
 *  \f$\{1,\dots,6\}\f$, and compute the indicator that the product is less
 *  than 2.
 *  \snippet HostOnly/hostonly.c iterate streams
 *  The uniform random numbers over \f$(0,1)\f$ are generated by alternating the two
 *  streams from the array.
 *  We then print the average of those indicators.
 *  \snippet HostOnly/hostonly.c output
 * 
 *
 *  \subsection small_examples_device Using streams in work items
 *  
 *  In our second example, we create an array of streams and use them  
 *  in work items that execute in parallel on a GPU device, one distinct stream per work item.
 *  Note that it is also possible (and sometimes useful) to use more than one stream per work item.
 *  We show only fragments of the code, to illustrate what we do with the streams.
 *  This code is only for illustration; the program does no useful computation.
 *  
 *  In the host code, we first include the clRNG header for the MRG31k3p RNG:
 *  \snippet WorkItem/workitem.c clRNG header
 *  Now suppose we have an integer variable \c numWorkItems that indicates the 
 *  number of work items we want to use.  
 *  We create an array of \c numWorkItems streams (and allocate memory for both 
 *  the array and the stream objects).
 *  The creator returns in the variable \c streamBufferSize the size of the buffer 
 *  that this array occupies (it depends on how much space is required to store the stream states),
 *  and an error code.
 *  \snippet WorkItem/workitem.c create streams
 *  Then we create an OpenCL buffer of size \c streamBufferSize and fill it with a copy of 
 *  the array of streams, to pass to the device.
 *  We also create and pass a buffer that will be used by the device to return 
 *  an array of \c numWorkItems values of type \c cl_double.
 *  (OpenCL buffer creation is not specific to clRNG, so it is not discussed here).
 *  \snippet WorkItem/workitem.c create streams buffer
 *  \snippet WorkItem/workitem.c create output buffer
 *  We finally enqueue the kernel with these two buffers as kernel arguments (not shown here).
 *  
 *  In the device code, we include the device-side clRNG header for the chosen RNG
 *  (it ends with `.clh` instead of `.h`).
 *  \snippet WorkItem/workitem_kernel.cl clRNG header
 *  Pointers to the global memory buffers 
 *  received from the host and to the output array are passed to the kernel as arguments.
 *  (The correspondence between the kernel arguments and the buffers on the host is
 *  specified in the host code, not shown here).
 *  For each work item, we create a private copy of its stream, named \c private_stream,
 *  in its private memory, so we can generate random numbers on the device.
 *  The private memory must be allocated at compile time; this is why
 *  \c private_stream is not declared as a pointer, so the declaration allocates memory.
 *  The kernel just generates two random numbers and returns the sum, in a \c cl_double.
 *  \snippet WorkItem/workitem_kernel.cl kernel
 *  The host can then recover the array of size \c numWorkItems that contains these sums.
 *
 *
 *  \subsection specialized_API RNG-Specific API's
 *
 *  \ref clRNG_template.h describes the random streams API as it is intended to
 *  be implemented using different types of RNG's or even using quasi-Monte
 *  Carlo (QMC) point sets.
 *
 *  In the description of this API, every data type and function name is
 *  assigned the prefix `clrng`.  It is understood that, in the implementation
 *  for each RNG type, the prefix `clrng` is to be expanded with another prefix
 *  that indicates the type of RNG (or other method) used.
 *
 *  As this API is not polymorphic, replacing an RNG type with another one in
 *  client code requires changing the code to match clRNG function names and
 *  data types to match those of the replacement RNG.
 *  We also intend to propose a generic (in the polymorphic sense) interface to
 *  the clRNG library.
 *
 *
 *  \subsection objects_vs_states Stream Objects and Stream States
 *
 *  The library defines, among others, two closely related types of structures:
 *  stream objects (clrngStream) and stream states (clrngStreamState).  The
 *  definitions of both structures depend on the specific type of RNG that they
 *  pertain to. 
 *  Stream states correspond to the seeds of conventional RNG's, to counter
 *  values in counter-based RNG's, or to point and coordinate indices in QMC
 *  methods.
 *  Normally, the client should not deal with stream states directly, but use
 *  instead the higher-level stream objects.
 *  Stream objects are intended to store several stream
 *  states: the current and initial stream states, but also current substream
 *  state when support for substreams is available.
 *  Stream objects may also store other properties of the RNG, such as
 *  encryption keys for cryptography-based RNG's.
 *
 *
 *  \subsection stream_arrays Arrays of Stream Objects
 *
 *  Many functions are defined only for arrays of stream objects and not for
 *  single stream objects.  It is always possible to use these functions for
 *  single stream objects by specifying a unit array size.
 *
 *  Also, in order to comply with the OpenCL API and be consistent with the
 *  clBLAS API, functions that take an array as an argument have the array size
 *  argument come *before* the array argument.
 *
 *
 *  \subsection device_storage Storing Stream States on the Device
 *
 *  When a kernel is called, the stream states it needs are normally passed by
 *  the host and stored in global memory.
 *  For efficiency reasons, it is desirable that the current stream state be
 *  first copied in a work-item's private memory, and to work with
 *  that copy inside the kernel.
 *  In the current implementation of clRNG, to avoid wasting device resources,
 *  only the current stream state is stored in the work-item's private memory.
 *  The initial stream state is left in global memory and
 *  a pointer to it is stored in the work-item's private memory.
 *  When substream support is turned on (by defining CLRNG_ENABLE_SUBSTREAMS
 *  before including the device-side header file; see \ref clRNG_template.h),
 *  the initial state of the substream is stored in the work-item's private
 *  memory together with the current state.
 *
 *
 *  \subsection device_side_code Device-Side Code
 *
 *  To use the clRNG library on a device from within a user-defined kernel, the
 *  user must include the clRNG header file corresponding to the desired RNG,
 *  using an `include` preprocessor directive.
 *
 *  If default settings are not suitable for the user's needs, optional library
 *  behavior can be selected by defining specific preprocessor macros *before*
 *  including the clRNG header.
 *  For example, to enable substreams support on the device while using the
 *  MRG31k3p generator, use:
 *  \code{c}
 *      #define  CLRNG_ENABLE_SUBSTREAMS
 *      #include <clRNG/mrg31k3p.clh>
 *  \endcode
 *
 *  A comprehensive list of supported device-side library options are described
 *  in \ref clRNG_template.h.
 *
 */


/*! @example HostOnly/hostonly.c
 *  @brief Very simple example client program that uses the clRNG host-only API
 */

/*! @example WorkItem/workitem.c
 *  @brief Very simple example client program that uses the clRNG host and device API's
 *  @see workitem_kernel.cl
 */

/*! @example WorkItem/workitem_kernel.cl
 *  @brief Very simple example of a kernel that uses the clRNG device API
 *  @see workitem.c
 */

/*! @example RandomArray/randomarray.c
 *  @brief Example program that calls the clrngDeviceRandomU01Array() function
 *
 *  The program also compares the device output with that obtained by
 *  using host code to generate the numbers.
 */

/*! @example MultiStream/multistream.c
 *  @brief Example program that generates random numbers using multiple streams per work-item.
 *
 *  The program also compares the device output with that obtained by
 *  using host code to generate the numbers.
 */



/*! @file clRNG.h
 *  @brief Library definitions common to all RNG's
 *  @see clRNG_template.h
 */

#pragma once
#ifndef CLRNG_H
#define CLRNG_H

#if defined(__APPLE__) || defined(__MACOSX)
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif

/** \internal
 */
#ifdef CLRNG_SINGLE_PRECISION
  #define _CLRNG_FPTYPE cl_float
#else
  #define _CLRNG_FPTYPE cl_double
#endif
#define _CLRNG_TAG_FPTYPE(name)           _CLRNG_TAG_FPTYPE_(name,_CLRNG_FPTYPE)
#define _CLRNG_TAG_FPTYPE_(name,fptype)   _CLRNG_TAG_FPTYPE__(name,fptype)
#define _CLRNG_TAG_FPTYPE__(name,fptype)  name##_##fptype
/** \endinternal
 */


#if defined( _WIN32 )
	#define CLRNGAPI __declspec( dllexport )
#else
	#define CLRNGAPI
#endif


/*! @brief Error codes
 *
 *  Most library functions return an error status indicating the success or
 *  error state of the operation carried by the function.
 *  In case of success, the error status is set to `CLRNG_SUCCESS`.
 *  Otherwise, an error message can be retrieved by invoking
 *  clrngGetErrorString().
 *
 *  @note In naming this type clrngStatus, we follow the convention from clFFT
 *  and clBLAS, where the homologous types are name clfftStatus and
 *  clblasStatus, respectively.
 */
typedef enum clrngStatus_ {
    CLRNG_SUCCESS              = CL_SUCCESS,
    CLRNG_OUT_OF_RESOURCES     = CL_OUT_OF_RESOURCES,
    CLRNG_INVALID_VALUE        = CL_INVALID_VALUE,
    /* ... */
    CLRNG_INVALID_RNG_TYPE,
    CLRNG_INVALID_STREAM_CREATOR,
    CLRNG_INVALID_SEED,
	CLRNG_FUNCTION_NOT_IMPLEMENTED
} clrngStatus;


#ifdef __cplusplus
extern "C" {
#endif

/*! @brief Retrieve the last error message.
 *
 *  The buffer containing the error message is internally allocated and must
 *  not be freed by the client.
 *
 *  @return     Error message or `NULL`.
 */
CLRNGAPI const char* clrngGetErrorString();

/*! @brief Generate an include option string for use with the OpenCL C compiler
 *
 *  Generate and return "-I${CLRNG_ROOT}/include", where \c ${CLRNG_ROOT} is
 *  the value of the \c CLRNG_ROOT environment variable.
 *  This string is meant to be passed as an option to the OpenCL C compiler for
 *  programs that make use of the clRNG device-side headers.
 *  If the \c CLRNG_ROOT environment variable is not defined, it defaults
 *  `/usr` if the file `/usr/include/clRNG/clRNG.h` exists, else to the current
 *  directory of execution of the program.
 *
 *  A static buffer is return and need not be released; it could change upon
 *  successive calls to the function.
 *
 *  An error is returned in \c err if the preallocated buffer is too small to
 *  contain the include string.
 *
 *  @param[out]     err         Error status variable, or `NULL`.
 *
 *  @return An OpenCL C compiler option to indicate where to find the
 *  device-side clRNG headers.
 */
CLRNGAPI const char* clrngGetLibraryDeviceIncludes(cl_int* err);

/*! @brief Retrieve the library installation path
 *
 *  @return Value of the CLRNG_ROOT environment variable, if defined; else,
 *  `/usr` if the file `/usr/include/clRNG/clRNG.h` exists; or, the current
 *  directory (.) of execution of the program otherwise.
 */
CLRNGAPI const char* clrngGetLibraryRoot();

#ifdef __cplusplus
}
#endif

#endif /* CLRNG_H */

/*
 * vim: syntax=c.doxygen spell spelllang=en fdm=syntax fdls=0
 */
