open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct
  open F
  open Owl_types.Complex_sparse

  let flock = foreign "flock" (int @-> int @-> returning int)

  let gsl_spmatrix_alloc = foreign "gsl_spmatrix_alloc" (int @-> int @-> returning (ptr spmat_struct))
  let gsl_spmatrix_alloc_nzmax = foreign "gsl_spmatrix_alloc_nzmax" (int @-> int @-> int @-> int @-> returning (ptr spmat_struct))
  let gsl_spmatrix_set = foreign "gsl_spmatrix_set" (ptr spmat_struct @-> int @-> int @-> complex64 @-> returning int)
  let gsl_spmatrix_get = foreign "gsl_spmatrix_get" (ptr spmat_struct @-> int @-> int @-> returning complex64)
  let gsl_spmatrix_set_zero = foreign "gsl_spmatrix_set_zero" (ptr spmat_struct @-> returning int)
end
