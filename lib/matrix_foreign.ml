open Ctypes
open Foreign

(* Dense matrices
  define the block struct, refer to gsl_matrix_double.h *)

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

let matptr_to_mat x m n =
  let raw = getf (!@ x) data in
  bigarray_of_ptr array2 (m,n) Bigarray.float64 raw

let col_vec_to_mat x =
  let raw = getf x vdata in
  let len = getf x vsize in
  bigarray_of_ptr array2 ((Int64.to_int len),1) Bigarray.float64 raw

let mat_to_matptr x : mat Ctypes.structure Ctypes_static.ptr =
  let m = Int64.of_int (Bigarray.Array2.dim1 x) in
  let n = Int64.of_int (Bigarray.Array2.dim2 x) in
  let y = make mblk in
  let z = make mat in
  let p = Ctypes.bigarray_start Ctypes_static.Array2 x in
  let _ = setf y msize (Int64.mul m n) in
  let _ = setf y mdata p in
  let _ = setf z size1 m in
  let _ = setf z size2 n in
  let _ = setf z tda n in
  let _ = setf z data p in
  let _ = setf z block (addr y) in
  (addr z)

let allocate_col_vecptr x = (* FIXME: not sure is setting is right, use gsl_vector_alloc *)
  let m = Int64.of_int x in
  let p = Bigarray.Array1.create Bigarray.float64 Bigarray.c_layout x in
  let p = Ctypes.bigarray_start Ctypes_static.Array1 p in
  let y = make mblk in
  let z = make vec in
  let _ = setf y mdata p in
  let _ = setf y msize m in
  let _ = setf z vsize m in
  (* let _ = setf z stride 5L in *)
  let _ = setf z vblock (addr y) in
  let _ = setf z vdata p in
  (addr z)

(* import some matrix functions from gsl *)

let gsl_matrix_get_col = foreign "gsl_matrix_get_col" (ptr vec @-> ptr mat @-> int @-> returning int)

let gsl_matrix_equal = foreign "gsl_matrix_equal" (ptr mat @-> ptr mat @-> returning int)

let gsl_matrix_isnull = foreign "gsl_matrix_isnull" (ptr mat @-> returning int)

let gsl_matrix_ispos = foreign "gsl_matrix_ispos" (ptr mat @-> returning int)

let gsl_matrix_isneg = foreign "gsl_matrix_isneg" (ptr mat @-> returning int)

let gsl_matrix_isnonneg = foreign "gsl_matrix_isnonneg" (ptr mat @-> returning int)

let gsl_matrix_min = foreign "gsl_matrix_min" (ptr mat @-> returning double)

let gsl_matrix_min_index = foreign "gsl_matrix_min_index" (ptr mat @-> ptr int @-> ptr int @-> returning void)

let gsl_matrix_max = foreign "gsl_matrix_max" (ptr mat @-> returning double)

let gsl_matrix_max_index = foreign "gsl_matrix_max_index" (ptr mat @-> ptr int @-> ptr int @-> returning void)

let gsl_matrix_fwrite = foreign "gsl_matrix_fwrite" (ptr int @-> ptr mat @-> returning void)


(* Sparse matrices
  define the block struct, refer to gsl_spmatrix.h *)

type sp_mat

let sp_mat : sp_mat structure typ = structure "sp_mat"
let sp_size1 = field sp_mat "sp_size1" int64_t
let sp_size2 = field sp_mat "sp_size2" int64_t
let sp_i = field sp_mat "sp_i" (ptr int64_t)
let sp_data = field sp_mat "sp_data" (ptr double)
let sp_p = field sp_mat "sp_p" (ptr int64_t)
let sp_nzmax = field sp_mat "sp_nzmax" int64_t
let sp_nz = field sp_mat "sp_nz" int64_t
let sp_tree = field sp_mat "sp_tree" (ptr void)
let sp_work = field sp_mat "sp_nz" (ptr void)
let sp_type = field sp_mat "sp_type" int64_t
let () = seal sp_mat


let gsl_spmatrix_alloc = foreign "gsl_spmatrix_alloc" (int @-> int @-> returning (ptr sp_mat))

let gsl_spmatrix_alloc_nzmax = foreign "gsl_spmatrix_alloc_nzmax" (int @-> int @-> int @-> int @-> returning (ptr sp_mat))

let gsl_spmatrix_set = foreign "gsl_spmatrix_set" (ptr sp_mat @-> int @-> int @-> double @-> returning int)

let gsl_spmatrix_get = foreign "gsl_spmatrix_get" (ptr sp_mat @-> int @-> int @-> returning double)

let gsl_spmatrix_add = foreign "gsl_spmatrix_add" (ptr sp_mat @-> ptr sp_mat @-> ptr sp_mat @-> returning int)

let gsl_spmatrix_scale = foreign "gsl_spmatrix_scale" (ptr sp_mat @-> double @-> returning int)

let gsl_spmatrix_memcpy = foreign "gsl_spmatrix_memcpy" (ptr sp_mat @-> ptr sp_mat @-> returning int)

let gsl_spmatrix_compcol = foreign "gsl_spmatrix_compcol" (ptr sp_mat @-> returning (ptr sp_mat))

let gsl_spmatrix_minmax = foreign "gsl_spmatrix_minmax" (ptr sp_mat @-> ptr double @-> ptr double @-> returning int)

let gsl_spmatrix_equal = foreign "gsl_spmatrix_equal" (ptr sp_mat @-> ptr sp_mat @-> returning int)

let gsl_spmatrix_transpose_memcpy = foreign "gsl_spmatrix_transpose_memcpy" (ptr sp_mat @-> ptr sp_mat @-> returning int)




(* ends here *)
