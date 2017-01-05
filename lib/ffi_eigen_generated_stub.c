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
value owl_stub_14_c_eigen_spmat_d_clone(value x76)
{
   struct c_spmat_d* x77 = CTYPES_ADDR_OF_FATPTR(x76);
   struct c_spmat_d* x78 = c_eigen_spmat_d_clone(x77);
   return CTYPES_FROM_PTR(x78);
}
value owl_stub_15_c_eigen_spmat_d_row(value x80, value x79)
{
   struct c_spmat_d* x81 = CTYPES_ADDR_OF_FATPTR(x80);
   int x82 = Int_val(x79);
   struct c_spmat_d* x85 = c_eigen_spmat_d_row(x81, x82);
   return CTYPES_FROM_PTR(x85);
}
value owl_stub_16_c_eigen_spmat_d_col(value x87, value x86)
{
   struct c_spmat_d* x88 = CTYPES_ADDR_OF_FATPTR(x87);
   int x89 = Int_val(x86);
   struct c_spmat_d* x92 = c_eigen_spmat_d_col(x88, x89);
   return CTYPES_FROM_PTR(x92);
}
value owl_stub_17_c_eigen_spmat_d_transpose(value x93)
{
   struct c_spmat_d* x94 = CTYPES_ADDR_OF_FATPTR(x93);
   struct c_spmat_d* x95 = c_eigen_spmat_d_transpose(x94);
   return CTYPES_FROM_PTR(x95);
}
value owl_stub_18_c_eigen_spmat_d_adjoint(value x96)
{
   struct c_spmat_d* x97 = CTYPES_ADDR_OF_FATPTR(x96);
   struct c_spmat_d* x98 = c_eigen_spmat_d_adjoint(x97);
   return CTYPES_FROM_PTR(x98);
}
value owl_stub_19_c_eigen_spmat_d_add(value x100, value x99)
{
   struct c_spmat_d* x101 = CTYPES_ADDR_OF_FATPTR(x100);
   struct c_spmat_d* x102 = CTYPES_ADDR_OF_FATPTR(x99);
   struct c_spmat_d* x103 = c_eigen_spmat_d_add(x101, x102);
   return CTYPES_FROM_PTR(x103);
}
value owl_stub_20_c_eigen_spmat_d_sub(value x105, value x104)
{
   struct c_spmat_d* x106 = CTYPES_ADDR_OF_FATPTR(x105);
   struct c_spmat_d* x107 = CTYPES_ADDR_OF_FATPTR(x104);
   struct c_spmat_d* x108 = c_eigen_spmat_d_sub(x106, x107);
   return CTYPES_FROM_PTR(x108);
}
value owl_stub_21_c_eigen_spmat_d_mul(value x110, value x109)
{
   struct c_spmat_d* x111 = CTYPES_ADDR_OF_FATPTR(x110);
   struct c_spmat_d* x112 = CTYPES_ADDR_OF_FATPTR(x109);
   struct c_spmat_d* x113 = c_eigen_spmat_d_mul(x111, x112);
   return CTYPES_FROM_PTR(x113);
}
value owl_stub_22_c_eigen_spmat_d_div(value x115, value x114)
{
   struct c_spmat_d* x116 = CTYPES_ADDR_OF_FATPTR(x115);
   struct c_spmat_d* x117 = CTYPES_ADDR_OF_FATPTR(x114);
   struct c_spmat_d* x118 = c_eigen_spmat_d_div(x116, x117);
   return CTYPES_FROM_PTR(x118);
}
value owl_stub_23_c_eigen_spmat_d_dot(value x120, value x119)
{
   struct c_spmat_d* x121 = CTYPES_ADDR_OF_FATPTR(x120);
   struct c_spmat_d* x122 = CTYPES_ADDR_OF_FATPTR(x119);
   struct c_spmat_d* x123 = c_eigen_spmat_d_dot(x121, x122);
   return CTYPES_FROM_PTR(x123);
}
value owl_stub_24_c_eigen_spmat_d_mul_scalar(value x125, value x124)
{
   struct c_spmat_d* x126 = CTYPES_ADDR_OF_FATPTR(x125);
   double x127 = Double_val(x124);
   struct c_spmat_d* x130 = c_eigen_spmat_d_mul_scalar(x126, x127);
   return CTYPES_FROM_PTR(x130);
}
value owl_stub_25_c_eigen_spmat_d_div_scalar(value x132, value x131)
{
   struct c_spmat_d* x133 = CTYPES_ADDR_OF_FATPTR(x132);
   double x134 = Double_val(x131);
   struct c_spmat_d* x137 = c_eigen_spmat_d_div_scalar(x133, x134);
   return CTYPES_FROM_PTR(x137);
}
value owl_stub_26_c_eigen_spmat_d_min2(value x139, value x138)
{
   struct c_spmat_d* x140 = CTYPES_ADDR_OF_FATPTR(x139);
   struct c_spmat_d* x141 = CTYPES_ADDR_OF_FATPTR(x138);
   struct c_spmat_d* x142 = c_eigen_spmat_d_min2(x140, x141);
   return CTYPES_FROM_PTR(x142);
}
value owl_stub_27_c_eigen_spmat_d_max2(value x144, value x143)
{
   struct c_spmat_d* x145 = CTYPES_ADDR_OF_FATPTR(x144);
   struct c_spmat_d* x146 = CTYPES_ADDR_OF_FATPTR(x143);
   struct c_spmat_d* x147 = c_eigen_spmat_d_max2(x145, x146);
   return CTYPES_FROM_PTR(x147);
}
value owl_stub_28_c_eigen_spmat_d_abs(value x148)
{
   struct c_spmat_d* x149 = CTYPES_ADDR_OF_FATPTR(x148);
   struct c_spmat_d* x150 = c_eigen_spmat_d_abs(x149);
   return CTYPES_FROM_PTR(x150);
}
value owl_stub_29_c_eigen_spmat_d_sqrt(value x151)
{
   struct c_spmat_d* x152 = CTYPES_ADDR_OF_FATPTR(x151);
   struct c_spmat_d* x153 = c_eigen_spmat_d_sqrt(x152);
   return CTYPES_FROM_PTR(x153);
}
value owl_stub_30_c_eigen_spmat_d_print(value x154)
{
   struct c_spmat_d* x155 = CTYPES_ADDR_OF_FATPTR(x154);
   c_eigen_spmat_d_print(x155);
   return Val_unit;
}
