(* Sparse matrix support *)

open Bigarray
open Types

let _empty_int_array () = Array1.create int64 c_layout 0

let _of_sp_mat_ptr p =
  let open Matrix_foreign in
  let open Ctypes in
  let y = !@ p in
  let tnz = Int64.to_int (getf y sp_nz) in
  let tm = Int64.to_int (getf y sp_size1) in
  let tn = Int64.to_int (getf y sp_size2) in
  let ti = bigarray_of_ptr array1 tnz Bigarray.int64 (getf y sp_i) in
  let tp = bigarray_of_ptr array1 tnz Bigarray.int64 (getf y sp_p) in
  let td = bigarray_of_ptr array1 tnz Bigarray.float64 (getf y sp_data) in
  let ty = Int64.to_int (getf y sp_type) in
  { m = tm; n = tn; i = ti; d = td; p = tp; nz = tnz; typ = ty; ptr = p; }

let _update_rec_from_ptr x =
  let open Matrix_foreign in
  let open Ctypes in
  let y = !@ (x.ptr) in
  let _ = x.m <- Int64.to_int (getf y sp_size1) in
  let _ = x.n <- Int64.to_int (getf y sp_size2) in
  let _ = x.nz <- Int64.to_int (getf y sp_nz) in
  let _ = x.i <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_i)) in
  let _ = x.p <- (bigarray_of_ptr array1 x.nz Bigarray.int64 (getf y sp_p)) in
  let _ = x.d <- (bigarray_of_ptr array1 x.nz Bigarray.float64 (getf y sp_data)) in
  let _ = x.typ <- Int64.to_int (getf y sp_type) in
  x

let _is_csc_format x = x.typ = 1

let allocate_vecptr m =
  let open Matrix_foreign in
  let open Ctypes in
  let p = gsl_vector_alloc m in
  let y = !@ p in
  let x = {
    vsize = Int64.to_int (getf y vsize);
    stride = Int64.to_int (getf y vsize);
    vdata = (
      let raw = getf y vdata in
      bigarray_of_ptr array2 (1,m) Bigarray.float64 raw );
    vptr = p } in x


(* sparse matrix creation function *)

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

let trace x =
  let r = ref 0. in
  let c = Pervasives.min (row_num x) (col_num x) in
  for i = 0 to c - 1 do
    r := !r +. (get x i i)
  done; !r

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

let dot x1 x2 =
  let open Matrix_foreign in
  let x1 = if _is_csc_format x1 then x1 else to_csc x1 in
  let x2 = if _is_csc_format x2 then x2 else to_csc x2 in
  let x3 = empty_csc (row_num x1) (col_num x2) in
  let _ = gsl_spblas_dgemm 1.0 x1.ptr x2.ptr x3.ptr in
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

(* matrix interation functions *)

let row x i =
  let y = empty 1 (col_num x) in
  for j = 0 to (col_num x) - 1 do
    set y 0 j (get x i j)
  done; y

let col x i =
  let y = empty (row_num x) 1 in
  for j = 0 to (row_num x) - 1 do
    set y j 0 (get x j i)
  done; y

let rows x l =
  let m, n = Array.length l, col_num x in
  let y = empty m n in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      set y i j (get x i j)
    done
  done; y

let cols = None

let iteri f x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      f i j (get x i j)
    done
  done

let mapi f x =
  let y = empty (row_num x) (col_num x) in
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      set y i j (f i j (get x i j))
    done
  done; y


(* formatted input / output operations *)

let print x =
  for i = 0 to (row_num x) - 1 do
    for j = 0 to (col_num x) - 1 do
      Printf.printf "%.2f " (get x i j)
    done;
    print_endline ""
  done

(* transform to and from different types *)

let to_dense x =
  let open Matrix_foreign in
  let y = gsl_matrix_alloc (row_num x) (col_num x) in
  let _ = gsl_spmatrix_sp2d y x.ptr in
  matptr_to_mat y (row_num x) (col_num x)

let of_dense x =
  let open Matrix_foreign in
  let y = empty (Array2.dim1 x) (Array2.dim2 x) in
  let _ = gsl_spmatrix_d2sp y.ptr (mat_to_matptr x) in
  _update_rec_from_ptr y






(* ends here *)
