(* Sparse matrix support *)

open Bigarray

type int_array = (int64, int64_elt, c_layout) Array1.t;;

type 'a sp_mat = {
  mutable m : int;           (* number of rows *)
  mutable n : int;           (* number of columns *)
  mutable i : int_array;     (* i index, meaning depends on the matrix format *)
  mutable d : 'a array;      (* where data actually stored *)
  mutable p : int_array;     (* p index, meaning depends on the matrix format *)
  mutable nz : int;          (* total number of non-zero elements *)
  mutable ptr : Matrix_foreign.sp_mat Ctypes_static.structure Ctypes_static.ptr;  (* pointer to the sparse metrix *)
  mutable typ : int;         (* format of the sparse matrix, 0:triplet; 1: CCS *)
}

let _empty_int_array () = Array1.create int64 c_layout 0

let _of_sp_mat_ptr p =
  let open Matrix_foreign in
  let open Ctypes in
  let x = {
    m = 0; n = 0;
    i = _empty_int_array ();
    d = [||];
    p = _empty_int_array ();
    nz = 0;
    ptr = p; typ = 0;
    } in
  let y = !@ p in
  let _ = x.m <- Int64.to_int (getf y sp_size1) in
  let _ = x.n <- Int64.to_int (getf y sp_size2) in
  let _ = x.nz <- Int64.to_int (getf y sp_nz) in
  let _ = x.i <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_i)) in
  let _ = x.p <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_p)) in
  let _ = x.typ <- Int64.to_int (getf y sp_type) in
  x

let _update_rec_from_ptr x =
  let open Matrix_foreign in
  let open Ctypes in
  let y = !@ (x.ptr) in
  let _ = x.m <- Int64.to_int (getf y sp_size1) in
  let _ = x.n <- Int64.to_int (getf y sp_size2) in
  let _ = x.nz <- Int64.to_int (getf y sp_nz) in
  let _ = x.i <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_i)) in
  let _ = x.p <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_p)) in
  let _ = x.typ <- Int64.to_int (getf y sp_type) in
  x

let _is_csc_format x = x.typ = 1

let empty m n =
  let open Matrix_foreign in
  let x = gsl_spmatrix_alloc m n in
  _of_sp_mat_ptr x

let empty_csc m n =
  let open Matrix_foreign in
  let c = int_of_float ((float_of_int (m * n)) *. 0.1) in
  let c = Pervasives.max 10 c in
  let x = gsl_spmatrix_alloc_nzmax m n c 1 in
  _of_sp_mat_ptr x

let set x i j y =
  (* FIXME: must be in triplet form *)
  let open Matrix_foreign in
  let _ = gsl_spmatrix_set x.ptr i j y in
  let _ = _update_rec_from_ptr x in ()

let get x i j =
  (* FIXME: may be in both forms *)
  let open Matrix_foreign in
  gsl_spmatrix_get x.ptr i j

let reset x =
  let open Matrix_foreign in
  let _ = (gsl_spmatrix_set_zero x.ptr) in
  let _ = _update_rec_from_ptr x in ()

let shape x = x.m, x.n

let row_num x = x.m

let col_num x = x.n

let nnz x = x.nz

let eye n =
  let x = empty n n in
  for i = 0 to (row_num x) - 1 do
      set x i i 1.
  done; x

let uniform_int ?(a=0) ?(b=99) m n =
  let c = int_of_float ((float_of_int (m * n)) *. 0.1) in
  let x = empty m n in
  for k = 0 to c do
    let i = Rand.uniform_int ~a:0 ~b:(m-1) () in
    let j = Rand.uniform_int ~a:0 ~b:(n-1) () in
    set x i j (float_of_int (Rand.uniform_int ~a ~b ()))
  done; x

(* matrix manipulations *)

let copy_to x1 x2 =
  let open Matrix_foreign in
  let _ = gsl_spmatrix_memcpy x2.ptr x1.ptr in
  _update_rec_from_ptr x2

let clone x =
  let y = if _is_csc_format x
    then empty_csc (row_num x) (col_num x)
    else empty (row_num x) (col_num x) in
  let _ = copy_to x y in y

let to_csc x =
  let open Matrix_foreign in
  let y = if _is_csc_format x then clone x
  else let p = gsl_spmatrix_compcol x.ptr in _of_sp_mat_ptr p
  in y

let to_triplet x = None

let transpose x =
  let open Matrix_foreign in
  let y = if _is_csc_format x
    then empty_csc (col_num x) (row_num x)
    else empty (col_num x) (row_num x) in
  let _ = gsl_spmatrix_transpose_memcpy y.ptr x.ptr in
  _update_rec_from_ptr y

let diag = None

let trace = None

(* matrix mathematical operations *)

let mul_scalar x1 y =
  let open Matrix_foreign in
  let x2 = to_csc x1 in
  let _ = gsl_spmatrix_scale x2.ptr y in
  x2

let div_scalar x1 y = mul_scalar x1 (1. /. y)

let add x1 x2 =
  let open Matrix_foreign in
  let x1 = if _is_csc_format x1 then x1 else to_csc x1 in
  let x2 = if _is_csc_format x2 then x2 else to_csc x2 in
  let x3 = empty_csc (row_num x1) (col_num x1) in
  let _ = gsl_spmatrix_add x3.ptr x1.ptr x2.ptr in
  _update_rec_from_ptr x3

let sub x1 x2 =
  let x2 = mul_scalar x2 (-1.) in
  add x1 x2

let minmax x =
  let open Matrix_foreign in
  let open Ctypes in
  let xmin = allocate double 0. in
  let xmax = allocate double 0. in
  let _ = gsl_spmatrix_minmax x.ptr xmin xmax in
  !@ xmin, !@ xmax

let min x = fst (minmax x)

let max x = snd (minmax x)

let is_equal x1 x2 =
  let open Matrix_foreign in
  (gsl_spmatrix_equal x1.ptr x2.ptr) = 1

(* formatted input / output operations *)

let print x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      Printf.printf "%.2f " (get x i j)
    done;
    print_endline ""
  done



(* ends here *)
