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
value owl_stub_15_c_eigen_spmat_d_valueptr(value x88, value x87)
{
   struct c_spmat_d* x89 = CTYPES_ADDR_OF_FATPTR(x88);
   int* x90 = CTYPES_ADDR_OF_FATPTR(x87);
   double* x91 = c_eigen_spmat_d_valueptr(x89, x90);
   return CTYPES_FROM_PTR(x91);
}
value owl_stub_16_c_eigen_spmat_d_clone(value x92)
{
   struct c_spmat_d* x93 = CTYPES_ADDR_OF_FATPTR(x92);
   struct c_spmat_d* x94 = c_eigen_spmat_d_clone(x93);
   return CTYPES_FROM_PTR(x94);
}
value owl_stub_17_c_eigen_spmat_d_row(value x96, value x95)
{
   struct c_spmat_d* x97 = CTYPES_ADDR_OF_FATPTR(x96);
   int x98 = Int_val(x95);
   struct c_spmat_d* x101 = c_eigen_spmat_d_row(x97, x98);
   return CTYPES_FROM_PTR(x101);
}
value owl_stub_18_c_eigen_spmat_d_col(value x103, value x102)
{
   struct c_spmat_d* x104 = CTYPES_ADDR_OF_FATPTR(x103);
   int x105 = Int_val(x102);
   struct c_spmat_d* x108 = c_eigen_spmat_d_col(x104, x105);
   return CTYPES_FROM_PTR(x108);
}
value owl_stub_19_c_eigen_spmat_d_transpose(value x109)
{
   struct c_spmat_d* x110 = CTYPES_ADDR_OF_FATPTR(x109);
   struct c_spmat_d* x111 = c_eigen_spmat_d_transpose(x110);
   return CTYPES_FROM_PTR(x111);
}
value owl_stub_20_c_eigen_spmat_d_adjoint(value x112)
{
   struct c_spmat_d* x113 = CTYPES_ADDR_OF_FATPTR(x112);
   struct c_spmat_d* x114 = c_eigen_spmat_d_adjoint(x113);
   return CTYPES_FROM_PTR(x114);
}
value owl_stub_21_c_eigen_spmat_d_is_zero(value x115)
{
   struct c_spmat_d* x116 = CTYPES_ADDR_OF_FATPTR(x115);
   int x117 = c_eigen_spmat_d_is_zero(x116);
   return Val_int(x117);
}
value owl_stub_22_c_eigen_spmat_d_is_positive(value x118)
{
   struct c_spmat_d* x119 = CTYPES_ADDR_OF_FATPTR(x118);
   int x120 = c_eigen_spmat_d_is_positive(x119);
   return Val_int(x120);
}
value owl_stub_23_c_eigen_spmat_d_is_negative(value x121)
{
   struct c_spmat_d* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   int x123 = c_eigen_spmat_d_is_negative(x122);
   return Val_int(x123);
}
value owl_stub_24_c_eigen_spmat_d_is_nonpositive(value x124)
{
   struct c_spmat_d* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   int x126 = c_eigen_spmat_d_is_nonpositive(x125);
   return Val_int(x126);
}
value owl_stub_25_c_eigen_spmat_d_is_nonnegative(value x127)
{
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   int x129 = c_eigen_spmat_d_is_nonnegative(x128);
   return Val_int(x129);
}
value owl_stub_26_c_eigen_spmat_d_is_equal(value x131, value x130)
{
   struct c_spmat_d* x132 = CTYPES_ADDR_OF_FATPTR(x131);
   struct c_spmat_d* x133 = CTYPES_ADDR_OF_FATPTR(x130);
   int x134 = c_eigen_spmat_d_is_equal(x132, x133);
   return Val_int(x134);
}
value owl_stub_27_c_eigen_spmat_d_is_unequal(value x136, value x135)
{
   struct c_spmat_d* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   struct c_spmat_d* x138 = CTYPES_ADDR_OF_FATPTR(x135);
   int x139 = c_eigen_spmat_d_is_unequal(x137, x138);
   return Val_int(x139);
}
value owl_stub_28_c_eigen_spmat_d_is_greater(value x141, value x140)
{
   struct c_spmat_d* x142 = CTYPES_ADDR_OF_FATPTR(x141);
   struct c_spmat_d* x143 = CTYPES_ADDR_OF_FATPTR(x140);
   int x144 = c_eigen_spmat_d_is_greater(x142, x143);
   return Val_int(x144);
}
value owl_stub_29_c_eigen_spmat_d_is_smaller(value x146, value x145)
{
   struct c_spmat_d* x147 = CTYPES_ADDR_OF_FATPTR(x146);
   struct c_spmat_d* x148 = CTYPES_ADDR_OF_FATPTR(x145);
   int x149 = c_eigen_spmat_d_is_smaller(x147, x148);
   return Val_int(x149);
}
value owl_stub_30_c_eigen_spmat_d_equal_or_greater(value x151, value x150)
{
   struct c_spmat_d* x152 = CTYPES_ADDR_OF_FATPTR(x151);
   struct c_spmat_d* x153 = CTYPES_ADDR_OF_FATPTR(x150);
   int x154 = c_eigen_spmat_d_equal_or_greater(x152, x153);
   return Val_int(x154);
}
value owl_stub_31_c_eigen_spmat_d_equal_or_smaller(value x156, value x155)
{
   struct c_spmat_d* x157 = CTYPES_ADDR_OF_FATPTR(x156);
   struct c_spmat_d* x158 = CTYPES_ADDR_OF_FATPTR(x155);
   int x159 = c_eigen_spmat_d_equal_or_smaller(x157, x158);
   return Val_int(x159);
}
value owl_stub_32_c_eigen_spmat_d_add(value x161, value x160)
{
   struct c_spmat_d* x162 = CTYPES_ADDR_OF_FATPTR(x161);
   struct c_spmat_d* x163 = CTYPES_ADDR_OF_FATPTR(x160);
   struct c_spmat_d* x164 = c_eigen_spmat_d_add(x162, x163);
   return CTYPES_FROM_PTR(x164);
}
value owl_stub_33_c_eigen_spmat_d_sub(value x166, value x165)
{
   struct c_spmat_d* x167 = CTYPES_ADDR_OF_FATPTR(x166);
   struct c_spmat_d* x168 = CTYPES_ADDR_OF_FATPTR(x165);
   struct c_spmat_d* x169 = c_eigen_spmat_d_sub(x167, x168);
   return CTYPES_FROM_PTR(x169);
}
value owl_stub_34_c_eigen_spmat_d_mul(value x171, value x170)
{
   struct c_spmat_d* x172 = CTYPES_ADDR_OF_FATPTR(x171);
   struct c_spmat_d* x173 = CTYPES_ADDR_OF_FATPTR(x170);
   struct c_spmat_d* x174 = c_eigen_spmat_d_mul(x172, x173);
   return CTYPES_FROM_PTR(x174);
}
value owl_stub_35_c_eigen_spmat_d_div(value x176, value x175)
{
   struct c_spmat_d* x177 = CTYPES_ADDR_OF_FATPTR(x176);
   struct c_spmat_d* x178 = CTYPES_ADDR_OF_FATPTR(x175);
   struct c_spmat_d* x179 = c_eigen_spmat_d_div(x177, x178);
   return CTYPES_FROM_PTR(x179);
}
value owl_stub_36_c_eigen_spmat_d_dot(value x181, value x180)
{
   struct c_spmat_d* x182 = CTYPES_ADDR_OF_FATPTR(x181);
   struct c_spmat_d* x183 = CTYPES_ADDR_OF_FATPTR(x180);
   struct c_spmat_d* x184 = c_eigen_spmat_d_dot(x182, x183);
   return CTYPES_FROM_PTR(x184);
}
value owl_stub_37_c_eigen_spmat_d_add_scalar(value x186, value x185)
{
   struct c_spmat_d* x187 = CTYPES_ADDR_OF_FATPTR(x186);
   double x188 = Double_val(x185);
   struct c_spmat_d* x191 = c_eigen_spmat_d_add_scalar(x187, x188);
   return CTYPES_FROM_PTR(x191);
}
value owl_stub_38_c_eigen_spmat_d_sub_scalar(value x193, value x192)
{
   struct c_spmat_d* x194 = CTYPES_ADDR_OF_FATPTR(x193);
   double x195 = Double_val(x192);
   struct c_spmat_d* x198 = c_eigen_spmat_d_sub_scalar(x194, x195);
   return CTYPES_FROM_PTR(x198);
}
value owl_stub_39_c_eigen_spmat_d_mul_scalar(value x200, value x199)
{
   struct c_spmat_d* x201 = CTYPES_ADDR_OF_FATPTR(x200);
   double x202 = Double_val(x199);
   struct c_spmat_d* x205 = c_eigen_spmat_d_mul_scalar(x201, x202);
   return CTYPES_FROM_PTR(x205);
}
value owl_stub_40_c_eigen_spmat_d_div_scalar(value x207, value x206)
{
   struct c_spmat_d* x208 = CTYPES_ADDR_OF_FATPTR(x207);
   double x209 = Double_val(x206);
   struct c_spmat_d* x212 = c_eigen_spmat_d_div_scalar(x208, x209);
   return CTYPES_FROM_PTR(x212);
}
value owl_stub_41_c_eigen_spmat_d_min2(value x214, value x213)
{
   struct c_spmat_d* x215 = CTYPES_ADDR_OF_FATPTR(x214);
   struct c_spmat_d* x216 = CTYPES_ADDR_OF_FATPTR(x213);
   struct c_spmat_d* x217 = c_eigen_spmat_d_min2(x215, x216);
   return CTYPES_FROM_PTR(x217);
}
value owl_stub_42_c_eigen_spmat_d_max2(value x219, value x218)
{
   struct c_spmat_d* x220 = CTYPES_ADDR_OF_FATPTR(x219);
   struct c_spmat_d* x221 = CTYPES_ADDR_OF_FATPTR(x218);
   struct c_spmat_d* x222 = c_eigen_spmat_d_max2(x220, x221);
   return CTYPES_FROM_PTR(x222);
}
value owl_stub_43_c_eigen_spmat_d_sum(value x223)
{
   struct c_spmat_d* x224 = CTYPES_ADDR_OF_FATPTR(x223);
   double x225 = c_eigen_spmat_d_sum(x224);
   return caml_copy_double(x225);
}
value owl_stub_44_c_eigen_spmat_d_min(value x226)
{
   struct c_spmat_d* x227 = CTYPES_ADDR_OF_FATPTR(x226);
   double x228 = c_eigen_spmat_d_min(x227);
   return caml_copy_double(x228);
}
value owl_stub_45_c_eigen_spmat_d_max(value x229)
{
   struct c_spmat_d* x230 = CTYPES_ADDR_OF_FATPTR(x229);
   double x231 = c_eigen_spmat_d_max(x230);
   return caml_copy_double(x231);
}
value owl_stub_46_c_eigen_spmat_d_abs(value x232)
{
   struct c_spmat_d* x233 = CTYPES_ADDR_OF_FATPTR(x232);
   struct c_spmat_d* x234 = c_eigen_spmat_d_abs(x233);
   return CTYPES_FROM_PTR(x234);
}
value owl_stub_47_c_eigen_spmat_d_neg(value x235)
{
   struct c_spmat_d* x236 = CTYPES_ADDR_OF_FATPTR(x235);
   struct c_spmat_d* x237 = c_eigen_spmat_d_neg(x236);
   return CTYPES_FROM_PTR(x237);
}
value owl_stub_48_c_eigen_spmat_d_sqrt(value x238)
{
   struct c_spmat_d* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   struct c_spmat_d* x240 = c_eigen_spmat_d_sqrt(x239);
   return CTYPES_FROM_PTR(x240);
}
value owl_stub_49_c_eigen_spmat_d_print(value x241)
{
   struct c_spmat_d* x242 = CTYPES_ADDR_OF_FATPTR(x241);
   c_eigen_spmat_d_print(x242);
   return Val_unit;
}
