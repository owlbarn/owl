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
