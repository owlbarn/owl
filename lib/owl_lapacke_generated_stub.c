#include "lapacke.h"
#include "ctypes_cstubs_internals.h"
value owl_stub_1_LAPACKE_sbdsdc(value x12, value x11, value x10, value x9,
                                value x8, value x7, value x6, value x5,
                                value x4, value x3, value x2, value x1)
{
   int x13 = Long_val(x12);
   int x16 = Int_val(x11);
   int x19 = Int_val(x10);
   int x22 = Long_val(x9);
   float* x25 = CTYPES_ADDR_OF_FATPTR(x8);
   float* x26 = CTYPES_ADDR_OF_FATPTR(x7);
   float* x27 = CTYPES_ADDR_OF_FATPTR(x6);
   int x28 = Long_val(x5);
   float* x31 = CTYPES_ADDR_OF_FATPTR(x4);
   int x32 = Long_val(x3);
   float* x35 = CTYPES_ADDR_OF_FATPTR(x2);
   int* x36 = CTYPES_ADDR_OF_FATPTR(x1);
   int x37 =
   LAPACKE_sbdsdc(x13, (char)x16, (char)x19, x22, x25, x26, x27, x28, 
                  x31, x32, x35, x36);
   return Val_long(x37);
}
value owl_stub_1_LAPACKE_sbdsdc_byte12(value* argv, int argc)
{
   value x38 = argv[11];
   value x39 = argv[10];
   value x40 = argv[9];
   value x41 = argv[8];
   value x42 = argv[7];
   value x43 = argv[6];
   value x44 = argv[5];
   value x45 = argv[4];
   value x46 = argv[3];
   value x47 = argv[2];
   value x48 = argv[1];
   value x49 = argv[0];
   return
     owl_stub_1_LAPACKE_sbdsdc(x49, x48, x47, x46, x45, x44, x43, x42, 
                               x41, x40, x39, x38);
}
