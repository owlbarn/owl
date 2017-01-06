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
value owl_stub_16_c_eigen_spmat_d_innerindexptr(value x92)
{
   struct c_spmat_d* x93 = CTYPES_ADDR_OF_FATPTR(x92);
   int* x94 = c_eigen_spmat_d_innerindexptr(x93);
   return CTYPES_FROM_PTR(x94);
}
value owl_stub_17_c_eigen_spmat_d_outerindexptr(value x95)
{
   struct c_spmat_d* x96 = CTYPES_ADDR_OF_FATPTR(x95);
   int* x97 = c_eigen_spmat_d_outerindexptr(x96);
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
   int x104 = Int_val(x101);
   struct c_spmat_d* x107 = c_eigen_spmat_d_row(x103, x104);
   return CTYPES_FROM_PTR(x107);
}
value owl_stub_20_c_eigen_spmat_d_col(value x109, value x108)
{
   struct c_spmat_d* x110 = CTYPES_ADDR_OF_FATPTR(x109);
   int x111 = Int_val(x108);
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
value owl_stub_23_c_eigen_spmat_d_is_zero(value x121)
{
   struct c_spmat_d* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   int x123 = c_eigen_spmat_d_is_zero(x122);
   return Val_int(x123);
}
value owl_stub_24_c_eigen_spmat_d_is_positive(value x124)
{
   struct c_spmat_d* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   int x126 = c_eigen_spmat_d_is_positive(x125);
   return Val_int(x126);
}
value owl_stub_25_c_eigen_spmat_d_is_negative(value x127)
{
   struct c_spmat_d* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   int x129 = c_eigen_spmat_d_is_negative(x128);
   return Val_int(x129);
}
value owl_stub_26_c_eigen_spmat_d_is_nonpositive(value x130)
{
   struct c_spmat_d* x131 = CTYPES_ADDR_OF_FATPTR(x130);
   int x132 = c_eigen_spmat_d_is_nonpositive(x131);
   return Val_int(x132);
}
value owl_stub_27_c_eigen_spmat_d_is_nonnegative(value x133)
{
   struct c_spmat_d* x134 = CTYPES_ADDR_OF_FATPTR(x133);
   int x135 = c_eigen_spmat_d_is_nonnegative(x134);
   return Val_int(x135);
}
value owl_stub_28_c_eigen_spmat_d_is_equal(value x137, value x136)
{
   struct c_spmat_d* x138 = CTYPES_ADDR_OF_FATPTR(x137);
   struct c_spmat_d* x139 = CTYPES_ADDR_OF_FATPTR(x136);
   int x140 = c_eigen_spmat_d_is_equal(x138, x139);
   return Val_int(x140);
}
value owl_stub_29_c_eigen_spmat_d_is_unequal(value x142, value x141)
{
   struct c_spmat_d* x143 = CTYPES_ADDR_OF_FATPTR(x142);
   struct c_spmat_d* x144 = CTYPES_ADDR_OF_FATPTR(x141);
   int x145 = c_eigen_spmat_d_is_unequal(x143, x144);
   return Val_int(x145);
}
value owl_stub_30_c_eigen_spmat_d_is_greater(value x147, value x146)
{
   struct c_spmat_d* x148 = CTYPES_ADDR_OF_FATPTR(x147);
   struct c_spmat_d* x149 = CTYPES_ADDR_OF_FATPTR(x146);
   int x150 = c_eigen_spmat_d_is_greater(x148, x149);
   return Val_int(x150);
}
value owl_stub_31_c_eigen_spmat_d_is_smaller(value x152, value x151)
{
   struct c_spmat_d* x153 = CTYPES_ADDR_OF_FATPTR(x152);
   struct c_spmat_d* x154 = CTYPES_ADDR_OF_FATPTR(x151);
   int x155 = c_eigen_spmat_d_is_smaller(x153, x154);
   return Val_int(x155);
}
value owl_stub_32_c_eigen_spmat_d_equal_or_greater(value x157, value x156)
{
   struct c_spmat_d* x158 = CTYPES_ADDR_OF_FATPTR(x157);
   struct c_spmat_d* x159 = CTYPES_ADDR_OF_FATPTR(x156);
   int x160 = c_eigen_spmat_d_equal_or_greater(x158, x159);
   return Val_int(x160);
}
value owl_stub_33_c_eigen_spmat_d_equal_or_smaller(value x162, value x161)
{
   struct c_spmat_d* x163 = CTYPES_ADDR_OF_FATPTR(x162);
   struct c_spmat_d* x164 = CTYPES_ADDR_OF_FATPTR(x161);
   int x165 = c_eigen_spmat_d_equal_or_smaller(x163, x164);
   return Val_int(x165);
}
value owl_stub_34_c_eigen_spmat_d_add(value x167, value x166)
{
   struct c_spmat_d* x168 = CTYPES_ADDR_OF_FATPTR(x167);
   struct c_spmat_d* x169 = CTYPES_ADDR_OF_FATPTR(x166);
   struct c_spmat_d* x170 = c_eigen_spmat_d_add(x168, x169);
   return CTYPES_FROM_PTR(x170);
}
value owl_stub_35_c_eigen_spmat_d_sub(value x172, value x171)
{
   struct c_spmat_d* x173 = CTYPES_ADDR_OF_FATPTR(x172);
   struct c_spmat_d* x174 = CTYPES_ADDR_OF_FATPTR(x171);
   struct c_spmat_d* x175 = c_eigen_spmat_d_sub(x173, x174);
   return CTYPES_FROM_PTR(x175);
}
value owl_stub_36_c_eigen_spmat_d_mul(value x177, value x176)
{
   struct c_spmat_d* x178 = CTYPES_ADDR_OF_FATPTR(x177);
   struct c_spmat_d* x179 = CTYPES_ADDR_OF_FATPTR(x176);
   struct c_spmat_d* x180 = c_eigen_spmat_d_mul(x178, x179);
   return CTYPES_FROM_PTR(x180);
}
value owl_stub_37_c_eigen_spmat_d_div(value x182, value x181)
{
   struct c_spmat_d* x183 = CTYPES_ADDR_OF_FATPTR(x182);
   struct c_spmat_d* x184 = CTYPES_ADDR_OF_FATPTR(x181);
   struct c_spmat_d* x185 = c_eigen_spmat_d_div(x183, x184);
   return CTYPES_FROM_PTR(x185);
}
value owl_stub_38_c_eigen_spmat_d_dot(value x187, value x186)
{
   struct c_spmat_d* x188 = CTYPES_ADDR_OF_FATPTR(x187);
   struct c_spmat_d* x189 = CTYPES_ADDR_OF_FATPTR(x186);
   struct c_spmat_d* x190 = c_eigen_spmat_d_dot(x188, x189);
   return CTYPES_FROM_PTR(x190);
}
value owl_stub_39_c_eigen_spmat_d_add_scalar(value x192, value x191)
{
   struct c_spmat_d* x193 = CTYPES_ADDR_OF_FATPTR(x192);
   double x194 = Double_val(x191);
   struct c_spmat_d* x197 = c_eigen_spmat_d_add_scalar(x193, x194);
   return CTYPES_FROM_PTR(x197);
}
value owl_stub_40_c_eigen_spmat_d_sub_scalar(value x199, value x198)
{
   struct c_spmat_d* x200 = CTYPES_ADDR_OF_FATPTR(x199);
   double x201 = Double_val(x198);
   struct c_spmat_d* x204 = c_eigen_spmat_d_sub_scalar(x200, x201);
   return CTYPES_FROM_PTR(x204);
}
value owl_stub_41_c_eigen_spmat_d_mul_scalar(value x206, value x205)
{
   struct c_spmat_d* x207 = CTYPES_ADDR_OF_FATPTR(x206);
   double x208 = Double_val(x205);
   struct c_spmat_d* x211 = c_eigen_spmat_d_mul_scalar(x207, x208);
   return CTYPES_FROM_PTR(x211);
}
value owl_stub_42_c_eigen_spmat_d_div_scalar(value x213, value x212)
{
   struct c_spmat_d* x214 = CTYPES_ADDR_OF_FATPTR(x213);
   double x215 = Double_val(x212);
   struct c_spmat_d* x218 = c_eigen_spmat_d_div_scalar(x214, x215);
   return CTYPES_FROM_PTR(x218);
}
value owl_stub_43_c_eigen_spmat_d_min2(value x220, value x219)
{
   struct c_spmat_d* x221 = CTYPES_ADDR_OF_FATPTR(x220);
   struct c_spmat_d* x222 = CTYPES_ADDR_OF_FATPTR(x219);
   struct c_spmat_d* x223 = c_eigen_spmat_d_min2(x221, x222);
   return CTYPES_FROM_PTR(x223);
}
value owl_stub_44_c_eigen_spmat_d_max2(value x225, value x224)
{
   struct c_spmat_d* x226 = CTYPES_ADDR_OF_FATPTR(x225);
   struct c_spmat_d* x227 = CTYPES_ADDR_OF_FATPTR(x224);
   struct c_spmat_d* x228 = c_eigen_spmat_d_max2(x226, x227);
   return CTYPES_FROM_PTR(x228);
}
value owl_stub_45_c_eigen_spmat_d_sum(value x229)
{
   struct c_spmat_d* x230 = CTYPES_ADDR_OF_FATPTR(x229);
   double x231 = c_eigen_spmat_d_sum(x230);
   return caml_copy_double(x231);
}
value owl_stub_46_c_eigen_spmat_d_min(value x232)
{
   struct c_spmat_d* x233 = CTYPES_ADDR_OF_FATPTR(x232);
   double x234 = c_eigen_spmat_d_min(x233);
   return caml_copy_double(x234);
}
value owl_stub_47_c_eigen_spmat_d_max(value x235)
{
   struct c_spmat_d* x236 = CTYPES_ADDR_OF_FATPTR(x235);
   double x237 = c_eigen_spmat_d_max(x236);
   return caml_copy_double(x237);
}
value owl_stub_48_c_eigen_spmat_d_abs(value x238)
{
   struct c_spmat_d* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   struct c_spmat_d* x240 = c_eigen_spmat_d_abs(x239);
   return CTYPES_FROM_PTR(x240);
}
value owl_stub_49_c_eigen_spmat_d_neg(value x241)
{
   struct c_spmat_d* x242 = CTYPES_ADDR_OF_FATPTR(x241);
   struct c_spmat_d* x243 = c_eigen_spmat_d_neg(x242);
   return CTYPES_FROM_PTR(x243);
}
value owl_stub_50_c_eigen_spmat_d_sqrt(value x244)
{
   struct c_spmat_d* x245 = CTYPES_ADDR_OF_FATPTR(x244);
   struct c_spmat_d* x246 = c_eigen_spmat_d_sqrt(x245);
   return CTYPES_FROM_PTR(x246);
}
value owl_stub_51_c_eigen_spmat_d_print(value x247)
{
   struct c_spmat_d* x248 = CTYPES_ADDR_OF_FATPTR(x247);
   c_eigen_spmat_d_print(x248);
   return Val_unit;
}
