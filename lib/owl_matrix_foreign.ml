(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes
open Foreign
open Owl_types
open Owl_types.Sparse_real

module B = Ffi_bindings.Bindings(Ffi_generated)
module DR = B.Dense_real
module DC = B.Dense_complex

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

(* TODO: not sure what to do with this function ... unless it is faster than dgemm
let gsl_spblas_dgemv = foreign "gsl_spblas_dgemv" (int @-> double @-> ptr spmat_struct @-> ptr vec_struct @-> double @-> ptr vec_struct @-> returning int)
*)

let gsl_spblas_dgemm = foreign "gsl_spblas_dgemm" (double @-> ptr spmat_struct @-> ptr spmat_struct @-> ptr spmat_struct @-> returning int)

let gsl_spmatrix_d2sp = foreign "gsl_spmatrix_d2sp" (ptr spmat_struct @-> ptr Dense_real.mat_struct @-> returning int)

let gsl_spmatrix_sp2d = foreign "gsl_spmatrix_sp2d" (ptr Dense_real.mat_struct @-> ptr spmat_struct @-> returning int)


(* some helper fucntions, e.g., for type translation and construction *)

let dr_matptr_to_mat x m n =
  let open Dense_real in
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let dr_col_vec_to_mat x =
  let open Dense_real in
  let raw = getf x vdata in
  let len = getf x vsize in
  bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float64 raw

let dr_mat_to_matptr x :
  Dense_real.mat_struct Ctypes.structure Ctypes_static.ptr =
  let open Dense_real in
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

let dr_allocate_vecptr m n =
  let open Dense_real in
  let open DR in
  let p = gsl_vector_alloc (Unsigned.Size_t.of_int m) in
  let y = !@ p in
  let x = {
    vsize = Int64.to_int (getf y vsize);
    stride = Int64.to_int (getf y vsize);
    vdata = (
      let raw = getf y vdata in
      bigarray_of_ptr array2 (m, n) Bigarray.float64 raw );
    vptr = p } in x

let dr_allocate_row_vecptr m = dr_allocate_vecptr 1 m

let dr_allocate_col_vecptr m = dr_allocate_vecptr m 1



(* ends here *)
