#include <gsl/gsl_block_double.h>
#include <gsl/gsl_block_complex_double.h>
#include <gsl/gsl_vector_double.h>
#include <gsl/gsl_vector_complex_double.h>
#include <gsl/gsl_matrix_double.h>
#include <gsl/gsl_matrix_complex_double.h>
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
value owl_stub_13_gsl_matrix_complex_equal(value x62, value x61)
{
   gsl_matrix_complex* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   gsl_matrix_complex* x64 = CTYPES_ADDR_OF_FATPTR(x61);
   int x65 = gsl_matrix_complex_equal(x63, x64);
   return Val_int(x65);
}
value owl_stub_14_gsl_matrix_complex_isnull(value x66)
{
   gsl_matrix_complex* x67 = CTYPES_ADDR_OF_FATPTR(x66);
   int x68 = gsl_matrix_complex_isnull(x67);
   return Val_int(x68);
}
value owl_stub_15_gsl_matrix_complex_ispos(value x69)
{
   gsl_matrix_complex* x70 = CTYPES_ADDR_OF_FATPTR(x69);
   int x71 = gsl_matrix_complex_ispos(x70);
   return Val_int(x71);
}
value owl_stub_16_gsl_matrix_complex_isneg(value x72)
{
   gsl_matrix_complex* x73 = CTYPES_ADDR_OF_FATPTR(x72);
   int x74 = gsl_matrix_complex_isneg(x73);
   return Val_int(x74);
}
value owl_stub_17_gsl_matrix_complex_isnonneg(value x75)
{
   gsl_matrix_complex* x76 = CTYPES_ADDR_OF_FATPTR(x75);
   int x77 = gsl_matrix_complex_isnonneg(x76);
   return Val_int(x77);
}
value owl_stub_18_gsl_spmatrix_alloc(value x79, value x78)
{
   int x80 = Int_val(x79);
   int x83 = Int_val(x78);
   gsl_spmatrix* x86 = gsl_spmatrix_alloc(x80, x83);
   return CTYPES_FROM_PTR(x86);
}
value owl_stub_19_gsl_spmatrix_alloc_nzmax(value x90, value x89, value x88,
                                           value x87)
{
   int x91 = Int_val(x90);
   int x94 = Int_val(x89);
   int x97 = Int_val(x88);
   int x100 = Int_val(x87);
   gsl_spmatrix* x103 = gsl_spmatrix_alloc_nzmax(x91, x94, x97, x100);
   return CTYPES_FROM_PTR(x103);
}
value owl_stub_20_gsl_spmatrix_set(value x107, value x106, value x105,
                                   value x104)
{
   gsl_spmatrix* x108 = CTYPES_ADDR_OF_FATPTR(x107);
   int x109 = Int_val(x106);
   int x112 = Int_val(x105);
   double x115 = Double_val(x104);
   int x118 = gsl_spmatrix_set(x108, x109, x112, x115);
   return Val_int(x118);
}
value owl_stub_21_gsl_spmatrix_get(value x121, value x120, value x119)
{
   gsl_spmatrix* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   int x123 = Int_val(x120);
   int x126 = Int_val(x119);
   double x129 = gsl_spmatrix_get(x122, x123, x126);
   return caml_copy_double(x129);
}
value owl_stub_22_gsl_spmatrix_add(value x132, value x131, value x130)
{
   gsl_spmatrix* x133 = CTYPES_ADDR_OF_FATPTR(x132);
   gsl_spmatrix* x134 = CTYPES_ADDR_OF_FATPTR(x131);
   gsl_spmatrix* x135 = CTYPES_ADDR_OF_FATPTR(x130);
   int x136 = gsl_spmatrix_add(x133, x134, x135);
   return Val_int(x136);
}
value owl_stub_23_gsl_spmatrix_scale(value x138, value x137)
{
   gsl_spmatrix* x139 = CTYPES_ADDR_OF_FATPTR(x138);
   double x140 = Double_val(x137);
   int x143 = gsl_spmatrix_scale(x139, x140);
   return Val_int(x143);
}
value owl_stub_24_gsl_spmatrix_memcpy(value x145, value x144)
{
   gsl_spmatrix* x146 = CTYPES_ADDR_OF_FATPTR(x145);
   gsl_spmatrix* x147 = CTYPES_ADDR_OF_FATPTR(x144);
   int x148 = gsl_spmatrix_memcpy(x146, x147);
   return Val_int(x148);
}
value owl_stub_25_gsl_spmatrix_compcol(value x149)
{
   gsl_spmatrix* x150 = CTYPES_ADDR_OF_FATPTR(x149);
   gsl_spmatrix* x151 = gsl_spmatrix_compcol(x150);
   return CTYPES_FROM_PTR(x151);
}
value owl_stub_26_gsl_spmatrix_minmax(value x154, value x153, value x152)
{
   gsl_spmatrix* x155 = CTYPES_ADDR_OF_FATPTR(x154);
   double* x156 = CTYPES_ADDR_OF_FATPTR(x153);
   double* x157 = CTYPES_ADDR_OF_FATPTR(x152);
   int x158 = gsl_spmatrix_minmax(x155, x156, x157);
   return Val_int(x158);
}
value owl_stub_27_gsl_spmatrix_equal(value x160, value x159)
{
   gsl_spmatrix* x161 = CTYPES_ADDR_OF_FATPTR(x160);
   gsl_spmatrix* x162 = CTYPES_ADDR_OF_FATPTR(x159);
   int x163 = gsl_spmatrix_equal(x161, x162);
   return Val_int(x163);
}
value owl_stub_28_gsl_spmatrix_transpose_memcpy(value x165, value x164)
{
   gsl_spmatrix* x166 = CTYPES_ADDR_OF_FATPTR(x165);
   gsl_spmatrix* x167 = CTYPES_ADDR_OF_FATPTR(x164);
   int x168 = gsl_spmatrix_transpose_memcpy(x166, x167);
   return Val_int(x168);
}
value owl_stub_29_gsl_spmatrix_set_zero(value x169)
{
   gsl_spmatrix* x170 = CTYPES_ADDR_OF_FATPTR(x169);
   int x171 = gsl_spmatrix_set_zero(x170);
   return Val_int(x171);
}
value owl_stub_30_gsl_spblas_dgemm(value x175, value x174, value x173,
                                   value x172)
{
   double x176 = Double_val(x175);
   gsl_spmatrix* x179 = CTYPES_ADDR_OF_FATPTR(x174);
   gsl_spmatrix* x180 = CTYPES_ADDR_OF_FATPTR(x173);
   gsl_spmatrix* x181 = CTYPES_ADDR_OF_FATPTR(x172);
   int x182 = gsl_spblas_dgemm(x176, x179, x180, x181);
   return Val_int(x182);
}
value owl_stub_31_gsl_spmatrix_d2sp(value x184, value x183)
{
   gsl_spmatrix* x185 = CTYPES_ADDR_OF_FATPTR(x184);
   gsl_matrix* x186 = CTYPES_ADDR_OF_FATPTR(x183);
   int x187 = gsl_spmatrix_d2sp(x185, x186);
   return Val_int(x187);
}
value owl_stub_32_gsl_spmatrix_sp2d(value x189, value x188)
{
   gsl_matrix* x190 = CTYPES_ADDR_OF_FATPTR(x189);
   gsl_spmatrix* x191 = CTYPES_ADDR_OF_FATPTR(x188);
   int x192 = gsl_spmatrix_sp2d(x190, x191);
   return Val_int(x192);
}
