module CI = Cstubs_internals

external owl_stub_1_c_eigen_spmat_d_new : int -> int -> CI.voidp
  = "owl_stub_1_c_eigen_spmat_d_new" 

external owl_stub_2_c_eigen_spmat_d_delete : _ CI.fatptr -> unit
  = "owl_stub_2_c_eigen_spmat_d_delete" 

external owl_stub_3_c_eigen_spmat_d_rows : _ CI.fatptr -> int
  = "owl_stub_3_c_eigen_spmat_d_rows" 

external owl_stub_4_c_eigen_spmat_d_cols : _ CI.fatptr -> int
  = "owl_stub_4_c_eigen_spmat_d_cols" 

external owl_stub_5_c_eigen_spmat_d_get : _ CI.fatptr -> int -> int -> float
  = "owl_stub_5_c_eigen_spmat_d_get" 

external owl_stub_6_c_eigen_spmat_d_set
  : _ CI.fatptr -> int -> int -> float -> unit
  = "owl_stub_6_c_eigen_spmat_d_set" 

external owl_stub_7_c_eigen_spmat_d_reset : _ CI.fatptr -> unit
  = "owl_stub_7_c_eigen_spmat_d_reset" 

external owl_stub_8_c_eigen_spmat_d_is_compressed : _ CI.fatptr -> int
  = "owl_stub_8_c_eigen_spmat_d_is_compressed" 

external owl_stub_9_c_eigen_spmat_d_compress : _ CI.fatptr -> unit
  = "owl_stub_9_c_eigen_spmat_d_compress" 

external owl_stub_10_c_eigen_spmat_d_uncompress : _ CI.fatptr -> unit
  = "owl_stub_10_c_eigen_spmat_d_uncompress" 

external owl_stub_11_c_eigen_spmat_d_reshape
  : _ CI.fatptr -> int -> int -> unit = "owl_stub_11_c_eigen_spmat_d_reshape" 

external owl_stub_12_c_eigen_spmat_d_print : _ CI.fatptr -> unit
  = "owl_stub_12_c_eigen_spmat_d_print" 

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
  (fun x1 -> owl_stub_12_c_eigen_spmat_d_print (CI.cptr x1))
| Function
    (CI.Pointer x4,
     Function
       (CI.Primitive CI.Int, Function (CI.Primitive CI.Int, Returns CI.Void))),
  "c_eigen_spmat_d_reshape" ->
  (fun x3 x5 x6 -> owl_stub_11_c_eigen_spmat_d_reshape (CI.cptr x3) x5 x6)
| Function (CI.Pointer x8, Returns CI.Void), "c_eigen_spmat_d_uncompress" ->
  (fun x7 -> owl_stub_10_c_eigen_spmat_d_uncompress (CI.cptr x7))
| Function (CI.Pointer x10, Returns CI.Void), "c_eigen_spmat_d_compress" ->
  (fun x9 -> owl_stub_9_c_eigen_spmat_d_compress (CI.cptr x9))
| Function (CI.Pointer x12, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_is_compressed" ->
  (fun x11 -> owl_stub_8_c_eigen_spmat_d_is_compressed (CI.cptr x11))
| Function (CI.Pointer x14, Returns CI.Void), "c_eigen_spmat_d_reset" ->
  (fun x13 -> owl_stub_7_c_eigen_spmat_d_reset (CI.cptr x13))
| Function
    (CI.Pointer x16,
     Function
       (CI.Primitive CI.Int,
        Function
          (CI.Primitive CI.Int,
           Function (CI.Primitive CI.Double, Returns CI.Void)))),
  "c_eigen_spmat_d_set" ->
  (fun x15 x17 x18 x19 ->
    owl_stub_6_c_eigen_spmat_d_set (CI.cptr x15) x17 x18 x19)
| Function
    (CI.Pointer x21,
     Function
       (CI.Primitive CI.Int,
        Function (CI.Primitive CI.Int, Returns (CI.Primitive CI.Double)))),
  "c_eigen_spmat_d_get" ->
  (fun x20 x22 x23 -> owl_stub_5_c_eigen_spmat_d_get (CI.cptr x20) x22 x23)
| Function (CI.Pointer x25, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_cols" ->
  (fun x24 -> owl_stub_4_c_eigen_spmat_d_cols (CI.cptr x24))
| Function (CI.Pointer x27, Returns (CI.Primitive CI.Int)),
  "c_eigen_spmat_d_rows" ->
  (fun x26 -> owl_stub_3_c_eigen_spmat_d_rows (CI.cptr x26))
| Function (CI.Pointer x29, Returns CI.Void), "c_eigen_spmat_d_delete" ->
  (fun x28 -> owl_stub_2_c_eigen_spmat_d_delete (CI.cptr x28))
| Function
    (CI.Primitive CI.Int,
     Function (CI.Primitive CI.Int, Returns (CI.Pointer x32))),
  "c_eigen_spmat_d_new" ->
  (fun x30 x31 -> CI.make_ptr x32 (owl_stub_1_c_eigen_spmat_d_new x30 x31))
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a b. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s

