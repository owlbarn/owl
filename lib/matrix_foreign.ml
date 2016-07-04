open Ctypes
open Foreign
open Types


(* Dense matrices functions, refer to gsl_matrix_double.h *)

let gsl_vector_alloc = foreign "gsl_vector_alloc" (int @-> returning (ptr vec_struct))

let gsl_matrix_alloc = foreign "gsl_matrix_alloc" (int @-> int @-> returning (ptr mat_struct))

let gsl_matrix_get_col = foreign "gsl_matrix_get_col" (ptr vec_struct @-> ptr mat_struct @-> int @-> returning int)

let gsl_matrix_equal = foreign "gsl_matrix_equal" (ptr mat_struct @-> ptr mat_struct @-> returning int)

let gsl_matrix_isnull = foreign "gsl_matrix_isnull" (ptr mat_struct @-> returning int)

let gsl_matrix_ispos = foreign "gsl_matrix_ispos" (ptr mat_struct @-> returning int)

let gsl_matrix_isneg = foreign "gsl_matrix_isneg" (ptr mat_struct @-> returning int)

let gsl_matrix_isnonneg = foreign "gsl_matrix_isnonneg" (ptr mat_struct @-> returning int)

let gsl_matrix_min = foreign "gsl_matrix_min" (ptr mat_struct @-> returning double)

let gsl_matrix_min_index = foreign "gsl_matrix_min_index" (ptr mat_struct @-> ptr int @-> ptr int @-> returning void)

let gsl_matrix_max = foreign "gsl_matrix_max" (ptr mat_struct @-> returning double)

let gsl_matrix_max_index = foreign "gsl_matrix_max_index" (ptr mat_struct @-> ptr int @-> ptr int @-> returning void)

let gsl_matrix_fwrite = foreign "gsl_matrix_fwrite" (ptr int @-> ptr mat_struct @-> returning void)


(* Sparse matrices functions, refer to gsl_spmatrix.h *)

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

(* TODO: not sure what to do with this function ... unless it is faster than dgemm *)
let gsl_spblas_dgemv = foreign "gsl_spblas_dgemv" (int @-> double @-> ptr spmat_struct @-> ptr vec_struct @-> double @-> ptr vec_struct @-> returning int)

let gsl_spblas_dgemm = foreign "gsl_spblas_dgemm" (double @-> ptr spmat_struct @-> ptr spmat_struct @-> ptr spmat_struct @-> returning int)

let gsl_spmatrix_d2sp = foreign "gsl_spmatrix_d2sp" (ptr spmat_struct @-> ptr mat_struct @-> returning int)

let gsl_spmatrix_sp2d = foreign "gsl_spmatrix_sp2d" (ptr mat_struct @-> ptr spmat_struct @-> returning int)


(* some helper fucntions, e.g., for type translation and construction *)

let matptr_to_mat x m n =
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let col_vec_to_mat x =
  let raw = getf x vdata in
  let len = getf x vsize in
  bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float64 raw

let mat_to_matptr x :
  mat_struct Ctypes.structure Ctypes_static.ptr =
  let m = Int64.of_int (Bigarray.Array2.dim1 x) in
  let n = Int64.of_int (Bigarray.Array2.dim2 x) in
  let y = make mblk_struct in
  let z = make mat_struct in
  let p = Ctypes.bigarray_start Ctypes_static.Array2 x in
  let _ = setf y msize (Int64.mul m n) in
  let _ = setf y mdata p in
  let _ = setf z size1 m in
  let _ = setf z size2 n in
  let _ = setf z tda n in
  let _ = setf z data p in
  let _ = setf z block (addr y) in
  (addr z)

let _allocate_vecptr m n =
  let p = gsl_vector_alloc m in
  let y = !@ p in
  let x = {
    vsize = Int64.to_int (getf y vsize);
    stride = Int64.to_int (getf y vsize);
    vdata = (
      let raw = getf y vdata in
      bigarray_of_ptr array2 (m, n) Bigarray.float64 raw );
    vptr = p } in x

let allocate_row_vecptr m = _allocate_vecptr 1 m

let allocate_col_vecptr m = _allocate_vecptr m 1



(* ends here *)
