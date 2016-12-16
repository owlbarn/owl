(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* You should only use this module to call foreign functions *)

open Bigarray
open Ctypes
open Owl_types

module FB = Ffi_bindings.Bindings(Ffi_generated)
module DR = FB.Dense_real_double
module DC = FB.Dense_complex_double
module SR = FB.Sparse_real_double

(* some helper fucntions, e.g., for type translation and construction *)

let dr_matptr_to_mat x m n =
  let open Dense_real_double in
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let dr_col_vec_to_mat x =
  let open Dense_real_double in
  let raw = getf x vdata in
  let len = getf x vsize in
  bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float64 raw

let dr_mat_to_matptr x :
  Dense_real_double.mat_struct Ctypes.structure Ctypes_static.ptr =
  let open Dense_real_double in
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
  let open Dense_real_double in
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

let dc_matptr_to_mat x m n =
  let open Dense_complex_double in
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.complex64 raw

let dc_mat_to_matptr x :
  Dense_complex_double.mat_struct Ctypes.structure Ctypes_static.ptr =
  let open Dense_complex_double in
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


(* experimental *)

module Dense_real_double = struct

  open FB.Dense_real_double
  open Owl_types.Dense_real_double

  let matptr_to_mat x m n =
    let raw = getf (!@ x) data in
    bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

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

  let col_vec_to_mat x =
    let raw = getf x vdata in
    let len = getf x vsize in
    bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float64 raw

  let ml_gsl_matrix_equal x y =
    let x' = mat_to_matptr x in
    let y' = mat_to_matptr y in
    gsl_matrix_equal x' y' = 1

  let ml_gsl_matrix_isnull x =
    let y = mat_to_matptr x in
    gsl_matrix_isnull y = 1

  let ml_gsl_matrix_ispos x =
    let y = mat_to_matptr x in
    gsl_matrix_ispos y = 1

  let ml_gsl_matrix_isneg x =
    let y = mat_to_matptr x in
    gsl_matrix_isneg y = 1

  let ml_gsl_matrix_isnonneg x =
    let y = mat_to_matptr x in
    gsl_matrix_isnonneg y = 1

  let ml_gsl_matrix_min x : float =
    let y = mat_to_matptr x in
    gsl_matrix_min y

  let ml_gsl_matrix_max x : float =
    let y = mat_to_matptr x in
    gsl_matrix_max y

  let ml_gsl_matrix_min_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_min_index y i j in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let a = Array2.unsafe_get x i j in
    a, i, j

  let ml_gsl_matrix_max_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_max_index y i j in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let a = Array2.unsafe_get x i j in
    a, i, j

end


module Dense_real_float = struct

  open FB.Dense_real_float
  open Owl_types.Dense_real_float

  let matptr_to_mat x m n =
    let raw = getf (!@ x) data in
    bigarray_of_ptr array2 (m,n) Bigarray.float32 raw

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

  let col_vec_to_mat x =
    let raw = getf x vdata in
    let len = getf x vsize in
    bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float32 raw

  let ml_gsl_matrix_equal x y =
    let x' = mat_to_matptr x in
    let y' = mat_to_matptr y in
    gsl_matrix_float_equal x' y' = 1

  let ml_gsl_matrix_isnull x =
    let y = mat_to_matptr x in
    gsl_matrix_float_isnull y = 1

  let ml_gsl_matrix_ispos x =
    let y = mat_to_matptr x in
    gsl_matrix_float_ispos y = 1

  let ml_gsl_matrix_isneg x =
    let y = mat_to_matptr x in
    gsl_matrix_float_isneg y = 1

  let ml_gsl_matrix_isnonneg x =
    let y = mat_to_matptr x in
    gsl_matrix_float_isnonneg y = 1

  let ml_gsl_matrix_min x : float =
    let y = mat_to_matptr x in
    gsl_matrix_float_min y

  let ml_gsl_matrix_max x : float =
    let y = mat_to_matptr x in
    gsl_matrix_float_max y

  let ml_gsl_matrix_min_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_float_min_index y i j in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let a = Array2.unsafe_get x i j in
    a, i, j

  let ml_gsl_matrix_max_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_float_max_index y i j in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let a = Array2.unsafe_get x i j in
    a, i, j

end


module Dense_complex_double = struct

  open FB.Dense_complex_double
  open Owl_types.Dense_complex_double

  let matptr_to_mat x m n =
    let raw = getf (!@ x) data in
    bigarray_of_ptr array2 (m,n) Bigarray.complex64 raw

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

  let col_vec_to_mat x =
    let raw = getf x vdata in
    let len = getf x vsize in
    bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.complex64 raw

  let ml_gsl_matrix_equal x y =
    let x' = mat_to_matptr x in
    let y' = mat_to_matptr y in
    gsl_matrix_complex_equal x' y' = 1

  let ml_gsl_matrix_isnull x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_isnull y = 1

  let ml_gsl_matrix_ispos x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_ispos y = 1

  let ml_gsl_matrix_isneg x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_isneg y = 1

  let ml_gsl_matrix_isnonneg x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_isnonneg y = 1

end


module Dense_complex_float = struct

  open FB.Dense_complex_float
  open Owl_types.Dense_complex_float

  let matptr_to_mat x m n =
    let raw = getf (!@ x) data in
    bigarray_of_ptr array2 (m,n) Bigarray.complex32 raw

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

  let col_vec_to_mat x =
    let raw = getf x vdata in
    let len = getf x vsize in
    bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.complex32 raw

  let ml_gsl_matrix_equal x y =
    let x' = mat_to_matptr x in
    let y' = mat_to_matptr y in
    gsl_matrix_complex_float_equal x' y' = 1

  let ml_gsl_matrix_isnull x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_float_isnull y = 1

  let ml_gsl_matrix_ispos x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_float_ispos y = 1

  let ml_gsl_matrix_isneg x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_float_isneg y = 1

  let ml_gsl_matrix_isnonneg x =
    let y = mat_to_matptr x in
    gsl_matrix_complex_float_isnonneg y = 1

end



(* ends here *)
