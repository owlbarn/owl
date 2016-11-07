(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

open Ctypes
open Owl_types

module B = Ffi_bindings.Bindings(Ffi_generated)
module DR = B.Dense_real
module DC = B.Dense_complex
module SR = B.Sparse_real

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

let dc_matptr_to_mat x m n =
  let open Dense_complex in
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.complex64 raw

let dc_mat_to_matptr x :
  Dense_complex.mat_struct Ctypes.structure Ctypes_static.ptr =
  let open Dense_complex in
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


(* ends here *)
