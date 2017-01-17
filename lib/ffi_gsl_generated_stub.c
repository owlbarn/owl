#include <gsl/gsl_block_double.h>
#include <gsl/gsl_block_complex_double.h>
#include <gsl/gsl_vector_double.h>
#include <gsl/gsl_vector_complex_double.h>
#include <gsl/gsl_matrix_double.h>
#include <gsl/gsl_matrix_complex_double.h>
#include <gsl/gsl_block_float.h>
#include <gsl/gsl_block_complex_float.h>
#include <gsl/gsl_vector_float.h>
#include <gsl/gsl_vector_complex_float.h>
#include <gsl/gsl_matrix_float.h>
#include <gsl/gsl_matrix_complex_float.h>
#include "ctypes_cstubs_internals.h"
value owl_stub_1_gsl_matrix_equal(value x2, value x1)
{
   gsl_matrix* x3 = CTYPES_ADDR_OF_FATPTR(x2);
   gsl_matrix* x4 = CTYPES_ADDR_OF_FATPTR(x1);
   int x5 = gsl_matrix_equal(x3, x4);
   return Val_long(x5);
}
value owl_stub_2_gsl_matrix_isnull(value x6)
{
   gsl_matrix* x7 = CTYPES_ADDR_OF_FATPTR(x6);
   int x8 = gsl_matrix_isnull(x7);
   return Val_long(x8);
}
value owl_stub_3_gsl_matrix_ispos(value x9)
{
   gsl_matrix* x10 = CTYPES_ADDR_OF_FATPTR(x9);
   int x11 = gsl_matrix_ispos(x10);
   return Val_long(x11);
}
value owl_stub_4_gsl_matrix_isneg(value x12)
{
   gsl_matrix* x13 = CTYPES_ADDR_OF_FATPTR(x12);
   int x14 = gsl_matrix_isneg(x13);
   return Val_long(x14);
}
value owl_stub_5_gsl_matrix_isnonneg(value x15)
{
   gsl_matrix* x16 = CTYPES_ADDR_OF_FATPTR(x15);
   int x17 = gsl_matrix_isnonneg(x16);
   return Val_long(x17);
}
value owl_stub_6_gsl_matrix_min(value x18)
{
   gsl_matrix* x19 = CTYPES_ADDR_OF_FATPTR(x18);
   double x20 = gsl_matrix_min(x19);
   return caml_copy_double(x20);
}
value owl_stub_7_gsl_matrix_max(value x21)
{
   gsl_matrix* x22 = CTYPES_ADDR_OF_FATPTR(x21);
   double x23 = gsl_matrix_max(x22);
   return caml_copy_double(x23);
}
value owl_stub_8_gsl_matrix_minmax(value x26, value x25, value x24)
{
   gsl_matrix* x27 = CTYPES_ADDR_OF_FATPTR(x26);
   double* x28 = CTYPES_ADDR_OF_FATPTR(x25);
   double* x29 = CTYPES_ADDR_OF_FATPTR(x24);
   gsl_matrix_minmax(x27, x28, x29);
   return Val_unit;
}
value owl_stub_9_gsl_matrix_min_index(value x33, value x32, value x31)
{
   gsl_matrix* x34 = CTYPES_ADDR_OF_FATPTR(x33);
   size_t* x35 = CTYPES_ADDR_OF_FATPTR(x32);
   size_t* x36 = CTYPES_ADDR_OF_FATPTR(x31);
   gsl_matrix_min_index(x34, x35, x36);
   return Val_unit;
}
value owl_stub_10_gsl_matrix_max_index(value x40, value x39, value x38)
{
   gsl_matrix* x41 = CTYPES_ADDR_OF_FATPTR(x40);
   size_t* x42 = CTYPES_ADDR_OF_FATPTR(x39);
   size_t* x43 = CTYPES_ADDR_OF_FATPTR(x38);
   gsl_matrix_max_index(x41, x42, x43);
   return Val_unit;
}
value owl_stub_11_gsl_matrix_minmax_index(value x49, value x48, value x47,
                                          value x46, value x45)
{
   gsl_matrix* x50 = CTYPES_ADDR_OF_FATPTR(x49);
   size_t* x51 = CTYPES_ADDR_OF_FATPTR(x48);
   size_t* x52 = CTYPES_ADDR_OF_FATPTR(x47);
   size_t* x53 = CTYPES_ADDR_OF_FATPTR(x46);
   size_t* x54 = CTYPES_ADDR_OF_FATPTR(x45);
   gsl_matrix_minmax_index(x50, x51, x52, x53, x54);
   return Val_unit;
}
value owl_stub_12_gsl_vector_alloc(value x56)
{
   size_t x57 = ctypes_size_t_val(x56);
   gsl_vector* x60 = gsl_vector_alloc(x57);
   return CTYPES_FROM_PTR(x60);
}
value owl_stub_13_gsl_matrix_alloc(value x62, value x61)
{
   size_t x63 = ctypes_size_t_val(x62);
   size_t x66 = ctypes_size_t_val(x61);
   gsl_matrix* x69 = gsl_matrix_alloc(x63, x66);
   return CTYPES_FROM_PTR(x69);
}
value owl_stub_14_gsl_matrix_get_col(value x72, value x71, value x70)
{
   gsl_vector* x73 = CTYPES_ADDR_OF_FATPTR(x72);
   gsl_matrix* x74 = CTYPES_ADDR_OF_FATPTR(x71);
   int x75 = Long_val(x70);
   int x78 = gsl_matrix_get_col(x73, x74, x75);
   return Val_long(x78);
}
value owl_stub_15_gsl_matrix_float_equal(value x80, value x79)
{
   gsl_matrix_float* x81 = CTYPES_ADDR_OF_FATPTR(x80);
   gsl_matrix_float* x82 = CTYPES_ADDR_OF_FATPTR(x79);
   int x83 = gsl_matrix_float_equal(x81, x82);
   return Val_long(x83);
}
value owl_stub_16_gsl_matrix_float_isnull(value x84)
{
   gsl_matrix_float* x85 = CTYPES_ADDR_OF_FATPTR(x84);
   int x86 = gsl_matrix_float_isnull(x85);
   return Val_long(x86);
}
value owl_stub_17_gsl_matrix_float_ispos(value x87)
{
   gsl_matrix_float* x88 = CTYPES_ADDR_OF_FATPTR(x87);
   int x89 = gsl_matrix_float_ispos(x88);
   return Val_long(x89);
}
value owl_stub_18_gsl_matrix_float_isneg(value x90)
{
   gsl_matrix_float* x91 = CTYPES_ADDR_OF_FATPTR(x90);
   int x92 = gsl_matrix_float_isneg(x91);
   return Val_long(x92);
}
value owl_stub_19_gsl_matrix_float_isnonneg(value x93)
{
   gsl_matrix_float* x94 = CTYPES_ADDR_OF_FATPTR(x93);
   int x95 = gsl_matrix_float_isnonneg(x94);
   return Val_long(x95);
}
value owl_stub_20_gsl_matrix_float_min(value x96)
{
   gsl_matrix_float* x97 = CTYPES_ADDR_OF_FATPTR(x96);
   float x98 = gsl_matrix_float_min(x97);
   return caml_copy_double(x98);
}
value owl_stub_21_gsl_matrix_float_max(value x99)
{
   gsl_matrix_float* x100 = CTYPES_ADDR_OF_FATPTR(x99);
   float x101 = gsl_matrix_float_max(x100);
   return caml_copy_double(x101);
}
value owl_stub_22_gsl_matrix_float_minmax(value x104, value x103, value x102)
{
   gsl_matrix_float* x105 = CTYPES_ADDR_OF_FATPTR(x104);
   float* x106 = CTYPES_ADDR_OF_FATPTR(x103);
   float* x107 = CTYPES_ADDR_OF_FATPTR(x102);
   gsl_matrix_float_minmax(x105, x106, x107);
   return Val_unit;
}
value owl_stub_23_gsl_matrix_float_min_index(value x111, value x110,
                                             value x109)
{
   gsl_matrix_float* x112 = CTYPES_ADDR_OF_FATPTR(x111);
   size_t* x113 = CTYPES_ADDR_OF_FATPTR(x110);
   size_t* x114 = CTYPES_ADDR_OF_FATPTR(x109);
   gsl_matrix_float_min_index(x112, x113, x114);
   return Val_unit;
}
value owl_stub_24_gsl_matrix_float_max_index(value x118, value x117,
                                             value x116)
{
   gsl_matrix_float* x119 = CTYPES_ADDR_OF_FATPTR(x118);
   size_t* x120 = CTYPES_ADDR_OF_FATPTR(x117);
   size_t* x121 = CTYPES_ADDR_OF_FATPTR(x116);
   gsl_matrix_float_max_index(x119, x120, x121);
   return Val_unit;
}
value owl_stub_25_gsl_matrix_float_minmax_index(value x127, value x126,
                                                value x125, value x124,
                                                value x123)
{
   gsl_matrix_float* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   size_t* x129 = CTYPES_ADDR_OF_FATPTR(x126);
   size_t* x130 = CTYPES_ADDR_OF_FATPTR(x125);
   size_t* x131 = CTYPES_ADDR_OF_FATPTR(x124);
   size_t* x132 = CTYPES_ADDR_OF_FATPTR(x123);
   gsl_matrix_float_minmax_index(x128, x129, x130, x131, x132);
   return Val_unit;
}
value owl_stub_26_gsl_matrix_complex_equal(value x135, value x134)
{
   gsl_matrix_complex* x136 = CTYPES_ADDR_OF_FATPTR(x135);
   gsl_matrix_complex* x137 = CTYPES_ADDR_OF_FATPTR(x134);
   int x138 = gsl_matrix_complex_equal(x136, x137);
   return Val_long(x138);
}
value owl_stub_27_gsl_matrix_complex_isnull(value x139)
{
   gsl_matrix_complex* x140 = CTYPES_ADDR_OF_FATPTR(x139);
   int x141 = gsl_matrix_complex_isnull(x140);
   return Val_long(x141);
}
value owl_stub_28_gsl_matrix_complex_ispos(value x142)
{
   gsl_matrix_complex* x143 = CTYPES_ADDR_OF_FATPTR(x142);
   int x144 = gsl_matrix_complex_ispos(x143);
   return Val_long(x144);
}
value owl_stub_29_gsl_matrix_complex_isneg(value x145)
{
   gsl_matrix_complex* x146 = CTYPES_ADDR_OF_FATPTR(x145);
   int x147 = gsl_matrix_complex_isneg(x146);
   return Val_long(x147);
}
value owl_stub_30_gsl_matrix_complex_isnonneg(value x148)
{
   gsl_matrix_complex* x149 = CTYPES_ADDR_OF_FATPTR(x148);
   int x150 = gsl_matrix_complex_isnonneg(x149);
   return Val_long(x150);
}
value owl_stub_31_gsl_matrix_complex_float_equal(value x152, value x151)
{
   gsl_matrix_complex_float* x153 = CTYPES_ADDR_OF_FATPTR(x152);
   gsl_matrix_complex_float* x154 = CTYPES_ADDR_OF_FATPTR(x151);
   int x155 = gsl_matrix_complex_float_equal(x153, x154);
   return Val_long(x155);
}
value owl_stub_32_gsl_matrix_complex_float_isnull(value x156)
{
   gsl_matrix_complex_float* x157 = CTYPES_ADDR_OF_FATPTR(x156);
   int x158 = gsl_matrix_complex_float_isnull(x157);
   return Val_long(x158);
}
value owl_stub_33_gsl_matrix_complex_float_ispos(value x159)
{
   gsl_matrix_complex_float* x160 = CTYPES_ADDR_OF_FATPTR(x159);
   int x161 = gsl_matrix_complex_float_ispos(x160);
   return Val_long(x161);
}
value owl_stub_34_gsl_matrix_complex_float_isneg(value x162)
{
   gsl_matrix_complex_float* x163 = CTYPES_ADDR_OF_FATPTR(x162);
   int x164 = gsl_matrix_complex_float_isneg(x163);
   return Val_long(x164);
}
value owl_stub_35_gsl_matrix_complex_float_isnonneg(value x165)
{
   gsl_matrix_complex_float* x166 = CTYPES_ADDR_OF_FATPTR(x165);
   int x167 = gsl_matrix_complex_float_isnonneg(x166);
   return Val_long(x167);
}
