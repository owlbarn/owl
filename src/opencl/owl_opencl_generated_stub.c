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
   uint64_t x101 = Uint64_val(x98);
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
   uint64_t x135 = Uint64_val(x130);
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
   uint64_t x167 = Uint64_val(x164);
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
   uint64_t x182 = Uint64_val(x179);
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
