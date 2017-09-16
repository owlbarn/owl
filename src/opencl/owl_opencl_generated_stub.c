#ifdef __APPLE__
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif
#include "ctypes_cstubs_internals.h"
value owl_opencl_stub_1_clGetPlatformIDs(value x3, value x2, value x1)
{
   uint32_t x4 = Uint32_val(x3);
   struct _cl_platform_id** x7 = CTYPES_ADDR_OF_FATPTR(x2);
   uint32_t* x8 = CTYPES_ADDR_OF_FATPTR(x1);
   int32_t x9 = clGetPlatformIDs(x4, x7, x8);
   return caml_copy_int32(x9);
}
value owl_opencl_stub_2_clGetPlatformInfo(value x14, value x13, value x12,
                                          value x11, value x10)
{
   struct _cl_platform_id* x15 = CTYPES_ADDR_OF_FATPTR(x14);
   uint32_t x16 = Uint32_val(x13);
   size_t x19 = ctypes_size_t_val(x12);
   void* x22 = CTYPES_ADDR_OF_FATPTR(x11);
   size_t* x23 = CTYPES_ADDR_OF_FATPTR(x10);
   int32_t x24 = clGetPlatformInfo(x15, x16, x19, x22, x23);
   return caml_copy_int32(x24);
}
value owl_opencl_stub_3_clGetDeviceIDs(value x29, value x28, value x27,
                                       value x26, value x25)
{
   struct _cl_platform_id* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   uint64_t x31 = Uint64_val(x28);
   uint32_t x34 = Uint32_val(x27);
   struct _cl_device_id** x37 = CTYPES_ADDR_OF_FATPTR(x26);
   uint32_t* x38 = CTYPES_ADDR_OF_FATPTR(x25);
   int32_t x39 = clGetDeviceIDs(x30, x31, x34, x37, x38);
   return caml_copy_int32(x39);
}
value owl_opencl_stub_4_clGetDeviceInfo(value x44, value x43, value x42,
                                        value x41, value x40)
{
   struct _cl_device_id* x45 = CTYPES_ADDR_OF_FATPTR(x44);
   uint32_t x46 = Uint32_val(x43);
   size_t x49 = ctypes_size_t_val(x42);
   void* x52 = CTYPES_ADDR_OF_FATPTR(x41);
   size_t* x53 = CTYPES_ADDR_OF_FATPTR(x40);
   int32_t x54 = clGetDeviceInfo(x45, x46, x49, x52, x53);
   return caml_copy_int32(x54);
}
