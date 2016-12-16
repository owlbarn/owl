(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *
 *)

 (* run the following commands -->
   ./ffi_stubgen.byte -ml > lib/ffi_generated.ml;
   ./ffi_stubgen.byte -c > lib/ffi_generated_stubs.c;
   cp ./lib/bindings/ffi_bindings_base.ml  ./lib/ffi_bindings.ml
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


  module Dense_real_float = struct

    open Owl_types.Dense_real_float

    (* deal with anonymous c struct *)
    let mat_struct = typedef mat_struct "gsl_matrix_float"
    let vec_struct = typedef vec_struct "gsl_vector_float"

    let gsl_matrix_float_isnull = foreign "gsl_matrix_float_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_ispos = foreign "gsl_matrix_float_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_isneg = foreign "gsl_matrix_float_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_float_isnonneg = foreign "gsl_matrix_float_isnonneg" (ptr mat_struct @-> returning int)

  end


  (* foreign functions of dense complex matrix *)

  module Dense_complex_double = struct

    open Owl_types.Dense_complex_double

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

    let mat_struct = typedef mat_struct "gsl_matrix_complex_float"
    let vec_struct = typedef vec_struct "gsl_vector_complex_float"

    let gsl_matrix_complex_float_equal = foreign "gsl_matrix_complex_float_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isnull = foreign "gsl_matrix_complex_float_isnull" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_ispos = foreign "gsl_matrix_complex_float_ispos" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isneg = foreign "gsl_matrix_complex_float_isneg" (ptr mat_struct @-> returning int)

    let gsl_matrix_complex_float_isnonneg = foreign "gsl_matrix_complex_float_isnonneg" (ptr mat_struct @-> returning int)

  end


  (* foreign functions of sparse real matrix *)

  module Sparse_real_double = struct

    open Owl_types.Sparse_real_double

    let spmat_struct = typedef spmat_struct "gsl_spmatrix"

    let gsl_spmatrix_alloc = foreign "gsl_spmatrix_alloc" (int @-> int @-> returning (ptr spmat_struct))

    let gsl_spmatrix_alloc_nzmax = foreign "gsl_spmatrix_alloc_nzmax" (int @-> int @-> int @-> int @-> returning (ptr spmat_struct))

    let gsl_spmatrix_set = foreign "gsl_spmatrix_set" (ptr spmat_struct @-> int @-> int @-> double @-> returning int)

    let gsl_spmatrix_get = foreign "gsl_spmatrix_get" (ptr spmat_struct @-> int @-> int @-> returning double)

    let gsl_spmatrix_add = foreign "gsl_spmatrix_add" (ptr spmat_struct @-> ptr spmat_struct @-> ptr spmat_struct @-> returning int)

    let gsl_spmatrix_scale = foreign "gsl_spmatrix_scale" (ptr spmat_struct @-> double @-> returning int)

    let gsl_spmatrix_memcpy = foreign "gsl_spmatrix_memcpy" (ptr spmat_struct @-> ptr spmat_struct @-> returning int)

    let gsl_spmatrix_compcol = foreign "gsl_spmatrix_compcol" (ptr spmat_struct @-> returning (ptr spmat_struct))

    let gsl_spmatrix_minmax = foreign "gsl_spmatrix_minmax" (ptr spmat_struct @-> ptr double @-> ptr double @-> returning int)

    let gsl_spmatrix_equal = foreign "gsl_spmatrix_equal" (ptr spmat_struct @-> ptr spmat_struct @-> returning int)

    let gsl_spmatrix_transpose_memcpy = foreign "gsl_spmatrix_transpose_memcpy" (ptr spmat_struct @-> ptr spmat_struct @-> returning int)

    let gsl_spmatrix_set_zero = foreign "gsl_spmatrix_set_zero" (ptr spmat_struct @-> returning int)

    let gsl_spblas_dgemm = foreign "gsl_spblas_dgemm" (double @-> ptr spmat_struct @-> ptr spmat_struct @-> ptr spmat_struct @-> returning int)

    let gsl_spmatrix_d2sp = foreign "gsl_spmatrix_d2sp" (ptr spmat_struct @-> ptr Dense_real_double.mat_struct @-> returning int)

    let gsl_spmatrix_sp2d = foreign "gsl_spmatrix_sp2d" (ptr Dense_real_double.mat_struct @-> ptr spmat_struct @-> returning int)

  end

end
