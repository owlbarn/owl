module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_d_new : int -> int -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_d_new" 

external owl_stub_2_c_eigen_spmat_d_delete : _ CI.fatptr -> unit
  = "owl_stub_2_c_eigen_spmat_d_delete" 

external owl_stub_3_c_eigen_spmat_d_eye : int -> CI.voidp
  = "owl_stub_3_c_eigen_spmat_d_eye" 

external owl_stub_4_c_eigen_spmat_d_rows : _ CI.fatptr -> int
  = "owl_stub_4_c_eigen_spmat_d_rows" 

external owl_stub_5_c_eigen_spmat_d_cols : _ CI.fatptr -> int
  = "owl_stub_5_c_eigen_spmat_d_cols" 

external owl_stub_6_c_eigen_spmat_d_nnz : _ CI.fatptr -> int
  = "owl_stub_6_c_eigen_spmat_d_nnz" 

external owl_stub_7_c_eigen_spmat_d_get : _ CI.fatptr -> int -> int -> float
  = "owl_stub_7_c_eigen_spmat_d_get" 

external owl_stub_8_c_eigen_spmat_d_set
  : _ CI.fatptr -> int -> int -> float -> unit
  = "owl_stub_8_c_eigen_spmat_d_set" 

external owl_stub_9_c_eigen_spmat_d_reset : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_d_reset" 

external owl_stub_10_c_eigen_spmat_d_is_compressed : _ CI.fatptr -> int
  = "owl_stub_10_c_eigen_spmat_d_is_compressed" 

external owl_stub_11_c_eigen_spmat_d_compress : _ CI.fatptr -> unit
  = "owl_stub_11_c_eigen_spmat_d_compress" 

external owl_stub_12_c_eigen_spmat_d_uncompress : _ CI.fatptr -> unit
  = "owl_stub_12_c_eigen_spmat_d_uncompress" 

external owl_stub_13_c_eigen_spmat_d_reshape
  : _ CI.fatptr -> int -> int -> unit = "owl_stub_13_c_eigen_spmat_d_reshape" 

external owl_stub_14_c_eigen_spmat_d_clone : _ CI.fatptr -> CI.voidp
  = "owl_stub_14_c_eigen_spmat_d_clone" 

external owl_stub_15_c_eigen_spmat_d_row : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_15_c_eigen_spmat_d_row" 

external owl_stub_16_c_eigen_spmat_d_col : _ CI.fatptr -> int -> CI.voidp
  = "owl_stub_16_c_eigen_spmat_d_col" 

external owl_stub_17_c_eigen_spmat_d_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_17_c_eigen_spmat_d_transpose" 

external owl_stub_18_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_18_c_eigen_spmat_d_print" 

type 'a result = 'a
type 'a return = 'a
type 'a fn =
 | Returns  : 'a CI.typ   -> 'a return fn
 | Function : 'a CI.typ * 'b fn  -> ('a -> 'b) fn
let map_result f x = f x
let returning t = Returns t
let (@->) f p = Function (f, p)
let foreign : type a b. string -> (a -> b) fn -> (a -> b) =
  fun name t -> match t, name with
| Function (CI.Pointer x2, Returns CI.Void), "c_eigen_spmat_d_print" ->
  (fun x1 -> owl_stub_18_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)),
  "c_eigen_spmat_d_transpose" ->
  (fun x3 ->
    CI.make_ptr x5 (owl_stub_17_c_eigen_spmat_d_transpose (CI.cptr x3)))
| Function
    (CI.Pointer x7, Function (CI.Primitive CI.Int, Returns (CI.Pointer x9))),
  "c_eigen_spmat_d_col" ->
  (fun x6 x8 ->
    CI.make_ptr x9 (owl_stub_16_c_eigen_spmat_d_col (CI.cptr x6) x8))
| Function
    (CI.Pointer x11,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x13))),
  "c_eigen_spmat_d_row" ->
  (fun x10 x12 ->
    CI.make_ptr x13 (owl_stub_15_c_eigen_spmat_d_row (CI.cptr x10) x12))
| Function (CI.Pointer x15, Returns (CI.Pointer x16)),
  "c_eigen_spmat_d_clone" ->
  (fun x14 ->
    CI.make_ptr x16 (owl_stub_14_c_eigen_spmat_d_clone (CI.cptr x14)))
| Function
    (CI.Pointer x18,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x17 x19 x20 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x17) x19 x20)
| Function (CI.Pointer x22, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x21 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x21))
| Function (CI.Pointer x24, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x23 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x23))
| Function (CI.Pointer x26, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x25 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x25))
| Function (CI.Pointer x28, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x27 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x27))
| Function
    (CI.Pointer x30,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x29 x31 x32 x33 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x29) x31 x32 x33)
| Function
    (CI.Pointer x35,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x34 x36 x37 -> owl_stub_7_c_eigen_spmat_d_get (CI.cptr x34) x36 x37)
| Function (CI.Pointer x39, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x38 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x38))
| Function (CI.Pointer x41, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x40 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x40))
| Function (CI.Pointer x43, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x42 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x42))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x45)),
  "c_eigen_spmat_d_eye" ->
  (fun x44 -> CI.make_ptr x45 (owl_stub_3_c_eigen_spmat_d_eye x44))
| Function (CI.Pointer x47, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x46 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x46))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x50))),
  "c_eigen_spmat_d_new" ->
  (fun x48 x49 -> CI.make_ptr x50 (owl_stub_1_c_eigen_spmat_d_new x48 x49))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

