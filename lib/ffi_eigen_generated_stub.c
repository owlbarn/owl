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
value owl_stub_20_c_eigen_spmat_d_is_zero(value x110)
{
   struct c_spmat_d* x111 = CTYPES_ADDR_OF_FATPTR(x110);
   int x112 = c_eigen_spmat_d_is_zero(x111);
   return Val_int(x112);
}
value owl_stub_21_c_eigen_spmat_d_add(value x114, value x113)
{
   struct c_spmat_d* x115 = CTYPES_ADDR_OF_FATPTR(x114);
   struct c_spmat_d* x116 = CTYPES_ADDR_OF_FATPTR(x113);
   struct c_spmat_d* x117 = c_eigen_spmat_d_add(x115, x116);
   return CTYPES_FROM_PTR(x117);
}
value owl_stub_22_c_eigen_spmat_d_sub(value x119, value x118)
{
   struct c_spmat_d* x120 = CTYPES_ADDR_OF_FATPTR(x119);
   struct c_spmat_d* x121 = CTYPES_ADDR_OF_FATPTR(x118);
   struct c_spmat_d* x122 = c_eigen_spmat_d_sub(x120, x121);
   return CTYPES_FROM_PTR(x122);
}
value owl_stub_23_c_eigen_spmat_d_mul(value x124, value x123)
{
   struct c_spmat_d* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   struct c_spmat_d* x126 = CTYPES_ADDR_OF_FATPTR(x123);
   struct c_spmat_d* x127 = c_eigen_spmat_d_mul(x125, x126);
   return CTYPES_FROM_PTR(x127);
}
value owl_stub_24_c_eigen_spmat_d_div(value x129, value x128)
{
   struct c_spmat_d* x130 = CTYPES_ADDR_OF_FATPTR(x129);
   struct c_spmat_d* x131 = CTYPES_ADDR_OF_FATPTR(x128);
   struct c_spmat_d* x132 = c_eigen_spmat_d_div(x130, x131);
   return CTYPES_FROM_PTR(x132);
}
value owl_stub_25_c_eigen_spmat_d_dot(value x134, value x133)
{
   struct c_spmat_d* x135 = CTYPES_ADDR_OF_FATPTR(x134);
   struct c_spmat_d* x136 = CTYPES_ADDR_OF_FATPTR(x133);
   struct c_spmat_d* x137 = c_eigen_spmat_d_dot(x135, x136);
   return CTYPES_FROM_PTR(x137);
}
value owl_stub_26_c_eigen_spmat_d_add_scalar(value x139, value x138)
{
   struct c_spmat_d* x140 = CTYPES_ADDR_OF_FATPTR(x139);
   double x141 = Double_val(x138);
   struct c_spmat_d* x144 = c_eigen_spmat_d_add_scalar(x140, x141);
   return CTYPES_FROM_PTR(x144);
}
value owl_stub_27_c_eigen_spmat_d_sub_scalar(value x146, value x145)
{
   struct c_spmat_d* x147 = CTYPES_ADDR_OF_FATPTR(x146);
   double x148 = Double_val(x145);
   struct c_spmat_d* x151 = c_eigen_spmat_d_sub_scalar(x147, x148);
   return CTYPES_FROM_PTR(x151);
}
value owl_stub_28_c_eigen_spmat_d_mul_scalar(value x153, value x152)
{
   struct c_spmat_d* x154 = CTYPES_ADDR_OF_FATPTR(x153);
   double x155 = Double_val(x152);
   struct c_spmat_d* x158 = c_eigen_spmat_d_mul_scalar(x154, x155);
   return CTYPES_FROM_PTR(x158);
}
value owl_stub_29_c_eigen_spmat_d_div_scalar(value x160, value x159)
{
   struct c_spmat_d* x161 = CTYPES_ADDR_OF_FATPTR(x160);
   double x162 = Double_val(x159);
   struct c_spmat_d* x165 = c_eigen_spmat_d_div_scalar(x161, x162);
   return CTYPES_FROM_PTR(x165);
}
value owl_stub_30_c_eigen_spmat_d_min2(value x167, value x166)
{
   struct c_spmat_d* x168 = CTYPES_ADDR_OF_FATPTR(x167);
   struct c_spmat_d* x169 = CTYPES_ADDR_OF_FATPTR(x166);
   struct c_spmat_d* x170 = c_eigen_spmat_d_min2(x168, x169);
   return CTYPES_FROM_PTR(x170);
}
value owl_stub_31_c_eigen_spmat_d_max2(value x172, value x171)
{
   struct c_spmat_d* x173 = CTYPES_ADDR_OF_FATPTR(x172);
   struct c_spmat_d* x174 = CTYPES_ADDR_OF_FATPTR(x171);
   struct c_spmat_d* x175 = c_eigen_spmat_d_max2(x173, x174);
   return CTYPES_FROM_PTR(x175);
}
value owl_stub_32_c_eigen_spmat_d_sum(value x176)
{
   struct c_spmat_d* x177 = CTYPES_ADDR_OF_FATPTR(x176);
   double x178 = c_eigen_spmat_d_sum(x177);
   return caml_copy_double(x178);
}
value owl_stub_33_c_eigen_spmat_d_min(value x179)
{
   struct c_spmat_d* x180 = CTYPES_ADDR_OF_FATPTR(x179);
   double x181 = c_eigen_spmat_d_min(x180);
   return caml_copy_double(x181);
}
value owl_stub_34_c_eigen_spmat_d_max(value x182)
{
   struct c_spmat_d* x183 = CTYPES_ADDR_OF_FATPTR(x182);
   double x184 = c_eigen_spmat_d_max(x183);
   return caml_copy_double(x184);
}
value owl_stub_35_c_eigen_spmat_d_abs(value x185)
{
   struct c_spmat_d* x186 = CTYPES_ADDR_OF_FATPTR(x185);
   struct c_spmat_d* x187 = c_eigen_spmat_d_abs(x186);
   return CTYPES_FROM_PTR(x187);
}
value owl_stub_36_c_eigen_spmat_d_neg(value x188)
{
   struct c_spmat_d* x189 = CTYPES_ADDR_OF_FATPTR(x188);
   struct c_spmat_d* x190 = c_eigen_spmat_d_neg(x189);
   return CTYPES_FROM_PTR(x190);
}
value owl_stub_37_c_eigen_spmat_d_sqrt(value x191)
{
   struct c_spmat_d* x192 = CTYPES_ADDR_OF_FATPTR(x191);
   struct c_spmat_d* x193 = c_eigen_spmat_d_sqrt(x192);
   return CTYPES_FROM_PTR(x193);
}
value owl_stub_38_c_eigen_spmat_d_print(value x194)
{
   struct c_spmat_d* x195 = CTYPES_ADDR_OF_FATPTR(x194);
   c_eigen_spmat_d_print(x195);
   return Val_unit;
}
