
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

#pragma once
#ifndef PRIVATE_H
#define PRIVATE_H


/*! @brief Set the current error string
 *
 *  The error string will be constructed based on the error code \c err and on
 *  the optional message \c msg.
 *
 *  @param[in]  err     Error code.
 *  @param[in]  msg     Additional error message (format string).  Can be `NULL`.
 *  @param[in]  ...     Additional arguments for the format string.
 *  @return     The value of err (for convenience).
 */
clrngStatus clrngSetErrorString(cl_int err, const char* msg, ...);


#endif
