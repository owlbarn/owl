#include "libowl_eigen.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_c_eigen_spmat_d_new(value x2, value x1)
{
   int64_t x3 = Int64_val(x2);
   int64_t x6 = Int64_val(x1);
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
   int64_t x14 = Int64_val(x13);
   struct c_spmat_d* x17 = c_eigen_spmat_d_eye(x14);
   return CTYPES_FROM_PTR(x17);
}
value owl_stub_4_c_eigen_spmat_d_rows(value x18)
{
   struct c_spmat_d* x19 = CTYPES_ADDR_OF_FATPTR(x18);
   int64_t x20 = c_eigen_spmat_d_rows(x19);
   return caml_copy_int64(x20);
}
value owl_stub_5_c_eigen_spmat_d_cols(value x21)
{
   struct c_spmat_d* x22 = CTYPES_ADDR_OF_FATPTR(x21);
   int64_t x23 = c_eigen_spmat_d_cols(x22);
   return caml_copy_int64(x23);
}
value owl_stub_6_c_eigen_spmat_d_nnz(value x24)
{
   struct c_spmat_d* x25 = CTYPES_ADDR_OF_FATPTR(x24);
   int64_t x26 = c_eigen_spmat_d_nnz(x25);
   return caml_copy_int64(x26);
}
value owl_stub_7_c_eigen_spmat_d_get(value x29, value x28, value x27)
{
   struct c_spmat_d* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   int64_t x31 = Int64_val(x28);
   int64_t x34 = Int64_val(x27);
   double x37 = c_eigen_spmat_d_get(x30, x31, x34);
   return caml_copy_double(x37);
}
value owl_stub_8_c_eigen_spmat_d_set(value x41, value x40, value x39,
                                     value x38)
{
   struct c_spmat_d* x42 = CTYPES_ADDR_OF_FATPTR(x41);
   int64_t x43 = Int64_val(x40);
   int64_t x46 = Int64_val(x39);
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
   int64_t x69 = Int64_val(x66);
   int64_t x72 = Int64_val(x65);
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
   int64_t* x90 = CTYPES_ADDR_OF_FATPTR(x87);
   double* x91 = c_eigen_spmat_d_valueptr(x89, x90);
   return CTYPES_FROM_PTR(x91);
}
value owl_stub_16_c_eigen_spmat_d_innerindexptr(value x92)
{
   struct c_spmat_d* x93 = CTYPES_ADDR_OF_FATPTR(x92);
   int64_t* x94 = c_eigen_spmat_d_innerindexptr(x93);
   return CTYPES_FROM_PTR(x94);
}
value owl_stub_17_c_eigen_spmat_d_outerindexptr(value x95)
{
   struct c_spmat_d* x96 = CTYPES_ADDR_OF_FATPTR(x95);
   int64_t* x97 = c_eigen_spmat_d_outerindexptr(x96);
   return CTYPES_FROM_PTR(x97);
}
value owl_stub_18_c_eigen_spmat_d_clone(value x98)
{
   struct c_spmat_d* x99 = CTYPES_ADDR_OF_FATPTR(x98);
   struct c_spmat_d* x100 = c_eigen_spmat_d_clone(x99);
   return CTYPES_FROM_PTR(x100);
}
value owl_stub_19_c_eigen_spmat_d_row(value x102, value x101)
{
   struct c_spmat_d* x103 = CTYPES_ADDR_OF_FATPTR(x102);
   int64_t x104 = Int64_val(x101);
   struct c_spmat_d* x107 = c_eigen_spmat_d_row(x103, x104);
   return CTYPES_FROM_PTR(x107);
}
value owl_stub_20_c_eigen_spmat_d_col(value x109, value x108)
{
   struct c_spmat_d* x110 = CTYPES_ADDR_OF_FATPTR(x109);
   int64_t x111 = Int64_val(x108);
   struct c_spmat_d* x114 = c_eigen_spmat_d_col(x110, x111);
   return CTYPES_FROM_PTR(x114);
}
value owl_stub_21_c_eigen_spmat_d_transpose(value x115)
{
   struct c_spmat_d* x116 = CTYPES_ADDR_OF_FATPTR(x115);
   struct c_spmat_d* x117 = c_eigen_spmat_d_transpose(x116);
   return CTYPES_FROM_PTR(x117);
}
value owl_stub_22_c_eigen_spmat_d_adjoint(value x118)
{
   struct c_spmat_d* x119 = CTYPES_ADDR_OF_FATPTR(x118);
   struct c_spmat_d* x120 = c_eigen_spmat_d_adjoint(x119);
   return CTYPES_FROM_PTR(x120);
}
value owl_stub_23_c_eigen_spmat_d_diagonal(value x121)
{
   struct c_spmat_d* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   struct c_spmat_d* x123 = c_eigen_spmat_d_diagonal(x122);
   return CTYPES_FROM_PTR(x123);
}
value owl_stub_24_c_eigen_spmat_d_trace(value x124)
{
   struct c_spmat_d* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   double x126 = c_eigen_spmat_d_trace(x125);
   return caml_copy_double(x126);
}
value owl_stub_25_c_eigen_spmat_d_is_zero(value x127)
{
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   int x129 = c_eigen_spmat_d_is_zero(x128);
   return Val_int(x129);
}
value owl_stub_26_c_eigen_spmat_d_is_positive(value x130)
{
   struct c_spmat_d* x131 = CTYPES_ADDR_OF_FATPTR(x130);
   int x132 = c_eigen_spmat_d_is_positive(x131);
   return Val_int(x132);
}
value owl_stub_27_c_eigen_spmat_d_is_negative(value x133)
{
   struct c_spmat_d* x134 = CTYPES_ADDR_OF_FATPTR(x133);
   int x135 = c_eigen_spmat_d_is_negative(x134);
   return Val_int(x135);
}
value owl_stub_28_c_eigen_spmat_d_is_nonpositive(value x136)
{
   struct c_spmat_d* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   int x138 = c_eigen_spmat_d_is_nonpositive(x137);
   return Val_int(x138);
}
value owl_stub_29_c_eigen_spmat_d_is_nonnegative(value x139)
{
   struct c_spmat_d* x140 = CTYPES_ADDR_OF_FATPTR(x139);
   int x141 = c_eigen_spmat_d_is_nonnegative(x140);
   return Val_int(x141);
}
value owl_stub_30_c_eigen_spmat_d_is_equal(value x143, value x142)
{
   struct c_spmat_d* x144 = CTYPES_ADDR_OF_FATPTR(x143);
   struct c_spmat_d* x145 = CTYPES_ADDR_OF_FATPTR(x142);
   int x146 = c_eigen_spmat_d_is_equal(x144, x145);
   return Val_int(x146);
}
value owl_stub_31_c_eigen_spmat_d_is_unequal(value x148, value x147)
{
   struct c_spmat_d* x149 = CTYPES_ADDR_OF_FATPTR(x148);
   struct c_spmat_d* x150 = CTYPES_ADDR_OF_FATPTR(x147);
   int x151 = c_eigen_spmat_d_is_unequal(x149, x150);
   return Val_int(x151);
}
value owl_stub_32_c_eigen_spmat_d_is_greater(value x153, value x152)
{
   struct c_spmat_d* x154 = CTYPES_ADDR_OF_FATPTR(x153);
   struct c_spmat_d* x155 = CTYPES_ADDR_OF_FATPTR(x152);
   int x156 = c_eigen_spmat_d_is_greater(x154, x155);
   return Val_int(x156);
}
value owl_stub_33_c_eigen_spmat_d_is_smaller(value x158, value x157)
{
   struct c_spmat_d* x159 = CTYPES_ADDR_OF_FATPTR(x158);
   struct c_spmat_d* x160 = CTYPES_ADDR_OF_FATPTR(x157);
   int x161 = c_eigen_spmat_d_is_smaller(x159, x160);
   return Val_int(x161);
}
value owl_stub_34_c_eigen_spmat_d_equal_or_greater(value x163, value x162)
{
   struct c_spmat_d* x164 = CTYPES_ADDR_OF_FATPTR(x163);
   struct c_spmat_d* x165 = CTYPES_ADDR_OF_FATPTR(x162);
   int x166 = c_eigen_spmat_d_equal_or_greater(x164, x165);
   return Val_int(x166);
}
value owl_stub_35_c_eigen_spmat_d_equal_or_smaller(value x168, value x167)
{
   struct c_spmat_d* x169 = CTYPES_ADDR_OF_FATPTR(x168);
   struct c_spmat_d* x170 = CTYPES_ADDR_OF_FATPTR(x167);
   int x171 = c_eigen_spmat_d_equal_or_smaller(x169, x170);
   return Val_int(x171);
}
value owl_stub_36_c_eigen_spmat_d_add(value x173, value x172)
{
   struct c_spmat_d* x174 = CTYPES_ADDR_OF_FATPTR(x173);
   struct c_spmat_d* x175 = CTYPES_ADDR_OF_FATPTR(x172);
   struct c_spmat_d* x176 = c_eigen_spmat_d_add(x174, x175);
   return CTYPES_FROM_PTR(x176);
}
value owl_stub_37_c_eigen_spmat_d_sub(value x178, value x177)
{
   struct c_spmat_d* x179 = CTYPES_ADDR_OF_FATPTR(x178);
   struct c_spmat_d* x180 = CTYPES_ADDR_OF_FATPTR(x177);
   struct c_spmat_d* x181 = c_eigen_spmat_d_sub(x179, x180);
   return CTYPES_FROM_PTR(x181);
}
value owl_stub_38_c_eigen_spmat_d_mul(value x183, value x182)
{
   struct c_spmat_d* x184 = CTYPES_ADDR_OF_FATPTR(x183);
   struct c_spmat_d* x185 = CTYPES_ADDR_OF_FATPTR(x182);
   struct c_spmat_d* x186 = c_eigen_spmat_d_mul(x184, x185);
   return CTYPES_FROM_PTR(x186);
}
value owl_stub_39_c_eigen_spmat_d_div(value x188, value x187)
{
   struct c_spmat_d* x189 = CTYPES_ADDR_OF_FATPTR(x188);
   struct c_spmat_d* x190 = CTYPES_ADDR_OF_FATPTR(x187);
   struct c_spmat_d* x191 = c_eigen_spmat_d_div(x189, x190);
   return CTYPES_FROM_PTR(x191);
}
value owl_stub_40_c_eigen_spmat_d_dot(value x193, value x192)
{
   struct c_spmat_d* x194 = CTYPES_ADDR_OF_FATPTR(x193);
   struct c_spmat_d* x195 = CTYPES_ADDR_OF_FATPTR(x192);
   struct c_spmat_d* x196 = c_eigen_spmat_d_dot(x194, x195);
   return CTYPES_FROM_PTR(x196);
}
value owl_stub_41_c_eigen_spmat_d_add_scalar(value x198, value x197)
{
   struct c_spmat_d* x199 = CTYPES_ADDR_OF_FATPTR(x198);
   double x200 = Double_val(x197);
   struct c_spmat_d* x203 = c_eigen_spmat_d_add_scalar(x199, x200);
   return CTYPES_FROM_PTR(x203);
}
value owl_stub_42_c_eigen_spmat_d_sub_scalar(value x205, value x204)
{
   struct c_spmat_d* x206 = CTYPES_ADDR_OF_FATPTR(x205);
   double x207 = Double_val(x204);
   struct c_spmat_d* x210 = c_eigen_spmat_d_sub_scalar(x206, x207);
   return CTYPES_FROM_PTR(x210);
}
value owl_stub_43_c_eigen_spmat_d_mul_scalar(value x212, value x211)
{
   struct c_spmat_d* x213 = CTYPES_ADDR_OF_FATPTR(x212);
   double x214 = Double_val(x211);
   struct c_spmat_d* x217 = c_eigen_spmat_d_mul_scalar(x213, x214);
   return CTYPES_FROM_PTR(x217);
}
value owl_stub_44_c_eigen_spmat_d_div_scalar(value x219, value x218)
{
   struct c_spmat_d* x220 = CTYPES_ADDR_OF_FATPTR(x219);
   double x221 = Double_val(x218);
   struct c_spmat_d* x224 = c_eigen_spmat_d_div_scalar(x220, x221);
   return CTYPES_FROM_PTR(x224);
}
value owl_stub_45_c_eigen_spmat_d_min2(value x226, value x225)
{
   struct c_spmat_d* x227 = CTYPES_ADDR_OF_FATPTR(x226);
   struct c_spmat_d* x228 = CTYPES_ADDR_OF_FATPTR(x225);
   struct c_spmat_d* x229 = c_eigen_spmat_d_min2(x227, x228);
   return CTYPES_FROM_PTR(x229);
}
value owl_stub_46_c_eigen_spmat_d_max2(value x231, value x230)
{
   struct c_spmat_d* x232 = CTYPES_ADDR_OF_FATPTR(x231);
   struct c_spmat_d* x233 = CTYPES_ADDR_OF_FATPTR(x230);
   struct c_spmat_d* x234 = c_eigen_spmat_d_max2(x232, x233);
   return CTYPES_FROM_PTR(x234);
}
value owl_stub_47_c_eigen_spmat_d_sum(value x235)
{
   struct c_spmat_d* x236 = CTYPES_ADDR_OF_FATPTR(x235);
   double x237 = c_eigen_spmat_d_sum(x236);
   return caml_copy_double(x237);
}
value owl_stub_48_c_eigen_spmat_d_min(value x238)
{
   struct c_spmat_d* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   double x240 = c_eigen_spmat_d_min(x239);
   return caml_copy_double(x240);
}
value owl_stub_49_c_eigen_spmat_d_max(value x241)
{
   struct c_spmat_d* x242 = CTYPES_ADDR_OF_FATPTR(x241);
   double x243 = c_eigen_spmat_d_max(x242);
   return caml_copy_double(x243);
}
value owl_stub_50_c_eigen_spmat_d_abs(value x244)
{
   struct c_spmat_d* x245 = CTYPES_ADDR_OF_FATPTR(x244);
   struct c_spmat_d* x246 = c_eigen_spmat_d_abs(x245);
   return CTYPES_FROM_PTR(x246);
}
value owl_stub_51_c_eigen_spmat_d_neg(value x247)
{
   struct c_spmat_d* x248 = CTYPES_ADDR_OF_FATPTR(x247);
   struct c_spmat_d* x249 = c_eigen_spmat_d_neg(x248);
   return CTYPES_FROM_PTR(x249);
}
value owl_stub_52_c_eigen_spmat_d_sqrt(value x250)
{
   struct c_spmat_d* x251 = CTYPES_ADDR_OF_FATPTR(x250);
   struct c_spmat_d* x252 = c_eigen_spmat_d_sqrt(x251);
   return CTYPES_FROM_PTR(x252);
}
value owl_stub_53_c_eigen_spmat_d_print(value x253)
{
   struct c_spmat_d* x254 = CTYPES_ADDR_OF_FATPTR(x253);
   c_eigen_spmat_d_print(x254);
   return Val_unit;
}
