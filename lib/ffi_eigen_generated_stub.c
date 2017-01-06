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
value owl_stub_21_c_eigen_spmat_d_is_positive(value x113)
{
   struct c_spmat_d* x114 = CTYPES_ADDR_OF_FATPTR(x113);
   int x115 = c_eigen_spmat_d_is_positive(x114);
   return Val_int(x115);
}
value owl_stub_22_c_eigen_spmat_d_add(value x117, value x116)
{
   struct c_spmat_d* x118 = CTYPES_ADDR_OF_FATPTR(x117);
   struct c_spmat_d* x119 = CTYPES_ADDR_OF_FATPTR(x116);
   struct c_spmat_d* x120 = c_eigen_spmat_d_add(x118, x119);
   return CTYPES_FROM_PTR(x120);
}
value owl_stub_23_c_eigen_spmat_d_sub(value x122, value x121)
{
   struct c_spmat_d* x123 = CTYPES_ADDR_OF_FATPTR(x122);
   struct c_spmat_d* x124 = CTYPES_ADDR_OF_FATPTR(x121);
   struct c_spmat_d* x125 = c_eigen_spmat_d_sub(x123, x124);
   return CTYPES_FROM_PTR(x125);
}
value owl_stub_24_c_eigen_spmat_d_mul(value x127, value x126)
{
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   struct c_spmat_d* x129 = CTYPES_ADDR_OF_FATPTR(x126);
   struct c_spmat_d* x130 = c_eigen_spmat_d_mul(x128, x129);
   return CTYPES_FROM_PTR(x130);
}
value owl_stub_25_c_eigen_spmat_d_div(value x132, value x131)
{
   struct c_spmat_d* x133 = CTYPES_ADDR_OF_FATPTR(x132);
   struct c_spmat_d* x134 = CTYPES_ADDR_OF_FATPTR(x131);
   struct c_spmat_d* x135 = c_eigen_spmat_d_div(x133, x134);
   return CTYPES_FROM_PTR(x135);
}
value owl_stub_26_c_eigen_spmat_d_dot(value x137, value x136)
{
   struct c_spmat_d* x138 = CTYPES_ADDR_OF_FATPTR(x137);
   struct c_spmat_d* x139 = CTYPES_ADDR_OF_FATPTR(x136);
   struct c_spmat_d* x140 = c_eigen_spmat_d_dot(x138, x139);
   return CTYPES_FROM_PTR(x140);
}
value owl_stub_27_c_eigen_spmat_d_add_scalar(value x142, value x141)
{
   struct c_spmat_d* x143 = CTYPES_ADDR_OF_FATPTR(x142);
   double x144 = Double_val(x141);
   struct c_spmat_d* x147 = c_eigen_spmat_d_add_scalar(x143, x144);
   return CTYPES_FROM_PTR(x147);
}
value owl_stub_28_c_eigen_spmat_d_sub_scalar(value x149, value x148)
{
   struct c_spmat_d* x150 = CTYPES_ADDR_OF_FATPTR(x149);
   double x151 = Double_val(x148);
   struct c_spmat_d* x154 = c_eigen_spmat_d_sub_scalar(x150, x151);
   return CTYPES_FROM_PTR(x154);
}
value owl_stub_29_c_eigen_spmat_d_mul_scalar(value x156, value x155)
{
   struct c_spmat_d* x157 = CTYPES_ADDR_OF_FATPTR(x156);
   double x158 = Double_val(x155);
   struct c_spmat_d* x161 = c_eigen_spmat_d_mul_scalar(x157, x158);
   return CTYPES_FROM_PTR(x161);
}
value owl_stub_30_c_eigen_spmat_d_div_scalar(value x163, value x162)
{
   struct c_spmat_d* x164 = CTYPES_ADDR_OF_FATPTR(x163);
   double x165 = Double_val(x162);
   struct c_spmat_d* x168 = c_eigen_spmat_d_div_scalar(x164, x165);
   return CTYPES_FROM_PTR(x168);
}
value owl_stub_31_c_eigen_spmat_d_min2(value x170, value x169)
{
   struct c_spmat_d* x171 = CTYPES_ADDR_OF_FATPTR(x170);
   struct c_spmat_d* x172 = CTYPES_ADDR_OF_FATPTR(x169);
   struct c_spmat_d* x173 = c_eigen_spmat_d_min2(x171, x172);
   return CTYPES_FROM_PTR(x173);
}
value owl_stub_32_c_eigen_spmat_d_max2(value x175, value x174)
{
   struct c_spmat_d* x176 = CTYPES_ADDR_OF_FATPTR(x175);
   struct c_spmat_d* x177 = CTYPES_ADDR_OF_FATPTR(x174);
   struct c_spmat_d* x178 = c_eigen_spmat_d_max2(x176, x177);
   return CTYPES_FROM_PTR(x178);
}
value owl_stub_33_c_eigen_spmat_d_sum(value x179)
{
   struct c_spmat_d* x180 = CTYPES_ADDR_OF_FATPTR(x179);
   double x181 = c_eigen_spmat_d_sum(x180);
   return caml_copy_double(x181);
}
value owl_stub_34_c_eigen_spmat_d_min(value x182)
{
   struct c_spmat_d* x183 = CTYPES_ADDR_OF_FATPTR(x182);
   double x184 = c_eigen_spmat_d_min(x183);
   return caml_copy_double(x184);
}
value owl_stub_35_c_eigen_spmat_d_max(value x185)
{
   struct c_spmat_d* x186 = CTYPES_ADDR_OF_FATPTR(x185);
   double x187 = c_eigen_spmat_d_max(x186);
   return caml_copy_double(x187);
}
value owl_stub_36_c_eigen_spmat_d_abs(value x188)
{
   struct c_spmat_d* x189 = CTYPES_ADDR_OF_FATPTR(x188);
   struct c_spmat_d* x190 = c_eigen_spmat_d_abs(x189);
   return CTYPES_FROM_PTR(x190);
}
value owl_stub_37_c_eigen_spmat_d_neg(value x191)
{
   struct c_spmat_d* x192 = CTYPES_ADDR_OF_FATPTR(x191);
   struct c_spmat_d* x193 = c_eigen_spmat_d_neg(x192);
   return CTYPES_FROM_PTR(x193);
}
value owl_stub_38_c_eigen_spmat_d_sqrt(value x194)
{
   struct c_spmat_d* x195 = CTYPES_ADDR_OF_FATPTR(x194);
   struct c_spmat_d* x196 = c_eigen_spmat_d_sqrt(x195);
   return CTYPES_FROM_PTR(x196);
}
value owl_stub_39_c_eigen_spmat_d_print(value x197)
{
   struct c_spmat_d* x198 = CTYPES_ADDR_OF_FATPTR(x197);
   c_eigen_spmat_d_print(x198);
   return Val_unit;
}
