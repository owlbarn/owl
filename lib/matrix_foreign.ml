open Ctypes
open Foreign

(* define the block struct, refer to gsl_matrix_double.h *)

type block

let mblk : block structure typ = structure "mblk"
let msize = field mblk "msize" int64_t
let mdata = field mblk "mdata" (ptr double)
let () = seal mblk

type vec

let vec : vec structure typ = structure "vec"
let vsize = field vec "vsize" int64_t
let stride = field vec "stride" int64_t
let vdata = field vec "vdata" (ptr double)
let vblock = field vec "vblock" (ptr mblk)
let vowner = field vec "vowner" int64_t
let () = seal vec

(* define the matrix struct, refer to gsl_matrix_double.h *)

type mat

let mat : mat structure typ = structure "mat"
let size1 = field mat "size1" int64_t
let size2 = field mat "size2" int64_t
let tda = field mat "tda" int64_t
let data = field mat "data" (ptr double)
let block = field mat "block" (ptr mblk)
let owner = field mat "owner" int64_t
let () = seal mat

let mat_ptr_to_mat x m n =
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let vec_to_mat x m n =
  let raw = getf x vdata in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let mat_to_ptr x m n =
  let y = make mblk in
  let z = make mat in
  let p = Ctypes.bigarray_start Ctypes_static.Array2 x in
  let _ = setf y msize (Int64.of_int(m * n)) in
  let _ = setf y mdata p in
  let _ = setf z size1 (Int64.of_int(m)) in
  let _ = setf z size2 (Int64.of_int(n)) in
  let _ = setf z tda (Int64.of_int(n)) in
  let _ = setf z data p in
  let _ = setf z block (addr y) in
  (addr z)

(* import some matrix functions from gsl *)

let gsl_matrix_column = foreign "gsl_matrix_column" (ptr mat @-> int @-> returning vec)

let gsl_matrix_equal = foreign "gsl_matrix_equal" (ptr mat @-> ptr mat @-> returning int)

let gsl_matrix_fwrite = foreign "gsl_matrix_fwrite" (string @-> ptr mat @-> returning void)

let empty = foreign "gsl_matrix_alloc" (int @-> int @-> returning (ptr mat))
