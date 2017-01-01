#include "libowl_eigen.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_c_eigen_spmat_d_new(value x2, value x1)
{
   int x3 = Int_val(x2);
   int x6 = Int_val(x1);
   struct eigen_spmat_d* x9 = c_eigen_spmat_d_new(x3, x6);
   return CTYPES_FROM_PTR(x9);
}
value owl_stub_2_c_eigen_spmat_d_rows(value x10)
{
   struct eigen_spmat_d* x11 = CTYPES_ADDR_OF_FATPTR(x10);
   int x12 = c_eigen_spmat_d_rows(x11);
   return Val_int(x12);
}
value owl_stub_3_c_eigen_spmat_d_cols(value x13)
{
   struct eigen_spmat_d* x14 = CTYPES_ADDR_OF_FATPTR(x13);
   int x15 = c_eigen_spmat_d_cols(x14);
   return Val_int(x15);
}
