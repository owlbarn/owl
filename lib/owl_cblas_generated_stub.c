#include "owl_cblas.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_cblas_scopy(value x5, value x4, value x3, value x2,
                             value x1)
{
   int x6 = Long_val(x5);
   float* x9 = CTYPES_ADDR_OF_FATPTR(x4);
   int x10 = Long_val(x3);
   float* x13 = CTYPES_ADDR_OF_FATPTR(x2);
   int x14 = Long_val(x1);
   cblas_scopy(x6, x9, x10, x13, x14);
   return Val_unit;
}
value owl_stub_2_cblas_dcopy(value x22, value x21, value x20, value x19,
                             value x18)
{
   int x23 = Long_val(x22);
   double* x26 = CTYPES_ADDR_OF_FATPTR(x21);
   int x27 = Long_val(x20);
   double* x30 = CTYPES_ADDR_OF_FATPTR(x19);
   int x31 = Long_val(x18);
   cblas_dcopy(x23, x26, x27, x30, x31);
   return Val_unit;
}
value owl_stub_3_cblas_ccopy(value x39, value x38, value x37, value x36,
                             value x35)
{
   int x40 = Long_val(x39);
   float _Complex* x43 = CTYPES_ADDR_OF_FATPTR(x38);
   int x44 = Long_val(x37);
   float _Complex* x47 = CTYPES_ADDR_OF_FATPTR(x36);
   int x48 = Long_val(x35);
   cblas_ccopy(x40, x43, x44, x47, x48);
   return Val_unit;
}
value owl_stub_4_cblas_zcopy(value x56, value x55, value x54, value x53,
                             value x52)
{
   int x57 = Long_val(x56);
   double _Complex* x60 = CTYPES_ADDR_OF_FATPTR(x55);
   int x61 = Long_val(x54);
   double _Complex* x64 = CTYPES_ADDR_OF_FATPTR(x53);
   int x65 = Long_val(x52);
   cblas_zcopy(x57, x60, x61, x64, x65);
   return Val_unit;
}
