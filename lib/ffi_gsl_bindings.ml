(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

 (* run the following commands -->
   ./ffi_gsl_stubgen.byte -ml > lib/ffi_gsl_generated.ml;
   ./ffi_gsl_stubgen.byte -c > lib/ffi_gsl_generated_stub.c;
   cp ./lib/bindings/ffi_gsl_bindings.ml  ./lib/ffi_gsl_bindings.ml
  *)

open Ctypes

module Bindings (F : Cstubs.FOREIGN) = struct

  open F

  (* foreign functions of dense real matrix *)

  module Dense_real_double = struct

    open Owl_types.Dense_real_double

    (* deal with anonymous c struct *)
    let mat_struct = typedef mat_struct "gsl_matrix"
    let vec_struct = typedef vec_struct "gsl_vector"

    let gsl_matrix_equal = foreign "gsl_matrix_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

    let gsl_matrix_isnull = foreign "gsl_matrix_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_ispos = foreign "gsl_matrix_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_isneg = foreign "gsl_matrix_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_isnonneg = foreign "gsl_matrix_isnonneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_min = foreign "gsl_matrix_min" (ptr mat_struct @-> returning double)

    let gsl_matrix_max = foreign "gsl_matrix_max" (ptr mat_struct @-> returning double)

    let gsl_matrix_minmax = foreign "gsl_matrix_minmax" (ptr mat_struct @-> ptr double @-> ptr double @-> returning void)

    let gsl_matrix_min_index = foreign "gsl_matrix_min_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

    let gsl_matrix_max_index = foreign "gsl_matrix_max_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

    let gsl_matrix_minmax_index = foreign "gsl_matrix_minmax_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> ptr size_t @-> ptr size_t @-> returning void)

    let gsl_vector_alloc = foreign "gsl_vector_alloc" (size_t @-> returning (ptr vec_struct))

    let gsl_matrix_alloc = foreign "gsl_matrix_alloc" (size_t @-> size_t @-> returning (ptr mat_struct))

    let gsl_matrix_get_col = foreign "gsl_matrix_get_col" (ptr vec_struct @-> ptr mat_struct @-> int @-> returning int)

  end


  module Dense_real_float = struct

    open Owl_types.Dense_real_float

    (* deal with anonymous c struct *)
    let mat_struct = typedef mat_struct "gsl_matrix_float"
    let vec_struct = typedef vec_struct "gsl_vector_float"

    let gsl_matrix_float_equal = foreign "gsl_matrix_float_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

    let gsl_matrix_float_isnull = foreign "gsl_matrix_float_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_ispos = foreign "gsl_matrix_float_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_isneg = foreign "gsl_matrix_float_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_isnonneg = foreign "gsl_matrix_float_isnonneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_min = foreign "gsl_matrix_float_min" (ptr mat_struct @-> returning float)

    let gsl_matrix_float_max = foreign "gsl_matrix_float_max" (ptr mat_struct @-> returning float)

    let gsl_matrix_float_minmax = foreign "gsl_matrix_float_minmax" (ptr mat_struct @-> ptr float @-> ptr float @-> returning void)

    let gsl_matrix_float_min_index = foreign "gsl_matrix_float_min_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

    let gsl_matrix_float_max_index = foreign "gsl_matrix_float_max_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> returning void)

    let gsl_matrix_float_minmax_index = foreign "gsl_matrix_float_minmax_index" (ptr mat_struct @-> ptr size_t @-> ptr size_t @-> ptr size_t @-> ptr size_t @-> returning void)

  end


  (* foreign functions of dense complex matrix *)

  module Dense_complex_double = struct

    open Owl_types.Dense_complex_double

    (* deal with anonymous c struct *)
    let mat_struct = typedef mat_struct "gsl_matrix_complex"
    let vec_struct = typedef vec_struct "gsl_vector_complex"

    let gsl_matrix_complex_equal = foreign "gsl_matrix_complex_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

    let gsl_matrix_complex_isnull = foreign "gsl_matrix_complex_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_ispos = foreign "gsl_matrix_complex_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_isneg = foreign "gsl_matrix_complex_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_isnonneg = foreign "gsl_matrix_complex_isnonneg" (ptr mat_struct @-> returning int)

  end


  module Dense_complex_float = struct

    open Owl_types.Dense_complex_float

    (* deal with anonymous c struct *)
    let mat_struct = typedef mat_struct "gsl_matrix_complex_float"
    let vec_struct = typedef vec_struct "gsl_vector_complex_float"

    let gsl_matrix_complex_float_equal = foreign "gsl_matrix_complex_float_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isnull = foreign "gsl_matrix_complex_float_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_ispos = foreign "gsl_matrix_complex_float_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isneg = foreign "gsl_matrix_complex_float_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isnonneg = foreign "gsl_matrix_complex_float_isnonneg" (ptr mat_struct @-> returning int)

  end

end
