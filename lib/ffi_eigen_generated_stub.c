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
value owl_stub_22_c_eigen_spmat_d_is_negative(value x116)
{
   struct c_spmat_d* x117 = CTYPES_ADDR_OF_FATPTR(x116);
   int x118 = c_eigen_spmat_d_is_negative(x117);
   return Val_int(x118);
}
value owl_stub_23_c_eigen_spmat_d_is_nonpositive(value x119)
{
   struct c_spmat_d* x120 = CTYPES_ADDR_OF_FATPTR(x119);
   int x121 = c_eigen_spmat_d_is_nonpositive(x120);
   return Val_int(x121);
}
value owl_stub_24_c_eigen_spmat_d_is_nonnegative(value x122)
{
   struct c_spmat_d* x123 = CTYPES_ADDR_OF_FATPTR(x122);
   int x124 = c_eigen_spmat_d_is_nonnegative(x123);
   return Val_int(x124);
}
value owl_stub_25_c_eigen_spmat_d_is_equal(value x126, value x125)
{
   struct c_spmat_d* x127 = CTYPES_ADDR_OF_FATPTR(x126);
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x125);
   int x129 = c_eigen_spmat_d_is_equal(x127, x128);
   return Val_int(x129);
}
value owl_stub_26_c_eigen_spmat_d_is_unequal(value x131, value x130)
{
   struct c_spmat_d* x132 = CTYPES_ADDR_OF_FATPTR(x131);
   struct c_spmat_d* x133 = CTYPES_ADDR_OF_FATPTR(x130);
   int x134 = c_eigen_spmat_d_is_unequal(x132, x133);
   return Val_int(x134);
}
value owl_stub_27_c_eigen_spmat_d_is_greater(value x136, value x135)
{
   struct c_spmat_d* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   struct c_spmat_d* x138 = CTYPES_ADDR_OF_FATPTR(x135);
   int x139 = c_eigen_spmat_d_is_greater(x137, x138);
   return Val_int(x139);
}
value owl_stub_28_c_eigen_spmat_d_is_smaller(value x141, value x140)
{
   struct c_spmat_d* x142 = CTYPES_ADDR_OF_FATPTR(x141);
   struct c_spmat_d* x143 = CTYPES_ADDR_OF_FATPTR(x140);
   int x144 = c_eigen_spmat_d_is_smaller(x142, x143);
   return Val_int(x144);
}
value owl_stub_29_c_eigen_spmat_d_equal_or_greater(value x146, value x145)
{
   struct c_spmat_d* x147 = CTYPES_ADDR_OF_FATPTR(x146);
   struct c_spmat_d* x148 = CTYPES_ADDR_OF_FATPTR(x145);
   int x149 = c_eigen_spmat_d_equal_or_greater(x147, x148);
   return Val_int(x149);
}
value owl_stub_30_c_eigen_spmat_d_equal_or_smaller(value x151, value x150)
{
   struct c_spmat_d* x152 = CTYPES_ADDR_OF_FATPTR(x151);
   struct c_spmat_d* x153 = CTYPES_ADDR_OF_FATPTR(x150);
   int x154 = c_eigen_spmat_d_equal_or_smaller(x152, x153);
   return Val_int(x154);
}
value owl_stub_31_c_eigen_spmat_d_add(value x156, value x155)
{
   struct c_spmat_d* x157 = CTYPES_ADDR_OF_FATPTR(x156);
   struct c_spmat_d* x158 = CTYPES_ADDR_OF_FATPTR(x155);
   struct c_spmat_d* x159 = c_eigen_spmat_d_add(x157, x158);
   return CTYPES_FROM_PTR(x159);
}
value owl_stub_32_c_eigen_spmat_d_sub(value x161, value x160)
{
   struct c_spmat_d* x162 = CTYPES_ADDR_OF_FATPTR(x161);
   struct c_spmat_d* x163 = CTYPES_ADDR_OF_FATPTR(x160);
   struct c_spmat_d* x164 = c_eigen_spmat_d_sub(x162, x163);
   return CTYPES_FROM_PTR(x164);
}
value owl_stub_33_c_eigen_spmat_d_mul(value x166, value x165)
{
   struct c_spmat_d* x167 = CTYPES_ADDR_OF_FATPTR(x166);
   struct c_spmat_d* x168 = CTYPES_ADDR_OF_FATPTR(x165);
   struct c_spmat_d* x169 = c_eigen_spmat_d_mul(x167, x168);
   return CTYPES_FROM_PTR(x169);
}
value owl_stub_34_c_eigen_spmat_d_div(value x171, value x170)
{
   struct c_spmat_d* x172 = CTYPES_ADDR_OF_FATPTR(x171);
   struct c_spmat_d* x173 = CTYPES_ADDR_OF_FATPTR(x170);
   struct c_spmat_d* x174 = c_eigen_spmat_d_div(x172, x173);
   return CTYPES_FROM_PTR(x174);
}
value owl_stub_35_c_eigen_spmat_d_dot(value x176, value x175)
{
   struct c_spmat_d* x177 = CTYPES_ADDR_OF_FATPTR(x176);
   struct c_spmat_d* x178 = CTYPES_ADDR_OF_FATPTR(x175);
   struct c_spmat_d* x179 = c_eigen_spmat_d_dot(x177, x178);
   return CTYPES_FROM_PTR(x179);
}
value owl_stub_36_c_eigen_spmat_d_add_scalar(value x181, value x180)
{
   struct c_spmat_d* x182 = CTYPES_ADDR_OF_FATPTR(x181);
   double x183 = Double_val(x180);
   struct c_spmat_d* x186 = c_eigen_spmat_d_add_scalar(x182, x183);
   return CTYPES_FROM_PTR(x186);
}
value owl_stub_37_c_eigen_spmat_d_sub_scalar(value x188, value x187)
{
   struct c_spmat_d* x189 = CTYPES_ADDR_OF_FATPTR(x188);
   double x190 = Double_val(x187);
   struct c_spmat_d* x193 = c_eigen_spmat_d_sub_scalar(x189, x190);
   return CTYPES_FROM_PTR(x193);
}
value owl_stub_38_c_eigen_spmat_d_mul_scalar(value x195, value x194)
{
   struct c_spmat_d* x196 = CTYPES_ADDR_OF_FATPTR(x195);
   double x197 = Double_val(x194);
   struct c_spmat_d* x200 = c_eigen_spmat_d_mul_scalar(x196, x197);
   return CTYPES_FROM_PTR(x200);
}
value owl_stub_39_c_eigen_spmat_d_div_scalar(value x202, value x201)
{
   struct c_spmat_d* x203 = CTYPES_ADDR_OF_FATPTR(x202);
   double x204 = Double_val(x201);
   struct c_spmat_d* x207 = c_eigen_spmat_d_div_scalar(x203, x204);
   return CTYPES_FROM_PTR(x207);
}
value owl_stub_40_c_eigen_spmat_d_min2(value x209, value x208)
{
   struct c_spmat_d* x210 = CTYPES_ADDR_OF_FATPTR(x209);
   struct c_spmat_d* x211 = CTYPES_ADDR_OF_FATPTR(x208);
   struct c_spmat_d* x212 = c_eigen_spmat_d_min2(x210, x211);
   return CTYPES_FROM_PTR(x212);
}
value owl_stub_41_c_eigen_spmat_d_max2(value x214, value x213)
{
   struct c_spmat_d* x215 = CTYPES_ADDR_OF_FATPTR(x214);
   struct c_spmat_d* x216 = CTYPES_ADDR_OF_FATPTR(x213);
   struct c_spmat_d* x217 = c_eigen_spmat_d_max2(x215, x216);
   return CTYPES_FROM_PTR(x217);
}
value owl_stub_42_c_eigen_spmat_d_sum(value x218)
{
   struct c_spmat_d* x219 = CTYPES_ADDR_OF_FATPTR(x218);
   double x220 = c_eigen_spmat_d_sum(x219);
   return caml_copy_double(x220);
}
value owl_stub_43_c_eigen_spmat_d_min(value x221)
{
   struct c_spmat_d* x222 = CTYPES_ADDR_OF_FATPTR(x221);
   double x223 = c_eigen_spmat_d_min(x222);
   return caml_copy_double(x223);
}
value owl_stub_44_c_eigen_spmat_d_max(value x224)
{
   struct c_spmat_d* x225 = CTYPES_ADDR_OF_FATPTR(x224);
   double x226 = c_eigen_spmat_d_max(x225);
   return caml_copy_double(x226);
}
value owl_stub_45_c_eigen_spmat_d_abs(value x227)
{
   struct c_spmat_d* x228 = CTYPES_ADDR_OF_FATPTR(x227);
   struct c_spmat_d* x229 = c_eigen_spmat_d_abs(x228);
   return CTYPES_FROM_PTR(x229);
}
value owl_stub_46_c_eigen_spmat_d_neg(value x230)
{
   struct c_spmat_d* x231 = CTYPES_ADDR_OF_FATPTR(x230);
   struct c_spmat_d* x232 = c_eigen_spmat_d_neg(x231);
   return CTYPES_FROM_PTR(x232);
}
value owl_stub_47_c_eigen_spmat_d_sqrt(value x233)
{
   struct c_spmat_d* x234 = CTYPES_ADDR_OF_FATPTR(x233);
   struct c_spmat_d* x235 = c_eigen_spmat_d_sqrt(x234);
   return CTYPES_FROM_PTR(x235);
}
value owl_stub_48_c_eigen_spmat_d_print(value x236)
{
   struct c_spmat_d* x237 = CTYPES_ADDR_OF_FATPTR(x236);
   c_eigen_spmat_d_print(x237);
   return Val_unit;
}
