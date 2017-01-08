#include "libowl_eigen.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_c_eigen_spmat_s_new(value x2, value x1)
{
   int64_t x3 = Int64_val(x2);
   int64_t x6 = Int64_val(x1);
   struct c_spmat_s* x9 = c_eigen_spmat_s_new(x3, x6);
   return CTYPES_FROM_PTR(x9);
}
value owl_stub_2_c_eigen_spmat_s_delete(value x10)
{
   struct c_spmat_s* x11 = CTYPES_ADDR_OF_FATPTR(x10);
   c_eigen_spmat_s_delete(x11);
   return Val_unit;
}
value owl_stub_3_c_eigen_spmat_s_eye(value x13)
{
   int64_t x14 = Int64_val(x13);
   struct c_spmat_s* x17 = c_eigen_spmat_s_eye(x14);
   return CTYPES_FROM_PTR(x17);
}
value owl_stub_4_c_eigen_spmat_s_rows(value x18)
{
   struct c_spmat_s* x19 = CTYPES_ADDR_OF_FATPTR(x18);
   int64_t x20 = c_eigen_spmat_s_rows(x19);
   return caml_copy_int64(x20);
}
value owl_stub_5_c_eigen_spmat_s_cols(value x21)
{
   struct c_spmat_s* x22 = CTYPES_ADDR_OF_FATPTR(x21);
   int64_t x23 = c_eigen_spmat_s_cols(x22);
   return caml_copy_int64(x23);
}
value owl_stub_6_c_eigen_spmat_s_nnz(value x24)
{
   struct c_spmat_s* x25 = CTYPES_ADDR_OF_FATPTR(x24);
   int64_t x26 = c_eigen_spmat_s_nnz(x25);
   return caml_copy_int64(x26);
}
value owl_stub_7_c_eigen_spmat_s_get(value x29, value x28, value x27)
{
   struct c_spmat_s* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   int64_t x31 = Int64_val(x28);
   int64_t x34 = Int64_val(x27);
   float x37 = c_eigen_spmat_s_get(x30, x31, x34);
   return caml_copy_double(x37);
}
value owl_stub_8_c_eigen_spmat_s_set(value x41, value x40, value x39,
                                     value x38)
{
   struct c_spmat_s* x42 = CTYPES_ADDR_OF_FATPTR(x41);
   int64_t x43 = Int64_val(x40);
   int64_t x46 = Int64_val(x39);
   double x49 = Double_val(x38);
   c_eigen_spmat_s_set(x42, x43, x46, (float)x49);
   return Val_unit;
}
value owl_stub_9_c_eigen_spmat_s_reset(value x53)
{
   struct c_spmat_s* x54 = CTYPES_ADDR_OF_FATPTR(x53);
   c_eigen_spmat_s_reset(x54);
   return Val_unit;
}
value owl_stub_10_c_eigen_spmat_s_is_compressed(value x56)
{
   struct c_spmat_s* x57 = CTYPES_ADDR_OF_FATPTR(x56);
   int x58 = c_eigen_spmat_s_is_compressed(x57);
   return Val_int(x58);
}
value owl_stub_11_c_eigen_spmat_s_compress(value x59)
{
   struct c_spmat_s* x60 = CTYPES_ADDR_OF_FATPTR(x59);
   c_eigen_spmat_s_compress(x60);
   return Val_unit;
}
value owl_stub_12_c_eigen_spmat_s_uncompress(value x62)
{
   struct c_spmat_s* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   c_eigen_spmat_s_uncompress(x63);
   return Val_unit;
}
value owl_stub_13_c_eigen_spmat_s_reshape(value x67, value x66, value x65)
{
   struct c_spmat_s* x68 = CTYPES_ADDR_OF_FATPTR(x67);
   int64_t x69 = Int64_val(x66);
   int64_t x72 = Int64_val(x65);
   c_eigen_spmat_s_reshape(x68, x69, x72);
   return Val_unit;
}
value owl_stub_14_c_eigen_spmat_s_prune(value x78, value x77, value x76)
{
   struct c_spmat_s* x79 = CTYPES_ADDR_OF_FATPTR(x78);
   double x80 = Double_val(x77);
   double x83 = Double_val(x76);
   c_eigen_spmat_s_prune(x79, (float)x80, (float)x83);
   return Val_unit;
}
value owl_stub_15_c_eigen_spmat_s_valueptr(value x88, value x87)
{
   struct c_spmat_s* x89 = CTYPES_ADDR_OF_FATPTR(x88);
   int64_t* x90 = CTYPES_ADDR_OF_FATPTR(x87);
   float* x91 = c_eigen_spmat_s_valueptr(x89, x90);
   return CTYPES_FROM_PTR(x91);
}
value owl_stub_16_c_eigen_spmat_s_innerindexptr(value x92)
{
   struct c_spmat_s* x93 = CTYPES_ADDR_OF_FATPTR(x92);
   int64_t* x94 = c_eigen_spmat_s_innerindexptr(x93);
   return CTYPES_FROM_PTR(x94);
}
value owl_stub_17_c_eigen_spmat_s_outerindexptr(value x95)
{
   struct c_spmat_s* x96 = CTYPES_ADDR_OF_FATPTR(x95);
   int64_t* x97 = c_eigen_spmat_s_outerindexptr(x96);
   return CTYPES_FROM_PTR(x97);
}
value owl_stub_18_c_eigen_spmat_s_clone(value x98)
{
   struct c_spmat_s* x99 = CTYPES_ADDR_OF_FATPTR(x98);
   struct c_spmat_s* x100 = c_eigen_spmat_s_clone(x99);
   return CTYPES_FROM_PTR(x100);
}
value owl_stub_19_c_eigen_spmat_s_row(value x102, value x101)
{
   struct c_spmat_s* x103 = CTYPES_ADDR_OF_FATPTR(x102);
   int64_t x104 = Int64_val(x101);
   struct c_spmat_s* x107 = c_eigen_spmat_s_row(x103, x104);
   return CTYPES_FROM_PTR(x107);
}
value owl_stub_20_c_eigen_spmat_s_col(value x109, value x108)
{
   struct c_spmat_s* x110 = CTYPES_ADDR_OF_FATPTR(x109);
   int64_t x111 = Int64_val(x108);
   struct c_spmat_s* x114 = c_eigen_spmat_s_col(x110, x111);
   return CTYPES_FROM_PTR(x114);
}
value owl_stub_21_c_eigen_spmat_s_transpose(value x115)
{
   struct c_spmat_s* x116 = CTYPES_ADDR_OF_FATPTR(x115);
   struct c_spmat_s* x117 = c_eigen_spmat_s_transpose(x116);
   return CTYPES_FROM_PTR(x117);
}
value owl_stub_22_c_eigen_spmat_s_adjoint(value x118)
{
   struct c_spmat_s* x119 = CTYPES_ADDR_OF_FATPTR(x118);
   struct c_spmat_s* x120 = c_eigen_spmat_s_adjoint(x119);
   return CTYPES_FROM_PTR(x120);
}
value owl_stub_23_c_eigen_spmat_s_diagonal(value x121)
{
   struct c_spmat_s* x122 = CTYPES_ADDR_OF_FATPTR(x121);
   struct c_spmat_s* x123 = c_eigen_spmat_s_diagonal(x122);
   return CTYPES_FROM_PTR(x123);
}
value owl_stub_24_c_eigen_spmat_s_trace(value x124)
{
   struct c_spmat_s* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   float x126 = c_eigen_spmat_s_trace(x125);
   return caml_copy_double(x126);
}
value owl_stub_25_c_eigen_spmat_s_is_zero(value x127)
{
   struct c_spmat_s* x128 = CTYPES_ADDR_OF_FATPTR(x127);
   int x129 = c_eigen_spmat_s_is_zero(x128);
   return Val_int(x129);
}
value owl_stub_26_c_eigen_spmat_s_is_positive(value x130)
{
   struct c_spmat_s* x131 = CTYPES_ADDR_OF_FATPTR(x130);
   int x132 = c_eigen_spmat_s_is_positive(x131);
   return Val_int(x132);
}
value owl_stub_27_c_eigen_spmat_s_is_negative(value x133)
{
   struct c_spmat_s* x134 = CTYPES_ADDR_OF_FATPTR(x133);
   int x135 = c_eigen_spmat_s_is_negative(x134);
   return Val_int(x135);
}
value owl_stub_28_c_eigen_spmat_s_is_nonpositive(value x136)
{
   struct c_spmat_s* x137 = CTYPES_ADDR_OF_FATPTR(x136);
   int x138 = c_eigen_spmat_s_is_nonpositive(x137);
   return Val_int(x138);
}
value owl_stub_29_c_eigen_spmat_s_is_nonnegative(value x139)
{
   struct c_spmat_s* x140 = CTYPES_ADDR_OF_FATPTR(x139);
   int x141 = c_eigen_spmat_s_is_nonnegative(x140);
   return Val_int(x141);
}
value owl_stub_30_c_eigen_spmat_s_is_equal(value x143, value x142)
{
   struct c_spmat_s* x144 = CTYPES_ADDR_OF_FATPTR(x143);
   struct c_spmat_s* x145 = CTYPES_ADDR_OF_FATPTR(x142);
   int x146 = c_eigen_spmat_s_is_equal(x144, x145);
   return Val_int(x146);
}
value owl_stub_31_c_eigen_spmat_s_is_unequal(value x148, value x147)
{
   struct c_spmat_s* x149 = CTYPES_ADDR_OF_FATPTR(x148);
   struct c_spmat_s* x150 = CTYPES_ADDR_OF_FATPTR(x147);
   int x151 = c_eigen_spmat_s_is_unequal(x149, x150);
   return Val_int(x151);
}
value owl_stub_32_c_eigen_spmat_s_is_greater(value x153, value x152)
{
   struct c_spmat_s* x154 = CTYPES_ADDR_OF_FATPTR(x153);
   struct c_spmat_s* x155 = CTYPES_ADDR_OF_FATPTR(x152);
   int x156 = c_eigen_spmat_s_is_greater(x154, x155);
   return Val_int(x156);
}
value owl_stub_33_c_eigen_spmat_s_is_smaller(value x158, value x157)
{
   struct c_spmat_s* x159 = CTYPES_ADDR_OF_FATPTR(x158);
   struct c_spmat_s* x160 = CTYPES_ADDR_OF_FATPTR(x157);
   int x161 = c_eigen_spmat_s_is_smaller(x159, x160);
   return Val_int(x161);
}
value owl_stub_34_c_eigen_spmat_s_equal_or_greater(value x163, value x162)
{
   struct c_spmat_s* x164 = CTYPES_ADDR_OF_FATPTR(x163);
   struct c_spmat_s* x165 = CTYPES_ADDR_OF_FATPTR(x162);
   int x166 = c_eigen_spmat_s_equal_or_greater(x164, x165);
   return Val_int(x166);
}
value owl_stub_35_c_eigen_spmat_s_equal_or_smaller(value x168, value x167)
{
   struct c_spmat_s* x169 = CTYPES_ADDR_OF_FATPTR(x168);
   struct c_spmat_s* x170 = CTYPES_ADDR_OF_FATPTR(x167);
   int x171 = c_eigen_spmat_s_equal_or_smaller(x169, x170);
   return Val_int(x171);
}
value owl_stub_36_c_eigen_spmat_s_add(value x173, value x172)
{
   struct c_spmat_s* x174 = CTYPES_ADDR_OF_FATPTR(x173);
   struct c_spmat_s* x175 = CTYPES_ADDR_OF_FATPTR(x172);
   struct c_spmat_s* x176 = c_eigen_spmat_s_add(x174, x175);
   return CTYPES_FROM_PTR(x176);
}
value owl_stub_37_c_eigen_spmat_s_sub(value x178, value x177)
{
   struct c_spmat_s* x179 = CTYPES_ADDR_OF_FATPTR(x178);
   struct c_spmat_s* x180 = CTYPES_ADDR_OF_FATPTR(x177);
   struct c_spmat_s* x181 = c_eigen_spmat_s_sub(x179, x180);
   return CTYPES_FROM_PTR(x181);
}
value owl_stub_38_c_eigen_spmat_s_mul(value x183, value x182)
{
   struct c_spmat_s* x184 = CTYPES_ADDR_OF_FATPTR(x183);
   struct c_spmat_s* x185 = CTYPES_ADDR_OF_FATPTR(x182);
   struct c_spmat_s* x186 = c_eigen_spmat_s_mul(x184, x185);
   return CTYPES_FROM_PTR(x186);
}
value owl_stub_39_c_eigen_spmat_s_div(value x188, value x187)
{
   struct c_spmat_s* x189 = CTYPES_ADDR_OF_FATPTR(x188);
   struct c_spmat_s* x190 = CTYPES_ADDR_OF_FATPTR(x187);
   struct c_spmat_s* x191 = c_eigen_spmat_s_div(x189, x190);
   return CTYPES_FROM_PTR(x191);
}
value owl_stub_40_c_eigen_spmat_s_dot(value x193, value x192)
{
   struct c_spmat_s* x194 = CTYPES_ADDR_OF_FATPTR(x193);
   struct c_spmat_s* x195 = CTYPES_ADDR_OF_FATPTR(x192);
   struct c_spmat_s* x196 = c_eigen_spmat_s_dot(x194, x195);
   return CTYPES_FROM_PTR(x196);
}
value owl_stub_41_c_eigen_spmat_s_add_scalar(value x198, value x197)
{
   struct c_spmat_s* x199 = CTYPES_ADDR_OF_FATPTR(x198);
   double x200 = Double_val(x197);
   struct c_spmat_s* x203 = c_eigen_spmat_s_add_scalar(x199, (float)x200);
   return CTYPES_FROM_PTR(x203);
}
value owl_stub_42_c_eigen_spmat_s_sub_scalar(value x205, value x204)
{
   struct c_spmat_s* x206 = CTYPES_ADDR_OF_FATPTR(x205);
   double x207 = Double_val(x204);
   struct c_spmat_s* x210 = c_eigen_spmat_s_sub_scalar(x206, (float)x207);
   return CTYPES_FROM_PTR(x210);
}
value owl_stub_43_c_eigen_spmat_s_mul_scalar(value x212, value x211)
{
   struct c_spmat_s* x213 = CTYPES_ADDR_OF_FATPTR(x212);
   double x214 = Double_val(x211);
   struct c_spmat_s* x217 = c_eigen_spmat_s_mul_scalar(x213, (float)x214);
   return CTYPES_FROM_PTR(x217);
}
value owl_stub_44_c_eigen_spmat_s_div_scalar(value x219, value x218)
{
   struct c_spmat_s* x220 = CTYPES_ADDR_OF_FATPTR(x219);
   double x221 = Double_val(x218);
   struct c_spmat_s* x224 = c_eigen_spmat_s_div_scalar(x220, (float)x221);
   return CTYPES_FROM_PTR(x224);
}
value owl_stub_45_c_eigen_spmat_s_min2(value x226, value x225)
{
   struct c_spmat_s* x227 = CTYPES_ADDR_OF_FATPTR(x226);
   struct c_spmat_s* x228 = CTYPES_ADDR_OF_FATPTR(x225);
   struct c_spmat_s* x229 = c_eigen_spmat_s_min2(x227, x228);
   return CTYPES_FROM_PTR(x229);
}
value owl_stub_46_c_eigen_spmat_s_max2(value x231, value x230)
{
   struct c_spmat_s* x232 = CTYPES_ADDR_OF_FATPTR(x231);
   struct c_spmat_s* x233 = CTYPES_ADDR_OF_FATPTR(x230);
   struct c_spmat_s* x234 = c_eigen_spmat_s_max2(x232, x233);
   return CTYPES_FROM_PTR(x234);
}
value owl_stub_47_c_eigen_spmat_s_sum(value x235)
{
   struct c_spmat_s* x236 = CTYPES_ADDR_OF_FATPTR(x235);
   float x237 = c_eigen_spmat_s_sum(x236);
   return caml_copy_double(x237);
}
value owl_stub_48_c_eigen_spmat_s_min(value x238)
{
   struct c_spmat_s* x239 = CTYPES_ADDR_OF_FATPTR(x238);
   float x240 = c_eigen_spmat_s_min(x239);
   return caml_copy_double(x240);
}
value owl_stub_49_c_eigen_spmat_s_max(value x241)
{
   struct c_spmat_s* x242 = CTYPES_ADDR_OF_FATPTR(x241);
   float x243 = c_eigen_spmat_s_max(x242);
   return caml_copy_double(x243);
}
value owl_stub_50_c_eigen_spmat_s_abs(value x244)
{
   struct c_spmat_s* x245 = CTYPES_ADDR_OF_FATPTR(x244);
   struct c_spmat_s* x246 = c_eigen_spmat_s_abs(x245);
   return CTYPES_FROM_PTR(x246);
}
value owl_stub_51_c_eigen_spmat_s_neg(value x247)
{
   struct c_spmat_s* x248 = CTYPES_ADDR_OF_FATPTR(x247);
   struct c_spmat_s* x249 = c_eigen_spmat_s_neg(x248);
   return CTYPES_FROM_PTR(x249);
}
value owl_stub_52_c_eigen_spmat_s_sqrt(value x250)
{
   struct c_spmat_s* x251 = CTYPES_ADDR_OF_FATPTR(x250);
   struct c_spmat_s* x252 = c_eigen_spmat_s_sqrt(x251);
   return CTYPES_FROM_PTR(x252);
}
value owl_stub_53_c_eigen_spmat_s_print(value x253)
{
   struct c_spmat_s* x254 = CTYPES_ADDR_OF_FATPTR(x253);
   c_eigen_spmat_s_print(x254);
   return Val_unit;
}
value owl_stub_54_c_eigen_spmat_d_new(value x257, value x256)
{
   int64_t x258 = Int64_val(x257);
   int64_t x261 = Int64_val(x256);
   struct c_spmat_d* x264 = c_eigen_spmat_d_new(x258, x261);
   return CTYPES_FROM_PTR(x264);
}
value owl_stub_55_c_eigen_spmat_d_delete(value x265)
{
   struct c_spmat_d* x266 = CTYPES_ADDR_OF_FATPTR(x265);
   c_eigen_spmat_d_delete(x266);
   return Val_unit;
}
value owl_stub_56_c_eigen_spmat_d_eye(value x268)
{
   int64_t x269 = Int64_val(x268);
   struct c_spmat_d* x272 = c_eigen_spmat_d_eye(x269);
   return CTYPES_FROM_PTR(x272);
}
value owl_stub_57_c_eigen_spmat_d_rows(value x273)
{
   struct c_spmat_d* x274 = CTYPES_ADDR_OF_FATPTR(x273);
   int64_t x275 = c_eigen_spmat_d_rows(x274);
   return caml_copy_int64(x275);
}
value owl_stub_58_c_eigen_spmat_d_cols(value x276)
{
   struct c_spmat_d* x277 = CTYPES_ADDR_OF_FATPTR(x276);
   int64_t x278 = c_eigen_spmat_d_cols(x277);
   return caml_copy_int64(x278);
}
value owl_stub_59_c_eigen_spmat_d_nnz(value x279)
{
   struct c_spmat_d* x280 = CTYPES_ADDR_OF_FATPTR(x279);
   int64_t x281 = c_eigen_spmat_d_nnz(x280);
   return caml_copy_int64(x281);
}
value owl_stub_60_c_eigen_spmat_d_get(value x284, value x283, value x282)
{
   struct c_spmat_d* x285 = CTYPES_ADDR_OF_FATPTR(x284);
   int64_t x286 = Int64_val(x283);
   int64_t x289 = Int64_val(x282);
   double x292 = c_eigen_spmat_d_get(x285, x286, x289);
   return caml_copy_double(x292);
}
value owl_stub_61_c_eigen_spmat_d_set(value x296, value x295, value x294,
                                      value x293)
{
   struct c_spmat_d* x297 = CTYPES_ADDR_OF_FATPTR(x296);
   int64_t x298 = Int64_val(x295);
   int64_t x301 = Int64_val(x294);
   double x304 = Double_val(x293);
   c_eigen_spmat_d_set(x297, x298, x301, x304);
   return Val_unit;
}
value owl_stub_62_c_eigen_spmat_d_reset(value x308)
{
   struct c_spmat_d* x309 = CTYPES_ADDR_OF_FATPTR(x308);
   c_eigen_spmat_d_reset(x309);
   return Val_unit;
}
value owl_stub_63_c_eigen_spmat_d_is_compressed(value x311)
{
   struct c_spmat_d* x312 = CTYPES_ADDR_OF_FATPTR(x311);
   int x313 = c_eigen_spmat_d_is_compressed(x312);
   return Val_int(x313);
}
value owl_stub_64_c_eigen_spmat_d_compress(value x314)
{
   struct c_spmat_d* x315 = CTYPES_ADDR_OF_FATPTR(x314);
   c_eigen_spmat_d_compress(x315);
   return Val_unit;
}
value owl_stub_65_c_eigen_spmat_d_uncompress(value x317)
{
   struct c_spmat_d* x318 = CTYPES_ADDR_OF_FATPTR(x317);
   c_eigen_spmat_d_uncompress(x318);
   return Val_unit;
}
value owl_stub_66_c_eigen_spmat_d_reshape(value x322, value x321, value x320)
{
   struct c_spmat_d* x323 = CTYPES_ADDR_OF_FATPTR(x322);
   int64_t x324 = Int64_val(x321);
   int64_t x327 = Int64_val(x320);
   c_eigen_spmat_d_reshape(x323, x324, x327);
   return Val_unit;
}
value owl_stub_67_c_eigen_spmat_d_prune(value x333, value x332, value x331)
{
   struct c_spmat_d* x334 = CTYPES_ADDR_OF_FATPTR(x333);
   double x335 = Double_val(x332);
   double x338 = Double_val(x331);
   c_eigen_spmat_d_prune(x334, x335, x338);
   return Val_unit;
}
value owl_stub_68_c_eigen_spmat_d_valueptr(value x343, value x342)
{
   struct c_spmat_d* x344 = CTYPES_ADDR_OF_FATPTR(x343);
   int64_t* x345 = CTYPES_ADDR_OF_FATPTR(x342);
   double* x346 = c_eigen_spmat_d_valueptr(x344, x345);
   return CTYPES_FROM_PTR(x346);
}
value owl_stub_69_c_eigen_spmat_d_innerindexptr(value x347)
{
   struct c_spmat_d* x348 = CTYPES_ADDR_OF_FATPTR(x347);
   int64_t* x349 = c_eigen_spmat_d_innerindexptr(x348);
   return CTYPES_FROM_PTR(x349);
}
value owl_stub_70_c_eigen_spmat_d_outerindexptr(value x350)
{
   struct c_spmat_d* x351 = CTYPES_ADDR_OF_FATPTR(x350);
   int64_t* x352 = c_eigen_spmat_d_outerindexptr(x351);
   return CTYPES_FROM_PTR(x352);
}
value owl_stub_71_c_eigen_spmat_d_clone(value x353)
{
   struct c_spmat_d* x354 = CTYPES_ADDR_OF_FATPTR(x353);
   struct c_spmat_d* x355 = c_eigen_spmat_d_clone(x354);
   return CTYPES_FROM_PTR(x355);
}
value owl_stub_72_c_eigen_spmat_d_row(value x357, value x356)
{
   struct c_spmat_d* x358 = CTYPES_ADDR_OF_FATPTR(x357);
   int64_t x359 = Int64_val(x356);
   struct c_spmat_d* x362 = c_eigen_spmat_d_row(x358, x359);
   return CTYPES_FROM_PTR(x362);
}
value owl_stub_73_c_eigen_spmat_d_col(value x364, value x363)
{
   struct c_spmat_d* x365 = CTYPES_ADDR_OF_FATPTR(x364);
   int64_t x366 = Int64_val(x363);
   struct c_spmat_d* x369 = c_eigen_spmat_d_col(x365, x366);
   return CTYPES_FROM_PTR(x369);
}
value owl_stub_74_c_eigen_spmat_d_transpose(value x370)
{
   struct c_spmat_d* x371 = CTYPES_ADDR_OF_FATPTR(x370);
   struct c_spmat_d* x372 = c_eigen_spmat_d_transpose(x371);
   return CTYPES_FROM_PTR(x372);
}
value owl_stub_75_c_eigen_spmat_d_adjoint(value x373)
{
   struct c_spmat_d* x374 = CTYPES_ADDR_OF_FATPTR(x373);
   struct c_spmat_d* x375 = c_eigen_spmat_d_adjoint(x374);
   return CTYPES_FROM_PTR(x375);
}
value owl_stub_76_c_eigen_spmat_d_diagonal(value x376)
{
   struct c_spmat_d* x377 = CTYPES_ADDR_OF_FATPTR(x376);
   struct c_spmat_d* x378 = c_eigen_spmat_d_diagonal(x377);
   return CTYPES_FROM_PTR(x378);
}
value owl_stub_77_c_eigen_spmat_d_trace(value x379)
{
   struct c_spmat_d* x380 = CTYPES_ADDR_OF_FATPTR(x379);
   double x381 = c_eigen_spmat_d_trace(x380);
   return caml_copy_double(x381);
}
value owl_stub_78_c_eigen_spmat_d_is_zero(value x382)
{
   struct c_spmat_d* x383 = CTYPES_ADDR_OF_FATPTR(x382);
   int x384 = c_eigen_spmat_d_is_zero(x383);
   return Val_int(x384);
}
value owl_stub_79_c_eigen_spmat_d_is_positive(value x385)
{
   struct c_spmat_d* x386 = CTYPES_ADDR_OF_FATPTR(x385);
   int x387 = c_eigen_spmat_d_is_positive(x386);
   return Val_int(x387);
}
value owl_stub_80_c_eigen_spmat_d_is_negative(value x388)
{
   struct c_spmat_d* x389 = CTYPES_ADDR_OF_FATPTR(x388);
   int x390 = c_eigen_spmat_d_is_negative(x389);
   return Val_int(x390);
}
value owl_stub_81_c_eigen_spmat_d_is_nonpositive(value x391)
{
   struct c_spmat_d* x392 = CTYPES_ADDR_OF_FATPTR(x391);
   int x393 = c_eigen_spmat_d_is_nonpositive(x392);
   return Val_int(x393);
}
value owl_stub_82_c_eigen_spmat_d_is_nonnegative(value x394)
{
   struct c_spmat_d* x395 = CTYPES_ADDR_OF_FATPTR(x394);
   int x396 = c_eigen_spmat_d_is_nonnegative(x395);
   return Val_int(x396);
}
value owl_stub_83_c_eigen_spmat_d_is_equal(value x398, value x397)
{
   struct c_spmat_d* x399 = CTYPES_ADDR_OF_FATPTR(x398);
   struct c_spmat_d* x400 = CTYPES_ADDR_OF_FATPTR(x397);
   int x401 = c_eigen_spmat_d_is_equal(x399, x400);
   return Val_int(x401);
}
value owl_stub_84_c_eigen_spmat_d_is_unequal(value x403, value x402)
{
   struct c_spmat_d* x404 = CTYPES_ADDR_OF_FATPTR(x403);
   struct c_spmat_d* x405 = CTYPES_ADDR_OF_FATPTR(x402);
   int x406 = c_eigen_spmat_d_is_unequal(x404, x405);
   return Val_int(x406);
}
value owl_stub_85_c_eigen_spmat_d_is_greater(value x408, value x407)
{
   struct c_spmat_d* x409 = CTYPES_ADDR_OF_FATPTR(x408);
   struct c_spmat_d* x410 = CTYPES_ADDR_OF_FATPTR(x407);
   int x411 = c_eigen_spmat_d_is_greater(x409, x410);
   return Val_int(x411);
}
value owl_stub_86_c_eigen_spmat_d_is_smaller(value x413, value x412)
{
   struct c_spmat_d* x414 = CTYPES_ADDR_OF_FATPTR(x413);
   struct c_spmat_d* x415 = CTYPES_ADDR_OF_FATPTR(x412);
   int x416 = c_eigen_spmat_d_is_smaller(x414, x415);
   return Val_int(x416);
}
value owl_stub_87_c_eigen_spmat_d_equal_or_greater(value x418, value x417)
{
   struct c_spmat_d* x419 = CTYPES_ADDR_OF_FATPTR(x418);
   struct c_spmat_d* x420 = CTYPES_ADDR_OF_FATPTR(x417);
   int x421 = c_eigen_spmat_d_equal_or_greater(x419, x420);
   return Val_int(x421);
}
value owl_stub_88_c_eigen_spmat_d_equal_or_smaller(value x423, value x422)
{
   struct c_spmat_d* x424 = CTYPES_ADDR_OF_FATPTR(x423);
   struct c_spmat_d* x425 = CTYPES_ADDR_OF_FATPTR(x422);
   int x426 = c_eigen_spmat_d_equal_or_smaller(x424, x425);
   return Val_int(x426);
}
value owl_stub_89_c_eigen_spmat_d_add(value x428, value x427)
{
   struct c_spmat_d* x429 = CTYPES_ADDR_OF_FATPTR(x428);
   struct c_spmat_d* x430 = CTYPES_ADDR_OF_FATPTR(x427);
   struct c_spmat_d* x431 = c_eigen_spmat_d_add(x429, x430);
   return CTYPES_FROM_PTR(x431);
}
value owl_stub_90_c_eigen_spmat_d_sub(value x433, value x432)
{
   struct c_spmat_d* x434 = CTYPES_ADDR_OF_FATPTR(x433);
   struct c_spmat_d* x435 = CTYPES_ADDR_OF_FATPTR(x432);
   struct c_spmat_d* x436 = c_eigen_spmat_d_sub(x434, x435);
   return CTYPES_FROM_PTR(x436);
}
value owl_stub_91_c_eigen_spmat_d_mul(value x438, value x437)
{
   struct c_spmat_d* x439 = CTYPES_ADDR_OF_FATPTR(x438);
   struct c_spmat_d* x440 = CTYPES_ADDR_OF_FATPTR(x437);
   struct c_spmat_d* x441 = c_eigen_spmat_d_mul(x439, x440);
   return CTYPES_FROM_PTR(x441);
}
value owl_stub_92_c_eigen_spmat_d_div(value x443, value x442)
{
   struct c_spmat_d* x444 = CTYPES_ADDR_OF_FATPTR(x443);
   struct c_spmat_d* x445 = CTYPES_ADDR_OF_FATPTR(x442);
   struct c_spmat_d* x446 = c_eigen_spmat_d_div(x444, x445);
   return CTYPES_FROM_PTR(x446);
}
value owl_stub_93_c_eigen_spmat_d_dot(value x448, value x447)
{
   struct c_spmat_d* x449 = CTYPES_ADDR_OF_FATPTR(x448);
   struct c_spmat_d* x450 = CTYPES_ADDR_OF_FATPTR(x447);
   struct c_spmat_d* x451 = c_eigen_spmat_d_dot(x449, x450);
   return CTYPES_FROM_PTR(x451);
}
value owl_stub_94_c_eigen_spmat_d_add_scalar(value x453, value x452)
{
   struct c_spmat_d* x454 = CTYPES_ADDR_OF_FATPTR(x453);
   double x455 = Double_val(x452);
   struct c_spmat_d* x458 = c_eigen_spmat_d_add_scalar(x454, x455);
   return CTYPES_FROM_PTR(x458);
}
value owl_stub_95_c_eigen_spmat_d_sub_scalar(value x460, value x459)
{
   struct c_spmat_d* x461 = CTYPES_ADDR_OF_FATPTR(x460);
   double x462 = Double_val(x459);
   struct c_spmat_d* x465 = c_eigen_spmat_d_sub_scalar(x461, x462);
   return CTYPES_FROM_PTR(x465);
}
value owl_stub_96_c_eigen_spmat_d_mul_scalar(value x467, value x466)
{
   struct c_spmat_d* x468 = CTYPES_ADDR_OF_FATPTR(x467);
   double x469 = Double_val(x466);
   struct c_spmat_d* x472 = c_eigen_spmat_d_mul_scalar(x468, x469);
   return CTYPES_FROM_PTR(x472);
}
value owl_stub_97_c_eigen_spmat_d_div_scalar(value x474, value x473)
{
   struct c_spmat_d* x475 = CTYPES_ADDR_OF_FATPTR(x474);
   double x476 = Double_val(x473);
   struct c_spmat_d* x479 = c_eigen_spmat_d_div_scalar(x475, x476);
   return CTYPES_FROM_PTR(x479);
}
value owl_stub_98_c_eigen_spmat_d_min2(value x481, value x480)
{
   struct c_spmat_d* x482 = CTYPES_ADDR_OF_FATPTR(x481);
   struct c_spmat_d* x483 = CTYPES_ADDR_OF_FATPTR(x480);
   struct c_spmat_d* x484 = c_eigen_spmat_d_min2(x482, x483);
   return CTYPES_FROM_PTR(x484);
}
value owl_stub_99_c_eigen_spmat_d_max2(value x486, value x485)
{
   struct c_spmat_d* x487 = CTYPES_ADDR_OF_FATPTR(x486);
   struct c_spmat_d* x488 = CTYPES_ADDR_OF_FATPTR(x485);
   struct c_spmat_d* x489 = c_eigen_spmat_d_max2(x487, x488);
   return CTYPES_FROM_PTR(x489);
}
value owl_stub_100_c_eigen_spmat_d_sum(value x490)
{
   struct c_spmat_d* x491 = CTYPES_ADDR_OF_FATPTR(x490);
   double x492 = c_eigen_spmat_d_sum(x491);
   return caml_copy_double(x492);
}
value owl_stub_101_c_eigen_spmat_d_min(value x493)
{
   struct c_spmat_d* x494 = CTYPES_ADDR_OF_FATPTR(x493);
   double x495 = c_eigen_spmat_d_min(x494);
   return caml_copy_double(x495);
}
value owl_stub_102_c_eigen_spmat_d_max(value x496)
{
   struct c_spmat_d* x497 = CTYPES_ADDR_OF_FATPTR(x496);
   double x498 = c_eigen_spmat_d_max(x497);
   return caml_copy_double(x498);
}
value owl_stub_103_c_eigen_spmat_d_abs(value x499)
{
   struct c_spmat_d* x500 = CTYPES_ADDR_OF_FATPTR(x499);
   struct c_spmat_d* x501 = c_eigen_spmat_d_abs(x500);
   return CTYPES_FROM_PTR(x501);
}
value owl_stub_104_c_eigen_spmat_d_neg(value x502)
{
   struct c_spmat_d* x503 = CTYPES_ADDR_OF_FATPTR(x502);
   struct c_spmat_d* x504 = c_eigen_spmat_d_neg(x503);
   return CTYPES_FROM_PTR(x504);
}
value owl_stub_105_c_eigen_spmat_d_sqrt(value x505)
{
   struct c_spmat_d* x506 = CTYPES_ADDR_OF_FATPTR(x505);
   struct c_spmat_d* x507 = c_eigen_spmat_d_sqrt(x506);
   return CTYPES_FROM_PTR(x507);
}
value owl_stub_106_c_eigen_spmat_d_print(value x508)
{
   struct c_spmat_d* x509 = CTYPES_ADDR_OF_FATPTR(x508);
   c_eigen_spmat_d_print(x509);
   return Val_unit;
}
value owl_stub_107_c_eigen_spmat_c_new(value x512, value x511)
{
   int64_t x513 = Int64_val(x512);
   int64_t x516 = Int64_val(x511);
   struct c_spmat_c* x519 = c_eigen_spmat_c_new(x513, x516);
   return CTYPES_FROM_PTR(x519);
}
value owl_stub_108_c_eigen_spmat_c_delete(value x520)
{
   struct c_spmat_c* x521 = CTYPES_ADDR_OF_FATPTR(x520);
   c_eigen_spmat_c_delete(x521);
   return Val_unit;
}
value owl_stub_109_c_eigen_spmat_c_eye(value x523)
{
   int64_t x524 = Int64_val(x523);
   struct c_spmat_c* x527 = c_eigen_spmat_c_eye(x524);
   return CTYPES_FROM_PTR(x527);
}
value owl_stub_110_c_eigen_spmat_c_rows(value x528)
{
   struct c_spmat_c* x529 = CTYPES_ADDR_OF_FATPTR(x528);
   int64_t x530 = c_eigen_spmat_c_rows(x529);
   return caml_copy_int64(x530);
}
value owl_stub_111_c_eigen_spmat_c_cols(value x531)
{
   struct c_spmat_c* x532 = CTYPES_ADDR_OF_FATPTR(x531);
   int64_t x533 = c_eigen_spmat_c_cols(x532);
   return caml_copy_int64(x533);
}
value owl_stub_112_c_eigen_spmat_c_nnz(value x534)
{
   struct c_spmat_c* x535 = CTYPES_ADDR_OF_FATPTR(x534);
   int64_t x536 = c_eigen_spmat_c_nnz(x535);
   return caml_copy_int64(x536);
}
value owl_stub_113_c_eigen_spmat_c_get(value x539, value x538, value x537)
{
   struct c_spmat_c* x540 = CTYPES_ADDR_OF_FATPTR(x539);
   int64_t x541 = Int64_val(x538);
   int64_t x544 = Int64_val(x537);
   float _Complex x547 = c_eigen_spmat_c_get(x540, x541, x544);
   return ctypes_copy_float_complex(x547);
}
value owl_stub_114_c_eigen_spmat_c_set(value x551, value x550, value x549,
                                       value x548)
{
   struct c_spmat_c* x552 = CTYPES_ADDR_OF_FATPTR(x551);
   int64_t x553 = Int64_val(x550);
   int64_t x556 = Int64_val(x549);
   float _Complex x559 = ctypes_float_complex_val(x548);
   c_eigen_spmat_c_set(x552, x553, x556, x559);
   return Val_unit;
}
value owl_stub_115_c_eigen_spmat_c_reset(value x563)
{
   struct c_spmat_c* x564 = CTYPES_ADDR_OF_FATPTR(x563);
   c_eigen_spmat_c_reset(x564);
   return Val_unit;
}
value owl_stub_116_c_eigen_spmat_c_is_compressed(value x566)
{
   struct c_spmat_c* x567 = CTYPES_ADDR_OF_FATPTR(x566);
   int x568 = c_eigen_spmat_c_is_compressed(x567);
   return Val_int(x568);
}
value owl_stub_117_c_eigen_spmat_c_compress(value x569)
{
   struct c_spmat_c* x570 = CTYPES_ADDR_OF_FATPTR(x569);
   c_eigen_spmat_c_compress(x570);
   return Val_unit;
}
value owl_stub_118_c_eigen_spmat_c_uncompress(value x572)
{
   struct c_spmat_c* x573 = CTYPES_ADDR_OF_FATPTR(x572);
   c_eigen_spmat_c_uncompress(x573);
   return Val_unit;
}
value owl_stub_119_c_eigen_spmat_c_reshape(value x577, value x576,
                                           value x575)
{
   struct c_spmat_c* x578 = CTYPES_ADDR_OF_FATPTR(x577);
   int64_t x579 = Int64_val(x576);
   int64_t x582 = Int64_val(x575);
   c_eigen_spmat_c_reshape(x578, x579, x582);
   return Val_unit;
}
value owl_stub_120_c_eigen_spmat_c_prune(value x588, value x587, value x586)
{
   struct c_spmat_c* x589 = CTYPES_ADDR_OF_FATPTR(x588);
   float _Complex x590 = ctypes_float_complex_val(x587);
   double x593 = Double_val(x586);
   c_eigen_spmat_c_prune(x589, x590, (float)x593);
   return Val_unit;
}
value owl_stub_121_c_eigen_spmat_c_valueptr(value x598, value x597)
{
   struct c_spmat_c* x599 = CTYPES_ADDR_OF_FATPTR(x598);
   int64_t* x600 = CTYPES_ADDR_OF_FATPTR(x597);
   float _Complex* x601 = c_eigen_spmat_c_valueptr(x599, x600);
   return CTYPES_FROM_PTR(x601);
}
value owl_stub_122_c_eigen_spmat_c_innerindexptr(value x602)
{
   struct c_spmat_c* x603 = CTYPES_ADDR_OF_FATPTR(x602);
   int64_t* x604 = c_eigen_spmat_c_innerindexptr(x603);
   return CTYPES_FROM_PTR(x604);
}
value owl_stub_123_c_eigen_spmat_c_outerindexptr(value x605)
{
   struct c_spmat_c* x606 = CTYPES_ADDR_OF_FATPTR(x605);
   int64_t* x607 = c_eigen_spmat_c_outerindexptr(x606);
   return CTYPES_FROM_PTR(x607);
}
value owl_stub_124_c_eigen_spmat_c_clone(value x608)
{
   struct c_spmat_c* x609 = CTYPES_ADDR_OF_FATPTR(x608);
   struct c_spmat_c* x610 = c_eigen_spmat_c_clone(x609);
   return CTYPES_FROM_PTR(x610);
}
value owl_stub_125_c_eigen_spmat_c_row(value x612, value x611)
{
   struct c_spmat_c* x613 = CTYPES_ADDR_OF_FATPTR(x612);
   int64_t x614 = Int64_val(x611);
   struct c_spmat_c* x617 = c_eigen_spmat_c_row(x613, x614);
   return CTYPES_FROM_PTR(x617);
}
value owl_stub_126_c_eigen_spmat_c_col(value x619, value x618)
{
   struct c_spmat_c* x620 = CTYPES_ADDR_OF_FATPTR(x619);
   int64_t x621 = Int64_val(x618);
   struct c_spmat_c* x624 = c_eigen_spmat_c_col(x620, x621);
   return CTYPES_FROM_PTR(x624);
}
value owl_stub_127_c_eigen_spmat_c_transpose(value x625)
{
   struct c_spmat_c* x626 = CTYPES_ADDR_OF_FATPTR(x625);
   struct c_spmat_c* x627 = c_eigen_spmat_c_transpose(x626);
   return CTYPES_FROM_PTR(x627);
}
value owl_stub_128_c_eigen_spmat_c_adjoint(value x628)
{
   struct c_spmat_c* x629 = CTYPES_ADDR_OF_FATPTR(x628);
   struct c_spmat_c* x630 = c_eigen_spmat_c_adjoint(x629);
   return CTYPES_FROM_PTR(x630);
}
value owl_stub_129_c_eigen_spmat_c_diagonal(value x631)
{
   struct c_spmat_c* x632 = CTYPES_ADDR_OF_FATPTR(x631);
   struct c_spmat_c* x633 = c_eigen_spmat_c_diagonal(x632);
   return CTYPES_FROM_PTR(x633);
}
value owl_stub_130_c_eigen_spmat_c_trace(value x634)
{
   struct c_spmat_c* x635 = CTYPES_ADDR_OF_FATPTR(x634);
   float _Complex x636 = c_eigen_spmat_c_trace(x635);
   return ctypes_copy_float_complex(x636);
}
value owl_stub_131_c_eigen_spmat_c_is_zero(value x637)
{
   struct c_spmat_c* x638 = CTYPES_ADDR_OF_FATPTR(x637);
   int x639 = c_eigen_spmat_c_is_zero(x638);
   return Val_int(x639);
}
value owl_stub_132_c_eigen_spmat_c_is_positive(value x640)
{
   struct c_spmat_c* x641 = CTYPES_ADDR_OF_FATPTR(x640);
   int x642 = c_eigen_spmat_c_is_positive(x641);
   return Val_int(x642);
}
value owl_stub_133_c_eigen_spmat_c_is_negative(value x643)
{
   struct c_spmat_c* x644 = CTYPES_ADDR_OF_FATPTR(x643);
   int x645 = c_eigen_spmat_c_is_negative(x644);
   return Val_int(x645);
}
value owl_stub_134_c_eigen_spmat_c_is_nonpositive(value x646)
{
   struct c_spmat_c* x647 = CTYPES_ADDR_OF_FATPTR(x646);
   int x648 = c_eigen_spmat_c_is_nonpositive(x647);
   return Val_int(x648);
}
value owl_stub_135_c_eigen_spmat_c_is_nonnegative(value x649)
{
   struct c_spmat_c* x650 = CTYPES_ADDR_OF_FATPTR(x649);
   int x651 = c_eigen_spmat_c_is_nonnegative(x650);
   return Val_int(x651);
}
value owl_stub_136_c_eigen_spmat_c_is_equal(value x653, value x652)
{
   struct c_spmat_c* x654 = CTYPES_ADDR_OF_FATPTR(x653);
   struct c_spmat_c* x655 = CTYPES_ADDR_OF_FATPTR(x652);
   int x656 = c_eigen_spmat_c_is_equal(x654, x655);
   return Val_int(x656);
}
value owl_stub_137_c_eigen_spmat_c_is_unequal(value x658, value x657)
{
   struct c_spmat_c* x659 = CTYPES_ADDR_OF_FATPTR(x658);
   struct c_spmat_c* x660 = CTYPES_ADDR_OF_FATPTR(x657);
   int x661 = c_eigen_spmat_c_is_unequal(x659, x660);
   return Val_int(x661);
}
value owl_stub_138_c_eigen_spmat_c_is_greater(value x663, value x662)
{
   struct c_spmat_c* x664 = CTYPES_ADDR_OF_FATPTR(x663);
   struct c_spmat_c* x665 = CTYPES_ADDR_OF_FATPTR(x662);
   int x666 = c_eigen_spmat_c_is_greater(x664, x665);
   return Val_int(x666);
}
value owl_stub_139_c_eigen_spmat_c_is_smaller(value x668, value x667)
{
   struct c_spmat_c* x669 = CTYPES_ADDR_OF_FATPTR(x668);
   struct c_spmat_c* x670 = CTYPES_ADDR_OF_FATPTR(x667);
   int x671 = c_eigen_spmat_c_is_smaller(x669, x670);
   return Val_int(x671);
}
value owl_stub_140_c_eigen_spmat_c_equal_or_greater(value x673, value x672)
{
   struct c_spmat_c* x674 = CTYPES_ADDR_OF_FATPTR(x673);
   struct c_spmat_c* x675 = CTYPES_ADDR_OF_FATPTR(x672);
   int x676 = c_eigen_spmat_c_equal_or_greater(x674, x675);
   return Val_int(x676);
}
value owl_stub_141_c_eigen_spmat_c_equal_or_smaller(value x678, value x677)
{
   struct c_spmat_c* x679 = CTYPES_ADDR_OF_FATPTR(x678);
   struct c_spmat_c* x680 = CTYPES_ADDR_OF_FATPTR(x677);
   int x681 = c_eigen_spmat_c_equal_or_smaller(x679, x680);
   return Val_int(x681);
}
value owl_stub_142_c_eigen_spmat_c_add(value x683, value x682)
{
   struct c_spmat_c* x684 = CTYPES_ADDR_OF_FATPTR(x683);
   struct c_spmat_c* x685 = CTYPES_ADDR_OF_FATPTR(x682);
   struct c_spmat_c* x686 = c_eigen_spmat_c_add(x684, x685);
   return CTYPES_FROM_PTR(x686);
}
value owl_stub_143_c_eigen_spmat_c_sub(value x688, value x687)
{
   struct c_spmat_c* x689 = CTYPES_ADDR_OF_FATPTR(x688);
   struct c_spmat_c* x690 = CTYPES_ADDR_OF_FATPTR(x687);
   struct c_spmat_c* x691 = c_eigen_spmat_c_sub(x689, x690);
   return CTYPES_FROM_PTR(x691);
}
value owl_stub_144_c_eigen_spmat_c_mul(value x693, value x692)
{
   struct c_spmat_c* x694 = CTYPES_ADDR_OF_FATPTR(x693);
   struct c_spmat_c* x695 = CTYPES_ADDR_OF_FATPTR(x692);
   struct c_spmat_c* x696 = c_eigen_spmat_c_mul(x694, x695);
   return CTYPES_FROM_PTR(x696);
}
value owl_stub_145_c_eigen_spmat_c_div(value x698, value x697)
{
   struct c_spmat_c* x699 = CTYPES_ADDR_OF_FATPTR(x698);
   struct c_spmat_c* x700 = CTYPES_ADDR_OF_FATPTR(x697);
   struct c_spmat_c* x701 = c_eigen_spmat_c_div(x699, x700);
   return CTYPES_FROM_PTR(x701);
}
value owl_stub_146_c_eigen_spmat_c_dot(value x703, value x702)
{
   struct c_spmat_c* x704 = CTYPES_ADDR_OF_FATPTR(x703);
   struct c_spmat_c* x705 = CTYPES_ADDR_OF_FATPTR(x702);
   struct c_spmat_c* x706 = c_eigen_spmat_c_dot(x704, x705);
   return CTYPES_FROM_PTR(x706);
}
value owl_stub_147_c_eigen_spmat_c_add_scalar(value x708, value x707)
{
   struct c_spmat_c* x709 = CTYPES_ADDR_OF_FATPTR(x708);
   float _Complex x710 = ctypes_float_complex_val(x707);
   struct c_spmat_c* x713 = c_eigen_spmat_c_add_scalar(x709, x710);
   return CTYPES_FROM_PTR(x713);
}
value owl_stub_148_c_eigen_spmat_c_sub_scalar(value x715, value x714)
{
   struct c_spmat_c* x716 = CTYPES_ADDR_OF_FATPTR(x715);
   float _Complex x717 = ctypes_float_complex_val(x714);
   struct c_spmat_c* x720 = c_eigen_spmat_c_sub_scalar(x716, x717);
   return CTYPES_FROM_PTR(x720);
}
value owl_stub_149_c_eigen_spmat_c_mul_scalar(value x722, value x721)
{
   struct c_spmat_c* x723 = CTYPES_ADDR_OF_FATPTR(x722);
   float _Complex x724 = ctypes_float_complex_val(x721);
   struct c_spmat_c* x727 = c_eigen_spmat_c_mul_scalar(x723, x724);
   return CTYPES_FROM_PTR(x727);
}
value owl_stub_150_c_eigen_spmat_c_div_scalar(value x729, value x728)
{
   struct c_spmat_c* x730 = CTYPES_ADDR_OF_FATPTR(x729);
   float _Complex x731 = ctypes_float_complex_val(x728);
   struct c_spmat_c* x734 = c_eigen_spmat_c_div_scalar(x730, x731);
   return CTYPES_FROM_PTR(x734);
}
value owl_stub_151_c_eigen_spmat_c_sum(value x735)
{
   struct c_spmat_c* x736 = CTYPES_ADDR_OF_FATPTR(x735);
   float _Complex x737 = c_eigen_spmat_c_sum(x736);
   return ctypes_copy_float_complex(x737);
}
value owl_stub_152_c_eigen_spmat_c_neg(value x738)
{
   struct c_spmat_c* x739 = CTYPES_ADDR_OF_FATPTR(x738);
   struct c_spmat_c* x740 = c_eigen_spmat_c_neg(x739);
   return CTYPES_FROM_PTR(x740);
}
value owl_stub_153_c_eigen_spmat_c_sqrt(value x741)
{
   struct c_spmat_c* x742 = CTYPES_ADDR_OF_FATPTR(x741);
   struct c_spmat_c* x743 = c_eigen_spmat_c_sqrt(x742);
   return CTYPES_FROM_PTR(x743);
}
value owl_stub_154_c_eigen_spmat_c_print(value x744)
{
   struct c_spmat_c* x745 = CTYPES_ADDR_OF_FATPTR(x744);
   c_eigen_spmat_c_print(x745);
   return Val_unit;
}
