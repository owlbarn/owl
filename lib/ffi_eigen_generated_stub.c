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
value owl_stub_18_c_eigen_spmat_d_add(value x97, value x96)
{
   struct c_spmat_d* x98 = CTYPES_ADDR_OF_FATPTR(x97);
   struct c_spmat_d* x99 = CTYPES_ADDR_OF_FATPTR(x96);
   struct c_spmat_d* x100 = c_eigen_spmat_d_add(x98, x99);
   return CTYPES_FROM_PTR(x100);
}
value owl_stub_19_c_eigen_spmat_d_sub(value x102, value x101)
{
   struct c_spmat_d* x103 = CTYPES_ADDR_OF_FATPTR(x102);
   struct c_spmat_d* x104 = CTYPES_ADDR_OF_FATPTR(x101);
   struct c_spmat_d* x105 = c_eigen_spmat_d_sub(x103, x104);
   return CTYPES_FROM_PTR(x105);
}
value owl_stub_20_c_eigen_spmat_d_mul(value x107, value x106)
{
   struct c_spmat_d* x108 = CTYPES_ADDR_OF_FATPTR(x107);
   struct c_spmat_d* x109 = CTYPES_ADDR_OF_FATPTR(x106);
   struct c_spmat_d* x110 = c_eigen_spmat_d_mul(x108, x109);
   return CTYPES_FROM_PTR(x110);
}
value owl_stub_21_c_eigen_spmat_d_div(value x112, value x111)
{
   struct c_spmat_d* x113 = CTYPES_ADDR_OF_FATPTR(x112);
   struct c_spmat_d* x114 = CTYPES_ADDR_OF_FATPTR(x111);
   struct c_spmat_d* x115 = c_eigen_spmat_d_div(x113, x114);
   return CTYPES_FROM_PTR(x115);
}
value owl_stub_22_c_eigen_spmat_d_mul_scalar(value x117, value x116)
{
   struct c_spmat_d* x118 = CTYPES_ADDR_OF_FATPTR(x117);
   double x119 = Double_val(x116);
   struct c_spmat_d* x122 = c_eigen_spmat_d_mul_scalar(x118, x119);
   return CTYPES_FROM_PTR(x122);
}
value owl_stub_23_c_eigen_spmat_d_div_scalar(value x124, value x123)
{
   struct c_spmat_d* x125 = CTYPES_ADDR_OF_FATPTR(x124);
   double x126 = Double_val(x123);
   struct c_spmat_d* x129 = c_eigen_spmat_d_div_scalar(x125, x126);
   return CTYPES_FROM_PTR(x129);
}
value owl_stub_24_c_eigen_spmat_d_print(value x130)
{
   struct c_spmat_d* x131 = CTYPES_ADDR_OF_FATPTR(x130);
   c_eigen_spmat_d_print(x131);
   return Val_unit;
}
