#include "libowl_eigen.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_c_eigen_spmat_d_new(value x2, value x1)
{
   int x3 = Int_val(x2);
   int x6 = Int_val(x1);
   struct c_spmat_d* x9 = c_eigen_spmat_d_new(x3, x6);
   return CTYPES_FROM_PTR(x9);
}
value owl_stub_2_c_eigen_spmat_d_delete(value x10)
{
   struct c_spmat_d* x11 = CTYPES_ADDR_OF_FATPTR(x10);
   c_eigen_spmat_d_delete(x11);
   return Val_unit;
}
value owl_stub_3_c_eigen_spmat_d_eye(value x13)
{
   int x14 = Int_val(x13);
   struct c_spmat_d* x17 = c_eigen_spmat_d_eye(x14);
   return CTYPES_FROM_PTR(x17);
}
value owl_stub_4_c_eigen_spmat_d_rows(value x18)
{
   struct c_spmat_d* x19 = CTYPES_ADDR_OF_FATPTR(x18);
   int x20 = c_eigen_spmat_d_rows(x19);
   return Val_int(x20);
}
value owl_stub_5_c_eigen_spmat_d_cols(value x21)
{
   struct c_spmat_d* x22 = CTYPES_ADDR_OF_FATPTR(x21);
   int x23 = c_eigen_spmat_d_cols(x22);
   return Val_int(x23);
}
value owl_stub_6_c_eigen_spmat_d_nnz(value x24)
{
   struct c_spmat_d* x25 = CTYPES_ADDR_OF_FATPTR(x24);
   int x26 = c_eigen_spmat_d_nnz(x25);
   return Val_int(x26);
}
value owl_stub_7_c_eigen_spmat_d_get(value x29, value x28, value x27)
{
   struct c_spmat_d* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   int x31 = Int_val(x28);
   int x34 = Int_val(x27);
   double x37 = c_eigen_spmat_d_get(x30, x31, x34);
   return caml_copy_double(x37);
}
value owl_stub_8_c_eigen_spmat_d_set(value x41, value x40, value x39,
                                     value x38)
{
   struct c_spmat_d* x42 = CTYPES_ADDR_OF_FATPTR(x41);
   int x43 = Int_val(x40);
   int x46 = Int_val(x39);
   double x49 = Double_val(x38);
   c_eigen_spmat_d_set(x42, x43, x46, x49);
   return Val_unit;
}
value owl_stub_9_c_eigen_spmat_d_reset(value x53)
{
   struct c_spmat_d* x54 = CTYPES_ADDR_OF_FATPTR(x53);
   c_eigen_spmat_d_reset(x54);
   return Val_unit;
}
value owl_stub_10_c_eigen_spmat_d_is_compressed(value x56)
{
   struct c_spmat_d* x57 = CTYPES_ADDR_OF_FATPTR(x56);
   int x58 = c_eigen_spmat_d_is_compressed(x57);
   return Val_int(x58);
}
value owl_stub_11_c_eigen_spmat_d_compress(value x59)
{
   struct c_spmat_d* x60 = CTYPES_ADDR_OF_FATPTR(x59);
   c_eigen_spmat_d_compress(x60);
   return Val_unit;
}
value owl_stub_12_c_eigen_spmat_d_uncompress(value x62)
{
   struct c_spmat_d* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   c_eigen_spmat_d_uncompress(x63);
   return Val_unit;
}
value owl_stub_13_c_eigen_spmat_d_reshape(value x67, value x66, value x65)
{
   struct c_spmat_d* x68 = CTYPES_ADDR_OF_FATPTR(x67);
   int x69 = Int_val(x66);
   int x72 = Int_val(x65);
   c_eigen_spmat_d_reshape(x68, x69, x72);
   return Val_unit;
}
value owl_stub_14_c_eigen_spmat_d_prune(value x78, value x77, value x76)
{
   struct c_spmat_d* x79 = CTYPES_ADDR_OF_FATPTR(x78);
   double x80 = Double_val(x77);
   double x83 = Double_val(x76);
   c_eigen_spmat_d_prune(x79, x80, x83);
   return Val_unit;
}
value owl_stub_15_c_eigen_spmat_d_clone(value x87)
{
   struct c_spmat_d* x88 = CTYPES_ADDR_OF_FATPTR(x87);
   struct c_spmat_d* x89 = c_eigen_spmat_d_clone(x88);
   return CTYPES_FROM_PTR(x89);
}
value owl_stub_16_c_eigen_spmat_d_row(value x91, value x90)
{
   struct c_spmat_d* x92 = CTYPES_ADDR_OF_FATPTR(x91);
   int x93 = Int_val(x90);
   struct c_spmat_d* x96 = c_eigen_spmat_d_row(x92, x93);
   return CTYPES_FROM_PTR(x96);
}
value owl_stub_17_c_eigen_spmat_d_col(value x98, value x97)
{
   struct c_spmat_d* x99 = CTYPES_ADDR_OF_FATPTR(x98);
   int x100 = Int_val(x97);
   struct c_spmat_d* x103 = c_eigen_spmat_d_col(x99, x100);
   return CTYPES_FROM_PTR(x103);
}
value owl_stub_18_c_eigen_spmat_d_transpose(value x104)
{
   struct c_spmat_d* x105 = CTYPES_ADDR_OF_FATPTR(x104);
   struct c_spmat_d* x106 = c_eigen_spmat_d_transpose(x105);
   return CTYPES_FROM_PTR(x106);
}
value owl_stub_19_c_eigen_spmat_d_adjoint(value x107)
{
   struct c_spmat_d* x108 = CTYPES_ADDR_OF_FATPTR(x107);
   struct c_spmat_d* x109 = c_eigen_spmat_d_adjoint(x108);
   return CTYPES_FROM_PTR(x109);
}
value owl_stub_20_c_eigen_spmat_d_add(value x111, value x110)
{
   struct c_spmat_d* x112 = CTYPES_ADDR_OF_FATPTR(x111);
   struct c_spmat_d* x113 = CTYPES_ADDR_OF_FATPTR(x110);
   struct c_spmat_d* x114 = c_eigen_spmat_d_add(x112, x113);
   return CTYPES_FROM_PTR(x114);
}
value owl_stub_21_c_eigen_spmat_d_sub(value x116, value x115)
{
   struct c_spmat_d* x117 = CTYPES_ADDR_OF_FATPTR(x116);
   struct c_spmat_d* x118 = CTYPES_ADDR_OF_FATPTR(x115);
   struct c_spmat_d* x119 = c_eigen_spmat_d_sub(x117, x118);
   return CTYPES_FROM_PTR(x119);
}
value owl_stub_22_c_eigen_spmat_d_mul(value x121, value x120)
{
   struct c_spmat_d* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   struct c_spmat_d* x123 = CTYPES_ADDR_OF_FATPTR(x120);
   struct c_spmat_d* x124 = c_eigen_spmat_d_mul(x122, x123);
   return CTYPES_FROM_PTR(x124);
}
value owl_stub_23_c_eigen_spmat_d_div(value x126, value x125)
{
   struct c_spmat_d* x127 = CTYPES_ADDR_OF_FATPTR(x126);
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x125);
   struct c_spmat_d* x129 = c_eigen_spmat_d_div(x127, x128);
   return CTYPES_FROM_PTR(x129);
}
value owl_stub_24_c_eigen_spmat_d_dot(value x131, value x130)
{
   struct c_spmat_d* x132 = CTYPES_ADDR_OF_FATPTR(x131);
   struct c_spmat_d* x133 = CTYPES_ADDR_OF_FATPTR(x130);
   struct c_spmat_d* x134 = c_eigen_spmat_d_dot(x132, x133);
   return CTYPES_FROM_PTR(x134);
}
value owl_stub_25_c_eigen_spmat_d_mul_scalar(value x136, value x135)
{
   struct c_spmat_d* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   double x138 = Double_val(x135);
   struct c_spmat_d* x141 = c_eigen_spmat_d_mul_scalar(x137, x138);
   return CTYPES_FROM_PTR(x141);
}
value owl_stub_26_c_eigen_spmat_d_div_scalar(value x143, value x142)
{
   struct c_spmat_d* x144 = CTYPES_ADDR_OF_FATPTR(x143);
   double x145 = Double_val(x142);
   struct c_spmat_d* x148 = c_eigen_spmat_d_div_scalar(x144, x145);
   return CTYPES_FROM_PTR(x148);
}
value owl_stub_27_c_eigen_spmat_d_min2(value x150, value x149)
{
   struct c_spmat_d* x151 = CTYPES_ADDR_OF_FATPTR(x150);
   struct c_spmat_d* x152 = CTYPES_ADDR_OF_FATPTR(x149);
   struct c_spmat_d* x153 = c_eigen_spmat_d_min2(x151, x152);
   return CTYPES_FROM_PTR(x153);
}
value owl_stub_28_c_eigen_spmat_d_max2(value x155, value x154)
{
   struct c_spmat_d* x156 = CTYPES_ADDR_OF_FATPTR(x155);
   struct c_spmat_d* x157 = CTYPES_ADDR_OF_FATPTR(x154);
   struct c_spmat_d* x158 = c_eigen_spmat_d_max2(x156, x157);
   return CTYPES_FROM_PTR(x158);
}
value owl_stub_29_c_eigen_spmat_d_sum(value x159)
{
   struct c_spmat_d* x160 = CTYPES_ADDR_OF_FATPTR(x159);
   double x161 = c_eigen_spmat_d_sum(x160);
   return caml_copy_double(x161);
}
value owl_stub_30_c_eigen_spmat_d_abs(value x162)
{
   struct c_spmat_d* x163 = CTYPES_ADDR_OF_FATPTR(x162);
   struct c_spmat_d* x164 = c_eigen_spmat_d_abs(x163);
   return CTYPES_FROM_PTR(x164);
}
value owl_stub_31_c_eigen_spmat_d_sqrt(value x165)
{
   struct c_spmat_d* x166 = CTYPES_ADDR_OF_FATPTR(x165);
   struct c_spmat_d* x167 = c_eigen_spmat_d_sqrt(x166);
   return CTYPES_FROM_PTR(x167);
}
value owl_stub_32_c_eigen_spmat_d_print(value x168)
{
   struct c_spmat_d* x169 = CTYPES_ADDR_OF_FATPTR(x168);
   c_eigen_spmat_d_print(x169);
   return Val_unit;
}
