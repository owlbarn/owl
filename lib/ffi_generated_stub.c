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
value owl_stub_1_gsl_matrix_equal(value x2, value x1)
{
   gsl_matrix* x3 = CTYPES_ADDR_OF_FATPTR(x2);
   gsl_matrix* x4 = CTYPES_ADDR_OF_FATPTR(x1);
   int x5 = gsl_matrix_equal(x3, x4);
   return Val_int(x5);
}
value owl_stub_2_gsl_matrix_isnull(value x6)
{
   gsl_matrix* x7 = CTYPES_ADDR_OF_FATPTR(x6);
   int x8 = gsl_matrix_isnull(x7);
   return Val_int(x8);
}
value owl_stub_3_gsl_matrix_ispos(value x9)
{
   gsl_matrix* x10 = CTYPES_ADDR_OF_FATPTR(x9);
   int x11 = gsl_matrix_ispos(x10);
   return Val_int(x11);
}
value owl_stub_4_gsl_matrix_isneg(value x12)
{
   gsl_matrix* x13 = CTYPES_ADDR_OF_FATPTR(x12);
   int x14 = gsl_matrix_isneg(x13);
   return Val_int(x14);
}
value owl_stub_5_gsl_matrix_isnonneg(value x15)
{
   gsl_matrix* x16 = CTYPES_ADDR_OF_FATPTR(x15);
   int x17 = gsl_matrix_isnonneg(x16);
   return Val_int(x17);
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
value owl_stub_8_gsl_matrix_min_index(value x26, value x25, value x24)
{
   gsl_matrix* x27 = CTYPES_ADDR_OF_FATPTR(x26);
   size_t* x28 = CTYPES_ADDR_OF_FATPTR(x25);
   size_t* x29 = CTYPES_ADDR_OF_FATPTR(x24);
   gsl_matrix_min_index(x27, x28, x29);
   return Val_unit;
}
value owl_stub_9_gsl_matrix_max_index(value x33, value x32, value x31)
{
   gsl_matrix* x34 = CTYPES_ADDR_OF_FATPTR(x33);
   size_t* x35 = CTYPES_ADDR_OF_FATPTR(x32);
   size_t* x36 = CTYPES_ADDR_OF_FATPTR(x31);
   gsl_matrix_max_index(x34, x35, x36);
   return Val_unit;
}
value owl_stub_10_gsl_vector_alloc(value x38)
{
   size_t x39 = ctypes_size_t_val(x38);
   gsl_vector* x42 = gsl_vector_alloc(x39);
   return CTYPES_FROM_PTR(x42);
}
value owl_stub_11_gsl_matrix_alloc(value x44, value x43)
{
   size_t x45 = ctypes_size_t_val(x44);
   size_t x48 = ctypes_size_t_val(x43);
   gsl_matrix* x51 = gsl_matrix_alloc(x45, x48);
   return CTYPES_FROM_PTR(x51);
}
value owl_stub_12_gsl_matrix_get_col(value x54, value x53, value x52)
{
   gsl_vector* x55 = CTYPES_ADDR_OF_FATPTR(x54);
   gsl_matrix* x56 = CTYPES_ADDR_OF_FATPTR(x53);
   int x57 = Int_val(x52);
   int x60 = gsl_matrix_get_col(x55, x56, x57);
   return Val_int(x60);
}
value owl_stub_13_gsl_matrix_float_equal(value x62, value x61)
{
   gsl_matrix_float* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   gsl_matrix_float* x64 = CTYPES_ADDR_OF_FATPTR(x61);
   int x65 = gsl_matrix_float_equal(x63, x64);
   return Val_int(x65);
}
value owl_stub_14_gsl_matrix_float_isnull(value x66)
{
   gsl_matrix_float* x67 = CTYPES_ADDR_OF_FATPTR(x66);
   int x68 = gsl_matrix_float_isnull(x67);
   return Val_int(x68);
}
value owl_stub_15_gsl_matrix_float_ispos(value x69)
{
   gsl_matrix_float* x70 = CTYPES_ADDR_OF_FATPTR(x69);
   int x71 = gsl_matrix_float_ispos(x70);
   return Val_int(x71);
}
value owl_stub_16_gsl_matrix_float_isneg(value x72)
{
   gsl_matrix_float* x73 = CTYPES_ADDR_OF_FATPTR(x72);
   int x74 = gsl_matrix_float_isneg(x73);
   return Val_int(x74);
}
value owl_stub_17_gsl_matrix_float_isnonneg(value x75)
{
   gsl_matrix_float* x76 = CTYPES_ADDR_OF_FATPTR(x75);
   int x77 = gsl_matrix_float_isnonneg(x76);
   return Val_int(x77);
}
value owl_stub_18_gsl_matrix_float_min(value x78)
{
   gsl_matrix_float* x79 = CTYPES_ADDR_OF_FATPTR(x78);
   float x80 = gsl_matrix_float_min(x79);
   return caml_copy_double(x80);
}
value owl_stub_19_gsl_matrix_float_max(value x81)
{
   gsl_matrix_float* x82 = CTYPES_ADDR_OF_FATPTR(x81);
   float x83 = gsl_matrix_float_max(x82);
   return caml_copy_double(x83);
}
value owl_stub_20_gsl_matrix_float_min_index(value x86, value x85, value x84)
{
   gsl_matrix_float* x87 = CTYPES_ADDR_OF_FATPTR(x86);
   size_t* x88 = CTYPES_ADDR_OF_FATPTR(x85);
   size_t* x89 = CTYPES_ADDR_OF_FATPTR(x84);
   gsl_matrix_float_min_index(x87, x88, x89);
   return Val_unit;
}
value owl_stub_21_gsl_matrix_float_max_index(value x93, value x92, value x91)
{
   gsl_matrix_float* x94 = CTYPES_ADDR_OF_FATPTR(x93);
   size_t* x95 = CTYPES_ADDR_OF_FATPTR(x92);
   size_t* x96 = CTYPES_ADDR_OF_FATPTR(x91);
   gsl_matrix_float_max_index(x94, x95, x96);
   return Val_unit;
}
value owl_stub_22_gsl_matrix_complex_equal(value x99, value x98)
{
   gsl_matrix_complex* x100 = CTYPES_ADDR_OF_FATPTR(x99);
   gsl_matrix_complex* x101 = CTYPES_ADDR_OF_FATPTR(x98);
   int x102 = gsl_matrix_complex_equal(x100, x101);
   return Val_int(x102);
}
value owl_stub_23_gsl_matrix_complex_isnull(value x103)
{
   gsl_matrix_complex* x104 = CTYPES_ADDR_OF_FATPTR(x103);
   int x105 = gsl_matrix_complex_isnull(x104);
   return Val_int(x105);
}
value owl_stub_24_gsl_matrix_complex_ispos(value x106)
{
   gsl_matrix_complex* x107 = CTYPES_ADDR_OF_FATPTR(x106);
   int x108 = gsl_matrix_complex_ispos(x107);
   return Val_int(x108);
}
value owl_stub_25_gsl_matrix_complex_isneg(value x109)
{
   gsl_matrix_complex* x110 = CTYPES_ADDR_OF_FATPTR(x109);
   int x111 = gsl_matrix_complex_isneg(x110);
   return Val_int(x111);
}
value owl_stub_26_gsl_matrix_complex_isnonneg(value x112)
{
   gsl_matrix_complex* x113 = CTYPES_ADDR_OF_FATPTR(x112);
   int x114 = gsl_matrix_complex_isnonneg(x113);
   return Val_int(x114);
}
value owl_stub_27_gsl_matrix_complex_float_equal(value x116, value x115)
{
   gsl_matrix_complex_float* x117 = CTYPES_ADDR_OF_FATPTR(x116);
   gsl_matrix_complex_float* x118 = CTYPES_ADDR_OF_FATPTR(x115);
   int x119 = gsl_matrix_complex_float_equal(x117, x118);
   return Val_int(x119);
}
value owl_stub_28_gsl_matrix_complex_float_isnull(value x120)
{
   gsl_matrix_complex_float* x121 = CTYPES_ADDR_OF_FATPTR(x120);
   int x122 = gsl_matrix_complex_float_isnull(x121);
   return Val_int(x122);
}
value owl_stub_29_gsl_matrix_complex_float_ispos(value x123)
{
   gsl_matrix_complex_float* x124 = CTYPES_ADDR_OF_FATPTR(x123);
   int x125 = gsl_matrix_complex_float_ispos(x124);
   return Val_int(x125);
}
value owl_stub_30_gsl_matrix_complex_float_isneg(value x126)
{
   gsl_matrix_complex_float* x127 = CTYPES_ADDR_OF_FATPTR(x126);
   int x128 = gsl_matrix_complex_float_isneg(x127);
   return Val_int(x128);
}
value owl_stub_31_gsl_matrix_complex_float_isnonneg(value x129)
{
   gsl_matrix_complex_float* x130 = CTYPES_ADDR_OF_FATPTR(x129);
   int x131 = gsl_matrix_complex_float_isnonneg(x130);
   return Val_int(x131);
}
value owl_stub_32_gsl_spmatrix_alloc(value x133, value x132)
{
   int x134 = Int_val(x133);
   int x137 = Int_val(x132);
   gsl_spmatrix* x140 = gsl_spmatrix_alloc(x134, x137);
   return CTYPES_FROM_PTR(x140);
}
value owl_stub_33_gsl_spmatrix_alloc_nzmax(value x144, value x143,
                                           value x142, value x141)
{
   int x145 = Int_val(x144);
   int x148 = Int_val(x143);
   int x151 = Int_val(x142);
   int x154 = Int_val(x141);
   gsl_spmatrix* x157 = gsl_spmatrix_alloc_nzmax(x145, x148, x151, x154);
   return CTYPES_FROM_PTR(x157);
}
value owl_stub_34_gsl_spmatrix_set(value x161, value x160, value x159,
                                   value x158)
{
   gsl_spmatrix* x162 = CTYPES_ADDR_OF_FATPTR(x161);
   int x163 = Int_val(x160);
   int x166 = Int_val(x159);
   double x169 = Double_val(x158);
   int x172 = gsl_spmatrix_set(x162, x163, x166, x169);
   return Val_int(x172);
}
value owl_stub_35_gsl_spmatrix_get(value x175, value x174, value x173)
{
   gsl_spmatrix* x176 = CTYPES_ADDR_OF_FATPTR(x175);
   int x177 = Int_val(x174);
   int x180 = Int_val(x173);
   double x183 = gsl_spmatrix_get(x176, x177, x180);
   return caml_copy_double(x183);
}
value owl_stub_36_gsl_spmatrix_add(value x186, value x185, value x184)
{
   gsl_spmatrix* x187 = CTYPES_ADDR_OF_FATPTR(x186);
   gsl_spmatrix* x188 = CTYPES_ADDR_OF_FATPTR(x185);
   gsl_spmatrix* x189 = CTYPES_ADDR_OF_FATPTR(x184);
   int x190 = gsl_spmatrix_add(x187, x188, x189);
   return Val_int(x190);
}
value owl_stub_37_gsl_spmatrix_scale(value x192, value x191)
{
   gsl_spmatrix* x193 = CTYPES_ADDR_OF_FATPTR(x192);
   double x194 = Double_val(x191);
   int x197 = gsl_spmatrix_scale(x193, x194);
   return Val_int(x197);
}
value owl_stub_38_gsl_spmatrix_memcpy(value x199, value x198)
{
   gsl_spmatrix* x200 = CTYPES_ADDR_OF_FATPTR(x199);
   gsl_spmatrix* x201 = CTYPES_ADDR_OF_FATPTR(x198);
   int x202 = gsl_spmatrix_memcpy(x200, x201);
   return Val_int(x202);
}
value owl_stub_39_gsl_spmatrix_compcol(value x203)
{
   gsl_spmatrix* x204 = CTYPES_ADDR_OF_FATPTR(x203);
   gsl_spmatrix* x205 = gsl_spmatrix_compcol(x204);
   return CTYPES_FROM_PTR(x205);
}
value owl_stub_40_gsl_spmatrix_minmax(value x208, value x207, value x206)
{
   gsl_spmatrix* x209 = CTYPES_ADDR_OF_FATPTR(x208);
   double* x210 = CTYPES_ADDR_OF_FATPTR(x207);
   double* x211 = CTYPES_ADDR_OF_FATPTR(x206);
   int x212 = gsl_spmatrix_minmax(x209, x210, x211);
   return Val_int(x212);
}
value owl_stub_41_gsl_spmatrix_equal(value x214, value x213)
{
   gsl_spmatrix* x215 = CTYPES_ADDR_OF_FATPTR(x214);
   gsl_spmatrix* x216 = CTYPES_ADDR_OF_FATPTR(x213);
   int x217 = gsl_spmatrix_equal(x215, x216);
   return Val_int(x217);
}
value owl_stub_42_gsl_spmatrix_transpose_memcpy(value x219, value x218)
{
   gsl_spmatrix* x220 = CTYPES_ADDR_OF_FATPTR(x219);
   gsl_spmatrix* x221 = CTYPES_ADDR_OF_FATPTR(x218);
   int x222 = gsl_spmatrix_transpose_memcpy(x220, x221);
   return Val_int(x222);
}
value owl_stub_43_gsl_spmatrix_set_zero(value x223)
{
   gsl_spmatrix* x224 = CTYPES_ADDR_OF_FATPTR(x223);
   int x225 = gsl_spmatrix_set_zero(x224);
   return Val_int(x225);
}
value owl_stub_44_gsl_spblas_dgemm(value x229, value x228, value x227,
                                   value x226)
{
   double x230 = Double_val(x229);
   gsl_spmatrix* x233 = CTYPES_ADDR_OF_FATPTR(x228);
   gsl_spmatrix* x234 = CTYPES_ADDR_OF_FATPTR(x227);
   gsl_spmatrix* x235 = CTYPES_ADDR_OF_FATPTR(x226);
   int x236 = gsl_spblas_dgemm(x230, x233, x234, x235);
   return Val_int(x236);
}
value owl_stub_45_gsl_spmatrix_d2sp(value x238, value x237)
{
   gsl_spmatrix* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   gsl_matrix* x240 = CTYPES_ADDR_OF_FATPTR(x237);
   int x241 = gsl_spmatrix_d2sp(x239, x240);
   return Val_int(x241);
}
value owl_stub_46_gsl_spmatrix_sp2d(value x243, value x242)
{
   gsl_matrix* x244 = CTYPES_ADDR_OF_FATPTR(x243);
   gsl_spmatrix* x245 = CTYPES_ADDR_OF_FATPTR(x242);
   int x246 = gsl_spmatrix_sp2d(x244, x245);
   return Val_int(x246);
}
