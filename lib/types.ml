(*
 * OWL - an OCaml math library for scientific computing
 * Copyright (c) 2016 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(**
  Define the types shared by various modules
*)

open Bigarray
open Ctypes

type int_array = (int64, int64_elt, c_layout) Array1.t

type float_array1 = (float, float64_elt, c_layout) Array1.t

type float_array2 = (float, float64_elt, c_layout) Array2.t

(** configure the logger *)
let _ = Log.color_on (); Log.(set_log_level INFO)

(* Some common data structure for both dense and sparse matrices.
  please refer to related header files in GSL code repository. *)

(** structure definition for memory block used in GSL  *)
type mblk_struct

let mblk_struct : mblk_struct structure typ = structure "mblk_struct"
  let msize = field mblk_struct "msize" int64_t
  let mdata = field mblk_struct "mdata" (ptr double)
let () = seal mblk_struct

(** structure definition for vector, refer to gsl_vector_double.h *)
type vec_struct

let vec_struct : vec_struct structure typ = structure "vec_struct"
  let vsize  = field vec_struct "vsize" int64_t
  let stride = field vec_struct "stride" int64_t
  let vdata  = field vec_struct "vdata" (ptr double)
  let vblock = field vec_struct "vblock" (ptr mblk_struct)
  let vowner = field vec_struct "vowner" int64_t
let () = seal vec_struct

(** define the vector record *)
type vec_record = {
  mutable vsize  : int;            (* size of a vector *)
  mutable stride : int;            (* stride of a vector *)
  mutable vdata  : float_array2;   (* actual data of a vector *)
  mutable vptr   : vec_struct Ctypes_static.structure Ctypes_static.ptr;
  (* pointer to a vector's memory *)
}

(** structure definition for dense matrix, refer to gsl_matrix_double.h *)
type mat_struct

let mat_struct : mat_struct structure typ = structure "mat_struct"
  let size1 = field mat_struct "size1" int64_t
  let size2 = field mat_struct "size2" int64_t
  let tda   = field mat_struct "tda" int64_t
  let data  = field mat_struct "data" (ptr double)
  let block = field mat_struct "block" (ptr mblk_struct)
  let owner = field mat_struct "owner" int64_t
let () = seal mat_struct


(** structure definition for sparse matrix, refer to gsl_spmatrix.h *)
type spmat_struct

let spmat_struct : spmat_struct structure typ = structure "spmat_struct"
  let sp_size1 = field spmat_struct "sp_size1" int64_t
  let sp_size2 = field spmat_struct "sp_size2" int64_t
  let sp_i     = field spmat_struct "sp_i" (ptr int64_t)
  let sp_data  = field spmat_struct "sp_data" (ptr double)
  let sp_p     = field spmat_struct "sp_p" (ptr int64_t)
  let sp_nzmax = field spmat_struct "sp_nzmax" int64_t
  let sp_nz    = field spmat_struct "sp_nz" int64_t
  let sp_tree  = field spmat_struct "sp_tree" (ptr void)
  let sp_work  = field spmat_struct "sp_work" (ptr void)
  let sp_type  = field spmat_struct "sp_type" int64_t
let () = seal spmat_struct

(** record definition for sparse matrix *)
type spmat_record = {
  mutable m   : int;           (* number of rows *)
  mutable n   : int;           (* number of columns *)
  mutable i   : int_array;     (* i index, meaning depends on the matrix format *)
  mutable d   : float_array1;  (* where data actually stored *)
  mutable p   : int_array;     (* p index, meaning depends on the matrix format *)
  mutable nz  : int;           (* total number of non-zero elements *)
  (* tree missing *)
  (* work missing *)
  mutable typ : int;           (* format of the sparse matrix, 0:triplet; 1: CCS *)
  mutable ptr : spmat_struct Ctypes_static.structure Ctypes_static.ptr;
  (* pointer to the sparse metrix *)
}


(* ends here *)
