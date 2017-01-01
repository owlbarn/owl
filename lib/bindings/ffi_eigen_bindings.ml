
open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  type eigen_spmat_d
  let eigen_spmat_d : eigen_spmat_d structure typ = structure "eigen_spmat_d"

  let ml_eigen_spmat_d_new = foreign "c_eigen_spmat_d_new" (int @-> int @-> returning (ptr eigen_spmat_d))

  let ml_eigen_spmat_d_rows = foreign "c_eigen_spmat_d_rows" (ptr eigen_spmat_d @-> returning int)

  let ml_eigen_spmat_d_cols = foreign "c_eigen_spmat_d_cols" (ptr eigen_spmat_d @-> returning int)

end
