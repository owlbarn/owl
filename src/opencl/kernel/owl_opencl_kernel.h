/*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2018 Liang Wang <liang.wang@cl.cam.ac.uk>
 */


/*
 * Include various static kernel modules
 * Only single precision is currently implemented. However, it is very easy to
 * extend existing code structure to support double precision.
 */


#include "owl_opencl_kernel_common.h"

#include "owl_opencl_kernel_maths.h"

#include "owl_opencl_kernel_stats.h"

#include "owl_opencl_kernel_broadcast.h"

#include "owl_opencl_kernel_create.h"
