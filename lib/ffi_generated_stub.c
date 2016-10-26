#include <sys/file.h>
#include <gsl/gsl_spmatrix.h>
#include <gsl/gsl_block_double.h>
#include <gsl/gsl_block_complex_double.h>
#include <gsl/gsl_vector_double.h>
#include <gsl/gsl_vector_complex_double.h>
#include <gsl/gsl_matrix_double.h>
#include <gsl/gsl_matrix_complex_double.h>
#include "ctypes_cstubs_internals.h"
value owl_stub_1_gsl_vector_alloc(value x1)
{
   size_t x2 = ctypes_size_t_val(x1);
   gsl_vector* x5 = gsl_vector_alloc(x2);
   return CTYPES_FROM_PTR(x5);
}
value owl_stub_2_gsl_matrix_alloc(value x7, value x6)
{
   size_t x8 = ctypes_size_t_val(x7);
   size_t x11 = ctypes_size_t_val(x6);
   gsl_matrix* x14 = gsl_matrix_alloc(x8, x11);
   return CTYPES_FROM_PTR(x14);
}
value owl_stub_3_gsl_matrix_get_col(value x17, value x16, value x15)
{
   gsl_vector* x18 = CTYPES_ADDR_OF_FATPTR(x17);
   gsl_matrix* x19 = CTYPES_ADDR_OF_FATPTR(x16);
   int x20 = Int_val(x15);
   int x23 = gsl_matrix_get_col(x18, x19, x20);
   return Val_int(x23);
}
value owl_stub_4_gsl_matrix_equal(value x25, value x24)
{
   gsl_matrix* x26 = CTYPES_ADDR_OF_FATPTR(x25);
   gsl_matrix* x27 = CTYPES_ADDR_OF_FATPTR(x24);
   int x28 = gsl_matrix_equal(x26, x27);
   return Val_int(x28);
}
value owl_stub_5_gsl_matrix_isnull(value x29)
{
   gsl_matrix* x30 = CTYPES_ADDR_OF_FATPTR(x29);
   int x31 = gsl_matrix_isnull(x30);
   return Val_int(x31);
}
value owl_stub_6_gsl_matrix_ispos(value x32)
{
   gsl_matrix* x33 = CTYPES_ADDR_OF_FATPTR(x32);
   int x34 = gsl_matrix_ispos(x33);
   return Val_int(x34);
}
value owl_stub_7_gsl_matrix_isneg(value x35)
{
   gsl_matrix* x36 = CTYPES_ADDR_OF_FATPTR(x35);
   int x37 = gsl_matrix_isneg(x36);
   return Val_int(x37);
}
value owl_stub_8_gsl_matrix_isnonneg(value x38)
{
   gsl_matrix* x39 = CTYPES_ADDR_OF_FATPTR(x38);
   int x40 = gsl_matrix_isnonneg(x39);
   return Val_int(x40);
}
value owl_stub_9_gsl_matrix_min(value x41)
{
   gsl_matrix* x42 = CTYPES_ADDR_OF_FATPTR(x41);
   double x43 = gsl_matrix_min(x42);
   return caml_copy_double(x43);
}
value owl_stub_10_gsl_matrix_min_index(value x46, value x45, value x44)
{
   gsl_matrix* x47 = CTYPES_ADDR_OF_FATPTR(x46);
   size_t* x48 = CTYPES_ADDR_OF_FATPTR(x45);
   size_t* x49 = CTYPES_ADDR_OF_FATPTR(x44);
   gsl_matrix_min_index(x47, x48, x49);
   return Val_unit;
}
value owl_stub_11_gsl_matrix_max(value x51)
{
   gsl_matrix* x52 = CTYPES_ADDR_OF_FATPTR(x51);
   double x53 = gsl_matrix_max(x52);
   return caml_copy_double(x53);
}
value owl_stub_12_gsl_matrix_max_index(value x56, value x55, value x54)
{
   gsl_matrix* x57 = CTYPES_ADDR_OF_FATPTR(x56);
   size_t* x58 = CTYPES_ADDR_OF_FATPTR(x55);
   size_t* x59 = CTYPES_ADDR_OF_FATPTR(x54);
   gsl_matrix_max_index(x57, x58, x59);
   return Val_unit;
}
value owl_stub_13_gsl_matrix_complex_equal(value x62, value x61)
{
   gsl_matrix_complex* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   gsl_matrix_complex* x64 = CTYPES_ADDR_OF_FATPTR(x61);
   int x65 = gsl_matrix_complex_equal(x63, x64);
   return Val_int(x65);
}
value owl_stub_14_gsl_matrix_complex_isnull(value x66)
{
   gsl_matrix_complex* x67 = CTYPES_ADDR_OF_FATPTR(x66);
   int x68 = gsl_matrix_complex_isnull(x67);
   return Val_int(x68);
}
value owl_stub_15_gsl_matrix_complex_ispos(value x69)
{
   gsl_matrix_complex* x70 = CTYPES_ADDR_OF_FATPTR(x69);
   int x71 = gsl_matrix_complex_ispos(x70);
   return Val_int(x71);
}
value owl_stub_16_gsl_matrix_complex_isneg(value x72)
{
   gsl_matrix_complex* x73 = CTYPES_ADDR_OF_FATPTR(x72);
   int x74 = gsl_matrix_complex_isneg(x73);
   return Val_int(x74);
}
value owl_stub_17_gsl_matrix_complex_isnonneg(value x75)
{
   gsl_matrix_complex* x76 = CTYPES_ADDR_OF_FATPTR(x75);
   int x77 = gsl_matrix_complex_isnonneg(x76);
   return Val_int(x77);
}
