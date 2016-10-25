(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** [ Complex sparse matrix ] *)

open Bigarray
open Owl_types.Complex_sparse

type spmat = spmat_record

let _empty_int_array () = Array1.create int64 c_layout 0

let _of_sp_mat_ptr p =
  let open Owl_matrix_foreign in
  let open Ctypes in
  let y = !@ p in
  let tz = Int64.to_int (getf y sp_nz) in
  let ty = Int64.to_int (getf y sp_type) in
  let tm = Int64.to_int (getf y sp_size1) in
  let tn = Int64.to_int (getf y sp_size2) in
  let ti = bigarray_of_ptr array1 tz Bigarray.int64 (getf y sp_i) in
  let td = bigarray_of_ptr array1 tz Bigarray.complex64 (getf y sp_data) in
  (** note: p array has different length in triplet and csc format *)
  let pl = if ty = 0 then tz else tn + 1 in
  let tp = bigarray_of_ptr array1 pl Bigarray.int64 (getf y sp_p) in
  { m = tm; n = tn; i = ti; d = td; p = tp; nz = tz; typ = ty; ptr = p; }

let _update_rec_from_ptr x =
  let open Owl_matrix_foreign in
  let open Ctypes in
  let y = !@ (x.ptr) in
  let _ = x.typ <- Int64.to_int (getf y sp_type) in
  let _ = x.m <- Int64.to_int (getf y sp_size1) in
  let _ = x.n <- Int64.to_int (getf y sp_size2) in
  let _ = x.nz <- Int64.to_int (getf y sp_nz) in
  let _ = x.i <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_i)) in
  let _ = x.d <- (bigarray_of_ptr array1 x.nz Bigarray.complex64 (getf y sp_data)) in
  (* note: p array has different length in triplet and csc format *)
  let pl = if x.typ = 0 then x.nz else x.n + 1 in
  let _ = x.p <- (bigarray_of_ptr array1 pl Bigarray.int64 (getf y sp_p)) in
  x

let _update_rec_after_set x =
  let open Owl_matrix_foreign in
  let open Ctypes in
  let y = !@ (x.ptr) in
  let _ = x.nz <- Int64.to_int (getf y sp_nz) in x

let _is_csc_format x = x.typ = 1


(** sparse matrix creation function *)

let zeros m n =
  let x = gsl_spmatrix_alloc m n in
  _of_sp_mat_ptr x
(*
let zeros m n =
  let open Ffi_generated in
  let x = owl_stub_2_gsl_spmatrix_alloc m n in
  _of_sp_mat_ptr x


let empty_csc m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.1) in
  let c = Pervasives.max 10 c in
  let x = gsl_spmatrix_alloc_nzmax m n c 1 in
  _of_sp_mat_ptr x

let set x i j y =
  (* FIXME: must be in triplet form; _update_rec_after_set *)
  let _ = gsl_spmatrix_set x.ptr i j y in
  let _ = _update_rec_after_set x in ()

let set_without_update_rec x i j y = gsl_spmatrix_set x.ptr i j y

let get x i j = gsl_spmatrix_get x.ptr i j

let reset x =
  let _ = gsl_spmatrix_set_zero x.ptr in
  let _ = _update_rec_from_ptr x in ()

let shape x = x.m, x.n

let row_num x = x.m

let col_num x = x.n

let numel x = (row_num x) * (col_num x)

let nnz x = x.nz

let density x =
  let a, b = nnz x, numel x in
  (float_of_int a) /. (float_of_int b)
*)



(** ends here *)
