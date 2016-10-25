#include <sys/file.h>
#include "ctypes_cstubs_internals.h"
value owl_stub_1_flock(value x2, value x1)
{
   int x3 = Int_val(x2);
   int x6 = Int_val(x1);
   int x9 = flock(x3, x6);
   return Val_int(x9);
}
value owl_stub_2_gsl_spmatrix_alloc(value x11, value x10)
{
   int x12 = Int_val(x11);
   int x15 = Int_val(x10);
   struct spmat_struct* x18 = gsl_spmatrix_alloc(x12, x15);
   return CTYPES_FROM_PTR(x18);
}
value owl_stub_3_gsl_spmatrix_alloc_nzmax(value x22, value x21, value x20,
                                          value x19)
{
   int x23 = Int_val(x22);
   int x26 = Int_val(x21);
   int x29 = Int_val(x20);
   int x32 = Int_val(x19);
   struct spmat_struct* x35 = gsl_spmatrix_alloc_nzmax(x23, x26, x29, x32);
   return CTYPES_FROM_PTR(x35);
}
value owl_stub_4_gsl_spmatrix_set(value x39, value x38, value x37, value x36)
{
   struct spmat_struct* x40 = CTYPES_ADDR_OF_FATPTR(x39);
   int x41 = Int_val(x38);
   int x44 = Int_val(x37);
   double _Complex x47 = ctypes_double_complex_val(x36);
   int x50 = gsl_spmatrix_set(x40, x41, x44, x47);
   return Val_int(x50);
}
value owl_stub_5_gsl_spmatrix_get(value x53, value x52, value x51)
{
   struct spmat_struct* x54 = CTYPES_ADDR_OF_FATPTR(x53);
   int x55 = Int_val(x52);
   int x58 = Int_val(x51);
   double _Complex x61 = gsl_spmatrix_get(x54, x55, x58);
   return ctypes_copy_double_complex(x61);
}
value owl_stub_6_gsl_spmatrix_set_zero(value x62)
{
   struct spmat_struct* x63 = CTYPES_ADDR_OF_FATPTR(x62);
   int x64 = gsl_spmatrix_set_zero(x63);
   return Val_int(x64);
}
