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
   unsigned long x31 = ctypes_ulong_val(x28);
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
value owl_opencl_stub_5_clCreateSubDevices(value x59, value x58, value x57,
                                           value x56, value x55)
{
   struct _cl_device_id* x60 = CTYPES_ADDR_OF_FATPTR(x59);
   intptr_t* x61 = CTYPES_ADDR_OF_FATPTR(x58);
   uint32_t x62 = Uint32_val(x57);
   struct _cl_device_id** x65 = CTYPES_ADDR_OF_FATPTR(x56);
   uint32_t* x66 = CTYPES_ADDR_OF_FATPTR(x55);
   int32_t x67 = clCreateSubDevices(x60, x61, x62, x65, x66);
   return caml_copy_int32(x67);
}
value owl_opencl_stub_6_clRetainDevice(value x68)
{
   struct _cl_device_id* x69 = CTYPES_ADDR_OF_FATPTR(x68);
   int32_t x70 = clRetainDevice(x69);
   return caml_copy_int32(x70);
}
value owl_opencl_stub_7_clReleaseDevice(value x71)
{
   struct _cl_device_id* x72 = CTYPES_ADDR_OF_FATPTR(x71);
   int32_t x73 = clReleaseDevice(x72);
   return caml_copy_int32(x73);
}
value owl_opencl_stub_8_clCreateContext(value x79, value x78, value x77,
                                        value x76, value x75, value x74)
{
   intptr_t* x80 = CTYPES_ADDR_OF_FATPTR(x79);
   uint32_t x81 = Uint32_val(x78);
   struct _cl_device_id** x84 = CTYPES_ADDR_OF_FATPTR(x77);
   void* x85 = CTYPES_ADDR_OF_FATPTR(x76);
   void* x86 = CTYPES_ADDR_OF_FATPTR(x75);
   int32_t* x87 = CTYPES_ADDR_OF_FATPTR(x74);
   struct _cl_context* x88 = clCreateContext(x80, x81, x84, x85, x86, x87);
   return CTYPES_FROM_PTR(x88);
}
value owl_opencl_stub_8_clCreateContext_byte6(value* argv, int argc)
{
   value x89 = argv[5];
   value x90 = argv[4];
   value x91 = argv[3];
   value x92 = argv[2];
   value x93 = argv[1];
   value x94 = argv[0];
   return owl_opencl_stub_8_clCreateContext(x94, x93, x92, x91, x90, x89);
}
value owl_opencl_stub_9_clCreateContextFromType(value x99, value x98,
                                                value x97, value x96,
                                                value x95)
{
   intptr_t* x100 = CTYPES_ADDR_OF_FATPTR(x99);
   unsigned long x101 = ctypes_ulong_val(x98);
   void* x104 = CTYPES_ADDR_OF_FATPTR(x97);
   void* x105 = CTYPES_ADDR_OF_FATPTR(x96);
   int32_t* x106 = CTYPES_ADDR_OF_FATPTR(x95);
   struct _cl_context* x107 =
   clCreateContextFromType(x100, x101, x104, x105, x106);
   return CTYPES_FROM_PTR(x107);
}
value owl_opencl_stub_10_clRetainContext(value x108)
{
   struct _cl_context* x109 = CTYPES_ADDR_OF_FATPTR(x108);
   int32_t x110 = clRetainContext(x109);
   return caml_copy_int32(x110);
}
value owl_opencl_stub_11_clReleaseContext(value x111)
{
   struct _cl_context* x112 = CTYPES_ADDR_OF_FATPTR(x111);
   int32_t x113 = clReleaseContext(x112);
   return caml_copy_int32(x113);
}
value owl_opencl_stub_12_clGetContextInfo(value x118, value x117, value x116,
                                          value x115, value x114)
{
   struct _cl_context* x119 = CTYPES_ADDR_OF_FATPTR(x118);
   uint32_t x120 = Uint32_val(x117);
   size_t x123 = ctypes_size_t_val(x116);
   void* x126 = CTYPES_ADDR_OF_FATPTR(x115);
   size_t* x127 = CTYPES_ADDR_OF_FATPTR(x114);
   int32_t x128 = clGetContextInfo(x119, x120, x123, x126, x127);
   return caml_copy_int32(x128);
}
value owl_opencl_stub_13_clCreateCommandQueue(value x132, value x131,
                                              value x130, value x129)
{
   struct _cl_context* x133 = CTYPES_ADDR_OF_FATPTR(x132);
   struct _cl_device_id* x134 = CTYPES_ADDR_OF_FATPTR(x131);
   unsigned long x135 = ctypes_ulong_val(x130);
   int32_t* x138 = CTYPES_ADDR_OF_FATPTR(x129);
   struct _cl_command_queue* x139 =
   clCreateCommandQueue(x133, x134, x135, x138);
   return CTYPES_FROM_PTR(x139);
}
value owl_opencl_stub_14_clRetainCommandQueue(value x140)
{
   struct _cl_command_queue* x141 = CTYPES_ADDR_OF_FATPTR(x140);
   int32_t x142 = clRetainCommandQueue(x141);
   return caml_copy_int32(x142);
}
value owl_opencl_stub_15_clReleaseCommandQueue(value x143)
{
   struct _cl_command_queue* x144 = CTYPES_ADDR_OF_FATPTR(x143);
   int32_t x145 = clReleaseCommandQueue(x144);
   return caml_copy_int32(x145);
}
value owl_opencl_stub_16_clGetCommandQueueInfo(value x150, value x149,
                                               value x148, value x147,
                                               value x146)
{
   struct _cl_command_queue* x151 = CTYPES_ADDR_OF_FATPTR(x150);
   uint32_t x152 = Uint32_val(x149);
   size_t x155 = ctypes_size_t_val(x148);
   void* x158 = CTYPES_ADDR_OF_FATPTR(x147);
   size_t* x159 = CTYPES_ADDR_OF_FATPTR(x146);
   int32_t x160 = clGetCommandQueueInfo(x151, x152, x155, x158, x159);
   return caml_copy_int32(x160);
}
value owl_opencl_stub_17_clCreateBuffer(value x165, value x164, value x163,
                                        value x162, value x161)
{
   struct _cl_context* x166 = CTYPES_ADDR_OF_FATPTR(x165);
   unsigned long x167 = ctypes_ulong_val(x164);
   size_t x170 = ctypes_size_t_val(x163);
   void* x173 = CTYPES_ADDR_OF_FATPTR(x162);
   int32_t* x174 = CTYPES_ADDR_OF_FATPTR(x161);
   struct _cl_mem* x175 = clCreateBuffer(x166, x167, x170, x173, x174);
   return CTYPES_FROM_PTR(x175);
}
value owl_opencl_stub_18_clCreateSubBuffer(value x180, value x179,
                                           value x178, value x177,
                                           value x176)
{
   struct _cl_mem* x181 = CTYPES_ADDR_OF_FATPTR(x180);
   unsigned long x182 = ctypes_ulong_val(x179);
   uint32_t x185 = Uint32_val(x178);
   void* x188 = CTYPES_ADDR_OF_FATPTR(x177);
   int32_t* x189 = CTYPES_ADDR_OF_FATPTR(x176);
   struct _cl_mem* x190 = clCreateSubBuffer(x181, x182, x185, x188, x189);
   return CTYPES_FROM_PTR(x190);
}
value owl_opencl_stub_19_clRetainMemObject(value x191)
{
   struct _cl_mem* x192 = CTYPES_ADDR_OF_FATPTR(x191);
   int32_t x193 = clRetainMemObject(x192);
   return caml_copy_int32(x193);
}
value owl_opencl_stub_20_clReleaseMemObject(value x194)
{
   struct _cl_mem* x195 = CTYPES_ADDR_OF_FATPTR(x194);
   int32_t x196 = clReleaseMemObject(x195);
   return caml_copy_int32(x196);
}
value owl_opencl_stub_21_clGetMemObjectInfo(value x201, value x200,
                                            value x199, value x198,
                                            value x197)
{
   struct _cl_mem* x202 = CTYPES_ADDR_OF_FATPTR(x201);
   uint32_t x203 = Uint32_val(x200);
   size_t x206 = ctypes_size_t_val(x199);
   void* x209 = CTYPES_ADDR_OF_FATPTR(x198);
   size_t* x210 = CTYPES_ADDR_OF_FATPTR(x197);
   int32_t x211 = clGetMemObjectInfo(x202, x203, x206, x209, x210);
   return caml_copy_int32(x211);
}
value owl_opencl_stub_22_clGetImageInfo(value x216, value x215, value x214,
                                        value x213, value x212)
{
   struct _cl_mem* x217 = CTYPES_ADDR_OF_FATPTR(x216);
   uint32_t x218 = Uint32_val(x215);
   size_t x221 = ctypes_size_t_val(x214);
   void* x224 = CTYPES_ADDR_OF_FATPTR(x213);
   size_t* x225 = CTYPES_ADDR_OF_FATPTR(x212);
   int32_t x226 = clGetImageInfo(x217, x218, x221, x224, x225);
   return caml_copy_int32(x226);
}
value owl_opencl_stub_23_clSetMemObjectDestructorCallback(value x229,
                                                          value x228,
                                                          value x227)
{
   struct _cl_mem* x230 = CTYPES_ADDR_OF_FATPTR(x229);
   void* x231 = CTYPES_ADDR_OF_FATPTR(x228);
   void* x232 = CTYPES_ADDR_OF_FATPTR(x227);
   int32_t x233 = clSetMemObjectDestructorCallback(x230, x231, x232);
   return caml_copy_int32(x233);
}
value owl_opencl_stub_24_clCreateSampler(value x238, value x237, value x236,
                                         value x235, value x234)
{
   struct _cl_context* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   uint32_t x240 = Uint32_val(x237);
   uint32_t x243 = Uint32_val(x236);
   uint32_t x246 = Uint32_val(x235);
   int32_t* x249 = CTYPES_ADDR_OF_FATPTR(x234);
   struct _cl_sampler* x250 = clCreateSampler(x239, x240, x243, x246, x249);
   return CTYPES_FROM_PTR(x250);
}
value owl_opencl_stub_25_clRetainSampler(value x251)
{
   struct _cl_sampler* x252 = CTYPES_ADDR_OF_FATPTR(x251);
   int32_t x253 = clRetainSampler(x252);
   return caml_copy_int32(x253);
}
value owl_opencl_stub_26_clReleaseSampler(value x254)
{
   struct _cl_sampler* x255 = CTYPES_ADDR_OF_FATPTR(x254);
   int32_t x256 = clReleaseSampler(x255);
   return caml_copy_int32(x256);
}
value owl_opencl_stub_27_clGetSamplerInfo(value x261, value x260, value x259,
                                          value x258, value x257)
{
   struct _cl_sampler* x262 = CTYPES_ADDR_OF_FATPTR(x261);
   uint32_t x263 = Uint32_val(x260);
   size_t x266 = ctypes_size_t_val(x259);
   void* x269 = CTYPES_ADDR_OF_FATPTR(x258);
   size_t* x270 = CTYPES_ADDR_OF_FATPTR(x257);
   int32_t x271 = clGetSamplerInfo(x262, x263, x266, x269, x270);
   return caml_copy_int32(x271);
}
value owl_opencl_stub_28_clCreateProgramWithSource(value x276, value x275,
                                                   value x274, value x273,
                                                   value x272)
{
   struct _cl_context* x277 = CTYPES_ADDR_OF_FATPTR(x276);
   uint32_t x278 = Uint32_val(x275);
   const char** x281 = CTYPES_ADDR_OF_FATPTR(x274);
   size_t* x282 = CTYPES_ADDR_OF_FATPTR(x273);
   int32_t* x283 = CTYPES_ADDR_OF_FATPTR(x272);
   struct _cl_program* x284 =
   clCreateProgramWithSource(x277, x278, x281, x282, x283);
   return CTYPES_FROM_PTR(x284);
}
value owl_opencl_stub_29_clCreateProgramWithBinary(value x291, value x290,
                                                   value x289, value x288,
                                                   value x287, value x286,
                                                   value x285)
{
   struct _cl_context* x292 = CTYPES_ADDR_OF_FATPTR(x291);
   uint32_t x293 = Uint32_val(x290);
   struct _cl_device_id** x296 = CTYPES_ADDR_OF_FATPTR(x289);
   size_t* x297 = CTYPES_ADDR_OF_FATPTR(x288);
   unsigned const char** x298 = CTYPES_ADDR_OF_FATPTR(x287);
   int32_t* x299 = CTYPES_ADDR_OF_FATPTR(x286);
   int32_t* x300 = CTYPES_ADDR_OF_FATPTR(x285);
   struct _cl_program* x301 =
   clCreateProgramWithBinary(x292, x293, x296, x297, x298, x299, x300);
   return CTYPES_FROM_PTR(x301);
}
value owl_opencl_stub_29_clCreateProgramWithBinary_byte7(value* argv,
                                                         int argc)
{
   value x302 = argv[6];
   value x303 = argv[5];
   value x304 = argv[4];
   value x305 = argv[3];
   value x306 = argv[2];
   value x307 = argv[1];
   value x308 = argv[0];
   return
     owl_opencl_stub_29_clCreateProgramWithBinary(x308, x307, x306, x305,
                                                  x304, x303, x302);
}
value owl_opencl_stub_30_clCreateProgramWithBuiltInKernels(value x313,
                                                           value x312,
                                                           value x311,
                                                           value x310,
                                                           value x309)
{
   struct _cl_context* x314 = CTYPES_ADDR_OF_FATPTR(x313);
   uint32_t x315 = Uint32_val(x312);
   struct _cl_device_id** x318 = CTYPES_ADDR_OF_FATPTR(x311);
   char* x319 = CTYPES_ADDR_OF_FATPTR(x310);
   int32_t* x320 = CTYPES_ADDR_OF_FATPTR(x309);
   struct _cl_program* x321 =
   clCreateProgramWithBuiltInKernels(x314, x315, x318, x319, x320);
   return CTYPES_FROM_PTR(x321);
}
value owl_opencl_stub_31_clRetainProgram(value x322)
{
   struct _cl_program* x323 = CTYPES_ADDR_OF_FATPTR(x322);
   int32_t x324 = clRetainProgram(x323);
   return caml_copy_int32(x324);
}
value owl_opencl_stub_32_clReleaseProgram(value x325)
{
   struct _cl_program* x326 = CTYPES_ADDR_OF_FATPTR(x325);
   int32_t x327 = clReleaseProgram(x326);
   return caml_copy_int32(x327);
}
value owl_opencl_stub_33_clBuildProgram(value x333, value x332, value x331,
                                        value x330, value x329, value x328)
{
   struct _cl_program* x334 = CTYPES_ADDR_OF_FATPTR(x333);
   uint32_t x335 = Uint32_val(x332);
   struct _cl_device_id** x338 = CTYPES_ADDR_OF_FATPTR(x331);
   char* x339 = CTYPES_ADDR_OF_FATPTR(x330);
   void* x340 = CTYPES_ADDR_OF_FATPTR(x329);
   void* x341 = CTYPES_ADDR_OF_FATPTR(x328);
   int32_t x342 = clBuildProgram(x334, x335, x338, x339, x340, x341);
   return caml_copy_int32(x342);
}
value owl_opencl_stub_33_clBuildProgram_byte6(value* argv, int argc)
{
   value x343 = argv[5];
   value x344 = argv[4];
   value x345 = argv[3];
   value x346 = argv[2];
   value x347 = argv[1];
   value x348 = argv[0];
   return
     owl_opencl_stub_33_clBuildProgram(x348, x347, x346, x345, x344, x343);
}
value owl_opencl_stub_34_clCompileProgram(value x357, value x356, value x355,
                                          value x354, value x353, value x352,
                                          value x351, value x350, value x349)
{
   struct _cl_program* x358 = CTYPES_ADDR_OF_FATPTR(x357);
   uint32_t x359 = Uint32_val(x356);
   struct _cl_device_id** x362 = CTYPES_ADDR_OF_FATPTR(x355);
   char* x363 = CTYPES_ADDR_OF_FATPTR(x354);
   uint32_t x364 = Uint32_val(x353);
   struct _cl_program** x367 = CTYPES_ADDR_OF_FATPTR(x352);
   const char** x368 = CTYPES_ADDR_OF_FATPTR(x351);
   void* x369 = CTYPES_ADDR_OF_FATPTR(x350);
   void* x370 = CTYPES_ADDR_OF_FATPTR(x349);
   int32_t x371 =
   clCompileProgram(x358, x359, x362, x363, x364, x367, x368, x369, x370);
   return caml_copy_int32(x371);
}
value owl_opencl_stub_34_clCompileProgram_byte9(value* argv, int argc)
{
   value x372 = argv[8];
   value x373 = argv[7];
   value x374 = argv[6];
   value x375 = argv[5];
   value x376 = argv[4];
   value x377 = argv[3];
   value x378 = argv[2];
   value x379 = argv[1];
   value x380 = argv[0];
   return
     owl_opencl_stub_34_clCompileProgram(x380, x379, x378, x377, x376, 
                                         x375, x374, x373, x372);
}
value owl_opencl_stub_35_clLinkProgram(value x389, value x388, value x387,
                                       value x386, value x385, value x384,
                                       value x383, value x382, value x381)
{
   struct _cl_context* x390 = CTYPES_ADDR_OF_FATPTR(x389);
   uint32_t x391 = Uint32_val(x388);
   struct _cl_device_id** x394 = CTYPES_ADDR_OF_FATPTR(x387);
   char* x395 = CTYPES_ADDR_OF_FATPTR(x386);
   uint32_t x396 = Uint32_val(x385);
   struct _cl_program** x399 = CTYPES_ADDR_OF_FATPTR(x384);
   void* x400 = CTYPES_ADDR_OF_FATPTR(x383);
   void* x401 = CTYPES_ADDR_OF_FATPTR(x382);
   int32_t* x402 = CTYPES_ADDR_OF_FATPTR(x381);
   struct _cl_program* x403 =
   clLinkProgram(x390, x391, x394, x395, x396, x399, x400, x401, x402);
   return CTYPES_FROM_PTR(x403);
}
value owl_opencl_stub_35_clLinkProgram_byte9(value* argv, int argc)
{
   value x404 = argv[8];
   value x405 = argv[7];
   value x406 = argv[6];
   value x407 = argv[5];
   value x408 = argv[4];
   value x409 = argv[3];
   value x410 = argv[2];
   value x411 = argv[1];
   value x412 = argv[0];
   return
     owl_opencl_stub_35_clLinkProgram(x412, x411, x410, x409, x408, x407,
                                      x406, x405, x404);
}
value owl_opencl_stub_36_clUnloadPlatformCompiler(value x413)
{
   struct _cl_platform_id* x414 = CTYPES_ADDR_OF_FATPTR(x413);
   int32_t x415 = clUnloadPlatformCompiler(x414);
   return caml_copy_int32(x415);
}
value owl_opencl_stub_37_clGetProgramInfo(value x420, value x419, value x418,
                                          value x417, value x416)
{
   struct _cl_program* x421 = CTYPES_ADDR_OF_FATPTR(x420);
   uint32_t x422 = Uint32_val(x419);
   size_t x425 = ctypes_size_t_val(x418);
   void* x428 = CTYPES_ADDR_OF_FATPTR(x417);
   size_t* x429 = CTYPES_ADDR_OF_FATPTR(x416);
   int32_t x430 = clGetProgramInfo(x421, x422, x425, x428, x429);
   return caml_copy_int32(x430);
}
value owl_opencl_stub_38_clGetProgramBuildInfo(value x436, value x435,
                                               value x434, value x433,
                                               value x432, value x431)
{
   struct _cl_program* x437 = CTYPES_ADDR_OF_FATPTR(x436);
   struct _cl_device_id* x438 = CTYPES_ADDR_OF_FATPTR(x435);
   uint32_t x439 = Uint32_val(x434);
   size_t x442 = ctypes_size_t_val(x433);
   void* x445 = CTYPES_ADDR_OF_FATPTR(x432);
   size_t* x446 = CTYPES_ADDR_OF_FATPTR(x431);
   int32_t x447 = clGetProgramBuildInfo(x437, x438, x439, x442, x445, x446);
   return caml_copy_int32(x447);
}
value owl_opencl_stub_38_clGetProgramBuildInfo_byte6(value* argv, int argc)
{
   value x448 = argv[5];
   value x449 = argv[4];
   value x450 = argv[3];
   value x451 = argv[2];
   value x452 = argv[1];
   value x453 = argv[0];
   return
     owl_opencl_stub_38_clGetProgramBuildInfo(x453, x452, x451, x450, 
                                              x449, x448);
}
value owl_opencl_stub_39_clCreateKernel(value x456, value x455, value x454)
{
   struct _cl_program* x457 = CTYPES_ADDR_OF_FATPTR(x456);
   char* x458 = CTYPES_ADDR_OF_FATPTR(x455);
   int32_t* x459 = CTYPES_ADDR_OF_FATPTR(x454);
   struct _cl_kernel* x460 = clCreateKernel(x457, x458, x459);
   return CTYPES_FROM_PTR(x460);
}
value owl_opencl_stub_40_clCreateKernelsInProgram(value x464, value x463,
                                                  value x462, value x461)
{
   struct _cl_program* x465 = CTYPES_ADDR_OF_FATPTR(x464);
   uint32_t x466 = Uint32_val(x463);
   struct _cl_kernel** x469 = CTYPES_ADDR_OF_FATPTR(x462);
   uint32_t* x470 = CTYPES_ADDR_OF_FATPTR(x461);
   int32_t x471 = clCreateKernelsInProgram(x465, x466, x469, x470);
   return caml_copy_int32(x471);
}
value owl_opencl_stub_41_clRetainKernel(value x472)
{
   struct _cl_kernel* x473 = CTYPES_ADDR_OF_FATPTR(x472);
   int32_t x474 = clRetainKernel(x473);
   return caml_copy_int32(x474);
}
value owl_opencl_stub_42_clReleaseKernel(value x475)
{
   struct _cl_kernel* x476 = CTYPES_ADDR_OF_FATPTR(x475);
   int32_t x477 = clReleaseKernel(x476);
   return caml_copy_int32(x477);
}
value owl_opencl_stub_43_clSetKernelArg(value x481, value x480, value x479,
                                        value x478)
{
   struct _cl_kernel* x482 = CTYPES_ADDR_OF_FATPTR(x481);
   uint32_t x483 = Uint32_val(x480);
   size_t x486 = ctypes_size_t_val(x479);
   void* x489 = CTYPES_ADDR_OF_FATPTR(x478);
   int32_t x490 = clSetKernelArg(x482, x483, x486, x489);
   return caml_copy_int32(x490);
}
value owl_opencl_stub_44_clGetKernelInfo(value x495, value x494, value x493,
                                         value x492, value x491)
{
   struct _cl_kernel* x496 = CTYPES_ADDR_OF_FATPTR(x495);
   uint32_t x497 = Uint32_val(x494);
   size_t x500 = ctypes_size_t_val(x493);
   void* x503 = CTYPES_ADDR_OF_FATPTR(x492);
   size_t* x504 = CTYPES_ADDR_OF_FATPTR(x491);
   int32_t x505 = clGetKernelInfo(x496, x497, x500, x503, x504);
   return caml_copy_int32(x505);
}
value owl_opencl_stub_45_clGetKernelArgInfo(value x511, value x510,
                                            value x509, value x508,
                                            value x507, value x506)
{
   struct _cl_kernel* x512 = CTYPES_ADDR_OF_FATPTR(x511);
   uint32_t x513 = Uint32_val(x510);
   uint32_t x516 = Uint32_val(x509);
   size_t x519 = ctypes_size_t_val(x508);
   void* x522 = CTYPES_ADDR_OF_FATPTR(x507);
   size_t* x523 = CTYPES_ADDR_OF_FATPTR(x506);
   int32_t x524 = clGetKernelArgInfo(x512, x513, x516, x519, x522, x523);
   return caml_copy_int32(x524);
}
value owl_opencl_stub_45_clGetKernelArgInfo_byte6(value* argv, int argc)
{
   value x525 = argv[5];
   value x526 = argv[4];
   value x527 = argv[3];
   value x528 = argv[2];
   value x529 = argv[1];
   value x530 = argv[0];
   return
     owl_opencl_stub_45_clGetKernelArgInfo(x530, x529, x528, x527, x526,
                                           x525);
}
value owl_opencl_stub_46_clGetKernelWorkGroupInfo(value x536, value x535,
                                                  value x534, value x533,
                                                  value x532, value x531)
{
   struct _cl_kernel* x537 = CTYPES_ADDR_OF_FATPTR(x536);
   struct _cl_device_id* x538 = CTYPES_ADDR_OF_FATPTR(x535);
   uint32_t x539 = Uint32_val(x534);
   size_t x542 = ctypes_size_t_val(x533);
   void* x545 = CTYPES_ADDR_OF_FATPTR(x532);
   size_t* x546 = CTYPES_ADDR_OF_FATPTR(x531);
   int32_t x547 =
   clGetKernelWorkGroupInfo(x537, x538, x539, x542, x545, x546);
   return caml_copy_int32(x547);
}
value owl_opencl_stub_46_clGetKernelWorkGroupInfo_byte6(value* argv,
                                                        int argc)
{
   value x548 = argv[5];
   value x549 = argv[4];
   value x550 = argv[3];
   value x551 = argv[2];
   value x552 = argv[1];
   value x553 = argv[0];
   return
     owl_opencl_stub_46_clGetKernelWorkGroupInfo(x553, x552, x551, x550,
                                                 x549, x548);
}
value owl_opencl_stub_47_clWaitForEvents(value x555, value x554)
{
   uint32_t x556 = Uint32_val(x555);
   struct _cl_event** x559 = CTYPES_ADDR_OF_FATPTR(x554);
   int32_t x560 = clWaitForEvents(x556, x559);
   return caml_copy_int32(x560);
}
value owl_opencl_stub_48_clGetEventInfo(value x565, value x564, value x563,
                                        value x562, value x561)
{
   struct _cl_event* x566 = CTYPES_ADDR_OF_FATPTR(x565);
   uint32_t x567 = Uint32_val(x564);
   size_t x570 = ctypes_size_t_val(x563);
   void* x573 = CTYPES_ADDR_OF_FATPTR(x562);
   size_t* x574 = CTYPES_ADDR_OF_FATPTR(x561);
   int32_t x575 = clGetEventInfo(x566, x567, x570, x573, x574);
   return caml_copy_int32(x575);
}
value owl_opencl_stub_49_clCreateUserEvent(value x577, value x576)
{
   struct _cl_context* x578 = CTYPES_ADDR_OF_FATPTR(x577);
   int32_t* x579 = CTYPES_ADDR_OF_FATPTR(x576);
   struct _cl_event* x580 = clCreateUserEvent(x578, x579);
   return CTYPES_FROM_PTR(x580);
}
value owl_opencl_stub_50_clRetainEvent(value x581)
{
   struct _cl_event* x582 = CTYPES_ADDR_OF_FATPTR(x581);
   int32_t x583 = clRetainEvent(x582);
   return caml_copy_int32(x583);
}
value owl_opencl_stub_51_clReleaseEvent(value x584)
{
   struct _cl_event* x585 = CTYPES_ADDR_OF_FATPTR(x584);
   int32_t x586 = clReleaseEvent(x585);
   return caml_copy_int32(x586);
}
value owl_opencl_stub_52_clSetUserEventStatus(value x588, value x587)
{
   struct _cl_event* x589 = CTYPES_ADDR_OF_FATPTR(x588);
   int32_t x590 = Int32_val(x587);
   int32_t x593 = clSetUserEventStatus(x589, x590);
   return caml_copy_int32(x593);
}
value owl_opencl_stub_53_clSetEventCallback(value x597, value x596,
                                            value x595, value x594)
{
   struct _cl_event* x598 = CTYPES_ADDR_OF_FATPTR(x597);
   int32_t x599 = Int32_val(x596);
   void* x602 = CTYPES_ADDR_OF_FATPTR(x595);
   void* x603 = CTYPES_ADDR_OF_FATPTR(x594);
   int32_t x604 = clSetEventCallback(x598, x599, x602, x603);
   return caml_copy_int32(x604);
}
value owl_opencl_stub_54_clGetEventProfilingInfo(value x609, value x608,
                                                 value x607, value x606,
                                                 value x605)
{
   struct _cl_event* x610 = CTYPES_ADDR_OF_FATPTR(x609);
   uint32_t x611 = Uint32_val(x608);
   size_t x614 = ctypes_size_t_val(x607);
   void* x617 = CTYPES_ADDR_OF_FATPTR(x606);
   size_t* x618 = CTYPES_ADDR_OF_FATPTR(x605);
   int32_t x619 = clGetEventProfilingInfo(x610, x611, x614, x617, x618);
   return caml_copy_int32(x619);
}
value owl_opencl_stub_55_clFlush(value x620)
{
   struct _cl_command_queue* x621 = CTYPES_ADDR_OF_FATPTR(x620);
   int32_t x622 = clFlush(x621);
   return caml_copy_int32(x622);
}
value owl_opencl_stub_56_clFinish(value x623)
{
   struct _cl_command_queue* x624 = CTYPES_ADDR_OF_FATPTR(x623);
   int32_t x625 = clFinish(x624);
   return caml_copy_int32(x625);
}
value owl_opencl_stub_57_clEnqueueReadBuffer(value x634, value x633,
                                             value x632, value x631,
                                             value x630, value x629,
                                             value x628, value x627,
                                             value x626)
{
   struct _cl_command_queue* x635 = CTYPES_ADDR_OF_FATPTR(x634);
   struct _cl_mem* x636 = CTYPES_ADDR_OF_FATPTR(x633);
   uint32_t x637 = Uint32_val(x632);
   size_t x640 = ctypes_size_t_val(x631);
   size_t x643 = ctypes_size_t_val(x630);
   void* x646 = CTYPES_ADDR_OF_FATPTR(x629);
   uint32_t x647 = Uint32_val(x628);
   struct _cl_event** x650 = CTYPES_ADDR_OF_FATPTR(x627);
   struct _cl_event** x651 = CTYPES_ADDR_OF_FATPTR(x626);
   int32_t x652 =
   clEnqueueReadBuffer(x635, x636, x637, x640, x643, x646, x647, x650, x651);
   return caml_copy_int32(x652);
}
value owl_opencl_stub_57_clEnqueueReadBuffer_byte9(value* argv, int argc)
{
   value x653 = argv[8];
   value x654 = argv[7];
   value x655 = argv[6];
   value x656 = argv[5];
   value x657 = argv[4];
   value x658 = argv[3];
   value x659 = argv[2];
   value x660 = argv[1];
   value x661 = argv[0];
   return
     owl_opencl_stub_57_clEnqueueReadBuffer(x661, x660, x659, x658, x657,
                                            x656, x655, x654, x653);
}
value owl_opencl_stub_58_clEnqueueReadBufferRect(value x675, value x674,
                                                 value x673, value x672,
                                                 value x671, value x670,
                                                 value x669, value x668,
                                                 value x667, value x666,
                                                 value x665, value x664,
                                                 value x663, value x662)
{
   struct _cl_command_queue* x676 = CTYPES_ADDR_OF_FATPTR(x675);
   struct _cl_mem* x677 = CTYPES_ADDR_OF_FATPTR(x674);
   uint32_t x678 = Uint32_val(x673);
   size_t* x681 = CTYPES_ADDR_OF_FATPTR(x672);
   size_t* x682 = CTYPES_ADDR_OF_FATPTR(x671);
   size_t* x683 = CTYPES_ADDR_OF_FATPTR(x670);
   size_t x684 = ctypes_size_t_val(x669);
   size_t x687 = ctypes_size_t_val(x668);
   size_t x690 = ctypes_size_t_val(x667);
   size_t x693 = ctypes_size_t_val(x666);
   void* x696 = CTYPES_ADDR_OF_FATPTR(x665);
   uint32_t x697 = Uint32_val(x664);
   struct _cl_event** x700 = CTYPES_ADDR_OF_FATPTR(x663);
   struct _cl_event** x701 = CTYPES_ADDR_OF_FATPTR(x662);
   int32_t x702 =
   clEnqueueReadBufferRect(x676, x677, x678, x681, x682, x683, x684, 
                           x687, x690, x693, x696, x697, x700, x701);
   return caml_copy_int32(x702);
}
value owl_opencl_stub_58_clEnqueueReadBufferRect_byte14(value* argv,
                                                        int argc)
{
   value x703 = argv[13];
   value x704 = argv[12];
   value x705 = argv[11];
   value x706 = argv[10];
   value x707 = argv[9];
   value x708 = argv[8];
   value x709 = argv[7];
   value x710 = argv[6];
   value x711 = argv[5];
   value x712 = argv[4];
   value x713 = argv[3];
   value x714 = argv[2];
   value x715 = argv[1];
   value x716 = argv[0];
   return
     owl_opencl_stub_58_clEnqueueReadBufferRect(x716, x715, x714, x713, 
                                                x712, x711, x710, x709, 
                                                x708, x707, x706, x705, 
                                                x704, x703);
}
value owl_opencl_stub_59_clEnqueueWriteBuffer(value x725, value x724,
                                              value x723, value x722,
                                              value x721, value x720,
                                              value x719, value x718,
                                              value x717)
{
   struct _cl_command_queue* x726 = CTYPES_ADDR_OF_FATPTR(x725);
   struct _cl_mem* x727 = CTYPES_ADDR_OF_FATPTR(x724);
   uint32_t x728 = Uint32_val(x723);
   size_t x731 = ctypes_size_t_val(x722);
   size_t x734 = ctypes_size_t_val(x721);
   void* x737 = CTYPES_ADDR_OF_FATPTR(x720);
   uint32_t x738 = Uint32_val(x719);
   struct _cl_event** x741 = CTYPES_ADDR_OF_FATPTR(x718);
   struct _cl_event** x742 = CTYPES_ADDR_OF_FATPTR(x717);
   int32_t x743 =
   clEnqueueWriteBuffer(x726, x727, x728, x731, x734, x737, x738, x741, x742);
   return caml_copy_int32(x743);
}
value owl_opencl_stub_59_clEnqueueWriteBuffer_byte9(value* argv, int argc)
{
   value x744 = argv[8];
   value x745 = argv[7];
   value x746 = argv[6];
   value x747 = argv[5];
   value x748 = argv[4];
   value x749 = argv[3];
   value x750 = argv[2];
   value x751 = argv[1];
   value x752 = argv[0];
   return
     owl_opencl_stub_59_clEnqueueWriteBuffer(x752, x751, x750, x749, 
                                             x748, x747, x746, x745, 
                                             x744);
}
value owl_opencl_stub_60_clEnqueueWriteBufferRect(value x766, value x765,
                                                  value x764, value x763,
                                                  value x762, value x761,
                                                  value x760, value x759,
                                                  value x758, value x757,
                                                  value x756, value x755,
                                                  value x754, value x753)
{
   struct _cl_command_queue* x767 = CTYPES_ADDR_OF_FATPTR(x766);
   struct _cl_mem* x768 = CTYPES_ADDR_OF_FATPTR(x765);
   uint32_t x769 = Uint32_val(x764);
   size_t* x772 = CTYPES_ADDR_OF_FATPTR(x763);
   size_t* x773 = CTYPES_ADDR_OF_FATPTR(x762);
   size_t* x774 = CTYPES_ADDR_OF_FATPTR(x761);
   size_t x775 = ctypes_size_t_val(x760);
   size_t x778 = ctypes_size_t_val(x759);
   size_t x781 = ctypes_size_t_val(x758);
   size_t x784 = ctypes_size_t_val(x757);
   void* x787 = CTYPES_ADDR_OF_FATPTR(x756);
   uint32_t x788 = Uint32_val(x755);
   struct _cl_event** x791 = CTYPES_ADDR_OF_FATPTR(x754);
   struct _cl_event** x792 = CTYPES_ADDR_OF_FATPTR(x753);
   int32_t x793 =
   clEnqueueWriteBufferRect(x767, x768, x769, x772, x773, x774, x775, 
                            x778, x781, x784, x787, x788, x791, x792);
   return caml_copy_int32(x793);
}
value owl_opencl_stub_60_clEnqueueWriteBufferRect_byte14(value* argv,
                                                         int argc)
{
   value x794 = argv[13];
   value x795 = argv[12];
   value x796 = argv[11];
   value x797 = argv[10];
   value x798 = argv[9];
   value x799 = argv[8];
   value x800 = argv[7];
   value x801 = argv[6];
   value x802 = argv[5];
   value x803 = argv[4];
   value x804 = argv[3];
   value x805 = argv[2];
   value x806 = argv[1];
   value x807 = argv[0];
   return
     owl_opencl_stub_60_clEnqueueWriteBufferRect(x807, x806, x805, x804,
                                                 x803, x802, x801, x800,
                                                 x799, x798, x797, x796,
                                                 x795, x794);
}
value owl_opencl_stub_61_clEnqueueFillBuffer(value x816, value x815,
                                             value x814, value x813,
                                             value x812, value x811,
                                             value x810, value x809,
                                             value x808)
{
   struct _cl_command_queue* x817 = CTYPES_ADDR_OF_FATPTR(x816);
   struct _cl_mem* x818 = CTYPES_ADDR_OF_FATPTR(x815);
   void* x819 = CTYPES_ADDR_OF_FATPTR(x814);
   size_t x820 = ctypes_size_t_val(x813);
   size_t x823 = ctypes_size_t_val(x812);
   size_t x826 = ctypes_size_t_val(x811);
   uint32_t x829 = Uint32_val(x810);
   struct _cl_event** x832 = CTYPES_ADDR_OF_FATPTR(x809);
   struct _cl_event** x833 = CTYPES_ADDR_OF_FATPTR(x808);
   int32_t x834 =
   clEnqueueFillBuffer(x817, x818, x819, x820, x823, x826, x829, x832, x833);
   return caml_copy_int32(x834);
}
value owl_opencl_stub_61_clEnqueueFillBuffer_byte9(value* argv, int argc)
{
   value x835 = argv[8];
   value x836 = argv[7];
   value x837 = argv[6];
   value x838 = argv[5];
   value x839 = argv[4];
   value x840 = argv[3];
   value x841 = argv[2];
   value x842 = argv[1];
   value x843 = argv[0];
   return
     owl_opencl_stub_61_clEnqueueFillBuffer(x843, x842, x841, x840, x839,
                                            x838, x837, x836, x835);
}
value owl_opencl_stub_62_clEnqueueCopyBuffer(value x852, value x851,
                                             value x850, value x849,
                                             value x848, value x847,
                                             value x846, value x845,
                                             value x844)
{
   struct _cl_command_queue* x853 = CTYPES_ADDR_OF_FATPTR(x852);
   struct _cl_mem* x854 = CTYPES_ADDR_OF_FATPTR(x851);
   struct _cl_mem* x855 = CTYPES_ADDR_OF_FATPTR(x850);
   size_t x856 = ctypes_size_t_val(x849);
   size_t x859 = ctypes_size_t_val(x848);
   size_t x862 = ctypes_size_t_val(x847);
   uint32_t x865 = Uint32_val(x846);
   struct _cl_event** x868 = CTYPES_ADDR_OF_FATPTR(x845);
   struct _cl_event** x869 = CTYPES_ADDR_OF_FATPTR(x844);
   int32_t x870 =
   clEnqueueCopyBuffer(x853, x854, x855, x856, x859, x862, x865, x868, x869);
   return caml_copy_int32(x870);
}
value owl_opencl_stub_62_clEnqueueCopyBuffer_byte9(value* argv, int argc)
{
   value x871 = argv[8];
   value x872 = argv[7];
   value x873 = argv[6];
   value x874 = argv[5];
   value x875 = argv[4];
   value x876 = argv[3];
   value x877 = argv[2];
   value x878 = argv[1];
   value x879 = argv[0];
   return
     owl_opencl_stub_62_clEnqueueCopyBuffer(x879, x878, x877, x876, x875,
                                            x874, x873, x872, x871);
}
value owl_opencl_stub_63_clEnqueueCopyBufferRect(value x892, value x891,
                                                 value x890, value x889,
                                                 value x888, value x887,
                                                 value x886, value x885,
                                                 value x884, value x883,
                                                 value x882, value x881,
                                                 value x880)
{
   struct _cl_command_queue* x893 = CTYPES_ADDR_OF_FATPTR(x892);
   struct _cl_mem* x894 = CTYPES_ADDR_OF_FATPTR(x891);
   struct _cl_mem* x895 = CTYPES_ADDR_OF_FATPTR(x890);
   size_t* x896 = CTYPES_ADDR_OF_FATPTR(x889);
   size_t* x897 = CTYPES_ADDR_OF_FATPTR(x888);
   size_t* x898 = CTYPES_ADDR_OF_FATPTR(x887);
   size_t x899 = ctypes_size_t_val(x886);
   size_t x902 = ctypes_size_t_val(x885);
   size_t x905 = ctypes_size_t_val(x884);
   size_t x908 = ctypes_size_t_val(x883);
   uint32_t x911 = Uint32_val(x882);
   struct _cl_event** x914 = CTYPES_ADDR_OF_FATPTR(x881);
   struct _cl_event** x915 = CTYPES_ADDR_OF_FATPTR(x880);
   int32_t x916 =
   clEnqueueCopyBufferRect(x893, x894, x895, x896, x897, x898, x899, 
                           x902, x905, x908, x911, x914, x915);
   return caml_copy_int32(x916);
}
value owl_opencl_stub_63_clEnqueueCopyBufferRect_byte13(value* argv,
                                                        int argc)
{
   value x917 = argv[12];
   value x918 = argv[11];
   value x919 = argv[10];
   value x920 = argv[9];
   value x921 = argv[8];
   value x922 = argv[7];
   value x923 = argv[6];
   value x924 = argv[5];
   value x925 = argv[4];
   value x926 = argv[3];
   value x927 = argv[2];
   value x928 = argv[1];
   value x929 = argv[0];
   return
     owl_opencl_stub_63_clEnqueueCopyBufferRect(x929, x928, x927, x926, 
                                                x925, x924, x923, x922, 
                                                x921, x920, x919, x918, 
                                                x917);
}
value owl_opencl_stub_64_clEnqueueReadImage(value x940, value x939,
                                            value x938, value x937,
                                            value x936, value x935,
                                            value x934, value x933,
                                            value x932, value x931,
                                            value x930)
{
   struct _cl_command_queue* x941 = CTYPES_ADDR_OF_FATPTR(x940);
   struct _cl_mem* x942 = CTYPES_ADDR_OF_FATPTR(x939);
   uint32_t x943 = Uint32_val(x938);
   size_t* x946 = CTYPES_ADDR_OF_FATPTR(x937);
   size_t* x947 = CTYPES_ADDR_OF_FATPTR(x936);
   size_t x948 = ctypes_size_t_val(x935);
   size_t x951 = ctypes_size_t_val(x934);
   void* x954 = CTYPES_ADDR_OF_FATPTR(x933);
   uint32_t x955 = Uint32_val(x932);
   struct _cl_event** x958 = CTYPES_ADDR_OF_FATPTR(x931);
   struct _cl_event** x959 = CTYPES_ADDR_OF_FATPTR(x930);
   int32_t x960 =
   clEnqueueReadImage(x941, x942, x943, x946, x947, x948, x951, x954, 
                      x955, x958, x959);
   return caml_copy_int32(x960);
}
value owl_opencl_stub_64_clEnqueueReadImage_byte11(value* argv, int argc)
{
   value x961 = argv[10];
   value x962 = argv[9];
   value x963 = argv[8];
   value x964 = argv[7];
   value x965 = argv[6];
   value x966 = argv[5];
   value x967 = argv[4];
   value x968 = argv[3];
   value x969 = argv[2];
   value x970 = argv[1];
   value x971 = argv[0];
   return
     owl_opencl_stub_64_clEnqueueReadImage(x971, x970, x969, x968, x967,
                                           x966, x965, x964, x963, x962,
                                           x961);
}
value owl_opencl_stub_65_clEnqueueWriteImage(value x982, value x981,
                                             value x980, value x979,
                                             value x978, value x977,
                                             value x976, value x975,
                                             value x974, value x973,
                                             value x972)
{
   struct _cl_command_queue* x983 = CTYPES_ADDR_OF_FATPTR(x982);
   struct _cl_mem* x984 = CTYPES_ADDR_OF_FATPTR(x981);
   uint32_t x985 = Uint32_val(x980);
   size_t* x988 = CTYPES_ADDR_OF_FATPTR(x979);
   size_t* x989 = CTYPES_ADDR_OF_FATPTR(x978);
   size_t x990 = ctypes_size_t_val(x977);
   size_t x993 = ctypes_size_t_val(x976);
   void* x996 = CTYPES_ADDR_OF_FATPTR(x975);
   uint32_t x997 = Uint32_val(x974);
   struct _cl_event** x1000 = CTYPES_ADDR_OF_FATPTR(x973);
   struct _cl_event** x1001 = CTYPES_ADDR_OF_FATPTR(x972);
   int32_t x1002 =
   clEnqueueWriteImage(x983, x984, x985, x988, x989, x990, x993, x996, 
                       x997, x1000, x1001);
   return caml_copy_int32(x1002);
}
value owl_opencl_stub_65_clEnqueueWriteImage_byte11(value* argv, int argc)
{
   value x1003 = argv[10];
   value x1004 = argv[9];
   value x1005 = argv[8];
   value x1006 = argv[7];
   value x1007 = argv[6];
   value x1008 = argv[5];
   value x1009 = argv[4];
   value x1010 = argv[3];
   value x1011 = argv[2];
   value x1012 = argv[1];
   value x1013 = argv[0];
   return
     owl_opencl_stub_65_clEnqueueWriteImage(x1013, x1012, x1011, x1010,
                                            x1009, x1008, x1007, x1006,
                                            x1005, x1004, x1003);
}
value owl_opencl_stub_66_clEnqueueFillImage(value x1021, value x1020,
                                            value x1019, value x1018,
                                            value x1017, value x1016,
                                            value x1015, value x1014)
{
   struct _cl_command_queue* x1022 = CTYPES_ADDR_OF_FATPTR(x1021);
   struct _cl_mem* x1023 = CTYPES_ADDR_OF_FATPTR(x1020);
   void* x1024 = CTYPES_ADDR_OF_FATPTR(x1019);
   size_t* x1025 = CTYPES_ADDR_OF_FATPTR(x1018);
   size_t* x1026 = CTYPES_ADDR_OF_FATPTR(x1017);
   uint32_t x1027 = Uint32_val(x1016);
   struct _cl_event** x1030 = CTYPES_ADDR_OF_FATPTR(x1015);
   struct _cl_event** x1031 = CTYPES_ADDR_OF_FATPTR(x1014);
   int32_t x1032 =
   clEnqueueFillImage(x1022, x1023, x1024, x1025, x1026, x1027, x1030, x1031);
   return caml_copy_int32(x1032);
}
value owl_opencl_stub_66_clEnqueueFillImage_byte8(value* argv, int argc)
{
   value x1033 = argv[7];
   value x1034 = argv[6];
   value x1035 = argv[5];
   value x1036 = argv[4];
   value x1037 = argv[3];
   value x1038 = argv[2];
   value x1039 = argv[1];
   value x1040 = argv[0];
   return
     owl_opencl_stub_66_clEnqueueFillImage(x1040, x1039, x1038, x1037, 
                                           x1036, x1035, x1034, x1033);
}
value owl_opencl_stub_67_clEnqueueCopyImage(value x1049, value x1048,
                                            value x1047, value x1046,
                                            value x1045, value x1044,
                                            value x1043, value x1042,
                                            value x1041)
{
   struct _cl_command_queue* x1050 = CTYPES_ADDR_OF_FATPTR(x1049);
   struct _cl_mem* x1051 = CTYPES_ADDR_OF_FATPTR(x1048);
   struct _cl_mem* x1052 = CTYPES_ADDR_OF_FATPTR(x1047);
   size_t* x1053 = CTYPES_ADDR_OF_FATPTR(x1046);
   size_t* x1054 = CTYPES_ADDR_OF_FATPTR(x1045);
   size_t* x1055 = CTYPES_ADDR_OF_FATPTR(x1044);
   uint32_t x1056 = Uint32_val(x1043);
   struct _cl_event** x1059 = CTYPES_ADDR_OF_FATPTR(x1042);
   struct _cl_event** x1060 = CTYPES_ADDR_OF_FATPTR(x1041);
   int32_t x1061 =
   clEnqueueCopyImage(x1050, x1051, x1052, x1053, x1054, x1055, x1056, 
                      x1059, x1060);
   return caml_copy_int32(x1061);
}
value owl_opencl_stub_67_clEnqueueCopyImage_byte9(value* argv, int argc)
{
   value x1062 = argv[8];
   value x1063 = argv[7];
   value x1064 = argv[6];
   value x1065 = argv[5];
   value x1066 = argv[4];
   value x1067 = argv[3];
   value x1068 = argv[2];
   value x1069 = argv[1];
   value x1070 = argv[0];
   return
     owl_opencl_stub_67_clEnqueueCopyImage(x1070, x1069, x1068, x1067, 
                                           x1066, x1065, x1064, x1063, 
                                           x1062);
}
value owl_opencl_stub_68_clEnqueueCopyImageToBuffer(value x1079, value x1078,
                                                    value x1077, value x1076,
                                                    value x1075, value x1074,
                                                    value x1073, value x1072,
                                                    value x1071)
{
   struct _cl_command_queue* x1080 = CTYPES_ADDR_OF_FATPTR(x1079);
   struct _cl_mem* x1081 = CTYPES_ADDR_OF_FATPTR(x1078);
   struct _cl_mem* x1082 = CTYPES_ADDR_OF_FATPTR(x1077);
   size_t* x1083 = CTYPES_ADDR_OF_FATPTR(x1076);
   size_t* x1084 = CTYPES_ADDR_OF_FATPTR(x1075);
   size_t x1085 = ctypes_size_t_val(x1074);
   uint32_t x1088 = Uint32_val(x1073);
   struct _cl_event** x1091 = CTYPES_ADDR_OF_FATPTR(x1072);
   struct _cl_event** x1092 = CTYPES_ADDR_OF_FATPTR(x1071);
   int32_t x1093 =
   clEnqueueCopyImageToBuffer(x1080, x1081, x1082, x1083, x1084, x1085,
                              x1088, x1091, x1092);
   return caml_copy_int32(x1093);
}
value owl_opencl_stub_68_clEnqueueCopyImageToBuffer_byte9(value* argv,
                                                          int argc)
{
   value x1094 = argv[8];
   value x1095 = argv[7];
   value x1096 = argv[6];
   value x1097 = argv[5];
   value x1098 = argv[4];
   value x1099 = argv[3];
   value x1100 = argv[2];
   value x1101 = argv[1];
   value x1102 = argv[0];
   return
     owl_opencl_stub_68_clEnqueueCopyImageToBuffer(x1102, x1101, x1100,
                                                   x1099, x1098, x1097,
                                                   x1096, x1095, x1094);
}
value owl_opencl_stub_69_clEnqueueCopyBufferToImage(value x1111, value x1110,
                                                    value x1109, value x1108,
                                                    value x1107, value x1106,
                                                    value x1105, value x1104,
                                                    value x1103)
{
   struct _cl_command_queue* x1112 = CTYPES_ADDR_OF_FATPTR(x1111);
   struct _cl_mem* x1113 = CTYPES_ADDR_OF_FATPTR(x1110);
   struct _cl_mem* x1114 = CTYPES_ADDR_OF_FATPTR(x1109);
   size_t x1115 = ctypes_size_t_val(x1108);
   size_t* x1118 = CTYPES_ADDR_OF_FATPTR(x1107);
   size_t* x1119 = CTYPES_ADDR_OF_FATPTR(x1106);
   uint32_t x1120 = Uint32_val(x1105);
   struct _cl_event** x1123 = CTYPES_ADDR_OF_FATPTR(x1104);
   struct _cl_event** x1124 = CTYPES_ADDR_OF_FATPTR(x1103);
   int32_t x1125 =
   clEnqueueCopyBufferToImage(x1112, x1113, x1114, x1115, x1118, x1119,
                              x1120, x1123, x1124);
   return caml_copy_int32(x1125);
}
value owl_opencl_stub_69_clEnqueueCopyBufferToImage_byte9(value* argv,
                                                          int argc)
{
   value x1126 = argv[8];
   value x1127 = argv[7];
   value x1128 = argv[6];
   value x1129 = argv[5];
   value x1130 = argv[4];
   value x1131 = argv[3];
   value x1132 = argv[2];
   value x1133 = argv[1];
   value x1134 = argv[0];
   return
     owl_opencl_stub_69_clEnqueueCopyBufferToImage(x1134, x1133, x1132,
                                                   x1131, x1130, x1129,
                                                   x1128, x1127, x1126);
}
value owl_opencl_stub_70_clEnqueueMapBuffer(value x1144, value x1143,
                                            value x1142, value x1141,
                                            value x1140, value x1139,
                                            value x1138, value x1137,
                                            value x1136, value x1135)
{
   struct _cl_command_queue* x1145 = CTYPES_ADDR_OF_FATPTR(x1144);
   struct _cl_mem* x1146 = CTYPES_ADDR_OF_FATPTR(x1143);
   uint32_t x1147 = Uint32_val(x1142);
   unsigned long x1150 = ctypes_ulong_val(x1141);
   size_t x1153 = ctypes_size_t_val(x1140);
   size_t x1156 = ctypes_size_t_val(x1139);
   uint32_t x1159 = Uint32_val(x1138);
   struct _cl_event** x1162 = CTYPES_ADDR_OF_FATPTR(x1137);
   struct _cl_event** x1163 = CTYPES_ADDR_OF_FATPTR(x1136);
   int32_t* x1164 = CTYPES_ADDR_OF_FATPTR(x1135);
   void* x1165 =
   clEnqueueMapBuffer(x1145, x1146, x1147, x1150, x1153, x1156, x1159, 
                      x1162, x1163, x1164);
   return CTYPES_FROM_PTR(x1165);
}
value owl_opencl_stub_70_clEnqueueMapBuffer_byte10(value* argv, int argc)
{
   value x1166 = argv[9];
   value x1167 = argv[8];
   value x1168 = argv[7];
   value x1169 = argv[6];
   value x1170 = argv[5];
   value x1171 = argv[4];
   value x1172 = argv[3];
   value x1173 = argv[2];
   value x1174 = argv[1];
   value x1175 = argv[0];
   return
     owl_opencl_stub_70_clEnqueueMapBuffer(x1175, x1174, x1173, x1172, 
                                           x1171, x1170, x1169, x1168, 
                                           x1167, x1166);
}
value owl_opencl_stub_71_clEnqueueMapImage(value x1187, value x1186,
                                           value x1185, value x1184,
                                           value x1183, value x1182,
                                           value x1181, value x1180,
                                           value x1179, value x1178,
                                           value x1177, value x1176)
{
   struct _cl_command_queue* x1188 = CTYPES_ADDR_OF_FATPTR(x1187);
   struct _cl_mem* x1189 = CTYPES_ADDR_OF_FATPTR(x1186);
   uint32_t x1190 = Uint32_val(x1185);
   unsigned long x1193 = ctypes_ulong_val(x1184);
   size_t* x1196 = CTYPES_ADDR_OF_FATPTR(x1183);
   size_t* x1197 = CTYPES_ADDR_OF_FATPTR(x1182);
   size_t* x1198 = CTYPES_ADDR_OF_FATPTR(x1181);
   size_t* x1199 = CTYPES_ADDR_OF_FATPTR(x1180);
   uint32_t x1200 = Uint32_val(x1179);
   struct _cl_event** x1203 = CTYPES_ADDR_OF_FATPTR(x1178);
   struct _cl_event** x1204 = CTYPES_ADDR_OF_FATPTR(x1177);
   int32_t* x1205 = CTYPES_ADDR_OF_FATPTR(x1176);
   void* x1206 =
   clEnqueueMapImage(x1188, x1189, x1190, x1193, x1196, x1197, x1198, 
                     x1199, x1200, x1203, x1204, x1205);
   return CTYPES_FROM_PTR(x1206);
}
value owl_opencl_stub_71_clEnqueueMapImage_byte12(value* argv, int argc)
{
   value x1207 = argv[11];
   value x1208 = argv[10];
   value x1209 = argv[9];
   value x1210 = argv[8];
   value x1211 = argv[7];
   value x1212 = argv[6];
   value x1213 = argv[5];
   value x1214 = argv[4];
   value x1215 = argv[3];
   value x1216 = argv[2];
   value x1217 = argv[1];
   value x1218 = argv[0];
   return
     owl_opencl_stub_71_clEnqueueMapImage(x1218, x1217, x1216, x1215, 
                                          x1214, x1213, x1212, x1211, 
                                          x1210, x1209, x1208, x1207);
}
value owl_opencl_stub_72_clEnqueueUnmapMemObject(value x1224, value x1223,
                                                 value x1222, value x1221,
                                                 value x1220, value x1219)
{
   struct _cl_command_queue* x1225 = CTYPES_ADDR_OF_FATPTR(x1224);
   struct _cl_mem* x1226 = CTYPES_ADDR_OF_FATPTR(x1223);
   void* x1227 = CTYPES_ADDR_OF_FATPTR(x1222);
   uint32_t x1228 = Uint32_val(x1221);
   struct _cl_event** x1231 = CTYPES_ADDR_OF_FATPTR(x1220);
   struct _cl_event** x1232 = CTYPES_ADDR_OF_FATPTR(x1219);
   int32_t x1233 =
   clEnqueueUnmapMemObject(x1225, x1226, x1227, x1228, x1231, x1232);
   return caml_copy_int32(x1233);
}
value owl_opencl_stub_72_clEnqueueUnmapMemObject_byte6(value* argv, int argc)
{
   value x1234 = argv[5];
   value x1235 = argv[4];
   value x1236 = argv[3];
   value x1237 = argv[2];
   value x1238 = argv[1];
   value x1239 = argv[0];
   return
     owl_opencl_stub_72_clEnqueueUnmapMemObject(x1239, x1238, x1237, 
                                                x1236, x1235, x1234);
}
value owl_opencl_stub_73_clEnqueueMigrateMemObjects(value x1246, value x1245,
                                                    value x1244, value x1243,
                                                    value x1242, value x1241,
                                                    value x1240)
{
   struct _cl_command_queue* x1247 = CTYPES_ADDR_OF_FATPTR(x1246);
   uint32_t x1248 = Uint32_val(x1245);
   struct _cl_mem** x1251 = CTYPES_ADDR_OF_FATPTR(x1244);
   unsigned long x1252 = ctypes_ulong_val(x1243);
   uint32_t x1255 = Uint32_val(x1242);
   struct _cl_event** x1258 = CTYPES_ADDR_OF_FATPTR(x1241);
   struct _cl_event** x1259 = CTYPES_ADDR_OF_FATPTR(x1240);
   int32_t x1260 =
   clEnqueueMigrateMemObjects(x1247, x1248, x1251, x1252, x1255, x1258,
                              x1259);
   return caml_copy_int32(x1260);
}
value owl_opencl_stub_73_clEnqueueMigrateMemObjects_byte7(value* argv,
                                                          int argc)
{
   value x1261 = argv[6];
   value x1262 = argv[5];
   value x1263 = argv[4];
   value x1264 = argv[3];
   value x1265 = argv[2];
   value x1266 = argv[1];
   value x1267 = argv[0];
   return
     owl_opencl_stub_73_clEnqueueMigrateMemObjects(x1267, x1266, x1265,
                                                   x1264, x1263, x1262,
                                                   x1261);
}
value owl_opencl_stub_74_clEnqueueNDRangeKernel(value x1276, value x1275,
                                                value x1274, value x1273,
                                                value x1272, value x1271,
                                                value x1270, value x1269,
                                                value x1268)
{
   struct _cl_command_queue* x1277 = CTYPES_ADDR_OF_FATPTR(x1276);
   struct _cl_kernel* x1278 = CTYPES_ADDR_OF_FATPTR(x1275);
   uint32_t x1279 = Uint32_val(x1274);
   size_t* x1282 = CTYPES_ADDR_OF_FATPTR(x1273);
   size_t* x1283 = CTYPES_ADDR_OF_FATPTR(x1272);
   size_t* x1284 = CTYPES_ADDR_OF_FATPTR(x1271);
   uint32_t x1285 = Uint32_val(x1270);
   struct _cl_event** x1288 = CTYPES_ADDR_OF_FATPTR(x1269);
   struct _cl_event** x1289 = CTYPES_ADDR_OF_FATPTR(x1268);
   int32_t x1290 =
   clEnqueueNDRangeKernel(x1277, x1278, x1279, x1282, x1283, x1284, x1285,
                          x1288, x1289);
   return caml_copy_int32(x1290);
}
value owl_opencl_stub_74_clEnqueueNDRangeKernel_byte9(value* argv, int argc)
{
   value x1291 = argv[8];
   value x1292 = argv[7];
   value x1293 = argv[6];
   value x1294 = argv[5];
   value x1295 = argv[4];
   value x1296 = argv[3];
   value x1297 = argv[2];
   value x1298 = argv[1];
   value x1299 = argv[0];
   return
     owl_opencl_stub_74_clEnqueueNDRangeKernel(x1299, x1298, x1297, x1296,
                                               x1295, x1294, x1293, x1292,
                                               x1291);
}
value owl_opencl_stub_75_clEnqueueTask(value x1304, value x1303, value x1302,
                                       value x1301, value x1300)
{
   struct _cl_command_queue* x1305 = CTYPES_ADDR_OF_FATPTR(x1304);
   struct _cl_kernel* x1306 = CTYPES_ADDR_OF_FATPTR(x1303);
   uint32_t x1307 = Uint32_val(x1302);
   struct _cl_event** x1310 = CTYPES_ADDR_OF_FATPTR(x1301);
   struct _cl_event** x1311 = CTYPES_ADDR_OF_FATPTR(x1300);
   int32_t x1312 = clEnqueueTask(x1305, x1306, x1307, x1310, x1311);
   return caml_copy_int32(x1312);
}
value owl_opencl_stub_76_clEnqueueNativeKernel(value x1322, value x1321,
                                               value x1320, value x1319,
                                               value x1318, value x1317,
                                               value x1316, value x1315,
                                               value x1314, value x1313)
{
   struct _cl_command_queue* x1323 = CTYPES_ADDR_OF_FATPTR(x1322);
   void* x1324 = CTYPES_ADDR_OF_FATPTR(x1321);
   void* x1325 = CTYPES_ADDR_OF_FATPTR(x1320);
   size_t x1326 = ctypes_size_t_val(x1319);
   uint32_t x1329 = Uint32_val(x1318);
   struct _cl_mem** x1332 = CTYPES_ADDR_OF_FATPTR(x1317);
   const void** x1333 = CTYPES_ADDR_OF_FATPTR(x1316);
   uint32_t x1334 = Uint32_val(x1315);
   struct _cl_event** x1337 = CTYPES_ADDR_OF_FATPTR(x1314);
   struct _cl_event** x1338 = CTYPES_ADDR_OF_FATPTR(x1313);
   int32_t x1339 =
   clEnqueueNativeKernel(x1323, x1324, x1325, x1326, x1329, x1332, x1333,
                         x1334, x1337, x1338);
   return caml_copy_int32(x1339);
}
value owl_opencl_stub_76_clEnqueueNativeKernel_byte10(value* argv, int argc)
{
   value x1340 = argv[9];
   value x1341 = argv[8];
   value x1342 = argv[7];
   value x1343 = argv[6];
   value x1344 = argv[5];
   value x1345 = argv[4];
   value x1346 = argv[3];
   value x1347 = argv[2];
   value x1348 = argv[1];
   value x1349 = argv[0];
   return
     owl_opencl_stub_76_clEnqueueNativeKernel(x1349, x1348, x1347, x1346,
                                              x1345, x1344, x1343, x1342,
                                              x1341, x1340);
}
value owl_opencl_stub_77_clEnqueueMarkerWithWaitList(value x1353,
                                                     value x1352,
                                                     value x1351,
                                                     value x1350)
{
   struct _cl_command_queue* x1354 = CTYPES_ADDR_OF_FATPTR(x1353);
   uint32_t x1355 = Uint32_val(x1352);
   struct _cl_event** x1358 = CTYPES_ADDR_OF_FATPTR(x1351);
   struct _cl_event** x1359 = CTYPES_ADDR_OF_FATPTR(x1350);
   int32_t x1360 = clEnqueueMarkerWithWaitList(x1354, x1355, x1358, x1359);
   return caml_copy_int32(x1360);
}
value owl_opencl_stub_78_clEnqueueBarrierWithWaitList(value x1364,
                                                      value x1363,
                                                      value x1362,
                                                      value x1361)
{
   struct _cl_command_queue* x1365 = CTYPES_ADDR_OF_FATPTR(x1364);
   uint32_t x1366 = Uint32_val(x1363);
   struct _cl_event** x1369 = CTYPES_ADDR_OF_FATPTR(x1362);
   struct _cl_event** x1370 = CTYPES_ADDR_OF_FATPTR(x1361);
   int32_t x1371 = clEnqueueBarrierWithWaitList(x1365, x1366, x1369, x1370);
   return caml_copy_int32(x1371);
}
value owl_opencl_stub_79_clGetExtensionFunctionAddressForPlatform(value x1373,
                                                                  value x1372)
{
   struct _cl_platform_id* x1374 = CTYPES_ADDR_OF_FATPTR(x1373);
   char* x1375 = CTYPES_ADDR_OF_FATPTR(x1372);
   void* x1376 = clGetExtensionFunctionAddressForPlatform(x1374, x1375);
   return CTYPES_FROM_PTR(x1376);
}
