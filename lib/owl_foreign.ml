(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(* You should only use this module to call foreign functions *)

open Bigarray
open Ctypes
open Owl_types

module FB = Ffi_gsl_bindings.Bindings(Ffi_gsl_generated)

(* TODO: for compatibility reasons, need to be removed *)
module DR = FB.Dense_real_double
module DC = FB.Dense_complex_double
module SR = FB.Sparse_real_double

(* ffi for dense double matrix *)
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

  let ml_gsl_matrix_minmax x : float * float =
    let y = mat_to_matptr x in
    let min = allocate double 0. in
    let max = allocate double 0. in
    let _ = gsl_matrix_minmax y min max in
    !@min, !@max

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

  let ml_gsl_matrix_minmax_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let p = allocate size_t (Unsigned.Size_t.of_int 0) in
    let q = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_minmax_index y i j p q in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let p = Unsigned.Size_t.to_int !@p in
    let q = Unsigned.Size_t.to_int !@q in
    let a = Array2.unsafe_get x i j in
    let b = Array2.unsafe_get x p q in
    (a, i, j), (b, p, q)

  let ml_gsl_dot x1 x2 =
    let open Gsl.Blas in
    let m, n = Array2.dim1 x1, Array2.dim2 x2 in
    let x3 = Array2.create (Array2.kind x1) c_layout m n in
    gemm ~ta:Gsl.Blas.NoTrans ~tb:Gsl.Blas.NoTrans ~alpha:1. ~beta:0. ~a:x1 ~b:x2 ~c:x3;
    x3

end


(* ffi for dense float matrix *)
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

  let ml_gsl_matrix_minmax x : float * float =
    let y = mat_to_matptr x in
    let min = allocate float 0. in
    let max = allocate float 0. in
    let _ = gsl_matrix_float_minmax y min max in
    !@min, !@max

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

  let ml_gsl_matrix_minmax_index x =
    let y = mat_to_matptr x in
    let i = allocate size_t (Unsigned.Size_t.of_int 0) in
    let j = allocate size_t (Unsigned.Size_t.of_int 0) in
    let p = allocate size_t (Unsigned.Size_t.of_int 0) in
    let q = allocate size_t (Unsigned.Size_t.of_int 0) in
    let _ = gsl_matrix_float_minmax_index y i j p q in
    let i = Unsigned.Size_t.to_int !@i in
    let j = Unsigned.Size_t.to_int !@j in
    let p = Unsigned.Size_t.to_int !@p in
    let q = Unsigned.Size_t.to_int !@q in
    let a = Array2.unsafe_get x i j in
    let b = Array2.unsafe_get x p q in
    (a, i, j), (b, p, q)

  let ml_gsl_dot x1 x2 =
    let open Gsl.Blas.Single in
    let m, n = Array2.dim1 x1, Array2.dim2 x2 in
    let x3 = Array2.create (Array2.kind x1) c_layout m n in
    gemm ~ta:Gsl.Blas.NoTrans ~tb:Gsl.Blas.NoTrans ~alpha:1. ~beta:0. ~a:x1 ~b:x2 ~c:x3;
    x3

end


(* ffi for dense complex double matrix *)
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

  let ml_gsl_dot x1 x2 =
    let open Gsl.Blas.Complex in
    let m, n = Array2.dim1 x1, Array2.dim2 x2 in
    let x3 = Array2.create (Array2.kind x1) c_layout m n in
    gemm ~ta:Gsl.Blas.NoTrans ~tb:Gsl.Blas.NoTrans ~alpha:Complex.one ~beta:Complex.zero ~a:x1 ~b:x2 ~c:x3;
    x3

end

(* ffi for dense complex float matrix *)
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

  let ml_gsl_dot x1 x2 =
    let open Gsl.Blas.Complex_Single in
    let m, n = Array2.dim1 x1, Array2.dim2 x2 in
    let x3 = Array2.create (Array2.kind x1) c_layout m n in
    gemm ~ta:Gsl.Blas.NoTrans ~tb:Gsl.Blas.NoTrans ~alpha:Complex.one ~beta:Complex.zero ~a:x1 ~b:x2 ~c:x3;
    x3

end

(* TODO: experimental, interface to eigen *)
module EigenFB = Ffi_eigen_bindings.Bindings(Ffi_eigen_generated)

module Eigen_D = struct

  open EigenFB

  let create m n =
    let x = ml_eigen_spmat_d_new (Int64.of_int m) (Int64.of_int n) in
    Gc.finalise ml_eigen_spmat_d_delete x;
    x

  let delete x = ml_eigen_spmat_d_delete x

  let eye m = ml_eigen_spmat_d_eye (Int64.of_int m)

  let rows x = ml_eigen_spmat_d_rows x |> Int64.to_int

  let cols x = ml_eigen_spmat_d_cols x |> Int64.to_int

  let nnz x = ml_eigen_spmat_d_nnz x |> Int64.to_int

  let get x i j = ml_eigen_spmat_d_get x (Int64.of_int i) (Int64.of_int j)

  let set x i j a = ml_eigen_spmat_d_set x (Int64.of_int i) (Int64.of_int j) a

  let reset x = ml_eigen_spmat_d_reset x

  let is_compressed x = ml_eigen_spmat_d_is_compressed x = 1

  let compress x = ml_eigen_spmat_d_compress x

  let uncompress x = ml_eigen_spmat_d_uncompress x

  let reshape x m n = ml_eigen_spmat_d_reshape x (Int64.of_int m) (Int64.of_int n)

  let prune x r e = ml_eigen_spmat_d_prune x r e

  let valueptr x =
    let l = allocate int64_t (Signed.Int64.of_int 0) in
    let raw = ml_eigen_spmat_d_valueptr x l in
    let l = Signed.Int64.to_int !@l in
    bigarray_of_ptr array1 l Bigarray.float64 raw

  let innerindexptr x =
    let raw = ml_eigen_spmat_d_innerindexptr x in
    bigarray_of_ptr array1 (nnz x) Bigarray.int64 raw

  let outerindexptr x =
    let raw = ml_eigen_spmat_d_outerindexptr x in
    bigarray_of_ptr array1 (rows x) Bigarray.int64 raw

  let clone x = ml_eigen_spmat_d_clone x

  let row x i = ml_eigen_spmat_d_row x (Int64.of_int i)

  let col x i = ml_eigen_spmat_d_col x (Int64.of_int i)

  let transpose x = ml_eigen_spmat_d_transpose x

  let adjoint x = ml_eigen_spmat_d_adjoint x

  let diagonal x = ml_eigen_spmat_d_diagonal x

  let trace x = ml_eigen_spmat_d_trace x

  let is_zero x = ml_eigen_spmat_d_is_zero x = 1

  let is_positive x = ml_eigen_spmat_d_is_positive x = 1

  let is_negative x = ml_eigen_spmat_d_is_negative x = 1

  let is_nonpositive x = ml_eigen_spmat_d_is_nonpositive x = 1

  let is_nonnegative x = ml_eigen_spmat_d_is_nonnegative x = 1

  let is_equal x y = ml_eigen_spmat_d_is_equal x y = 1

  let is_unequal x y = ml_eigen_spmat_d_is_unequal x y = 1

  let is_greater x y = ml_eigen_spmat_d_is_greater x y = 1

  let is_smaller x y = ml_eigen_spmat_d_is_smaller x y = 1

  let equal_or_greater x y = ml_eigen_spmat_d_equal_or_greater x y = 1

  let equal_or_smaller x y = ml_eigen_spmat_d_equal_or_smaller x y = 1

  let add x y = ml_eigen_spmat_d_add x y

  let sub x y = ml_eigen_spmat_d_sub x y

  let mul x y = ml_eigen_spmat_d_mul x y

  let div x y = ml_eigen_spmat_d_div x y

  let dot x y = ml_eigen_spmat_d_dot x y

  let add_scalar x a = ml_eigen_spmat_d_add_scalar x a

  let sub_scalar x a = ml_eigen_spmat_d_sub_scalar x a

  let mul_scalar x a = ml_eigen_spmat_d_mul_scalar x a

  let div_scalar x a = ml_eigen_spmat_d_div_scalar x a

  let min2 x y = ml_eigen_spmat_d_min2 x y

  let max2 x y = ml_eigen_spmat_d_max2 x y

  let sum x = ml_eigen_spmat_d_sum x

  let min x = ml_eigen_spmat_d_min x

  let max x = ml_eigen_spmat_d_max x

  let abs x = ml_eigen_spmat_d_abs x

  let neg x = ml_eigen_spmat_d_neg x

  let sqrt x = ml_eigen_spmat_d_sqrt x

  let print x = ml_eigen_spmat_d_print x

end




(* ends here *)
