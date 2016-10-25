open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct
  open F
  open Owl_types.Complex_sparse

  let flock = foreign "flock" (int @-> int @-> returning int)

  let gsl_spmatrix_alloc = foreign "gsl_spmatrix_alloc" (int @-> int @-> returning (ptr spmat_struct))
end
