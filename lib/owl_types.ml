(*
 * OWL - an OCaml numerical library for scientific computing
 * Copyright (c) 2016-2017 Liang Wang <liang.wang@cl.cam.ac.uk>
 *)

(** Define the types shared by various modules *)

open Bigarray
open Ctypes

(* configure the logger *)
let _ = Log.color_on (); Log.(set_log_level INFO)

(* define some constants *)

let _zero : type a b. (a, b) kind -> a = function
  | Float32 -> 0.0 | Complex32 -> Complex.zero
  | Float64 -> 0.0 | Complex64 -> Complex.zero
  | Int8_signed -> 0 | Int8_unsigned -> 0
  | Int16_signed -> 0 | Int16_unsigned -> 0
  | Int32 -> 0l | Int64 -> 0L
  | Int -> 0 | Nativeint -> 0n
  | Char -> '\000'

let _one : type a b. (a, b) kind -> a = function
  | Float32 -> 1.0 | Complex32 -> Complex.one
  | Float64 -> 1.0 | Complex64 -> Complex.one
  | Int8_signed -> 1 | Int8_unsigned -> 1
  | Int16_signed -> 1 | Int16_unsigned -> 1
  | Int32 -> 1l | Int64 -> 1L
  | Int -> 1 | Nativeint -> 1n
  | Char -> '\001'

let _pos_inf : type a b. (a, b) kind -> a = function
  | Float32   -> infinity
  | Float64   -> infinity
  | Complex32 -> Complex.({re = infinity; im = infinity})
  | Complex64 -> Complex.({re = infinity; im = infinity})
  | _         -> failwith "_pos_inf: unsupported operation"

let _neg_inf : type a b. (a, b) kind -> a = function
  | Float32   -> neg_infinity
  | Float64   -> neg_infinity
  | Complex32 -> Complex.({re = neg_infinity; im = neg_infinity})
  | Complex64 -> Complex.({re = neg_infinity; im = neg_infinity})
  | _         -> failwith "_neg_inf: unsupported operation"

(* struct definition for real dense matrix *)

module Dense_real_double = struct

  type elt_array = (float, float64_elt, c_layout) Array2.t

  type mblk_struct

  let mblk_struct : mblk_struct structure typ = structure "gsl_block"
    let msize = field mblk_struct "size" int64_t
    let mdata = field mblk_struct "data" (ptr double)
  let () = seal mblk_struct

  (** structure definition for vector, refer to gsl_vector_double.h *)
  type vec_struct

  let vec_struct : vec_struct structure typ = structure "gsl_vector"
    let vsize  = field vec_struct "size" int64_t
    let stride = field vec_struct "stride" int64_t
    let vdata  = field vec_struct "data" (ptr double)
    let vblock = field vec_struct "block" (ptr mblk_struct)
    let vowner = field vec_struct "owner" int64_t
  let () = seal vec_struct

  (** structure definition for dense matrix, refer to gsl_matrix_double.h *)
  type mat_struct

  let mat_struct : mat_struct structure typ = structure "gsl_matrix"
    let size1 = field mat_struct "size1" int64_t
    let size2 = field mat_struct "size2" int64_t
    let tda   = field mat_struct "tda" int64_t
    let data  = field mat_struct "data" (ptr double)
    let block = field mat_struct "block" (ptr mblk_struct)
    let owner = field mat_struct "owner" int64_t
  let () = seal mat_struct

  (** define the vector record *)
  type vec_record = {
    mutable vsize  : int;            (* size of a vector *)
    mutable stride : int;            (* stride of a vector *)
    mutable vdata  : elt_array;      (* actual data of a vector *)
    mutable vptr   : vec_struct Ctypes_static.structure Ctypes_static.ptr;
    (* pointer to a vector's memory *)
  }

end


module Dense_real_float = struct

  type elt_array = (float, float32_elt, c_layout) Array2.t

  type mblk_struct

  let mblk_struct : mblk_struct structure typ = structure "gsl_block_float"
    let msize = field mblk_struct "size" int64_t
    let mdata = field mblk_struct "data" (ptr float)
  let () = seal mblk_struct

  (** structure definition for vector, refer to gsl_vector_double.h *)
  type vec_struct

  let vec_struct : vec_struct structure typ = structure "gsl_vector_float"
    let vsize  = field vec_struct "size" int64_t
    let stride = field vec_struct "stride" int64_t
    let vdata  = field vec_struct "data" (ptr float)
    let vblock = field vec_struct "block" (ptr mblk_struct)
    let vowner = field vec_struct "owner" int64_t
  let () = seal vec_struct

  (** structure definition for dense matrix, refer to gsl_matrix_double.h *)
  type mat_struct

  let mat_struct : mat_struct structure typ = structure "gsl_matrix_float"
    let size1 = field mat_struct "size1" int64_t
    let size2 = field mat_struct "size2" int64_t
    let tda   = field mat_struct "tda" int64_t
    let data  = field mat_struct "data" (ptr float)
    let block = field mat_struct "block" (ptr mblk_struct)
    let owner = field mat_struct "owner" int64_t
  let () = seal mat_struct

  (** define the vector record *)
  type vec_record = {
    mutable vsize  : int;            (* size of a vector *)
    mutable stride : int;            (* stride of a vector *)
    mutable vdata  : elt_array;      (* actual data of a vector *)
    mutable vptr   : vec_struct Ctypes_static.structure Ctypes_static.ptr;
    (* pointer to a vector's memory *)
  }

end


(* struct definition for complex dense matrix *)

module Dense_complex_double = struct

  type elt_array = (Complex.t, complex64_elt, c_layout) Array2.t

  type mblk_struct

  let mblk_struct : mblk_struct structure typ = structure "gsl_block_complex"
    let msize = field mblk_struct "size" int64_t
    let mdata = field mblk_struct "data" (ptr complex64)
  let () = seal mblk_struct

  (** structure definition for vector, refer to gsl_vector_double.h *)
  type vec_struct

  let vec_struct : vec_struct structure typ = structure "gsl_vector_complex"
    let vsize  = field vec_struct "size" int64_t
    let stride = field vec_struct "stride" int64_t
    let vdata  = field vec_struct "data" (ptr complex64)
    let vblock = field vec_struct "block" (ptr mblk_struct)
    let vowner = field vec_struct "owner" int64_t
  let () = seal vec_struct

  (** structure definition for dense matrix, refer to gsl_matrix_double.h *)
  type mat_struct

  let mat_struct : mat_struct structure typ = structure "gsl_matrix_complex"
    let size1 = field mat_struct "size1" int64_t
    let size2 = field mat_struct "size2" int64_t
    let tda   = field mat_struct "tda" int64_t
    let data  = field mat_struct "data" (ptr complex64)
    let block = field mat_struct "block" (ptr mblk_struct)
    let owner = field mat_struct "owner" int64_t
  let () = seal mat_struct

  (** define the vector record *)
  type vec_record = {
    mutable vsize  : int;            (* size of a vector *)
    mutable stride : int;            (* stride of a vector *)
    mutable vdata  : elt_array;      (* actual data of a vector *)
    mutable vptr   : vec_struct Ctypes_static.structure Ctypes_static.ptr;
    (* pointer to a vector's memory *)
  }

end


module Dense_complex_float = struct

  type elt_array = (Complex.t, complex32_elt, c_layout) Array2.t

  type mblk_struct

  let mblk_struct : mblk_struct structure typ = structure "gsl_block_complex_float"
    let msize = field mblk_struct "size" int64_t
    let mdata = field mblk_struct "data" (ptr complex32)
  let () = seal mblk_struct

  (** structure definition for vector, refer to gsl_vector_double.h *)
  type vec_struct

  let vec_struct : vec_struct structure typ = structure "gsl_vector_complex_float"
    let vsize  = field vec_struct "size" int64_t
    let stride = field vec_struct "stride" int64_t
    let vdata  = field vec_struct "data" (ptr complex32)
    let vblock = field vec_struct "block" (ptr mblk_struct)
    let vowner = field vec_struct "owner" int64_t
  let () = seal vec_struct

  (** structure definition for dense matrix, refer to gsl_matrix_double.h *)
  type mat_struct

  let mat_struct : mat_struct structure typ = structure "gsl_matrix_complex_float"
    let size1 = field mat_struct "size1" int64_t
    let size2 = field mat_struct "size2" int64_t
    let tda   = field mat_struct "tda" int64_t
    let data  = field mat_struct "data" (ptr complex32)
    let block = field mat_struct "block" (ptr mblk_struct)
    let owner = field mat_struct "owner" int64_t
  let () = seal mat_struct

  (** define the vector record *)
  type vec_record = {
    mutable vsize  : int;            (* size of a vector *)
    mutable stride : int;            (* stride of a vector *)
    mutable vdata  : elt_array;      (* actual data of a vector *)
    mutable vptr   : vec_struct Ctypes_static.structure Ctypes_static.ptr;
    (* pointer to a vector's memory *)
  }

end


(* ends here *)
