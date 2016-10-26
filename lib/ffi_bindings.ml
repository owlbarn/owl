open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F
  open Owl_types.Dense_real

  (* deal with anonymous c struct *)

  let mat_struct = typedef mat_struct "gsl_matrix"
  let vec_struct = typedef vec_struct "gsl_vector"

  (* dense real matrix functions *)

  let gsl_vector_alloc = foreign "gsl_vector_alloc" (size_t @-> returning (ptr vec_struct))

  let gsl_matrix_alloc = foreign "gsl_matrix_alloc" (size_t @-> size_t @-> returning (ptr mat_struct))

  let gsl_matrix_get_col = foreign "gsl_matrix_get_col" (ptr vec_struct @-> ptr mat_struct @-> int @-> returning int)

  let gsl_matrix_equal = foreign "gsl_matrix_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

  let gsl_matrix_isnull = foreign "gsl_matrix_isnull" (ptr mat_struct @-> returning int)

  let gsl_matrix_ispos = foreign "gsl_matrix_ispos" (ptr mat_struct @-> returning int)

  let gsl_matrix_isneg = foreign "gsl_matrix_isneg" (ptr mat_struct @-> returning int)

  let gsl_matrix_isnonneg = foreign "gsl_matrix_isnonneg" (ptr mat_struct @-> returning int)

  let gsl_matrix_min = foreign "gsl_matrix_min" (ptr mat_struct @-> returning double)

  let gsl_matrix_min_index = foreign "gsl_matrix_min_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

  let gsl_matrix_max = foreign "gsl_matrix_max" (ptr mat_struct @-> returning double)

  let gsl_matrix_max_index = foreign "gsl_matrix_max_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

end
