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
#include <gsl/gsl_spmatrix.h>
#include <gsl/gsl_spblas.h>
#include "ctypes_cstubs_internals.h"
value owl_stub_1_gsl_vector_alloc(value x1)
{
   size_t x2 = ctypes_size_t_val(x1);
   gsl_vector* x5 = gsl_vector_alloc(x2);
   return CTYPES_FROM_PTR(x5);
}
value owl_stub_2_gsl_matrix_alloc(value x7, value x6)
{
   size_t x8 = ctypes_size_t_val(x7);
   size_t x11 = ctypes_size_t_val(x6);
   gsl_matrix* x14 = gsl_matrix_alloc(x8, x11);
   return CTYPES_FROM_PTR(x14);
}
value owl_stub_3_gsl_matrix_get_col(value x17, value x16, value x15)
{
   gsl_vector* x18 = CTYPES_ADDR_OF_FATPTR(x17);
   gsl_matrix* x19 = CTYPES_ADDR_OF_FATPTR(x16);
   int x20 = Int_val(x15);
   int x23 = gsl_matrix_get_col(x18, x19, x20);
   return Val_int(x23);
}
value owl_stub_4_gsl_matrix_equal(value x25, value x24)
{
   gsl_matrix* x26 = CTYPES_ADDR_OF_FATPTR(x25);
   gsl_matrix* x27 = CTYPES_ADDR_OF_FATPTR(x24);
   int x28 = gsl_matrix_equal(x26, x27);
   return Val_int(x28);
}
value owl_stub_5_gsl_matrix_isnull(value x29)
{
   gsl_matrix* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   int x31 = gsl_matrix_isnull(x30);
   return Val_int(x31);
}
value owl_stub_6_gsl_matrix_ispos(value x32)
{
   gsl_matrix* x33 = CTYPES_ADDR_OF_FATPTR(x32);
   int x34 = gsl_matrix_ispos(x33);
   return Val_int(x34);
}
value owl_stub_7_gsl_matrix_isneg(value x35)
{
   gsl_matrix* x36 = CTYPES_ADDR_OF_FATPTR(x35);
   int x37 = gsl_matrix_isneg(x36);
   return Val_int(x37);
}
value owl_stub_8_gsl_matrix_isnonneg(value x38)
{
   gsl_matrix* x39 = CTYPES_ADDR_OF_FATPTR(x38);
   int x40 = gsl_matrix_isnonneg(x39);
   return Val_int(x40);
}
value owl_stub_9_gsl_matrix_min(value x41)
{
   gsl_matrix* x42 = CTYPES_ADDR_OF_FATPTR(x41);
   double x43 = gsl_matrix_min(x42);
   return caml_copy_double(x43);
}
value owl_stub_10_gsl_matrix_min_index(value x46, value x45, value x44)
{
   gsl_matrix* x47 = CTYPES_ADDR_OF_FATPTR(x46);
   size_t* x48 = CTYPES_ADDR_OF_FATPTR(x45);
   size_t* x49 = CTYPES_ADDR_OF_FATPTR(x44);
   gsl_matrix_min_index(x47, x48, x49);
   return Val_unit;
}
value owl_stub_11_gsl_matrix_max(value x51)
{
   gsl_matrix* x52 = CTYPES_ADDR_OF_FATPTR(x51);
   double x53 = gsl_matrix_max(x52);
   return caml_copy_double(x53);
}
value owl_stub_12_gsl_matrix_max_index(value x56, value x55, value x54)
{
   gsl_matrix* x57 = CTYPES_ADDR_OF_FATPTR(x56);
   size_t* x58 = CTYPES_ADDR_OF_FATPTR(x55);
   size_t* x59 = CTYPES_ADDR_OF_FATPTR(x54);
   gsl_matrix_max_index(x57, x58, x59);
   return Val_unit;
}
value owl_stub_13_gsl_matrix_float_isnull(value x61)
{
   gsl_matrix_float* x62 = CTYPES_ADDR_OF_FATPTR(x61);
   int x63 = gsl_matrix_float_isnull(x62);
   return Val_int(x63);
}
value owl_stub_14_gsl_matrix_float_ispos(value x64)
{
   gsl_matrix_float* x65 = CTYPES_ADDR_OF_FATPTR(x64);
   int x66 = gsl_matrix_float_ispos(x65);
   return Val_int(x66);
}
value owl_stub_15_gsl_matrix_float_isneg(value x67)
{
   gsl_matrix_float* x68 = CTYPES_ADDR_OF_FATPTR(x67);
   int x69 = gsl_matrix_float_isneg(x68);
   return Val_int(x69);
}
value owl_stub_16_gsl_matrix_float_isnonneg(value x70)
{
   gsl_matrix_float* x71 = CTYPES_ADDR_OF_FATPTR(x70);
   int x72 = gsl_matrix_float_isnonneg(x71);
   return Val_int(x72);
}
value owl_stub_17_gsl_matrix_complex_equal(value x74, value x73)
{
   gsl_matrix_complex* x75 = CTYPES_ADDR_OF_FATPTR(x74);
   gsl_matrix_complex* x76 = CTYPES_ADDR_OF_FATPTR(x73);
   int x77 = gsl_matrix_complex_equal(x75, x76);
   return Val_int(x77);
}
value owl_stub_18_gsl_matrix_complex_isnull(value x78)
{
   gsl_matrix_complex* x79 = CTYPES_ADDR_OF_FATPTR(x78);
   int x80 = gsl_matrix_complex_isnull(x79);
   return Val_int(x80);
}
value owl_stub_19_gsl_matrix_complex_ispos(value x81)
{
   gsl_matrix_complex* x82 = CTYPES_ADDR_OF_FATPTR(x81);
   int x83 = gsl_matrix_complex_ispos(x82);
   return Val_int(x83);
}
value owl_stub_20_gsl_matrix_complex_isneg(value x84)
{
   gsl_matrix_complex* x85 = CTYPES_ADDR_OF_FATPTR(x84);
   int x86 = gsl_matrix_complex_isneg(x85);
   return Val_int(x86);
}
value owl_stub_21_gsl_matrix_complex_isnonneg(value x87)
{
   gsl_matrix_complex* x88 = CTYPES_ADDR_OF_FATPTR(x87);
   int x89 = gsl_matrix_complex_isnonneg(x88);
   return Val_int(x89);
}
value owl_stub_22_gsl_matrix_complex_float_equal(value x91, value x90)
{
   gsl_matrix_complex_float* x92 = CTYPES_ADDR_OF_FATPTR(x91);
   gsl_matrix_complex_float* x93 = CTYPES_ADDR_OF_FATPTR(x90);
   int x94 = gsl_matrix_complex_float_equal(x92, x93);
   return Val_int(x94);
}
value owl_stub_23_gsl_matrix_complex_float_isnull(value x95)
{
   gsl_matrix_complex_float* x96 = CTYPES_ADDR_OF_FATPTR(x95);
   int x97 = gsl_matrix_complex_float_isnull(x96);
   return Val_int(x97);
}
value owl_stub_24_gsl_matrix_complex_float_ispos(value x98)
{
   gsl_matrix_complex_float* x99 = CTYPES_ADDR_OF_FATPTR(x98);
   int x100 = gsl_matrix_complex_float_ispos(x99);
   return Val_int(x100);
}
value owl_stub_25_gsl_matrix_complex_float_isneg(value x101)
{
   gsl_matrix_complex_float* x102 = CTYPES_ADDR_OF_FATPTR(x101);
   int x103 = gsl_matrix_complex_float_isneg(x102);
   return Val_int(x103);
}
value owl_stub_26_gsl_matrix_complex_float_isnonneg(value x104)
{
   gsl_matrix_complex_float* x105 = CTYPES_ADDR_OF_FATPTR(x104);
   int x106 = gsl_matrix_complex_float_isnonneg(x105);
   return Val_int(x106);
}
value owl_stub_27_gsl_spmatrix_alloc(value x108, value x107)
{
   int x109 = Int_val(x108);
   int x112 = Int_val(x107);
   gsl_spmatrix* x115 = gsl_spmatrix_alloc(x109, x112);
   return CTYPES_FROM_PTR(x115);
}
value owl_stub_28_gsl_spmatrix_alloc_nzmax(value x119, value x118,
                                           value x117, value x116)
{
   int x120 = Int_val(x119);
   int x123 = Int_val(x118);
   int x126 = Int_val(x117);
   int x129 = Int_val(x116);
   gsl_spmatrix* x132 = gsl_spmatrix_alloc_nzmax(x120, x123, x126, x129);
   return CTYPES_FROM_PTR(x132);
}
value owl_stub_29_gsl_spmatrix_set(value x136, value x135, value x134,
                                   value x133)
{
   gsl_spmatrix* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   int x138 = Int_val(x135);
   int x141 = Int_val(x134);
   double x144 = Double_val(x133);
   int x147 = gsl_spmatrix_set(x137, x138, x141, x144);
   return Val_int(x147);
}
value owl_stub_30_gsl_spmatrix_get(value x150, value x149, value x148)
{
   gsl_spmatrix* x151 = CTYPES_ADDR_OF_FATPTR(x150);
   int x152 = Int_val(x149);
   int x155 = Int_val(x148);
   double x158 = gsl_spmatrix_get(x151, x152, x155);
   return caml_copy_double(x158);
}
value owl_stub_31_gsl_spmatrix_add(value x161, value x160, value x159)
{
   gsl_spmatrix* x162 = CTYPES_ADDR_OF_FATPTR(x161);
   gsl_spmatrix* x163 = CTYPES_ADDR_OF_FATPTR(x160);
   gsl_spmatrix* x164 = CTYPES_ADDR_OF_FATPTR(x159);
   int x165 = gsl_spmatrix_add(x162, x163, x164);
   return Val_int(x165);
}
value owl_stub_32_gsl_spmatrix_scale(value x167, value x166)
{
   gsl_spmatrix* x168 = CTYPES_ADDR_OF_FATPTR(x167);
   double x169 = Double_val(x166);
   int x172 = gsl_spmatrix_scale(x168, x169);
   return Val_int(x172);
}
value owl_stub_33_gsl_spmatrix_memcpy(value x174, value x173)
{
   gsl_spmatrix* x175 = CTYPES_ADDR_OF_FATPTR(x174);
   gsl_spmatrix* x176 = CTYPES_ADDR_OF_FATPTR(x173);
   int x177 = gsl_spmatrix_memcpy(x175, x176);
   return Val_int(x177);
}
value owl_stub_34_gsl_spmatrix_compcol(value x178)
{
   gsl_spmatrix* x179 = CTYPES_ADDR_OF_FATPTR(x178);
   gsl_spmatrix* x180 = gsl_spmatrix_compcol(x179);
   return CTYPES_FROM_PTR(x180);
}
value owl_stub_35_gsl_spmatrix_minmax(value x183, value x182, value x181)
{
   gsl_spmatrix* x184 = CTYPES_ADDR_OF_FATPTR(x183);
   double* x185 = CTYPES_ADDR_OF_FATPTR(x182);
   double* x186 = CTYPES_ADDR_OF_FATPTR(x181);
   int x187 = gsl_spmatrix_minmax(x184, x185, x186);
   return Val_int(x187);
}
value owl_stub_36_gsl_spmatrix_equal(value x189, value x188)
{
   gsl_spmatrix* x190 = CTYPES_ADDR_OF_FATPTR(x189);
   gsl_spmatrix* x191 = CTYPES_ADDR_OF_FATPTR(x188);
   int x192 = gsl_spmatrix_equal(x190, x191);
   return Val_int(x192);
}
value owl_stub_37_gsl_spmatrix_transpose_memcpy(value x194, value x193)
{
   gsl_spmatrix* x195 = CTYPES_ADDR_OF_FATPTR(x194);
   gsl_spmatrix* x196 = CTYPES_ADDR_OF_FATPTR(x193);
   int x197 = gsl_spmatrix_transpose_memcpy(x195, x196);
   return Val_int(x197);
}
value owl_stub_38_gsl_spmatrix_set_zero(value x198)
{
   gsl_spmatrix* x199 = CTYPES_ADDR_OF_FATPTR(x198);
   int x200 = gsl_spmatrix_set_zero(x199);
   return Val_int(x200);
}
value owl_stub_39_gsl_spblas_dgemm(value x204, value x203, value x202,
                                   value x201)
{
   double x205 = Double_val(x204);
   gsl_spmatrix* x208 = CTYPES_ADDR_OF_FATPTR(x203);
   gsl_spmatrix* x209 = CTYPES_ADDR_OF_FATPTR(x202);
   gsl_spmatrix* x210 = CTYPES_ADDR_OF_FATPTR(x201);
   int x211 = gsl_spblas_dgemm(x205, x208, x209, x210);
   return Val_int(x211);
}
value owl_stub_40_gsl_spmatrix_d2sp(value x213, value x212)
{
   gsl_spmatrix* x214 = CTYPES_ADDR_OF_FATPTR(x213);
   gsl_matrix* x215 = CTYPES_ADDR_OF_FATPTR(x212);
   int x216 = gsl_spmatrix_d2sp(x214, x215);
   return Val_int(x216);
}
value owl_stub_41_gsl_spmatrix_sp2d(value x218, value x217)
{
   gsl_matrix* x219 = CTYPES_ADDR_OF_FATPTR(x218);
   gsl_spmatrix* x220 = CTYPES_ADDR_OF_FATPTR(x217);
   int x221 = gsl_spmatrix_sp2d(x219, x220);
   return Val_int(x221);
}
