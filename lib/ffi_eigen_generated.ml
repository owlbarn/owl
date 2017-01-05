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

external owl_stub_16_c_eigen_spmat_d_transpose : _ CI.fatptr -> CI.voidp
  = "owl_stub_16_c_eigen_spmat_d_transpose" 

external owl_stub_17_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_17_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_17_c_eigen_spmat_d_print (CI.cptr x1))
| Function (CI.Pointer x4, Returns (CI.Pointer x5)),
  "c_eigen_spmat_d_transpose" ->
  (fun x3 ->
    CI.make_ptr x5 (owl_stub_16_c_eigen_spmat_d_transpose (CI.cptr x3)))
| Function
    (CI.Pointer x7, Function (CI.Primitive CI.Int, Returns (CI.Pointer x9))),
  "c_eigen_spmat_d_row" ->
  (fun x6 x8 ->
    CI.make_ptr x9 (owl_stub_15_c_eigen_spmat_d_row (CI.cptr x6) x8))
| Function (CI.Pointer x11, Returns (CI.Pointer x12)),
  "c_eigen_spmat_d_clone" ->
  (fun x10 ->
    CI.make_ptr x12 (owl_stub_14_c_eigen_spmat_d_clone (CI.cptr x10)))
| Function
    (CI.Pointer x14,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x13 x15 x16 ->
    owl_stub_13_c_eigen_spmat_d_reshape (CI.cptr x13) x15 x16)
| Function (CI.Pointer x18, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x17 -> owl_stub_12_c_eigen_spmat_d_uncompress (CI.cptr x17))
| Function (CI.Pointer x20, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x19 -> owl_stub_11_c_eigen_spmat_d_compress (CI.cptr x19))
| Function (CI.Pointer x22, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x21 -> owl_stub_10_c_eigen_spmat_d_is_compressed (CI.cptr x21))
| Function (CI.Pointer x24, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x23 -> owl_stub_9_c_eigen_spmat_d_reset (CI.cptr x23))
| Function
    (CI.Pointer x26,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x25 x27 x28 x29 ->
    owl_stub_8_c_eigen_spmat_d_set (CI.cptr x25) x27 x28 x29)
| Function
    (CI.Pointer x31,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x30 x32 x33 -> owl_stub_7_c_eigen_spmat_d_get (CI.cptr x30) x32 x33)
| Function (CI.Pointer x35, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_nnz" ->
  (fun x34 -> owl_stub_6_c_eigen_spmat_d_nnz (CI.cptr x34))
| Function (CI.Pointer x37, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x36 -> owl_stub_5_c_eigen_spmat_d_cols (CI.cptr x36))
| Function (CI.Pointer x39, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x38 -> owl_stub_4_c_eigen_spmat_d_rows (CI.cptr x38))
| Function (CI.Primitive CI.Int, Returns (CI.Pointer x41)),
  "c_eigen_spmat_d_eye" ->
  (fun x40 -> CI.make_ptr x41 (owl_stub_3_c_eigen_spmat_d_eye x40))
| Function (CI.Pointer x43, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x42 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x42))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x46))),
  "c_eigen_spmat_d_new" ->
  (fun x44 x45 -> CI.make_ptr x46 (owl_stub_1_c_eigen_spmat_d_new x44 x45))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

